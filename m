Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0053F0214
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHRK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:58:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8877 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhHRK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:57:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GqPrV4twBz8sXX;
        Wed, 18 Aug 2021 18:53:14 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 18:57:17 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 18:57:17 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <liuqi115@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] Make save_all_base_regs and restore_all_base_regs as common macro
Date:   Wed, 18 Aug 2021 15:33:35 +0800
Message-ID: <20210818073336.59678-2-liuqi115@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818073336.59678-1-liuqi115@huawei.com>
References: <20210818073336.59678-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move save_all_base_regs and restore_all_base_regs to <asm/assembler.h>,
as these two macros can be reused in optprobe.
---
 arch/arm64/include/asm/assembler.h            | 52 +++++++++++++++++++
 arch/arm64/kernel/probes/kprobes_trampoline.S | 52 -------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 89faca0e740d..cd912810fc80 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -515,6 +515,58 @@ alternative_endif
 	.pushsection "_kprobe_blacklist", "aw";	\
 	.quad	x;				\
 	.popsection;
+
+	.macro	save_all_base_regs
+	stp x0, x1, [sp, #S_X0]
+	stp x2, x3, [sp, #S_X2]
+	stp x4, x5, [sp, #S_X4]
+	stp x6, x7, [sp, #S_X6]
+	stp x8, x9, [sp, #S_X8]
+	stp x10, x11, [sp, #S_X10]
+	stp x12, x13, [sp, #S_X12]
+	stp x14, x15, [sp, #S_X14]
+	stp x16, x17, [sp, #S_X16]
+	stp x18, x19, [sp, #S_X18]
+	stp x20, x21, [sp, #S_X20]
+	stp x22, x23, [sp, #S_X22]
+	stp x24, x25, [sp, #S_X24]
+	stp x26, x27, [sp, #S_X26]
+	stp x28, x29, [sp, #S_X28]
+	add x0, sp, #PT_REGS_SIZE
+	stp lr, x0, [sp, #S_LR]
+	/*
+	 * Construct a useful saved PSTATE
+	 */
+	mrs x0, nzcv
+	mrs x1, daif
+	orr x0, x0, x1
+	mrs x1, CurrentEL
+	orr x0, x0, x1
+	mrs x1, SPSel
+	orr x0, x0, x1
+	stp xzr, x0, [sp, #S_PC]
+	.endm
+
+	.macro	restore_all_base_regs
+	ldr x0, [sp, #S_PSTATE]
+	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
+	msr nzcv, x0
+	ldp x0, x1, [sp, #S_X0]
+	ldp x2, x3, [sp, #S_X2]
+	ldp x4, x5, [sp, #S_X4]
+	ldp x6, x7, [sp, #S_X6]
+	ldp x8, x9, [sp, #S_X8]
+	ldp x10, x11, [sp, #S_X10]
+	ldp x12, x13, [sp, #S_X12]
+	ldp x14, x15, [sp, #S_X14]
+	ldp x16, x17, [sp, #S_X16]
+	ldp x18, x19, [sp, #S_X18]
+	ldp x20, x21, [sp, #S_X20]
+	ldp x22, x23, [sp, #S_X22]
+	ldp x24, x25, [sp, #S_X24]
+	ldp x26, x27, [sp, #S_X26]
+	ldp x28, x29, [sp, #S_X28]
+	.endm
 #else
 #define NOKPROBE(x)
 #endif
diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
index 288a84e253cc..2463d5d0e004 100644
--- a/arch/arm64/kernel/probes/kprobes_trampoline.S
+++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
@@ -9,58 +9,6 @@
 
 	.text
 
-	.macro	save_all_base_regs
-	stp x0, x1, [sp, #S_X0]
-	stp x2, x3, [sp, #S_X2]
-	stp x4, x5, [sp, #S_X4]
-	stp x6, x7, [sp, #S_X6]
-	stp x8, x9, [sp, #S_X8]
-	stp x10, x11, [sp, #S_X10]
-	stp x12, x13, [sp, #S_X12]
-	stp x14, x15, [sp, #S_X14]
-	stp x16, x17, [sp, #S_X16]
-	stp x18, x19, [sp, #S_X18]
-	stp x20, x21, [sp, #S_X20]
-	stp x22, x23, [sp, #S_X22]
-	stp x24, x25, [sp, #S_X24]
-	stp x26, x27, [sp, #S_X26]
-	stp x28, x29, [sp, #S_X28]
-	add x0, sp, #PT_REGS_SIZE
-	stp lr, x0, [sp, #S_LR]
-	/*
-	 * Construct a useful saved PSTATE
-	 */
-	mrs x0, nzcv
-	mrs x1, daif
-	orr x0, x0, x1
-	mrs x1, CurrentEL
-	orr x0, x0, x1
-	mrs x1, SPSel
-	orr x0, x0, x1
-	stp xzr, x0, [sp, #S_PC]
-	.endm
-
-	.macro	restore_all_base_regs
-	ldr x0, [sp, #S_PSTATE]
-	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
-	msr nzcv, x0
-	ldp x0, x1, [sp, #S_X0]
-	ldp x2, x3, [sp, #S_X2]
-	ldp x4, x5, [sp, #S_X4]
-	ldp x6, x7, [sp, #S_X6]
-	ldp x8, x9, [sp, #S_X8]
-	ldp x10, x11, [sp, #S_X10]
-	ldp x12, x13, [sp, #S_X12]
-	ldp x14, x15, [sp, #S_X14]
-	ldp x16, x17, [sp, #S_X16]
-	ldp x18, x19, [sp, #S_X18]
-	ldp x20, x21, [sp, #S_X20]
-	ldp x22, x23, [sp, #S_X22]
-	ldp x24, x25, [sp, #S_X24]
-	ldp x26, x27, [sp, #S_X26]
-	ldp x28, x29, [sp, #S_X28]
-	.endm
-
 SYM_CODE_START(kretprobe_trampoline)
 	sub sp, sp, #PT_REGS_SIZE
 
-- 
2.17.1

