Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D34437F83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJVUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F916112F;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sy-000QH2-1e;
        Fri, 22 Oct 2021 16:48:40 -0400
Message-ID: <20211022204839.888916364@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/40] bootconfig: Remove unused debug function
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Remove unused xbc_debug_dump() from bootconfig for clean up
the code.

Link: https://lkml.kernel.org/r/163187297371.2366983.12943349701785875450.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h |  3 ---
 lib/bootconfig.c           | 21 ---------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 7eb7a7f8ade7..85cdfd381877 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -279,7 +279,4 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init xbc_exit(void);
 
-/* Debug dump functions */
-void __init xbc_debug_dump(void);
-
 #endif
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b7e5a32b30d3..953789171858 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,15 +4,12 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#define pr_fmt(fmt)    "bootconfig: " fmt
-
 #include <linux/bootconfig.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
-#include <linux/printk.h>
 #include <linux/string.h>
 
 /*
@@ -940,21 +937,3 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 
 	return ret;
 }
-
-/**
- * xbc_debug_dump() - Dump current XBC node list
- *
- * Dump the current XBC node list on printk buffer for debug.
- */
-void __init xbc_debug_dump(void)
-{
-	int i;
-
-	for (i = 0; i < xbc_node_num; i++) {
-		pr_debug("[%d] %s (%s) .next=%d, .child=%d .parent=%d\n", i,
-			xbc_node_get_data(xbc_nodes + i),
-			xbc_node_is_value(xbc_nodes + i) ? "value" : "key",
-			xbc_nodes[i].next, xbc_nodes[i].child,
-			xbc_nodes[i].parent);
-	}
-}
-- 
2.33.0
