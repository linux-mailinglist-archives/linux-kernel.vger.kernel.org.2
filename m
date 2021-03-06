Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5032F71D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhCFAGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhCFAGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:06:04 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DEC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:06:04 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id jx11so2771959qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yJop2QuXemsmY+rS7D33vVlqYl2tBY2jpSe363QSuIM=;
        b=nXH2trZDoocaHnXZy9lunINKCAPLoEdruTQBpX+duew8jFyFi4bGAswsllitk77fTl
         gy8SkK26eD/B3TXFWBdyZYVioeHDQG6oTSonKuy4YeB6hkaYf4t+j7AZ4Wsvlsl5PaU9
         yrLZ/A8Z68QAeNmRTzvAnlYevQz365QVkqsfwxn07GVMtmKTrtLd3KnXfNfv6SSUX0yq
         72gSp28iqf/Y82UwlY5YP25EbqsikWKrHxp4qjPqYXQeDBQ22DL7S4a8rdC2TXmy4AHR
         KdCxD5XDDWt6jg0TKs0/GmX3VdMJrbhwLA0RC7iCl3+cS+/BUmsDurnNOgL+U/nJByWr
         7QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yJop2QuXemsmY+rS7D33vVlqYl2tBY2jpSe363QSuIM=;
        b=BcQpAtBbzCGvoSefgBVlUKdcIcIsRDpQOP+mgACVmet6OjJyjD7SKFmdBpml2rzQCZ
         0vFxL6AkNS/MTxcDR48C8ZN7UF2zx6IARZH2RJQQe3PMJZSsIQs8HZTY8sIMUDjQIXqx
         4N85kBGHMaOVjSU38f4vRabvMQO0ggQNRrujlO7EDA8Fk2HCIKPYZJj9/sVoJjshKL1Q
         xbFIz96lkgyJXwt744mkdS816w7W6qZ5VD3sXiYm3mg8CCKIEU1TejAZA2QOdseEYGS6
         dbewkRZt4p2RTrEVQ4/YzQb5Yfc+ZdIIq2DoOdY/j3Z+8WWiJAFYguX5lkDpbbeMPMpt
         fv3Q==
X-Gm-Message-State: AOAM531Z9HC9Ls6rJcgsmLJQjwY+wwno9/6U6eEMYQM3xlKrOLAqPV/W
        5p3oLgnCqVurTm+n9iZYjnJ85CDkwCyGP01S
X-Google-Smtp-Source: ABdhPJw81hRTIWJJNIhUsKBPgA01itVYetB5Q5wKddIucRQJpl/MSrsgixro13Mk7IHNYh/ATiT60Eeo0kx/p40z
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c60b:: with SMTP id
 v11mr11124307qvi.44.1614989163659; Fri, 05 Mar 2021 16:06:03 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:05:58 +0100
In-Reply-To: <b6cd96a70f8faf58a1013ae063357d84db8d38d6.1614989145.git.andreyknvl@google.com>
Message-Id: <cbe2a3195ea0875c0abe44a18a3a7802b2ba4b58.1614989145.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <b6cd96a70f8faf58a1013ae063357d84db8d38d6.1614989145.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 2/2] mm, kasan: don't poison boot memory with tag-based modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

During boot, all non-reserved memblock memory is exposed to page_alloc
via memblock_free_pages->__free_pages_core(). This results in
kasan_free_pages() being called, which poisons that memory.

Poisoning all that memory lengthens boot time. The most noticeable effect
is observed with the HW_TAGS mode. A boot-time impact may potentially also
affect systems with large amount of RAM.

This patch changes the tag-based modes to not poison the memory during
the memblock->page_alloc transition.

An exception is made for KASAN_GENERIC. Since it marks all new memory as
accessible, not poisoning the memory released from memblock will lead to
KASAN missing invalid boot-time accesses to that memory.

With KASAN_SW_TAGS, as it uses the invalid 0xFE tag as the default tag
for all memory, it won't miss bad boot-time accesses even if the poisoning
of memblock memory is removed.

With KASAN_HW_TAGS, the default memory tags values are unspecified.
Therefore, if memblock poisoning is removed, this KASAN mode will miss
the mentioned type of boot-time bugs with a 1/16 probability. This is
taken as an acceptable trafe-off.

Internally, the poisoning is removed as follows. __free_pages_core() is
used when exposing fresh memory during system boot and when onlining
memory during hotplug. This patch adds a new FPI_SKIP_KASAN_POISON flag
and passes it to __free_pages_ok() through free_pages_prepare() from
__free_pages_core(). If FPI_SKIP_KASAN_POISON is set, kasan_free_pages()
is not called.

All memory allocated normally when the boot is over keeps getting
poisoned as usual.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Rebased onto v3 of "kasan, mm: fix crash with HW_TAGS and
  DEBUG_PAGEALLOC".

---
 mm/page_alloc.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c89ee1ba7034..0efb07b5907c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -108,6 +108,17 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
+/*
+ * Don't poison memory with KASAN (only for the tag-based modes).
+ * During boot, all non-reserved memblock memory is exposed to page_alloc.
+ * Poisoning all that memory lengthens boot time, especially on systems with
+ * large amount of RAM. This flag is used to skip that poisoning.
+ * This is only done for the tag-based KASAN modes, as those are able to
+ * detect memory corruptions with the memory tags assigned by default.
+ * All memory allocated normally after boot gets poisoned as usual.
+ */
+#define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -384,10 +395,15 @@ static DEFINE_STATIC_KEY_TRUE(deferred_pages);
  * on-demand allocation and then freed again before the deferred pages
  * initialization is done, but this is not likely to happen.
  */
-static inline void kasan_free_nondeferred_pages(struct page *page, int order)
+static inline void kasan_free_nondeferred_pages(struct page *page, int order,
+							fpi_t fpi_flags)
 {
-	if (!static_branch_unlikely(&deferred_pages))
-		kasan_free_pages(page, order);
+	if (static_branch_unlikely(&deferred_pages))
+		return;
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+			(fpi_flags & FPI_SKIP_KASAN_POISON))
+		return;
+	kasan_free_pages(page, order);
 }
 
 /* Returns true if the struct page for the pfn is uninitialised */
@@ -438,7 +454,14 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 #else
-#define kasan_free_nondeferred_pages(p, o)	kasan_free_pages(p, o)
+static inline void kasan_free_nondeferred_pages(struct page *page, int order,
+							fpi_t fpi_flags)
+{
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+			(fpi_flags & FPI_SKIP_KASAN_POISON))
+		return;
+	kasan_free_pages(page, order);
+}
 
 static inline bool early_page_uninitialised(unsigned long pfn)
 {
@@ -1216,7 +1239,7 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 }
 
 static __always_inline bool free_pages_prepare(struct page *page,
-					unsigned int order, bool check_free)
+			unsigned int order, bool check_free, fpi_t fpi_flags)
 {
 	int bad = 0;
 
@@ -1285,7 +1308,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
-	kasan_free_nondeferred_pages(page, order);
+	kasan_free_nondeferred_pages(page, order, fpi_flags);
 
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
@@ -1307,7 +1330,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
  */
 static bool free_pcp_prepare(struct page *page)
 {
-	return free_pages_prepare(page, 0, true);
+	return free_pages_prepare(page, 0, true, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1327,9 +1350,9 @@ static bool bulkfree_pcp_prepare(struct page *page)
 static bool free_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
-		return free_pages_prepare(page, 0, true);
+		return free_pages_prepare(page, 0, true, FPI_NONE);
 	else
-		return free_pages_prepare(page, 0, false);
+		return free_pages_prepare(page, 0, false, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1537,7 +1560,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 
-	if (!free_pages_prepare(page, order, true))
+	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
@@ -1574,7 +1597,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-- 
2.30.1.766.gb4fecdf3b7-goog

