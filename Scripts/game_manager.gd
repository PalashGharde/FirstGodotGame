extends Node

@onready var score_label: Label = $ScoreLabel

var score = 0

func addPoints():
	score += 1
	score_label.text = "Score : " + str(score)
