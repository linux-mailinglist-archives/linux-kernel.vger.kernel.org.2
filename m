Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30D40B246
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhINO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhINO5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:57:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDEA60FD7;
        Tue, 14 Sep 2021 14:56:21 +0000 (UTC)
Date:   Tue, 14 Sep 2021 10:56:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-ID: <20210914105620.677b90e5@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A couple of memory management fixes to the bootconfig code


Please pull the latest trace-v5.15-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc1

Tag SHA1: 04c8861530c8c66f00918702374668e8e8b230af
Head SHA1: 8e9f0934a07e699044d422ca9cfb553f25c72b41


Masami Hiramatsu (2):
      bootconfig: Fix to check the xbc_node is used before free it
      bootconfig: Free copied bootconfig data after boot

----
 init/main.c      | 8 ++++++++
 lib/bootconfig.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)
---------------------------
diff --git a/init/main.c b/init/main.c
index d08caed17c7f..ddbcb372225a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -319,6 +319,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 #ifdef CONFIG_BOOT_CONFIG
 
 static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static void *init_xbc_data_copy __initdata;
+static phys_addr_t init_xbc_data_size __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
@@ -458,18 +460,24 @@ static void __init setup_boot_config(void)
 		else
 			pr_err("Failed to parse bootconfig: %s at %d.\n",
 				msg, pos);
+		memblock_free(__pa(copy), size + 1);
 	} else {
 		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
+		init_xbc_data_copy = copy;
+		init_xbc_data_size = size + 1;
 	}
 	return;
 }
 
 static void __init exit_boot_config(void)
 {
+	if (!init_xbc_data_copy)
+		return;
+	memblock_free(__pa(init_xbc_data_copy), init_xbc_data_size);
 	xbc_destroy_all();
 }
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f8419cff1147..4f8849706ef6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -792,7 +792,8 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
+	if (xbc_nodes)
+		memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
