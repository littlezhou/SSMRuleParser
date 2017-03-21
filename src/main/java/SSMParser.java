import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.List;

/**
 * Created by root on 3/21/17.
 */
public class SSMParser {
  public static class SSMRuleErrorListener extends BaseErrorListener {
    @Override
    public void syntaxError(Recognizer<?, ?> recognizer,
                            Object offendingSymbol,
                            int line, int charPositionInLine,
                            String msg,
                            RecognitionException e)
    {
      List<String> stack = ((Parser)recognizer).getRuleInvocationStack();
      Collections.reverse(stack);
      System.err.println("rule stack: "+stack);
      System.err.println("line "+line+":"+charPositionInLine+" at "+
          offendingSymbol+": "+msg);
    }
  }

  public void parseRule() throws IOException {
    String ruleFileName = "test_1.rule";
    String currDir = System.getProperty("user.dir");
    String ruleFilePath = currDir + "/src/main/java/" + ruleFileName;
    //System.out.println("Current directory: " + currDir);
    InputStream input;
    input = new FileInputStream(ruleFilePath);
    ANTLRInputStream antlrInput = new ANTLRInputStream(input);
    SSMRuleLexer lexer = new SSMRuleLexer(antlrInput);
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    SSMRuleParser parser = new SSMRuleParser(tokens);
    parser.removeErrorListeners();
    parser.addErrorListener(new SSMRuleErrorListener());
    ParseTree tree = parser.ssmrule();
    System.out.println("Parser tree: " + tree.toStringTree(parser));
  }

  public static void main(String[] args) throws Exception {
    new SSMParser().parseRule();
  }
}
