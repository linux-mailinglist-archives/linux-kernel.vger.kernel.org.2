Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97A640F58A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbhIQKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343827AbhIQKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33BA860EE9;
        Fri, 17 Sep 2021 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872975;
        bh=rRN+dRkB07oTWDgm++HlT1MUWqQ5/Tvyx1ROrsg7Hek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpRs5iI+/yX6Nnhu9FD6z1zP5W0H1gr7GUNodccxVpfBja06OZ+eNV9JoStmeLUTy
         +zd7kA0/zvzNlSCkhM2rPWiEhplTQ9LIZ7GR6dqIWJ+VYVu1mpeA7YvNKLolz3jt2N
         hviqJsYw10AihmbUQavJDX5cj17xgVdwDsmI9EPsBSpi/lnjpsw0ax5GrBEMefZWLO
         3NMJTLJYoH2HqWX7iUJPCe9liqD9442Ljs1MwQtRT0ddLfR/ICpSR9SrHCxXsbO8Fb
         a2GpPmur+JhFyh7TPUNyGqWf3FIQLkx2fvhnFYON0UC2TB1Hha4aiIiXJy1A63eCNv
         anjoil48VRTXA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/7] bootconfig: Remove unused debug function
Date:   Fri, 17 Sep 2021 19:02:53 +0900
Message-Id: <163187297371.2366983.12943349701785875450.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163187294400.2366983.7393164788107844569.stgit@devnote2>
References: <163187294400.2366983.7393164788107844569.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused xbc_debug_dump() from bootconfig for clean up
the code.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |    3 ---
 lib/bootconfig.c           |   21 ---------------------
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

