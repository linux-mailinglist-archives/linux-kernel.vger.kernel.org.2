Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C61D31F352
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBSAXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBSAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:23:14 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:22:34 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id p20so2247570qtn.23
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hrKEbBMgsE8JTGg8XVXnIk1GaeWuGUQgi5pPA+IiEQ4=;
        b=ak7Lim4r6UGdoX3Z1PzU0EoMlkFZ/AwbBJ5Xeb7WEfkr3zrhXbt30Zi0mxiTLr1gM3
         oOJsBHdsz3YfynCuuPUwXxPVzGpQsbNeL10ozod7WcGa112DcPa9aYLmwJqLAYf+23aN
         1xOTtE1TMka7NPRtgbayLjP6VxKPa+JTnee8iqw0eH4kyTV1qOEYf/ZF/gICBeh4RiFv
         8aCTOJMmkkZSZ2DOYbIGhlXMUqZZ2kCZi+CutvvE8liFmyynXXxxhPhSdP9MmkV+xM2v
         2VssB8mFg+9TgHPgUmX4078E4QPksWkhXQJnJfj+fr2HMge/AdaAn31PTd+odLG3IxQP
         qNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hrKEbBMgsE8JTGg8XVXnIk1GaeWuGUQgi5pPA+IiEQ4=;
        b=jNn1cdfQx+gDW8Yg8wZZO5XqmXaRbt9fvhBsG+j8dja5u3JjXQW+DBh8l/PZgllqZf
         VHAivV9QsYyLkMyTFwKkM7Jrbh4qIf9zk+eCNmbXPlBP+ZO+H6kvCTe0ukjKihTqv8rn
         7ftg4GD34RGvgo0hCtOhMcdq7Vp1KZFmh0rEpOdapd6EA/TmCXfMA5d7yQlJE3ghkWTq
         LEPRbEhTY+aGL2blUoM/grJgSUupNivuZzirWd1idMG+w0YZ/fIVmqdnN9Jgg8Dc9JBw
         XN/m+QSN5g8lf65LVMsDgxvdo9YLKNY/lPEADho56Ky6+LDUmJjukRJcNsVm/CPi4lbi
         B2WA==
X-Gm-Message-State: AOAM532E60xS73f9iV0DRHH+MD+kS0HRqJoaXMs5c/MoUAHG5YHZctIU
        SwXkYHTdp6zSZP+IxBiwtx9fp39kNkHDs63Q
X-Google-Smtp-Source: ABdhPJw4Yi61ckpHWJpC6IgjpY8vd4yFN412cUOB1rVjce5SvKJbPNZGR7ts+bVgdWqFpnTQ6UbzOjNQeAja1IV2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:2d89:512e:587f:6e72])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9e13:: with SMTP id
 p19mr7008653qve.12.1613694153272; Thu, 18 Feb 2021 16:22:33 -0800 (PST)
Date:   Fri, 19 Feb 2021 01:22:24 +0100
In-Reply-To: <c8e93571c18b3528aac5eb33ade213bf133d10ad.1613692950.git.andreyknvl@google.com>
Message-Id: <a0570dc1e3a8f39a55aa343a1fc08cd5c2d4cad6.1613692950.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c8e93571c18b3528aac5eb33ade213bf133d10ad.1613692950.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 2/2] mm, kasan: don't poison boot memory with tag-based modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

Changes v1->v2:
- Only drop memblock poisoning for tag-based KASAN modes.

---
 mm/page_alloc.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b55c9c95364..c89e7b107514 100644
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
 
@@ -1290,7 +1313,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
-	kasan_free_nondeferred_pages(page, order);
+	kasan_free_nondeferred_pages(page, order, fpi_flags);
 
 	return true;
 }
@@ -1303,7 +1326,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
  */
 static bool free_pcp_prepare(struct page *page)
 {
-	return free_pages_prepare(page, 0, true);
+	return free_pages_prepare(page, 0, true, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1323,9 +1346,9 @@ static bool bulkfree_pcp_prepare(struct page *page)
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
@@ -1533,7 +1556,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 
-	if (!free_pages_prepare(page, order, true))
+	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
@@ -1570,7 +1593,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-- 
2.30.0.617.g56c4b15f3c-goog

