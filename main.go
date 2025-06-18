package main

import (
	"fmt"

	p4api "github.com/perforce/p4go/p4"
)

func main() {
	p4 := p4api.New()
	_, err := p4.Connect()
	if err != nil {
		fmt.Println("Error connecting to P4:", err)
		return
	}
	fmt.Println("Connected to P4 server:", p4.Port())
	info, err := p4.Run("info")
	if err != nil {
		fmt.Println("Error running 'info' command:", err)
		return
	}

	infoDict := info[0].(p4api.Dictionary)
	fmt.Printf("Info: %+v\n", infoDict)
}
