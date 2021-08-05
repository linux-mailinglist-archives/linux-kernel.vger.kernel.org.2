Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBDB3E0C55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhHECLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhHECLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C24E261073;
        Thu,  5 Aug 2021 02:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628129453;
        bh=e4sEkXFMdDCll8XB9qCZ+VnHcmQ6GvRT0CFeXKa7oco=;
        h=From:To:Cc:Subject:Date:From;
        b=QPO24gT+5Qhkd1nT3cdsffaJCIiMlKIHW4CT3XN4ejoO/iTU+I3iVXgf+Nhcspbe0
         H3uXuxHh4AElHWx59HVKZQFw0p4RcXnqDVOdZX3d4ni1aZwcM3eZ5NBjbrmggcHUpd
         jUFLj2nm7+tEJ9Hzfo32Tq0sMRwj3CtelFYcpOAcukpq7okUJgzbxP9hEJElEx5MxV
         OHsgj8tDOopbyf0msIiftFEjffyS09VRlqFZS4CMiCu8m+8Znx5g7iuODdHtpVJyjs
         LVgG7jrn+LlcWzzFvsyu3fg256PXXI7qnURSOJLuAlV6ZKP5f2TTmrBIK3FYx7jTTV
         s/1xSD16ztjew==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] init: Suppress wrong warning for bootconfig cmdline parameter
Date:   Thu,  5 Aug 2021 11:10:51 +0900
Message-Id: <162812945097.77369.1849780946468010448.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 'bootconfig' command line parameter is handled before
parsing the command line, it doesn't use early_param(). But in
this case, kernel shows a wrong warning message about it.

[    0.013714] Kernel command line: ro console=ttyS0  bootconfig console=tty0
[    0.013741] Unknown command line parameters: bootconfig

To suppress this message, add a dummy handler for 'bootconfig'.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..8d97aba78c3a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
 	return 0;
 }
 
+static int __init warn_bootconfig(char *str)
+{
+	/* The 'bootconfig' has been handled by bootconfig_params(). */
+	return 0;
+}
+
 static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
@@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
 	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
 	return 0;
 }
-early_param("bootconfig", warn_bootconfig);
-
 #endif
+early_param("bootconfig", warn_bootconfig);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
 static void __init repair_env_string(char *param, char *val)

