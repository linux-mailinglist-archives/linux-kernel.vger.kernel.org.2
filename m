Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4424F31E0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhBQU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhBQU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:57:36 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF266C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:56:55 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id o10so17121528wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SFShG9HSiA/a5wZPjw/2OI6suzBuDo/vPg1sGXiNPU4=;
        b=uq+kvVIzeR3An4gN/CAYw6QE6pVQHn27D86IFwunejdmU2OjZaTb9XiR41vGvWVf1m
         DksVLOj8BdFHTVsw2bj45IJjx43mEoGKUZA6z2RJ8uqSk/sjjs9qy/YvYTfc78kfmHKw
         ur3Pwdw66rmu5Fo43k0P81tGop/9P/X9cep/Alz9YOKrijW7UIjvvnikPc5vPke+4zXc
         oBsnCBHRKMjugKkcpV4PRP1ZwVB352IYfVqSk6lqqJtCp2DNfCCl0Fi3P+J0Ydy/z84l
         cXjO9FMDbiHmosEuqU9+ZzFuSrBXaRZ+eUr4rk9bU5OtGytxWDGj7MwqEkWhh+/Uyc5Q
         ADNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SFShG9HSiA/a5wZPjw/2OI6suzBuDo/vPg1sGXiNPU4=;
        b=tl+bXCxaQSQ7pH73wzalru5CdNEuaZad4DB+1VohSoHvPOhbV3TGhrfxPhqxrRkFsH
         SiAZzsJ/XzTykbse8rSRZ0TVz+sIkVLe0YdplLzjiiQ0aJ9M73TvuIonLvCfxZyFx8d0
         kotb376P3Q+xFxeUhJYvQXD8cQlztjS3qE6Yfop1z/Zqv6OW1cec5t3vsJJgGTLsUtK5
         ennZjiRhszVDWwL6FcsPgT+2ENFgrNUkSRhtPcLy4HoT31kTijJhuiIM03lZR+WeDdzr
         9Go3x3nOtxHKj5ShAnFB7HRrDN2Tcig3X1IENOz87qbnuGAkdks/snthAAdbLe44BSo+
         an/w==
X-Gm-Message-State: AOAM532YjbZJK2+a6X44XlCn8PTTte1VvCUG0G3rT9kyBujHhhu6PPhe
        uey5tZyYQWpgfFTCAVkQPi+EnlGNvDbNSE71
X-Google-Smtp-Source: ABdhPJzpzJFCBeHD/qAy4KRbvT1c+dX2xurE+gdmzIVLGnbTZurQCDQ/kd3T+GmwRfTjrwYjKetpJ1RUziqKPKwg
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:fc35:c4d:59c2:bb21])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:4314:: with SMTP id
 p20mr604956wme.52.1613595413677; Wed, 17 Feb 2021 12:56:53 -0800 (PST)
Date:   Wed, 17 Feb 2021 21:56:32 +0100
Message-Id: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] mm, kasan: don't poison boot memory
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot, all non-reserved memblock memory is exposed to the buddy
allocator. Poisoning all that memory with KASAN lengthens boot time,
especially on systems with large amount of RAM. This patch makes
page_alloc to not call kasan_free_pages() on all new memory.

__free_pages_core() is used when exposing fresh memory during system
boot and when onlining memory during hotplug. This patch adds a new
FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
free_pages_prepare() from __free_pages_core().

This has little impact on KASAN memory tracking.

Assuming that there are no references to newly exposed pages before they
are ever allocated, there won't be any intended (but buggy) accesses to
that memory that KASAN would normally detect.

However, with this patch, KASAN stops detecting wild and large
out-of-bounds accesses that happen to land on a fresh memory page that
was never allocated. This is taken as an acceptable trade-off.

All memory allocated normally when the boot is over keeps getting
poisoned as usual.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
---
 mm/page_alloc.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b55c9c95364..f10966e3b4a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -108,6 +108,17 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
+/*
+ * Don't poison memory with KASAN.
+ * During boot, all non-reserved memblock memory is exposed to the buddy
+ * allocator. Poisoning all that memory lengthens boot time, especially on
+ * systems with large amount of RAM. This flag is used to skip that poisoning.
+ * Assuming that there are no references to those newly exposed pages before
+ * they are ever allocated, this has little effect on KASAN memory tracking.
+ * All memory allocated normally after boot gets poisoned as usual.
+ */
+#define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -384,10 +395,14 @@ static DEFINE_STATIC_KEY_TRUE(deferred_pages);
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
+	if (fpi_flags & FPI_SKIP_KASAN_POISON)
+		return;
+	kasan_free_pages(page, order);
 }
 
 /* Returns true if the struct page for the pfn is uninitialised */
@@ -438,7 +453,13 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 #else
-#define kasan_free_nondeferred_pages(p, o)	kasan_free_pages(p, o)
+static inline void kasan_free_nondeferred_pages(struct page *page, int order,
+							fpi_t fpi_flags)
+{
+	if (fpi_flags & FPI_SKIP_KASAN_POISON)
+		return;
+	kasan_free_pages(page, order);
+}
 
 static inline bool early_page_uninitialised(unsigned long pfn)
 {
@@ -1216,7 +1237,7 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 }
 
 static __always_inline bool free_pages_prepare(struct page *page,
-					unsigned int order, bool check_free)
+			unsigned int order, bool check_free, fpi_t fpi_flags)
 {
 	int bad = 0;
 
@@ -1290,7 +1311,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
-	kasan_free_nondeferred_pages(page, order);
+	kasan_free_nondeferred_pages(page, order, fpi_flags);
 
 	return true;
 }
@@ -1303,7 +1324,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
  */
 static bool free_pcp_prepare(struct page *page)
 {
-	return free_pages_prepare(page, 0, true);
+	return free_pages_prepare(page, 0, true, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1323,9 +1344,9 @@ static bool bulkfree_pcp_prepare(struct page *page)
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
@@ -1533,7 +1554,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 
-	if (!free_pages_prepare(page, order, true))
+	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
@@ -1570,7 +1591,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-- 
2.30.0.478.g8a0d178c01-goog

