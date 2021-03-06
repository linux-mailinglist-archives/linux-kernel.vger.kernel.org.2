Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A700232F72E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCFAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:16:02 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7BC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:16:02 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h21so1751649wrc.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0Q6hAqH6fyVVw5hCkpEOYFgiWfgnj6qL15/X+pD6J2A=;
        b=WPOHPdaRjB7t3Uf0U9zDkowioAdUfOwgJC8qaBOHrjvyNnXDOnWr4l9V4GzpLuk5Bg
         Ksl3qYlvWhrt1kC+QU5cT9sA7BU5QjM2q0pv8YfC6rE1nnfnwOOEfk3mBsr38vL0b6F1
         T2C99k8heVmKyzmnkaVB3+e6PNlPe7+ajQtwdlt/wO7l5SDFf/rrsBAgAMEKYIXbStv5
         4Z/izW73EurNctB3ElHwEzI3/5F0eg4fYX3kGBqqG3WGNBrQmZTO/gZUvMqGnNhhtNgF
         55HiX9/lIJF9axO+ccL5psWisLTMhuWgFRcXHSuJNnxeq992E1UFBMRe+GGwY5O44Ris
         Invw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0Q6hAqH6fyVVw5hCkpEOYFgiWfgnj6qL15/X+pD6J2A=;
        b=HnLIGYVfS99JmgQS3FpMaSyVvlhYz221RV2yM9vO1qbZiZAHl+1snIsOBnA9wzuKrC
         7knLSxb91IuGsewCfl9bImEPxOyjUMW23lucocDbmcOmXPkjwLuggiVXj9QaEkrsbwl8
         jfdT3FFrFjbtGCk/TxS5mxRqPBwDlCQDAtrUUJC5iSmTqRtCEfga5BikaYYfiA+Yohp6
         UNhZLBxeKxgBeTT/d9ygTcE4W93hrzJfN0Z7eIm9+c1zrS7lW4V+ngd2nIZ1QsyAP0zt
         IGnda+kgctEiahdEcNRlYgJwb30ZEz0GhtIxZHeKWPonV/jYyXHIDxMPK6zM2l/JXWbf
         NK+g==
X-Gm-Message-State: AOAM533xIbHE6U7ltFqXsq+dO+aGZOwnclnCcAKYx0sEYL3OdPs41Ga/
        KWZaFGmAQgY7ZCwIlDW7jNsGna6UCagWKVHR
X-Google-Smtp-Source: ABdhPJwZARCNlNlc3fuoGFNT12NWkkP5eTaFIQ4dlC/WXEzeU00FCHc+LFMzZ92olvfufEE1d4OvMvi6aPGBotXJ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2109:: with SMTP id
 u9mr11025313wml.44.1614989761143; Fri, 05 Mar 2021 16:16:01 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:15:50 +0100
In-Reply-To: <cover.1614989433.git.andreyknvl@google.com>
Message-Id: <e43afadb507f25dfb1abfcb958470a3393bfdbf9.1614989433.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1614989433.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/5] arm64: kasan: allow to init memory when setting tags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
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

