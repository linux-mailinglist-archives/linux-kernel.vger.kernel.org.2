Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47759386DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhEQX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhEQX5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:57:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:55:53 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w62-20020a0ca4440000b02901ebcd69b1a8so6003727qvw.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=pJYdEWZccGedi7sOusNpe9uQTsCIvJdO8bX0ACEO4b0=;
        b=f7J+W6v+cr2PexYHfeEZy6Gc7Yj9Pu4xSLYL2CxJn9ftrGcNzcXGtQtLLHYiNa0trr
         f6TUFbKbBs4imcupnDLerV721OZXfVE2ZApMrj44/gnlWTt8gku6Tx811Ik3i32BaoAC
         Wd2My8imlxuiTqdHrOVaW+qcO+5tAZ+/U+uCxNPv5x0TF95wdGQtH3frqSOZvcmrzqrs
         dh2Q0NWBRb0dB4IU6FXfy1ZFFWcgj0mCnLTvT40yh6uWqnAkQbG4iNJW6tY6lqe/ISK6
         gkCUmGIds35U0jA8qit1Uuf6YeiEhRb7cj7ErEIbIuteF2ynSFmsbDwjYSufboRYFeyj
         8k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=pJYdEWZccGedi7sOusNpe9uQTsCIvJdO8bX0ACEO4b0=;
        b=kfFmFUlRDYPJKMT539BimDwAwq+AaVyXjJZ7wIXAvKPndYhQmoOqVUSg9bggNk5aR2
         NMG98MciPwD146sJpucfC+msx1k6i7A93Bu2JTsJlnVzzm3JgsO0iVdPIJyppM4zaVyQ
         kwPJLTMIZqPFsDcDg1T0XarOlAo6Xe50sJ9Xh8+abrPxrvEcFqMwgD474NyHahQ2bzzN
         yRl9t7boqe4AZwMynv71cixqJzMi3o9ICaeu8xsynXYIa+weIE4Q545pNk14ifqgaqY7
         BEwW4cl4uLvKJZFA86ZlJbBM2Io7TMbEGSDD4IRvAv+nsrNWU+s0T5kDUmz8FtuWAd+6
         +qZg==
X-Gm-Message-State: AOAM533MyOnc9/KujwSaoTkI6+FqCpTJZem0NWwDAYzWnfAQgrTFB2Uj
        HaKLKWXiK06+boyKXvE/5yFWNShOO8q1
X-Google-Smtp-Source: ABdhPJzQgxhP49V5cIDudbSANXAj+t7IoJ7LIiohVBZ8KIyNsMBpRJ3UdsPcmL91UtEftGnPLXhekWC4NQAC
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:c60e:2f76:b979:5cae])
 (user=eugenis job=sendgmr) by 2002:a0c:e6c5:: with SMTP id
 l5mr2636123qvn.2.1621295752535; Mon, 17 May 2021 16:55:52 -0700 (PDT)
Date:   Mon, 17 May 2021 16:55:46 -0700
Message-Id: <20210517235546.3038875-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v3] kasan: speed up mte_set_mem_tag_range
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
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
Changelog since v1:
- Added Co-developed-by.

Changelog since v2:
- Added Signed-off-by.

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

