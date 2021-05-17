Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F5386DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhEQXl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbhEQXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:41:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:40:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d63-20020a254f420000b02904f91ef33453so11338983ybb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=coDTUdE+DGzuNtOpTVsbEzy4lno8tcR+JrndAuiFaAY=;
        b=ETZHVsVLM6zgfAvFBtbD1eu4omETNnBZpVC9qpg6rPwd/2LA3IgM3nHyM2dtZp36+a
         tVAtGh/v9soIJc06yJM/EsjEhwtONB5uFWnRaQE/A6mk4QdzJxFwVcBvnQcVci4jYpeB
         M9Rm8wdkNb11GHZ8gZu+j1QikI//+KGAodS/1iFfuSpQ1Q9cKd+d7zro7NFiWJv2BnNd
         eI3OpC/2OL+nwVTrxy1YUtjyd/5h/9PeHTc5Kl2CjMug5EppZ1X1RvUyWv85BpSkxixJ
         FvzsFW3nokBYvmaCXZq/eJNitnvl5XLy5r/iTr15RFL/KWg5ux9RUotXKQBoXeZviB6/
         Nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=coDTUdE+DGzuNtOpTVsbEzy4lno8tcR+JrndAuiFaAY=;
        b=S0qRS/xrg8mYTuUmBFnHukYj+pdKvmL55aNHbAs9oV/Jien/kcEpXmTX00hDxgQscc
         0ZgOdAUiL+C2TjRcCDhaNhFDjP2VhLPRFDYBBUXlZ9W2y4z/9bN1XaZ8f+Gm8dV7bTdP
         JUCnuVCuZkFLyGFc138VvOyKyqTIHBJ8akP70FVQbA4g2FYOqBbeJMjAUClx77G/uPuL
         xX6b7HQwvOdFEB3clDlhsKkBM4rTgLi94/RwaMTza42Vp+v1DnqXj1hig61yFhTKQxPB
         YBe4TkV6XSyVT5GfFIXG0oF7NEObYVHZyFdlA5rJRoqhloNDAshZi3ObHXXAlUR2EUhw
         FMMw==
X-Gm-Message-State: AOAM530Rx4j/T/L1G/gPVFSoYKIxPLb+GVuQuoQu0iJmAjtFqa0+u6xj
        z66XE9GidkMJLQMXY3R3IMbJ+pEKnBRV
X-Google-Smtp-Source: ABdhPJzynIaiP53CBZP4ukqMMREB5dMDyFdgXUpZpI0qqMj0RK0GzXOoaDstQ3Y0tBa3AMBmrsgXG/JEmFGz
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:c60e:2f76:b979:5cae])
 (user=eugenis job=sendgmr) by 2002:a5b:84c:: with SMTP id v12mr3203460ybq.77.1621294833200;
 Mon, 17 May 2021 16:40:33 -0700 (PDT)
Date:   Mon, 17 May 2021 16:40:18 -0700
Message-Id: <20210517234018.3031003-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2] kasan: speed up mte_set_mem_tag_range
From:   Evgenii Stepanov <eugenis@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DC GVA / DC GZVA to speed up KASan memory tagging in HW tags mode.

The first cacheline is always tagged using STG/STZG even if the address is
cacheline-aligned, as benchmarks show it is faster than a conditional
branch.

Signed-off-by: Evgenii Stepanov <eugenis@google.com>
Co-developed-by: Peter Collingbourne <pcc@google.com>
---
Changelog since v1:
- Added Co-developed-by.

 arch/arm64/include/asm/mte-kasan.h | 40 +------------------
 arch/arm64/lib/Makefile            |  2 +
 arch/arm64/lib/mte-kasan.S         | 63 ++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/lib/mte-kasan.S

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index ddd4d17cf9a0..e29a0e2ab35c 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -48,45 +48,7 @@ static inline u8 mte_get_random_tag(void)
 	return mte_get_ptr_tag(addr);
 }
 
-/*
- * Assign allocation tags for a region of memory based on the pointer tag.
- * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
- * size must be non-zero and MTE_GRANULE_SIZE aligned.
- */
-static inline void mte_set_mem_tag_range(void *addr, size_t size,
-						u8 tag, bool init)
-{
-	u64 curr, end;
-
-	if (!size)
-		return;
-
-	curr = (u64)__tag_set(addr, tag);
-	end = curr + size;
-
-	/*
-	 * 'asm volatile' is required to prevent the compiler to move
-	 * the statement outside of the loop.
-	 */
-	if (init) {
-		do {
-			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
-				     :
-				     : "r" (curr)
-				     : "memory");
-			curr += MTE_GRANULE_SIZE;
-		} while (curr != end);
-	} else {
-		do {
-			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
-				     :
-				     : "r" (curr)
-				     : "memory");
-			curr += MTE_GRANULE_SIZE;
-		} while (curr != end);
-	}
-}
-
+void mte_set_mem_tag_range(void *addr, size_t size, u8 tag, bool init);
 void mte_enable_kernel_sync(void);
 void mte_enable_kernel_async(void);
 void mte_init_tags(u64 max_tag);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index d31e1169d9b8..c06ada79a437 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -18,3 +18,5 @@ obj-$(CONFIG_CRC32) += crc32.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_ARM64_MTE) += mte.o
+
+obj-$(CONFIG_KASAN_HW_TAGS) += mte-kasan.o
diff --git a/arch/arm64/lib/mte-kasan.S b/arch/arm64/lib/mte-kasan.S
new file mode 100644
index 000000000000..9f6975e2af60
--- /dev/null
+++ b/arch/arm64/lib/mte-kasan.S
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google Inc.
+ */
+#include <linux/const.h>
+#include <linux/linkage.h>
+
+#include <asm/mte-def.h>
+
+	.arch	armv8.5-a+memtag
+
+	.macro  __set_mem_tag_range, stg, gva, start, size, linesize, tmp1, tmp2, tmp3
+	add	\tmp3, \start, \size
+	cmp	\size, \linesize, lsl #1
+	b.lt	.Lsmtr3_\@
+
+	sub	\tmp1, \linesize, #1
+	bic	\tmp2, \tmp3, \tmp1
+	orr	\tmp1, \start, \tmp1
+
+.Lsmtr1_\@:
+	\stg	\start, [\start], #MTE_GRANULE_SIZE
+	cmp	\start, \tmp1
+	b.lt	.Lsmtr1_\@
+
+.Lsmtr2_\@:
+	dc	\gva, \start
+	add	\start, \start, \linesize
+	cmp	\start, \tmp2
+	b.lt	.Lsmtr2_\@
+
+.Lsmtr3_\@:
+	cmp	\start, \tmp3
+	b.ge	.Lsmtr4_\@
+	\stg	\start, [\start], #MTE_GRANULE_SIZE
+	b	.Lsmtr3_\@
+.Lsmtr4_\@:
+	.endm
+
+/*
+ * Assign allocation tags for a region of memory based on the pointer tag.
+ * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
+ * size must be non-zero and MTE_GRANULE_SIZE aligned.
+ *   x0 - start address
+ *   x1 - region size
+ *   x2 - tag
+ *   x3 - bool init
+ */
+SYM_FUNC_START(mte_set_mem_tag_range)
+	mrs	x4, dczid_el0
+	and	w4, w4, #0xf
+	mov	x5, #4
+	lsl	x4, x5, x4
+
+	bfi	x0, x2, #56, #8
+
+	cbz	x3, .Lnoinit
+	__set_mem_tag_range stzg, gzva, x0, x1, x4, x2, x3, x5
+	ret
+.Lnoinit:
+	__set_mem_tag_range stg, gva, x0, x1, x4, x2, x3, x5
+	ret
+SYM_FUNC_END(mte_set_mem_tag_range)
-- 
2.31.1.751.gd2f1c929bd-goog

