Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F400438BB27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhEUBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhEUBBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:01:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:00:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so13719145qtk.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=MP2sMnnxnX2LmSdngJ3nolM2oLXjZHItYoP+hS8tzaE=;
        b=BwoAvtTf8usTATeG9OiejaUofx5iwWkEgQwq37n8U7yNK84zh7n2Sb2UMjiuGxMiW7
         U706zjC7a8LsWOAATMOJ0Jh04bE3BNNFxAF2b08vInw7kXjhj9FSt9i07vKOlP0kvoZB
         6eeIRzZpc4xvjj/iE1Gg2MUViPhRm6Orq8uP6ThM8F8v5PHb0GCo1Hf7fuA4B6uSbQXA
         gwWIAFhK+eLN0w8I2yStuNjnwXck7RzFajrdDLehoL0H/ftKImHumrHsIJV0iwZYSJNF
         qlJ41DtOawtZJ5YVruu5QOIkHO7XOl/W4oLion3YBmP8U3K51htHEtAYmmzeImt/8ciW
         7kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=MP2sMnnxnX2LmSdngJ3nolM2oLXjZHItYoP+hS8tzaE=;
        b=Jd91nx7j2c3L7prxKlghPd0Ie4YrAX4SuwWrz2l31G0GcfW4q5FCK3n+PHaSrJhXj/
         MAxaHJut488wC2GtclUzRzoXUuBy0Yi1SCuEMGr1lQhllkh5M6vJXNJArE9MG6pQk2DX
         5mU93Okz7++iE2aRJXYAMqzyc93dG33KEcFiiuwmcReoi276RPBNJ34x6Kf2KVChKLyJ
         6QRmCWZvGFox1NKapTjHb+ORMT7YH8v7WPOFEKtqquc3hf59Z8suwW4r0L75Qk+L1UIS
         5dosr1UzNcDAQV9uqM/ARBaIAML2F5XfVoWAuh1T2AOxNS36TMfyo7ZB8SKOqnf4my9e
         C4OA==
X-Gm-Message-State: AOAM532hFr584WAIXKa7oxmYus21zFPpFXE8emlPxZTkRlotbJOq+gxw
        FjPzPT0tgm9NISRvckDBOpsogUt31sGc
X-Google-Smtp-Source: ABdhPJwUjMEJCrd4sDUvwQNiJo67iUx3mk1WNCVvJbfWRphbOWNDM1kr5cHpRPFXezyhMxb0WFybiOwtGj64
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:d894:cb92:45a3:f171])
 (user=eugenis job=sendgmr) by 2002:a05:6214:391:: with SMTP id
 l17mr9195252qvy.22.1621558831163; Thu, 20 May 2021 18:00:31 -0700 (PDT)
Date:   Thu, 20 May 2021 18:00:23 -0700
Message-Id: <20210521010023.3244784-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v5] kasan: speed up mte_set_mem_tag_range
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Changelog since v1:
- Added Co-developed-by.

Changelog since v2:
- Added Signed-off-by.

Changelog since v3:
- Move the implementation back to C with a bit of inline asm.

Changelog since v3:
- Fixed coding style issues.

 arch/arm64/include/asm/mte-kasan.h | 93 +++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index ddd4d17cf9a0..d952352bd008 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -48,43 +48,84 @@ static inline u8 mte_get_random_tag(void)
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
+	u64 curr, mask, dczid_bs, end1, end2, end3;
 
-	if (!size)
-		return;
+	/* Read DC G(Z)VA block size from the system register. */
+	dczid_bs = 4ul << (read_cpuid(DCZID_EL0) & 0xf);
 
 	curr = (u64)__tag_set(addr, tag);
-	end = curr + size;
+	mask = dczid_bs - 1;
+	/* STG/STZG up to the end of the first block. */
+	end1 = curr | mask;
+	end3 = curr + size;
+	/* DC GVA / GZVA in [end1, end2) */
+	end2 = end3 & ~mask;
 
 	/*
-	 * 'asm volatile' is required to prevent the compiler to move
-	 * the statement outside of the loop.
+	 * The following code uses STG on the first DC GVA block even if the
+	 * start address is aligned - it appears to be faster than an alignment
+	 * check + conditional branch. Also, if the range size is at least 2 DC
+	 * GVA blocks, the first two loops can use post-condition to save one
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
+		if (size >= 2 * dczid_bs) {		\
+			do {				\
+				curr = stg_post(curr);	\
+			} while (curr < end1);		\
+							\
+			do {				\
+				dc_gva(curr);		\
+				curr += dczid_bs;	\
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
2.31.1.818.g46aad6cb9e-goog

