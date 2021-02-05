Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C931176A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBEXq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63363C061356
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:46:52 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u15so5585000wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kg30/g/LrsxD86gPJMTES5VW5Hgvjnk4vM4kmv21+Z4=;
        b=LCEFnlDaJcG0Q41NRa+Ch0e8o0QaxKPH4VLE5PeiB/2TOutaBSjhOVNhtlIuqskKNL
         phpumV6RzdrEdBMlzF0JJ/UV8Gi5lGDAW74e0LAzZYz+t1c3Y9oGFxEzdOri6TmYTr5U
         na1Uut/9hwzYcfOIuhkjF9fJjKOrh+9Tqp8O7hNSKLlOFpHYyFP5w0AVgMSjecylbZlj
         pFazgfiM/L2igEvCu3/YSfXsjME4M0Weph+1nBqRsxnRS5ZoqKSs/FwCT7YXTazQ1F47
         i3VS6u9Ncn4Er7IZkPDPnp8tQRJvJXTxGiJK3gP2p+0V3VZSUOiVr8uO6j1rSNg8VTTG
         ++5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kg30/g/LrsxD86gPJMTES5VW5Hgvjnk4vM4kmv21+Z4=;
        b=aNp4PkqoWvKKFUt2bHFd6Ksp0SDRd33QMKO3QuHnatTqzhkoOm5jJQBq92TZitzV5e
         SQPRmVCAkEoD0AjrJwOMxmQGm87hEpb0CBJ7Ajol4zdf8P2aj4+tInnJB5T7k65etUrN
         cJR/nZOTrFzjEUYSbO+5pej7/U5X6sEiOYyBuoEL5COGAtUXiNrTrskaZOVoWzeHlMqT
         58XSyDCjaryQT3j4NPmnwcWymiOKA8j0t0lodQ4SRdEKt7U1viMDkk9poTt83IGQo4Ec
         jqLP2p5faajyRMzcNqNbcIYNQ92tjqLi5jV7GQFGVw+FqSS/K+vUkuY3r3UrDGLrb4/s
         eexg==
X-Gm-Message-State: AOAM533tJKow/e45licMYZrDASg4Ox0j6q/uKIx16UrjKaMe+p1dsHmu
        vO+NBWG1mb4PaHmSmqFg2zjAY73xGP2QEQCY
X-Google-Smtp-Source: ABdhPJwwKKgQGlKIo0fdvx1Js8AFJ3EgmJEbKeq2cWI3dxu4cKp8SA/tbBXB1FczDscVCzjNnOVVknB1qI6ECJfd
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c2aa:: with SMTP id
 c10mr3901926wmk.101.1612539569588; Fri, 05 Feb 2021 07:39:29 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:06 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <492dcd5030419c5421a3762457c0ff1a7c91e628.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 05/12] kasan: unify large kfree checks
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

Unify checks in kasan_kfree_large() and in kasan_slab_free_mempool()
for large allocations as it's done for small kfree() allocations.

With this change, kasan_slab_free_mempool() starts checking that the
first byte of the memory that's being freed is accessible.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     | 36 ++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 2d5de4092185..d53ea3c047bc 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -200,6 +200,13 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
 	return false;
 }
 
+void __kasan_kfree_large(void *ptr, unsigned long ip);
+static __always_inline void kasan_kfree_large(void *ptr)
+{
+	if (kasan_enabled())
+		__kasan_kfree_large(ptr, _RET_IP_);
+}
+
 void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
 static __always_inline void kasan_slab_free_mempool(void *ptr)
 {
@@ -247,13 +254,6 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
-void __kasan_kfree_large(void *ptr, unsigned long ip);
-static __always_inline void kasan_kfree_large(void *ptr)
-{
-	if (kasan_enabled())
-		__kasan_kfree_large(ptr, _RET_IP_);
-}
-
 /*
  * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
  * the hardware tag-based mode that doesn't rely on compiler instrumentation.
@@ -302,6 +302,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
 {
 	return false;
 }
+static inline void kasan_kfree_large(void *ptr) {}
 static inline void kasan_slab_free_mempool(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
@@ -322,7 +323,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_kfree_large(void *ptr) {}
 static inline bool kasan_check_byte(const void *address)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index da24b144d46c..7ea643f7e69c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -364,6 +364,31 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
+static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
+{
+	if (ptr != page_address(virt_to_head_page(ptr))) {
+		kasan_report_invalid_free(ptr, ip);
+		return true;
+	}
+
+	if (!kasan_byte_accessible(ptr)) {
+		kasan_report_invalid_free(ptr, ip);
+		return true;
+	}
+
+	/*
+	 * The object will be poisoned by kasan_free_pages() or
+	 * kasan_slab_free_mempool().
+	 */
+
+	return false;
+}
+
+void __kasan_kfree_large(void *ptr, unsigned long ip)
+{
+	____kasan_kfree_large(ptr, ip);
+}
+
 void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 {
 	struct page *page;
@@ -377,10 +402,8 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
 	 */
 	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
-			kasan_report_invalid_free(ptr, ip);
+		if (____kasan_kfree_large(ptr, ip))
 			return;
-		}
 		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE);
 	} else {
 		____kasan_slab_free(page->slab_cache, ptr, ip, false);
@@ -539,13 +562,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 		return ____kasan_kmalloc(page->slab_cache, object, size, flags);
 }
 
-void __kasan_kfree_large(void *ptr, unsigned long ip)
-{
-	if (ptr != page_address(virt_to_head_page(ptr)))
-		kasan_report_invalid_free(ptr, ip);
-	/* The object will be poisoned by kasan_free_pages(). */
-}
-
 bool __kasan_check_byte(const void *address, unsigned long ip)
 {
 	if (!kasan_byte_accessible(address)) {
-- 
2.30.0.365.g02bc693789-goog

