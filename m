Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AF40B212
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhINOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhINOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:51:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2D46113B;
        Tue, 14 Sep 2021 14:50:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mQ9lZ-001oPc-M6; Tue, 14 Sep 2021 10:50:33 -0400
Message-ID: <20210914145033.522789625@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Sep 2021 10:48:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/2] bootconfig: Free copied bootconfig data after boot
References: <20210914144809.297030763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Free copied bootconfig data after booting kernel because that
data will not be used anymore.

commit 40caa127f3c7 ("init: bootconfig: Remove all bootconfig
data when the init memory is removed") freed the bootconfig
xbc_node array after booting kernel, but forgot to free the
bootconfig data itself. This fixes that to free the bootconfig
data too.

This also frees the bootconfig data if the bootconfig data
parsing failed.

Link: https://lkml.kernel.org/r/163151166275.369741.12201304720604568345.stgit@devnote2

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
 
-- 
2.32.0
