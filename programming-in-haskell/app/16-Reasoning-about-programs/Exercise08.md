```hs
data Tree a = Leaf a | Node (Tree a) (Tree a)

instance Functor Tree where
  -- fmap :: (a -> b) -> Tree a -> Tree b
  fmap g (Leaf x) = Leaf (g x)
  fmap g (Node l r) = Node (fmap g l) (fmap g r)
```

```
-- functor laws
fmap id = id
fmap (g . h) = fmap g . fmap h
```

```
Induction hypothesis: fmap id = id

case 1:
fmap id (Leaf x)
= { applying fmap }
Leaf (id x)
= { applying id }
Leaf x
= { unapplying id }
id (Leaf x)

case 2:
fmap id (Node l r)
= { applying fmap }
Node (fmap id l) (fmap id r)
= { inductive hypothesis }
Node l r
= { unapplying id }
id (Node l r)
```

```
Induction hypothesis: fmap (g . h) = fmap g . fmap h

case 1:
fmap (g . h) (Leaf x)
= { applying fmap }
Leaf ((g . h) x)
= { using (g . h) x = g (h (x)) }
Leaf (g (h (x)))
= { unapplying fmap }
fmap g (Leaf (h (x)))
= { unapplying fmap }
fmap g (fmap h (Leaf x))
= { using (g . h) x = g (h (x)) }
fmap g . fmap h (Leaf x)

case 2:
fmap (g . h) (Node l r)
= { applying fmap }
Node (fmap (g . h) l) (fmap (g . h) r)
= { induction hypothesis }
Node (fmap g . fmap h l) (fmap g . fmap h r)
= { unapplying fmap }
fmap g (Node (fmap h l) (fmap h r))
= { unapplying fmap }
fmap g (fmap h (Node l r))
= { using (g . h) x = g (h (x)) }
fmap g . fmap h (Node l r)
```