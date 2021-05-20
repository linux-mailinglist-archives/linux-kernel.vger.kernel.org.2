Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2515389B21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhETCEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:04:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41813C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 19:03:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p140-20020a25d8920000b0290508c3296a35so18625143ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=RWXPMPgEuCU/3b7hbbrURn9Chl/0n89KN/Wk7Q6xjkE=;
        b=Ffv4hWV7qz58aiWwC1/U+7uD/OmRY4nHoO1SSD2a84NFt4UjGtWodKKiZO+oMn0uus
         3QQRRc/8J4gNpQELWrzZQvEppnuFG60Clrg50QUee8d4UHwjI9lu1pzcyvJkvXFN5M7K
         qVnna8V/FGUva8AZAhWYrXCCNrce92LaD69FsxGQPudb9IVS8/UAxUmauRfzikY6vzsA
         BXpUd/ABBUlOcaPoRx7RoeGhkeM+/6DZ0HjsctL/XzVp+L57vHs2AVRtxBYcziiEP2nt
         YDkiIsV2gfDN+jfE24qPvttOP8aO1PELE7K2yfi0I1fa5emodGi1/npxq3Ao5Ts6otsn
         dZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=RWXPMPgEuCU/3b7hbbrURn9Chl/0n89KN/Wk7Q6xjkE=;
        b=Tq/TnKmCZQx5rf6eMp7htO9nW4PdGBmn2eIm8qnjMEH8zVRe1Up4i+oUP+MA38ps6c
         HtLBIPPu4cRo34azs0EgFa20bRyzxcs/AoUlwAJbS++KqTDYKAOA3KiInZDVVBQEHeVx
         F+I+DuPofxA/Hfpg8ia3ZkMz8DrOJgmsdT42mR0uH1fqjp0LtxTuMlm1INKyisGDzAzU
         Ts/r+axoO9wVGxW+gXuzoq1eRbVwGD+ZcDJpiJesFYejYno1RY9nx8/zpycWLs7pUHyf
         Ycmm8JAonKnw4kIbfIxr4V+W7TAgI6RiZ0DTabN3IspMvTMnkuzGG+FTMnxJNAgmwxyI
         fz2g==
X-Gm-Message-State: AOAM533AC8rLhuihWRS5QENODYcclNJWs12/xaSPvh9OGvgwxnIJCFmv
        ed8hETHrLmpzFrTSztoavP614rIaILCF
X-Google-Smtp-Source: ABdhPJwhvrPdqkLsHHWGfUDUXsyPzwAmuX2finWkvCnTk1TAyQjlCyOHtAZMnfqYlVztEuaxyYv0a7IRY9S+
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:b800:442e:78b7:3fac])
 (user=eugenis job=sendgmr) by 2002:a25:b701:: with SMTP id
 t1mr3595486ybj.348.1621476196428; Wed, 19 May 2021 19:03:16 -0700 (PDT)
Date:   Wed, 19 May 2021 19:03:05 -0700
Message-Id: <20210520020305.2826694-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v4] kasan: speed up mte_set_mem_tag_range
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

Changelog since v3:
- Move the implementation back to C with a bit of inline asm.

 arch/arm64/include/asm/mte-kasan.h | 98 +++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index ddd4d17cf9a0..34e23886f346 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -48,43 +48,85 @@ static inline u8 mte_get_random_tag(void)
 	return mte_get_ptr_tag(addr);
 }
 
+static inline u64 __stg_post(u64 p)
+{
+	asm volatile(__MTE_PREAMBLE "stg %0, [%0], #16"
+		     : "+r"(p)
+		     :
+		     : "memory");
+	return p;
+}
+
+static inline u64 __stzg_post(u64 p)
+{
+	asm volatile(__MTE_PREAMBLE "stzg %0, [%0], #16"
+		     : "+r"(p)
+		     :
+		     : "memory");
+	return p;
+}
+
+static inline void __dc_gva(u64 p)
+{
+	asm volatile(__MTE_PREAMBLE "dc gva, %0" : : "r"(p) : "memory");
+}
+
+static inline void __dc_gzva(u64 p)
+{
+	asm volatile(__MTE_PREAMBLE "dc gzva, %0" : : "r"(p) : "memory");
+}
+
 /*
  * Assign allocation tags for a region of memory based on the pointer tag.
  * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
- * size must be non-zero and MTE_GRANULE_SIZE aligned.
+ * size must be MTE_GRANULE_SIZE aligned.
  */
-static inline void mte_set_mem_tag_range(void *addr, size_t size,
-						u8 tag, bool init)
+static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
+					 bool init)
 {
-	u64 curr, end;
+	u64 curr, DCZID, mask, line_size, end1, end2, end3;
 
-	if (!size)
-		return;
+	/* Read DC G(Z)VA store size from the register. */
+	__asm__ __volatile__(__MTE_PREAMBLE "mrs %0, dczid_el0"
+			     : "=r"(DCZID)::);
+	line_size = 4ul << (DCZID & 0xf);
 
 	curr = (u64)__tag_set(addr, tag);
-	end = curr + size;
-
-	/*
-	 * 'asm volatile' is required to prevent the compiler to move
-	 * the statement outside of the loop.
+	mask = line_size - 1;
+	/* STG/STZG up to the end of the first cache line. */
+	end1 = curr | mask;
+	end3 = curr + size;
+	/* DC GVA / GZVA in [end1, end2) */
+	end2 = end3 & ~mask;
+
+	/* The following code uses STG on the first cache line even if the start
+	 * address is cache line aligned - it appears to be faster than an
+	 * alignment check + conditional branch. Also, if the size is at least 2
+	 * cache lines, the first two loops can use post-condition to save one
+	 * branch each.
 	 */
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
+#define SET_MEMTAG_RANGE(stg_post, dc_gva)		\
+	do {						\
+		if (size >= 2 * line_size) {		\
+			do {				\
+				curr = stg_post(curr);	\
+			} while (curr < end1);		\
+							\
+			do {				\
+				dc_gva(curr);		\
+				curr += line_size;	\
+			} while (curr < end2);		\
+		}					\
+							\
+		while (curr < end3)			\
+			curr = stg_post(curr);		\
+	} while (0)
+
+	if (init)
+		SET_MEMTAG_RANGE(__stzg_post, __dc_gzva);
+	else
+		SET_MEMTAG_RANGE(__stg_post, __dc_gva);
+#undef SET_MEMTAG_RANGE
 }
 
 void mte_enable_kernel_sync(void);
-- 
2.31.1.751.gd2f1c929bd-goog

