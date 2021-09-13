Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B84C408AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhIMMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:12:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9035 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbhIMMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:12:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7QKW52MHzW2Lq;
        Mon, 13 Sep 2021 20:10:23 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:22 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:21 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] riscv: Support DCACHE_WORD_ACCESS
Date:   Mon, 13 Sep 2021 12:19:56 +0000
Message-ID: <20210913121956.1776656-3-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210913121956.1776656-1-chenhuang5@huawei.com>
References: <20210913121956.1776656-1-chenhuang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 arch/riscv/include/asm/word-at-a-time.h | 36 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6e70bf50b02a..f6f0da0f436b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,6 +44,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select DCACHE_WORD_ACCESS
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..0b77ce654f56 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -11,6 +11,8 @@
 
 #include <linux/kernel.h>
 
+#include <asm/asm.h>
+
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
 };
@@ -45,4 +47,38 @@ static inline unsigned long find_zero(unsigned long mask)
 /* The mask we created is directly usable as a bytemask */
 #define zero_bytemask(mask) (mask)
 
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
+
 #endif /* _ASM_RISCV_WORD_AT_A_TIME_H */
-- 
2.18.0.huawei.25

