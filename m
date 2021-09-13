Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048804083DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhIMFmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhIMFmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:42:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A8160FED;
        Mon, 13 Sep 2021 05:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631511665;
        bh=isvnjXQAvGPhT0oHosKnKu26KlhYKrH2kGNhw4wK8Ok=;
        h=From:To:Cc:Subject:Date:From;
        b=RJiFPEZzWy9tZvCaGpDZcJlkoxwKLIZJNzhojwKLCUjGmrYSOhqHgGCzaqJAQYISR
         pxj5QNHPn7T1FKlhjcVIaL69xmO0HoStpYvxD0CP9xuCNlCLCLoow+gBPLUTGZ9G6P
         XFf90rFHedtRJSPabfY2PJ1Xs9vUR41SPDoU682ONVcmFra5xdFvdLR7W8bHvb3VPt
         RO6LwH+cHdBAVFqJHPGeq4cJ8y1nxn24hiaxzJFaXmU5syZA2/f6iJjelakQWB53fY
         BqwsBzwzM3pxOvzdtoaiEMR5EJbouiKLAweGjE5Tsje8lmEqBLxue1zD6tyzW2+q/X
         MRYoGjvx1nYpg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] bootconfig: Free copied bootconfig data after boot
Date:   Mon, 13 Sep 2021 14:41:03 +0900
Message-Id: <163151166275.369741.12201304720604568345.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free copied bootconfig data after booting kernel because that
data will not be used anymore.

commit 40caa127f3c7 ("init: bootconfig: Remove all bootconfig
data when the init memory is removed") freed the bootconfig
xbc_node array after booting kernel, but forgot to free the
bootconfig data itself. This fixes that to free the bootconfig
data too.

This also frees the bootconfig data if the bootconfig data
parsing failed.

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/main.c b/init/main.c
index 5c9a48df90e1..dc433d1d5fc4 100644
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
 

