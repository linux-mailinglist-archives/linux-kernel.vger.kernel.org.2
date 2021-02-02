Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6531B30B3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBBAOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBBAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:14:06 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E9C061573;
        Mon,  1 Feb 2021 16:13:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8040849B;
        Tue,  2 Feb 2021 00:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8040849B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612224806; bh=mC5DYKkweiqxOilqrvYYf8Aa6yGW0+baHFWk2tJrhiw=;
        h=From:To:Cc:Subject:Date:From;
        b=ShcOrqj4oAY/RzEg1pdqN9CFKnIknh97/iZpOrAeszZxjjHMU+Ox9HCLX617z72DP
         GJtSkK068v+5ZXC+SyWw8xdnjTPeOlOGKUlwfcHJk9rwDMaoi5J2T2iKXC1mzASsyj
         SKhxnXf3dCl3WOFUAeyHEWZ4eOke42XNXaQJZrO3pUXeor5mytEnVrKJiMR1XDMWDv
         x3TLoPLOnqyPgXfW8XP2uLbYq/Ylcc/cE9gtskNkt+uInX4+HYe2jzYREOlw32ozAg
         zCkkJiasi0eYNWoSJozmp1gXBy3gRG8cNoHqrpVgdfg30RIclgePgjZ6wZmrxpFOY5
         FIG4tYMX9ziVg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH] Move our minimum Sphinx version to 1.7
Date:   Mon, 01 Feb 2021 17:13:26 -0700
Message-ID: <87zh0ntjh5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, drop support for some ancient sphinx releases, along with a
lot of the cruft that was required to make that support work.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
Gotta love the diffstat :)

 Documentation/conf.py               | 75 ++---------------------------
 Documentation/sphinx/cdomain.py     |  8 +--
 Documentation/sphinx/kernel_abi.py  | 27 ++---------
 Documentation/sphinx/kernel_feat.py | 25 ++--------
 Documentation/sphinx/kerneldoc.py   | 26 ++--------
 Documentation/sphinx/kernellog.py   | 26 +++-------
 6 files changed, 21 insertions(+), 166 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 6a767294887e..5bd45d5fb0a0 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -31,7 +31,7 @@ from load_config import loadConfig
 # -- General configuration ------------------------------------------------
 
 # If your documentation needs a minimal Sphinx version, state it here.
-needs_sphinx = '1.3'
+needs_sphinx = '1.7'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
@@ -112,19 +112,12 @@ if major >= 3:
 
 else:
     extensions.append('cdomain')
-    if major == 1 and minor < 7:
-        sys.stderr.write('WARNING: Sphinx 1.7 or greater will be required as of '
-                         'the 5.12 release\n')
 
 # Ensure that autosectionlabel will produce unique names
 autosectionlabel_prefix_document = True
 autosectionlabel_maxdepth = 2
 
-# The name of the math extension changed on Sphinx 1.4
-if (major == 1 and minor > 3) or (major > 1):
-    extensions.append("sphinx.ext.imgmath")
-else:
-    extensions.append("sphinx.ext.pngmath")
+extensions.append("sphinx.ext.imgmath")
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
@@ -375,71 +368,9 @@ if cjk_cmd.find("Noto Sans CJK SC") >= 0:
      '''
 
 # Fix reference escape troubles with Sphinx 1.4.x
-if major == 1 and minor > 3:
+if major == 1:
     latex_elements['preamble']  += '\\renewcommand*{\\DUrole}[2]{ #2 }\n'
 
-if major == 1 and minor <= 4:
-    latex_elements['preamble']  += '\\usepackage[margin=0.5in, top=1in, bottom=1in]{geometry}'
-elif major == 1 and (minor > 5 or (minor == 5 and patch >= 3)):
-    latex_elements['sphinxsetup'] = 'hmargin=0.5in, vmargin=1in'
-    latex_elements['preamble']  += '\\fvset{fontsize=auto}\n'
-
-# Customize notice background colors on Sphinx < 1.6:
-if major == 1 and minor < 6:
-   latex_elements['preamble']  += '''
-        \\usepackage{ifthen}
-
-        % Put notes in color and let them be inside a table
-	\\definecolor{NoteColor}{RGB}{204,255,255}
-	\\definecolor{WarningColor}{RGB}{255,204,204}
-	\\definecolor{AttentionColor}{RGB}{255,255,204}
-	\\definecolor{ImportantColor}{RGB}{192,255,204}
-	\\definecolor{OtherColor}{RGB}{204,204,204}
-        \\newlength{\\mynoticelength}
-        \\makeatletter\\newenvironment{coloredbox}[1]{%
-	   \\setlength{\\fboxrule}{1pt}
-	   \\setlength{\\fboxsep}{7pt}
-	   \\setlength{\\mynoticelength}{\\linewidth}
-	   \\addtolength{\\mynoticelength}{-2\\fboxsep}
-	   \\addtolength{\\mynoticelength}{-2\\fboxrule}
-           \\begin{lrbox}{\\@tempboxa}\\begin{minipage}{\\mynoticelength}}{\\end{minipage}\\end{lrbox}%
-	   \\ifthenelse%
-	      {\\equal{\\py@noticetype}{note}}%
-	      {\\colorbox{NoteColor}{\\usebox{\\@tempboxa}}}%
-	      {%
-	         \\ifthenelse%
-	         {\\equal{\\py@noticetype}{warning}}%
-	         {\\colorbox{WarningColor}{\\usebox{\\@tempboxa}}}%
-		 {%
-	            \\ifthenelse%
-	            {\\equal{\\py@noticetype}{attention}}%
-	            {\\colorbox{AttentionColor}{\\usebox{\\@tempboxa}}}%
-		    {%
-	               \\ifthenelse%
-	               {\\equal{\\py@noticetype}{important}}%
-	               {\\colorbox{ImportantColor}{\\usebox{\\@tempboxa}}}%
-	               {\\colorbox{OtherColor}{\\usebox{\\@tempboxa}}}%
-		    }%
-		 }%
-	      }%
-        }\\makeatother
-
-        \\makeatletter
-        \\renewenvironment{notice}[2]{%
-          \\def\\py@noticetype{#1}
-          \\begin{coloredbox}{#1}
-          \\bf\\it
-          \\par\\strong{#2}
-          \\csname py@noticestart@#1\\endcsname
-        }
-	{
-          \\csname py@noticeend@\\py@noticetype\\endcsname
-          \\end{coloredbox}
-        }
-	\\makeatother
-
-     '''
-
 # With Sphinx 1.6, it is possible to change the Bg color directly
 # by using:
 #	\definecolor{sphinxnoteBgColor}{RGB}{204,255,255}
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index 014a5229e57a..ca8ac9e59ded 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -236,13 +236,7 @@ class CObject(Base_CObject):
 
         indextext = self.get_index_text(name)
         if indextext:
-            if major == 1 and minor < 4:
-                # indexnode's tuple changed in 1.4
-                # https://github.com/sphinx-doc/sphinx/commit/e6a5a3a92e938fcd75866b4227db9e0524d58f7c
-                self.indexnode['entries'].append(
-                    ('single', indextext, targetname, ''))
-            else:
-                self.indexnode['entries'].append(
+            self.indexnode['entries'].append(
                     ('single', indextext, targetname, '', None))
 
 class CDomain(Base_CDomain):
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index f3da859c9878..efe760e410c4 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -45,17 +45,7 @@ from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from docutils.utils.error_reporting import ErrorString
-
-#
-# AutodocReporter is only good up to Sphinx 1.7
-#
-import sphinx
-
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
+from sphinx.util.docutils import switch_source_input
 
 __version__  = '1.0'
 
@@ -179,16 +169,5 @@ class KernelCmd(Directive):
         return node.children
 
     def do_parse(self, content, node):
-        if Use_SSI:
-            with switch_source_input(self.state, content):
-                self.state.nested_parse(content, 0, node, match_titles=1)
-        else:
-            buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
-
-            self.state.memo.title_styles  = []
-            self.state.memo.section_level = 0
-            self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
-            try:
-                self.state.nested_parse(content, 0, node, match_titles=1)
-            finally:
-                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+        with switch_source_input(self.state, content):
+            self.state.nested_parse(content, 0, node, match_titles=1)
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 2fee04f1dedd..c91ea2b27697 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -42,17 +42,7 @@ from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from docutils.utils.error_reporting import ErrorString
-
-#
-# AutodocReporter is only good up to Sphinx 1.7
-#
-import sphinx
-
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
+from sphinx.util.docutils import switch_source_input
 
 __version__  = '1.0'
 
@@ -154,16 +144,7 @@ class KernelFeat(Directive):
 
         buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
 
-        if Use_SSI:
-            with switch_source_input(self.state, content):
-                self.state.nested_parse(content, 0, node, match_titles=1)
-        else:
-            self.state.memo.title_styles  = []
-            self.state.memo.section_level = 0
-            self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
-            try:
-                self.state.nested_parse(content, 0, node, match_titles=1)
-            finally:
-                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+        with switch_source_input(self.state, content):
+            self.state.nested_parse(content, 0, node, match_titles=1)
 
         return node.children
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index e9857ab904f1..8189c33b9dda 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -37,18 +37,8 @@ import glob
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-
-#
-# AutodocReporter is only good up to Sphinx 1.7
-#
 import sphinx
-
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
-
+from sphinx.util.docutils import switch_source_input
 import kernellog
 
 __version__  = '1.0'
@@ -163,18 +153,8 @@ class KernelDocDirective(Directive):
             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
 
     def do_parse(self, result, node):
-        if Use_SSI:
-            with switch_source_input(self.state, result):
-                self.state.nested_parse(result, 0, node, match_titles=1)
-        else:
-            save = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
-            self.state.memo.title_styles, self.state.memo.section_level = [], 0
-            try:
-                self.state.nested_parse(result, 0, node, match_titles=1)
-            finally:
-                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = save
-
+        with switch_source_input(self.state, result):
+            self.state.nested_parse(result, 0, node, match_titles=1)
 
 def setup(app):
     app.add_config_value('kerneldoc_bin', None, 'env')
diff --git a/Documentation/sphinx/kernellog.py b/Documentation/sphinx/kernellog.py
index 8ac7d274f542..0bc00c138cad 100644
--- a/Documentation/sphinx/kernellog.py
+++ b/Documentation/sphinx/kernellog.py
@@ -4,29 +4,19 @@
 # only goes back to 1.6.  So here's a wrapper layer to keep around for
 # as long as we support 1.4.
 #
+# We don't support 1.4 anymore, but we'll keep the wrappers around until
+# we change all the code to not use them anymore :)
+#
 import sphinx
+from sphinx.util import logging
 
-if sphinx.__version__[:3] >= '1.6':
-    UseLogging = True
-    from sphinx.util import logging
-    logger = logging.getLogger('kerneldoc')
-else:
-    UseLogging = False
+logger = logging.getLogger('kerneldoc')
 
 def warn(app, message):
-    if UseLogging:
-        logger.warning(message)
-    else:
-        app.warn(message)
+    logger.warning(message)
 
 def verbose(app, message):
-    if UseLogging:
-        logger.verbose(message)
-    else:
-        app.verbose(message)
+    logger.verbose(message)
 
 def info(app, message):
-    if UseLogging:
-        logger.info(message)
-    else:
-        app.info(message)
+    logger.info(message)
-- 
2.29.2

