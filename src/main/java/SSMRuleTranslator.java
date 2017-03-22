import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.tree.TerminalNode;

/**
 * Created by root on 3/22/17.
 */

public class SSMRuleTranslator extends SSMRuleBaseListener {

  private ParseTreeWalker walker;
  public SSMRuleTranslator(ParseTreeWalker walker) {
    this.walker = walker;
  }

  @Override
  public void enterSsmrule(SSMRuleParser.SsmruleContext ctx) {
    System.out.println("XXXXXXXXXXXXXXX");
  }

  @Override
  public void enterObject(SSMRuleParser.ObjectContext ctx) {
    TerminalNode tm = ctx.OBJECTTYPE(); ctx.
  }

}