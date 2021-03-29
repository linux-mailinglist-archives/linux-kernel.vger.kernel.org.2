Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A734C247
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 05:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2Dpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 23:45:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15368 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhC2Dpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 23:45:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F7z273cjpz9sJy;
        Mon, 29 Mar 2021 11:43:27 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 11:45:23 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <valentin.schneider@arm.com>, <maz@kernel.org>,
        <dbrazdil@google.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <heying24@huawei.com>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <johnny.chenyi@huawei.com>,
        Chen Lifu <chenlifu@huawei.com>
Subject: [PATCH v2 -next] arm64: smp: Add missing prototype for some smp.c functions
Date:   Mon, 29 Mar 2021 11:43:43 +0800
Message-ID: <20210329034343.183974-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210328172147.GA19252@arm.com>
References: <20210328172147.GA19252@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.78]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit eb631bb5bf5b
("arm64: Support arch_irq_work_raise() via self IPIs") a new
function "arch_irq_work_raise" was added without a prototype.

In commit d914d4d49745
("arm64: Implement panic_smp_self_stop()") a new
function "panic_smp_self_stop" was added without a prototype.

We get the following warnings on W=1:
arch/arm64/kernel/smp.c:842:6: warning: no previous prototype
for ‘arch_irq_work_raise’ [-Wmissing-prototypes]
arch/arm64/kernel/smp.c:862:6: warning: no previous prototype
for ‘panic_smp_self_stop’ [-Wmissing-prototypes]

Fix the warnings by:
1. Adding the prototype for 'arch_irq_work_raise' in irq_work.h
2. Adding the prototype for 'panic_smp_self_stop' in smp.h

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
v2:
- move the prototype for 'panic_smp_self_stop' to smp.h
 arch/arm64/include/asm/irq_work.h | 2 ++
 arch/arm64/include/asm/smp.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index a1020285ea75..81bbfa3a035b 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
+extern void arch_irq_work_raise(void);
+
 static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index bcb01ca15325..0e357757c0cc 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -145,6 +145,7 @@ bool cpus_are_stuck_in_kernel(void);
 
 extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
+extern void panic_smp_self_stop(void);
 
 #endif /* ifndef __ASSEMBLY__ */
 
-- 
2.17.1

