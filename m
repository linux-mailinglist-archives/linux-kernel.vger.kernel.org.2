Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4409834B4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhC0HHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:07:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14157 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhC0HHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:07:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6qb40s4RzndhZ;
        Sat, 27 Mar 2021 15:04:32 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 15:06:57 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <valentin.schneider@arm.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <heying24@huawei.com>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <johnny.chenyi@huawei.com>,
        Chen Lifu <chenlifu@huawei.com>
Subject: [PATCH -next] arm64: smp: Add missing prototype for some smp.c functions
Date:   Sat, 27 Mar 2021 15:06:51 +0800
Message-ID: <20210327070651.70773-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
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
function "arch_irq_work_raise" was added without a prototype
in header irq_work.h

In commit d914d4d49745
("arm64: Implement panic_smp_self_stop()") a new
function "panic_smp_self_stop" was added without a prototype
in header irq_work.h

We get the following warnings on W=1:
arch/arm64/kernel/smp.c:842:6: warning: no previous prototype
for ‘arch_irq_work_raise’ [-Wmissing-prototypes]
arch/arm64/kernel/smp.c:862:6: warning: no previous prototype
for ‘panic_smp_self_stop’ [-Wmissing-prototypes]

Fix the same by adding the missing prototype in header irq_work.h

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/arm64/include/asm/irq_work.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index a1020285ea75..f766e2190e7c 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
+extern void arch_irq_work_raise(void);
+extern void panic_smp_self_stop(void);
+
 static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
-- 
2.17.1

