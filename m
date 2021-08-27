Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4F3F9243
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbhH0CRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhH0CRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 733F8608FB;
        Fri, 27 Aug 2021 02:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630030584;
        bh=J7duBNM3xhrPDaN1rlHXuHpiOuTyBRbTeVxcokgMprc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAnGP/tmomlqk7cN2yIVPGZzT+pc9X7pwnJO/iUmpGs9LKTnIO2xexzMzccBAkIi6
         N3pkAYWdbSKkS8Bui57VcewYNA2/5ob0B5Sf/TFIX+NH15pD4sYbjpqGPFS6NL5duU
         vzoTD3dn2RAbc1O9nMKf5vlS3wO/uyeRodpLMa6u9xl0u9wAagn2lwQWTwGbtzS+1S
         gdvMTZkN0VYcDRhE+PyK+J36fbVlxoGNWV9n8ocbljstINZPeGLI16btmHQt5cWP/z
         u5oZdKxh0dtrB6d6gMMtBYmNjHamYYK22yszklVnrEBd3ifbtT6yjWnFc0DpT0nEFv
         w/ZS8nNT+lP8Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] init/bootconfig: Reorder init parameter from bootconfig and cmdline
Date:   Fri, 27 Aug 2021 11:16:22 +0900
Message-Id: <163003058198.284890.11970279075103894801.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163003056713.284890.5878333391812608469.stgit@devnote2>
References: <163003056713.284890.5878333391812608469.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the init parameters from bootconfig and kernel cmdline
so that the kernel cmdline always be the last part of the
parameters as below.

 " -- "[bootconfig init params][cmdline init params]

This change will help us to prevent that bootconfig init params
overwrite the init params which user gives in the command line.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   23 ++++++++++++++---------
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
 

