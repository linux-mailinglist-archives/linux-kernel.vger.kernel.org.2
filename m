Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8103F8434
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhHZJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240568AbhHZJND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C222B6108E;
        Thu, 26 Aug 2021 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629969136;
        bh=CuKF30mP54rpdMbVfNBp1nQNsM/4MrCouKk5WH+V0+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2BbbDR2gx1J2o0nQI0NgNWTjksVonwRQujXA8KzZUrZJOarSRuUNAQie+vxn2ZkX
         QJeBucBxVzd/91krUvnPpqCM4WL/yYS+WVA9RKoaNwaLm9f71pIqhYtDeFW1EWLUna
         2CSvDBSQNEGqnTWEm1+CxWtYzbTmjoaHbm36yn08oU7CsVWtechq/S7YHMpE2p175U
         rVZkpmvg0uENvy0LsOivV56dUAZctnESFN1AxHs+nOG+kt73R22f3JOMny0R+kq5uA
         UIqmli8eXculG/ugGOZ9jMKc3YVGNsxvHAPC9iQn/Eb2wrxAKAo+T7DiGYyODR6kFc
         OB4b9UWbVRstg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] init/bootconfig: Reorder init parameter from bootconfig and cmdline
Date:   Thu, 26 Aug 2021 18:12:14 +0900
Message-Id: <162996913426.236535.9040577893259840567.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162996911932.236535.7533708592332223449.stgit@devnote2>
References: <162996911932.236535.7533708592332223449.stgit@devnote2>
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
index d9b0a99bb2dd..b24a18aebed7 100644
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
@@ -646,16 +646,21 @@ static void __init setup_command_line(char *command_line)
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
 

