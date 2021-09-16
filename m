Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDB40DA85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhIPNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:01:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16268 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbhIPNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:01:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H9HH20R2jz8tC9;
        Thu, 16 Sep 2021 20:59:42 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:00:20 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:00:19 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Darius Rad <darius@bluespec.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] riscv: Support DCACHE_WORD_ACCESS
Date:   Thu, 16 Sep 2021 13:08:55 +0000
Message-ID: <20210916130855.4054926-3-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916130855.4054926-1-chenhuang5@huawei.com>
References: <20210916130855.4054926-1-chenhuang5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects DCACHE_WORD_ACCESS on riscv and implements support
for load_unaligned_zeropad.

DCACHE_WORD_ACCESS uses the word-at-a-time API for optimised string
comparisons in the vfs layer.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cd0be39d4c08..4e98ff76977f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,6 +44,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..8f4ad1ec39fb 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -45,4 +45,41 @@ static inline unsigned long find_zero(unsigned long mask)
 /* The mask we created is directly usable as a bytemask */
 #define zero_bytemask(mask) (mask)
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+#include <asm/asm.h>
+
+/*
+ * Load an unaligned word from kernel space.
+ *
+ * In the (very unlikely) case of the word being a page-crosser
+ * and the next page not being mapped, take the exception and
+ * return zeroes in the non-existing part.
+ */
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long ret, tmp;
+
+	/* Load word from unaligned pointer addr */
+	asm(
+	"1:	" REG_L " %0, %3\n"
+	"2:\n"
+	"	.section .fixup,\"ax\"\n"
+	"	.balign 2\n"
+	"3:	andi	%1, %2, ~0x7\n"
+	"	" REG_L " %0, (%1)\n"
+	"	andi	%1, %2, 0x7\n"
+	"	slli	%1, %1, 0x3\n"
+	"	srl	%0, %0, %1\n"
+	"	jump	2b, %1\n"
+	"	.previous\n"
+	"	.section __ex_table,\"a\"\n"
+	"	.balign	" RISCV_SZPTR "\n"
+	"	" RISCV_PTR "	1b, 3b\n"
+	"	.previous"
+	: "=&r" (ret), "=&r" (tmp)
+	: "r" (addr), "m" (*(unsigned long *)addr));
+
+	return ret;
+}
+#endif	/* DCACHE_WORD_ACCESS */
 #endif /* _ASM_RISCV_WORD_AT_A_TIME_H */
-- 
2.25.1

