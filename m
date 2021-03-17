Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D137D33F27E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhCQOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:23:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14365 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhCQOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:23:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0slb3gWnz904G;
        Wed, 17 Mar 2021 22:21:15 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 22:23:02 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rui.xiang@huawei.com>
Subject: [PATCH 1/2] stacktrace: Move struct stacktrace_cookie to stacktrace.h
Date:   Wed, 17 Mar 2021 14:20:49 +0000
Message-ID: <20210317142050.57712-2-chenjun102@huawei.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20210317142050.57712-1-chenjun102@huawei.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 need to modify the stacktrace_cookie->skip.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 include/linux/stacktrace.h | 7 +++++++
 kernel/stacktrace.c        | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 50e2df3..238b276 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -25,6 +25,13 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
 /* Internal interfaces. Do not use in generic code */
 #ifdef CONFIG_ARCH_STACKWALK
 
+struct stacktrace_cookie {
+	unsigned long	*store;
+	unsigned int	size;
+	unsigned int	skip;
+	unsigned int	len;
+};
+
 /**
  * stack_trace_consume_fn - Callback for arch_stack_walk()
  * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9f8117c..b072e8f 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -71,13 +71,6 @@ EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
 #ifdef CONFIG_ARCH_STACKWALK
 
-struct stacktrace_cookie {
-	unsigned long	*store;
-	unsigned int	size;
-	unsigned int	skip;
-	unsigned int	len;
-};
-
 static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
 {
 	struct stacktrace_cookie *c = cookie;
-- 
2.9.4

