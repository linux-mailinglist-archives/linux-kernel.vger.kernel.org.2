Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC42840F589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbhIQKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343837AbhIQKEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:04:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B58160FBF;
        Fri, 17 Sep 2021 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872983;
        bh=Tk1rlSCmD9t0aOKgyjW/Zd8gac9u7fKg0dL3FKV5yck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLb0igchEnCKby90oaeoaSCAW7Xneil//icLT24dsOPMNDUedjKXGn2NonoQ7t3DX
         PrvjKmrDiGaJSTbcSP6X+l70IBtiW0D00yE0xZprXuFAECPqq14AGiqQTMnuo/9XU/
         fNEGqVDO98vg4Q6AXMJnZdgVv7wwOuE2QRPflHLl+O1K93ZBEI3uzV+HNobahDxYKP
         IyCehX9tqtq3H5BBY9n5ynk2IgY9dzjt/ILXxkUNcOfRard94LwoL0IbxfNOs2FI6Z
         Ddh0toB4CWDZqLs+9CvWzYzWuIs8SMwVnqfyGTcHMNvph/ir1e2A2hGC2hfVC0DTfu
         WWSNC2LKbagRg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/7] tools/bootconfig: Print all error message in stderr
Date:   Fri, 17 Sep 2021 19:03:01 +0900
Message-Id: <163187298106.2366983.15210300267326257397.stgit@devnote2>
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

Print all error message in stderr. This also removes
unneeded tools/bootconfig/include/linux/printk.h.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/include/linux/kernel.h |    2 --
 tools/bootconfig/include/linux/printk.h |   14 --------------
 tools/bootconfig/main.c                 |    2 ++
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

