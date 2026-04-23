#!/bin/bash
kubectl apply -f namespace.yml
kubectl apply -f mysql-deploy.yml
kubectl apply -f mysql-service.yml
kubectl apply -f flask-deploy.yml
kubectl apply -f flask-service.yml