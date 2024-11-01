package com.javarush.jira.common.error;

public class DirectoryCreationException extends RuntimeException {
    public DirectoryCreationException(String message, Throwable cause) {
        super(message, cause);
    }
}