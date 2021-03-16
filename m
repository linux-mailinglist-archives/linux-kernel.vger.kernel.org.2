Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F433D00B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhCPImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:42:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13627 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhCPImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:42:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F06Dc1Yj8z17LwQ;
        Tue, 16 Mar 2021 16:40:16 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 16:42:02 +0800
From:   He Ying <heying24@huawei.com>
To:     <peterz@infradead.org>, <mingo@kernel.org>, <frederic@kernel.org>,
        <paulmck@kernel.org>, <christophe.leroy@csgroup.eu>,
        <clg@kaod.org>, <qais.yousef@arm.com>
CC:     <johnny.chenyi@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] smp: kernel/panic.c - silence warnings
Date:   Tue, 16 Mar 2021 04:41:50 -0400
Message-ID: <20210316084150.75201-1-heying24@huawei.com>
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
V1->V2:
- fix some misspellings

 include/linux/smp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..27008a1c8111 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -50,6 +50,14 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+/*
+ * Cpus stopping functions in panic. All have default weak definitions.
+ * Architecture-dependent code may override them.
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

