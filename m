Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D759C33270D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCINZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhCINYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:24:46 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B37C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:24:46 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id s192so1134207wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l+UpHCxZ2NwdA6Wfc2QV4OtHQWAx+WJePRBQJIJEiJo=;
        b=l34afbqAvPQXcjzsfMShqnGlvlF2i0RtNWfxzKU8zpaVbXnzK9SRfNwVdu0eCO9Vr2
         29XkE6R0aWdcnI3YWGOvZ2uJmjeDtfV/PQ8AToJTTmWl+YTzA9fOcnXeKkL/gZ0mNicn
         3b3maekCEU0R8ffe1IkKR8PlFHB+iC6ng2btK+k1npxcqAEDFLKcWQPaPNdP7d+YENGU
         1ddiVRNoqZ6xfvBdEH23T5LMnnF3XA5PD8FqcTHNMnAmH6L285I2x89IER2tN2qX6p09
         uQJzSMnhAqgqTiNckRmECktMPneOakeNkGTfrCvMfsQvtJrTXALafVZMXRxp45+XVgX/
         TX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l+UpHCxZ2NwdA6Wfc2QV4OtHQWAx+WJePRBQJIJEiJo=;
        b=X78d881EWDD324DgMhMz1lI35Xv2CTtbuL0/52EIboeSYtM9Cj3oUxUDU/DjNjT7kX
         OwDXf2T1ut4nV5hirnM2sWUuVuInZ9sRDxUySPwM+3cyev1pCO/JC6kQ9B7mgwnhm1JR
         4HNulwHQkvcEbCjiJ3V/Doc7Gh8aTVf8BbIkwUEJIU44aJA1KcWC0L+FbWoBWjxV4JpT
         IEMMc/yVzrcarkbXRxkBfA5VDNyl79/KTZh2pmGvxltZw42T6loDk65HMMtbGjKsX8/U
         YYfdeHfNE5H/BGs50P57/L7RP4TfR6DqdvBpMWYMrYkN2JAZfASXBzhY85vfLgJqBf4f
         AiPA==
X-Gm-Message-State: AOAM531M5M2fpvd3eh0QQqAKiaE/0Al1Hf4QM2yZtojAaUvIX831wBw/
        F5dOAnIht3PoQXuJI3lwSKT3ZypYoQ7vCAv5
X-Google-Smtp-Source: ABdhPJzeJ3O/vPx4Qw7ptEvZYassi6QjjMCwgCMDLJKe6O3hz3UbTW/Oc5x1nCdywjwdeW0BcIqpezuZkydvIVQY
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5802:818:ce92:dfef])
 (user=andreyknvl job=sendgmr) by 2002:a5d:6810:: with SMTP id
 w16mr28447553wru.333.1615296285067; Tue, 09 Mar 2021 05:24:45 -0800 (PST)
Date:   Tue,  9 Mar 2021 14:24:35 +0100
In-Reply-To: <cover.1615296150.git.andreyknvl@google.com>
Message-Id: <d04ae90cc36be3fe246ea8025e5085495681c3d7.1615296150.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615296150.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 1/5] arm64: kasan: allow to init memory when setting tags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h    |  4 +--
 arch/arm64/include/asm/mte-kasan.h | 39 +++++++++++++++++++-----------
 mm/kasan/kasan.h                   |  9 ++++---
 3 files changed, 32 insertions(+), 20 deletions(-)

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
index 7ab500e2ad17..570af3e99296 100644
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
 
@@ -63,18 +64,27 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	curr = (u64)__tag_set(addr, tag);
 	end = curr + size;
 
-	do {
-		/*
-		 * 'asm volatile' is required to prevent the compiler to move
-		 * the statement outside of the loop.
-		 */
-		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
-			     :
-			     : "r" (curr)
-			     : "memory");
-
-		curr += MTE_GRANULE_SIZE;
-	} while (curr != end);
+	/*
+	 * 'asm volatile' is required to prevent the compiler to move
+	 * the statement outside of the loop.
+	 */
+	if (init) {
+		do {
+			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
+				     :
+				     : "r" (curr)
+				     : "memory");
+			curr += MTE_GRANULE_SIZE;
+		} while (curr != end);
+	} else {
+		do {
+			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
+				     :
+				     : "r" (curr)
+				     : "memory");
+			curr += MTE_GRANULE_SIZE;
+		} while (curr != end);
+	}
 }
 
 void mte_enable_kernel(void);
@@ -100,7 +110,8 @@ static inline u8 mte_get_random_tag(void)
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

