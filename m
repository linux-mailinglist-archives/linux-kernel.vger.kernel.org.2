Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2DD403FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350813AbhIHTVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350225AbhIHTV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5E761158;
        Wed,  8 Sep 2021 19:20:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014YS-0y; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191953.867680714@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/12] init: bootconfig: Remove all bootconfig data when the init memory is
 removed
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the bootconfig is used only in the init functions,
it doesn't need to keep the data after boot. Free it when
the init memory is removed.

Link: https://lkml.kernel.org/r/163077084958.222577.5924961258513004428.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 14 ++++++++++++--
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
 
-- 
2.32.0
