/*
 * The contents of this file are subject to the terms
 * of the Common Development and Distribution License
 * (the "License").  You may not use this file except
 * in compliance with the License.
 * 
 * You can obtain a copy of the license at
 * https://jwsdp.dev.java.net/CDDLv1.0.html
 * See the License for the specific language governing
 * permissions and limitations under the License.
 * 
 * When distributing Covered Code, include this CDDL
 * HEADER in each file and include the License file at
 * https://jwsdp.dev.java.net/CDDLv1.0.html  If applicable,
 * add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your
 * own identifying information: Portions Copyright [yyyy]
 * [name of copyright owner]
 */

/**
 * Alias of {@link com.sun.tools.xjc.Driver}, just to make testing easier.
 */
public class Driver
{
	public static void main( String[] args ) throws Exception {
        // since this is only used for testing/debugging,
        // this is a good place to enable assertions.
        ClassLoader loader = Driver.class.getClassLoader();
        if (loader != null)
            loader.setPackageAssertionStatus("com.sun", true);

        // do not write anything here.
        com.sun.tools.xjc.Driver.main(args);
    }
}
