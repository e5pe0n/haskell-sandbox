data Expr = Val Int | Add Expr Expr | Mul Expr Expr

type Cont = [Op]

data Op = EVAL_ADD Expr | EVAL_MUL Expr | ADD Int | MUL Int

eval :: Expr -> Cont -> Int
eval (Val n) c = exec c n
eval (Add x y) c = eval x (EVAL_ADD y : c)
eval (Mul x y) c = eval x (EVAL_MUL y : c)

exec :: Cont -> Int -> Int
exec [] n = n
exec (EVAL_ADD y : c) n = eval y (ADD n : c)
exec (EVAL_MUL y : c) n = eval y (MUL n : c)
exec (ADD n : c) m = exec c (n + m)
exec (MUL n : c) m = exec c (n * m)

value :: Expr -> Int
value e = eval e []

main = do
  print (value (Add (Add (Val 2) (Val 3)) (Val 4))) -- 9
  print (value (Mul (Add (Mul (Val 2) (Val 3)) (Val 4)) (Mul (Add (Val 2) (Val 3)) (Val 4)))) -- 200
