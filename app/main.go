package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "os"
    "time"
)

type Response struct {
    Timestamp string `json:"timestamp"`
    Hostname  string `json:"hostname"`
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
    hostname, err := os.Hostname()
    if err != nil {
        http.Error(w, "Unable to get hostname", http.StatusInternalServerError)
        return
    }

    response := Response{
        Timestamp: time.Now().Format(time.RFC3339),
        Hostname:  hostname,
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(response)
}

func main() {
    http.HandleFunc("/", helloHandler)
    fmt.Println("Starting server on :8080")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Println("Failed to start server:", err)
    }
}
