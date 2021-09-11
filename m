Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73E4075C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhIKJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235514AbhIKJXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D4AC61208;
        Sat, 11 Sep 2021 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631352144;
        bh=LjAKkpiCnirsB4Y6pdvnBZ3V6hPR2NG4vhp7kebZdOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQseqkLEQnMLI8Sfk0Mox519Abj3QiSjmQtZCJBU3ctwqKIF9DUwIeLfDghYCSWpx
         mUxS7MpliI+o/ilhDblwmTRXEooaTbRWLTgl7ij5aX0/3id0uf6OMv7I/2ETs7sfkA
         Jd/ifC2HV04/a6vF7E8W/GQZFtl5AHIGXN9EQ8VmieGx636gOhSfffplrqcD7tnk5H
         Z4MRewQbeAwzjH/alNr0O2dRTcNX/yERk66Tsu+bUnIlEUAB/o5kWsPSNN7DFpTX8y
         ZzUF7tYHCc443tCBF0WvHv4g5XhJNjusSMZu97o0bvhUuNzQONwgtw4gVQQQ+FlX5w
         S+1MPZqBE3qIg==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V4 5/6] riscv: errata: Support T-HEAD custom dcache ops
Date:   Sat, 11 Sep 2021 17:21:38 +0800
Message-Id: <20210911092139.79607-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911092139.79607-1-guoren@kernel.org>
References: <20210911092139.79607-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Here are the DMA sync ops needed by Allwinner D1. RISC-V CMO
extension is still in progress, and D1 is using custom CMO
instructions:

 dcache.ipa rs1 (invalidate)
 | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
   0000001    01010      rs1       000      00000  0001011

 dcache.cpa rs1 (clean)
 | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
   0000001    01001      rs1       000      00000  0001011

 dcache.cipa rs1 (clean then invalidate)
 | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
   0000001    01011      rs1       000      00000  0001011

 sync.s (completion barrier)
 | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
   0000000    11001     00000      000      00000  0001011

TODO:
 - Using alternative patch_text based on Atish's patch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Wei Fu <wefu@redhat.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/errata/alternative.c      |  5 +++
 arch/riscv/errata/thead/errata.c     | 61 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h |  2 +
 3 files changed, 68 insertions(+)

diff --git a/arch/riscv/errata/alternative.c b/arch/riscv/errata/alternative.c
index b879aa546bc5..396aab1b62c2 100644
--- a/arch/riscv/errata/alternative.c
+++ b/arch/riscv/errata/alternative.c
@@ -46,6 +46,11 @@ static void __init init_alternative(void)
 	case SIFIVE_VENDOR_ID:
 		vendor_patch_func = sifive_errata_patch_func;
 		break;
+#endif
+#ifdef CONFIG_ERRATA_THEAD
+	case THEAD_VENDOR_ID:
+		vendor_patch_func = thead_errata_patch_func;
+		break;
 #endif
 	default:
 		vendor_patch_func = NULL;
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 1f5c0f82bc23..9c0bf9b25be3 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -5,6 +5,7 @@
 #include <linux/bug.h>
 #include <asm/patch.h>
 #include <asm/alternative.h>
+#include <asm/dma-noncoherent.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
 #include <asm/pgtable-bits.h>
@@ -45,3 +46,63 @@ void __init thead_errata_setup_vm(unsigned long archid, unsigned long impid)
 	__riscv_pbmt.mt[MT_IO]	= _PAGE_MT_IO;
 #endif
 }
+
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+/*
+ * dcache.ipa rs1 (invalidate)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01010      rs1       000      00000  0001011
+ *
+ * dcache.cpa rs1 (clean)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01001      rs1       000      00000  0001011
+ *
+ * dcache.cipa rs1 (clean then invalidate)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01011      rs1       000      00000  0001011
+ *
+ * sync.s
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11001     00000      000      00000  0001011
+ */
+#define DCACHE_IPA_A0	".long 0x02a5000b"
+#define DCACHE_CPA_A0	".long 0x0295000b"
+#define DCACHE_CIPA_A0	".long 0x02b5000b"
+
+#define SYNC_S		".long 0x0190000b"
+
+#define CACHE_OP_RANGE(OP, start, size) \
+	register unsigned long i asm("a0") = start & ~(L1_CACHE_BYTES - 1); \
+	for (; i < ALIGN(start + size, L1_CACHE_BYTES); i += L1_CACHE_BYTES) \
+		__asm__ __volatile__(OP); \
+	 __asm__ __volatile__(SYNC_S);
+
+static void c900_cache_invalidate(phys_addr_t start, size_t size)
+{
+	CACHE_OP_RANGE(DCACHE_IPA_A0, start, size);
+}
+
+static void c900_cache_clean(phys_addr_t start, size_t size)
+{
+	CACHE_OP_RANGE(DCACHE_CPA_A0, start, size);
+}
+
+static void c900_cache_flush(phys_addr_t start, size_t size)
+{
+	CACHE_OP_RANGE(DCACHE_CIPA_A0, start, size);
+}
+
+static struct riscv_dma_cache_sync c900_dma_cache_sync = {
+	.cache_invalidate = c900_cache_invalidate,
+	.cache_clean = c900_cache_clean,
+	.cache_flush = c900_cache_flush,
+};
+#endif
+
+void __init thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+				     unsigned long archid, unsigned long impid)
+{
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+	riscv_dma_cache_sync_set(&c900_dma_cache_sync);
+#endif
+}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 3605894081a8..a519671fa7d1 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -35,6 +35,8 @@ struct errata_checkfunc_id {
 
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid);
+void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			      unsigned long archid, unsigned long impid);
 
 void thead_errata_setup_vm(unsigned long archid, unsigned long impid);
 #endif
-- 
2.25.1

