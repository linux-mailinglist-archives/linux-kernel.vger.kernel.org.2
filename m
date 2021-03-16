Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C065B33CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCPEIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:08:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13542 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCPEIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:08:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F008S5cBLzPjr7;
        Tue, 16 Mar 2021 12:06:16 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 12:08:30 +0800
From:   He Ying <heying24@huawei.com>
To:     <peterz@infradead.org>, <mingo@kernel.org>, <frederic@kernel.org>,
        <paulmck@kernel.org>, <christophe.leroy@csgroup.eu>,
        <clg@kaod.org>, <qais.yousef@arm.com>
CC:     <johnny.chenyi@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] smp: kernel/panic.c - silence warnings
Date:   Tue, 16 Mar 2021 00:08:19 -0400
Message-ID: <20210316040819.29085-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found these warnings in kernel/panic.c by using sparse tool:
warning: symbol 'panic_smp_self_stop' was not declared.
warning: symbol 'nmi_panic_self_stop' was not declared.
warning: symbol 'crash_smp_send_stop' was not declared.

To avoid them, add declarations for these three functions in
include/linux/smp.h.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
 include/linux/smp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..861a253cc179 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -50,6 +50,14 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+/*
+ * Cpus stopping functions in panic. All have default weak definations.
+ * Architecure dependent code may override them.
+ */
+void panic_smp_self_stop(void);
+void nmi_panic_self_stop(struct pt_regs *regs);
+void crash_smp_send_stop(void);
+
 /*
  * Call a function on all processors
  */
-- 
2.17.1

