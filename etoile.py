import turtle

turtle.bgcolor('red') // couleur du background

star = turtle.Turtle()
star.color("green") // couleur
star.width(15)
star.right(75)
star.forward(250)  // longueur

for i in range(4):
    star.right(144)
    star.forward(250)

turtle.done()
