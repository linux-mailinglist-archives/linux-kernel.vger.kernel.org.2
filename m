Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F605437F84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhJVUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234370AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAE761246;
        Fri, 22 Oct 2021 20:48:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sy-000QHa-7j;
        Fri, 22 Oct 2021 16:48:40 -0400
Message-ID: <20211022204840.071507869@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/40] tools/bootconfig: Print all error message in stderr
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Print all error message in stderr. This also removes
unneeded tools/bootconfig/include/linux/printk.h.

Link: https://lkml.kernel.org/r/163187298106.2366983.15210300267326257397.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/include/linux/kernel.h |  2 --
 tools/bootconfig/include/linux/printk.h | 14 --------------
 tools/bootconfig/main.c                 |  2 ++
 3 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 tools/bootconfig/include/linux/printk.h

diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
index 2d93320aa374..c4854b8e7023 100644
--- a/tools/bootconfig/include/linux/kernel.h
+++ b/tools/bootconfig/include/linux/kernel.h
@@ -5,8 +5,6 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
-#include <linux/printk.h>
-
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
deleted file mode 100644
index 036e667596eb..000000000000
--- a/tools/bootconfig/include/linux/printk.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_PRINTK_H
-#define _SKC_LINUX_PRINTK_H
-
-#include <stdio.h>
-
-#define printk(fmt, ...) printf(fmt, ##__VA_ARGS__)
-
-#define pr_err printk
-#define pr_warn	printk
-#define pr_info	printk
-#define pr_debug printk
-
-#endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4252c23bd35d..adc6c6e73fa9 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
+#define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
-- 
2.33.0
