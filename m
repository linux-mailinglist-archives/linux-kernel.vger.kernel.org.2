Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D5403FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350536AbhIHTVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350508AbhIHTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3600F61179;
        Wed,  8 Sep 2021 19:20:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014Yz-6o; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191954.051463779@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/12] init/bootconfig: Reorder init parameter from bootconfig and cmdline
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Reorder the init parameters from bootconfig and kernel cmdline
so that the kernel cmdline always be the last part of the
parameters as below.

 " -- "[bootconfig init params][cmdline init params]

This change will help us to prevent that bootconfig init params
overwrite the init params which user gives in the command line.

Link: https://lkml.kernel.org/r/163077085675.222577.5665176468023636160.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/init/main.c b/init/main.c
index d35c4a865adb..d08caed17c7f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -153,10 +153,10 @@ static char *extra_init_args;
 #ifdef CONFIG_BOOT_CONFIG
 /* Is bootconfig on command line? */
 static bool bootconfig_found;
-static bool initargs_found;
+static size_t initargs_offs;
 #else
 # define bootconfig_found false
-# define initargs_found false
+# define initargs_offs 0
 #endif
 
 static char *execute_command;
@@ -422,9 +422,9 @@ static void __init setup_boot_config(void)
 	if (IS_ERR(err) || !bootconfig_found)
 		return;
 
-	/* parse_args() stops at '--' and returns an address */
+	/* parse_args() stops at the next param of '--' and returns an address */
 	if (err)
-		initargs_found = true;
+		initargs_offs = err - tmp_cmdline;
 
 	if (!data) {
 		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
@@ -655,16 +655,21 @@ static void __init setup_command_line(char *command_line)
 		 * Append supplemental init boot args to saved_command_line
 		 * so that user can check what command line options passed
 		 * to init.
+		 * The order should always be
+		 * " -- "[bootconfig init-param][cmdline init-param]
 		 */
-		len = strlen(saved_command_line);
-		if (initargs_found) {
-			saved_command_line[len++] = ' ';
+		if (initargs_offs) {
+			len = xlen + initargs_offs;
+			strcpy(saved_command_line + len, extra_init_args);
+			len += ilen - 4;	/* strlen(extra_init_args) */
+			strcpy(saved_command_line + len,
+				boot_command_line + initargs_offs - 1);
 		} else {
+			len = strlen(saved_command_line);
 			strcpy(saved_command_line + len, " -- ");
 			len += 4;
+			strcpy(saved_command_line + len, extra_init_args);
 		}
-
-		strcpy(saved_command_line + len, extra_init_args);
 	}
 }
 
-- 
2.32.0
