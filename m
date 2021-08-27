Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2742B3F9242
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbhH0CRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhH0CRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:17:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F5960E97;
        Fri, 27 Aug 2021 02:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630030576;
        bh=HaqS4HZ1EJWty1/MWGdQEXTnj8+AAnJyTFmkJPax9fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvdyvfOXRLrP0Dgp2nBpUIlaapCfHxRA7vg+Y6FIINV3t+bFB5RVWP1UzeC4NMD4C
         NzFGaPTPzx+e97a6B+IRWZKGcyn3pPwX0dqvM7YerlQBwnsZPFq3bqzcbCYHB9R1Ao
         PYhuWuFVQAmSbUL7C4K1irEnM+onTkKd7aOBDm7Ak9At+qwjZloRTpnNEyz6+n6sQZ
         r9pA1tPCNogj9xMVpKg81TjhGDLjJVsfiqQvfzqcWOAFv3HmfJe3Jm22uyLYxTZMjy
         yBCmkP4ZcI730scxu2hspWuwrMMAHk5/B+9RY3dEaJ8z9x6xVN6zgpP7x1yTlKr516
         GntErPOqNuSWA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] init: bootconfig: Remove all bootconfig data when the init memory is removed
Date:   Fri, 27 Aug 2021 11:16:15 +0900
Message-Id: <163003057476.284890.18160956322745559349.stgit@devnote2>
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

Since the bootconfig is used only in the init functions,
it doesn't need to keep the data after boot. Free it when
the init memory is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - introduce exit_boot_config() wrapper for !CONFIG_BOOT_CONFIG
---
 init/main.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 8d97aba78c3a..d35c4a865adb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -468,7 +468,12 @@ static void __init setup_boot_config(void)
 	return;
 }
 
-#else
+static void __init exit_boot_config(void)
+{
+	xbc_destroy_all();
+}
+
+#else	/* !CONFIG_BOOT_CONFIG */
 
 static void __init setup_boot_config(void)
 {
@@ -481,7 +486,11 @@ static int __init warn_bootconfig(char *str)
 	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
 	return 0;
 }
-#endif
+
+#define exit_boot_config()	do {} while (0)
+
+#endif	/* CONFIG_BOOT_CONFIG */
+
 early_param("bootconfig", warn_bootconfig);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
@@ -1493,6 +1502,7 @@ static int __ref kernel_init(void *unused)
 	kprobe_free_init_mem();
 	ftrace_free_init_mem();
 	kgdb_free_init_mem();
+	exit_boot_config();
 	free_initmem();
 	mark_readonly();
 

