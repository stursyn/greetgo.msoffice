package kz.greetgo.gbatis.modelreader;

public class NoXmlRequestIdException extends RuntimeException {
  
  public NoXmlRequestIdException() {}
  
  public NoXmlRequestIdException(String message, Throwable cause) {
    super(message, cause);
  }
  
  public NoXmlRequestIdException(String message) {
    super(message);
  }
  
  public NoXmlRequestIdException(Throwable cause) {
    super(cause);
  }
  
}
