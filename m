Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA53312A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCHPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:55:27 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612BBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:55:27 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p12so2428223wrn.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/BAO9ttHzCncRHdq2i5eu5LhUmwsdIn4HIy1rtrNRFc=;
        b=pB4bszXs7eg4iEC/f7lPbOmUyqfwLVIAkusMpoLIcEzhTvci5FuAKX+WtUCMT0OOKe
         fNuh/Rke0YH3W4gTl9P1Bi9YFkhxw/+VCRqo/qvNOiebJdM5CG2kMHVmSkKceHEs+4aO
         pQMMacT0AYSHqQnViAb/FuPuxQ8H3Tw5QcR48/5LJ3LUKJxT/vIyx3gZLT7XPdhcc2go
         6KKg3H5hlpiLQ4LDYE64cp17vMyJnMFMRHATAjNODGPkv4VuutUzlMMSFk4Yecm53Spd
         dY39fPO1aWmwJy1YVxzglXlI6hEgtvH+4n+dUmooGMWTRxZE1J0o+esAlVESEOcH3bJU
         fEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/BAO9ttHzCncRHdq2i5eu5LhUmwsdIn4HIy1rtrNRFc=;
        b=NZlDfjQu4QxRcvyUsxrZbR2ztEuEhxjG52PdOI2T/WnHtZL1TgAOUfmTqgIitHUR4T
         472koz5YQU50otq6EA9l0Xb5Peykmo5yolrA1Y5/novdlh6YGQMXaZTlcLfXcXDkdVxO
         FpsykmCT1y+mmElPlxElYiKY1OrmFE2MsEjlgfLgLzhm5KbfyGCFo3d4sl5KnwghqGns
         BFb01i0tx1lbw+rvKMM0ZfL5KjMi4KuhKuqf8Aer1lm7at/j1DVZqNdnjcyIPSUDf1zp
         kTUlw0UH0VyPkpFw36vQ/KiFs6v7fIOZI/DML8rnYJvRha4QgBUjICxK/VE5UoAtrMdJ
         UwXA==
X-Gm-Message-State: AOAM530jjel8xBxWmU1P2W8DT8rTWUSt0J5BqqP0W061GAgcWQe1nxL5
        e8Cs/gBNX10nwyTjsdpbO+8SR/n7IRhwDF6/
X-Google-Smtp-Source: ABdhPJwJMahHz8a6RnID8ilXLKTGZvWBo52nzB+MU0q2lSC6rkBvHBe6DWbJRXKUNkY2lnhyv6ySlCl374OhDgmp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:85fb:aac9:69ed:e574])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:35c1:: with SMTP id
 r1mr22344025wmq.60.1615218924080; Mon, 08 Mar 2021 07:55:24 -0800 (PST)
Date:   Mon,  8 Mar 2021 16:55:14 +0100
In-Reply-To: <cover.1615218180.git.andreyknvl@google.com>
Message-Id: <755161094eac5b0fc15273d609c78a459d4d07b9.1615218180.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615218180.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 1/5] arm64: kasan: allow to init memory when setting tags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds an argument to mte_set_mem_tag_range() that allows
to enable memory initialization when settinh the allocation tags.
The implementation uses stzg instruction instead of stg when this
argument indicates to initialize memory.

Combining setting allocation tags with memory initialization will
improve HW_TAGS KASAN performance when init_on_alloc/free is enabled.

This change doesn't integrate memory initialization with KASAN,
this is done is subsequent patches in this series.

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h    |  4 ++--
 arch/arm64/include/asm/mte-kasan.h | 20 ++++++++++++++------
 mm/kasan/kasan.h                   |  9 +++++----
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c759faf7a1ff..f1ba48b4347d 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -248,8 +248,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
-#define arch_set_mem_tag_range(addr, size, tag)	\
-			mte_set_mem_tag_range((addr), (size), (tag))
+#define arch_set_mem_tag_range(addr, size, tag, init)	\
+			mte_set_mem_tag_range((addr), (size), (tag), (init))
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 /*
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 7ab500e2ad17..35fe549f7ea4 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -53,7 +53,8 @@ static inline u8 mte_get_random_tag(void)
  * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
  * size must be non-zero and MTE_GRANULE_SIZE aligned.
  */
-static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+static inline void mte_set_mem_tag_range(void *addr, size_t size,
+						u8 tag, bool init)
 {
 	u64 curr, end;
 
@@ -68,10 +69,16 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 		 * 'asm volatile' is required to prevent the compiler to move
 		 * the statement outside of the loop.
 		 */
-		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
-			     :
-			     : "r" (curr)
-			     : "memory");
+		if (init)
+			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
+				     :
+				     : "r" (curr)
+				     : "memory");
+		else
+			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
+				     :
+				     : "r" (curr)
+				     : "memory");
 
 		curr += MTE_GRANULE_SIZE;
 	} while (curr != end);
@@ -100,7 +107,8 @@ static inline u8 mte_get_random_tag(void)
 	return 0xFF;
 }
 
-static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+static inline void mte_set_mem_tag_range(void *addr, size_t size,
+						u8 tag, bool init)
 {
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8c55634d6edd..7fbb32234414 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -291,7 +291,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_get_mem_tag(addr)	(0xFF)
 #endif
 #ifndef arch_set_mem_tag_range
-#define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
+#define arch_set_mem_tag_range(addr, size, tag, init) ((void *)(addr))
 #endif
 
 #define hw_enable_tagging()			arch_enable_tagging()
@@ -299,7 +299,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
-#define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
+#define hw_set_mem_tag_range(addr, size, tag, init) \
+			arch_set_mem_tag_range((addr), (size), (tag), (init))
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
@@ -343,7 +344,7 @@ static inline void kasan_poison(const void *addr, size_t size, u8 value)
 	if (WARN_ON(size & KASAN_GRANULE_MASK))
 		return;
 
-	hw_set_mem_tag_range((void *)addr, size, value);
+	hw_set_mem_tag_range((void *)addr, size, value, false);
 }
 
 static inline void kasan_unpoison(const void *addr, size_t size)
@@ -360,7 +361,7 @@ static inline void kasan_unpoison(const void *addr, size_t size)
 		return;
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
-	hw_set_mem_tag_range((void *)addr, size, tag);
+	hw_set_mem_tag_range((void *)addr, size, tag, false);
 }
 
 static inline bool kasan_byte_accessible(const void *addr)
-- 
2.30.1.766.gb4fecdf3b7-goog

