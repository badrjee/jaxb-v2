#!/bin/sh
#
# The contents of this file are subject to the terms
# of the Common Development and Distribution License
# (the "License").  You may not use this file except
# in compliance with the License.
# 
# You can obtain a copy of the license at
# https://jwsdp.dev.java.net/CDDLv1.0.html
# See the License for the specific language governing
# permissions and limitations under the License.
# 
# When distributing Covered Code, include this CDDL
# HEADER in each file and include the License file at
# https://jwsdp.dev.java.net/CDDLv1.0.html  If applicable,
# add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your
# own identifying information: Portions Copyright [yyyy]
# [name of copyright owner]
#

#
# Make sure that JAXB_HOME and JAVA_HOME are set
#
if [ -z "$JAXB_HOME" ]
then
    # search the installation directory
    
    PRG=$0
    progname=`basename $0`
    saveddir=`pwd`
    
    cd `dirname $PRG`
    
    while [ -h "$PRG" ] ; do
        ls=`ls -ld "$PRG"`
        link=`expr "$ls" : '.*-> \(.*\)$'`
        if expr "$link" : '.*/.*' > /dev/null; then
            PRG="$link"
        else
            PRG="`dirname $PRG`/$link"
        fi
    done
    
    JAXB_HOME=`dirname "$PRG"`/..
    
    # make it fully qualified
    cd "$saveddir"
    JAXB_HOME=`cd "$JAXB_HOME" && pwd`
    
    cd $saveddir
fi

if [ -n "$CLASSPATH" ] ; then
  LOCALCLASSPATH="$CLASSPATH"
fi

# add the api jar file
if [ -z "$LOCALCLASSPATH" ] ; then
    LOCALCLASSPATH="$JAXB_HOME"/lib/jaxb-api.jar:"$JAXB_HOME"/lib/jaxb-xjc.jar
else
    LOCALCLASSPATH="$JAXB_HOME"/lib/jaxb-api.jar:"$JAXB_HOME"/lib/jaxb-xjc.jar:"$LOCALCLASSPATH"
fi


if [ -n "$JAVA_HOME" ]
then
    JAVA="$JAVA_HOME"/bin/java
    LOCALCLASSPATH="$JAVA_HOME"/lib/tools.jar:"$LOCALCLASSPATH"
else
    JAVA=java
    JAVACMD=`which $JAVA`
    BINDIR=`dirname $JAVACMD`
    LOCALCLASSPATH="$BINDIR"/../lib/tools.jar:"$LOCALCLASSPATH"
fi
[ `expr \`uname\` : 'CYGWIN'` -eq 6 ] &&
{
    LOCALCLASSPATH=`cygpath -w -p ${LOCALCLASSPATH}`
}

if [ `expr \`uname\` : 'CYGWIN'` -eq 6 ]
then
    JAXB_HOME="`cygpath -w "$JAXB_HOME"`"
fi


exec "$JAVA"  $XJC_OPTS -cp "$LOCALCLASSPATH" com.sun.tools.jxc.apt.SchemaGeneratorWrapper "$@"
