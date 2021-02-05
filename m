Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85D310EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBEP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBEPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:21 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D639C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:03 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id ew14so5491320qvb.21
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nFFQgpju2Q7ah9cWGUiX1xDaTa8Y8GPfAWjtc31c0z0=;
        b=r27Shr/X3udVa2hmQsmAvRhsSQcbPxddxYiMADquyC4ddoUoh3BF44I0qSECkE1QbE
         XyiBTM1BYB3TBJw8frdxYfnmDe87g3UcOdlqDgb20TclMhoJzVgY8OBFfc9vs9AZMjIF
         gDC0AV7iYQwTLplxbKhb+BBTgwxY214hlh4lwbughapRkDfgstiFZigokoykURbJ68w8
         FbqJGkxclpeNP1ejzOiVkJdKV+0yAsSYMJyY8+DPhwRgzacMSLKDCP3vG3TN0W0WdRb5
         tfBHk8hMane0rTGMZyTrOilNtwyf4YJ4IL2zuXBAWqi1U6SnR+UXZmCMMnVzLJEVB5eq
         q3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nFFQgpju2Q7ah9cWGUiX1xDaTa8Y8GPfAWjtc31c0z0=;
        b=noR1WlbcSSZAqa1jPXwnZ5ydbMq2LObyW1VIC0egNjMg/sHQkOZIiDQwsMstymDA2R
         51pAdbSMk/ibgisY+9yd+i4eDZgshriaOlM3w9nfupjZbzRHuJxE6lR0J3y2hC09MXKT
         8Sn6fS2dnCuBtd31thxksOp2OxUWcBddUvnyV2mNSRjXHuOSt12nn5KrmSpmakcBgq/b
         /6zGSow9ljREwrblRGHWWbvsM+hGrPXT4EmtfwQKtm9lo1r81ad1gnhCWwV8mOntMSXZ
         cgo074Iy9sLQYE35UzrbR7ZckQcqZF9uYvKvdUvteYpeMh07lvNOjE5yjjCLXX3qr/Y2
         V+Lg==
X-Gm-Message-State: AOAM530uV+H5nkbvOlJQKWZXxPOIHvpnMRnRQhPsaHulosrrHihZ1/f4
        vKC/zTgDzXH2F1AFxw7JIi2O4wYpDV29MOL8
X-Google-Smtp-Source: ABdhPJzdJEzolm2fJQSPJFKzxG4tHoyBATuOUxru6VS89YHbAkuJ/+VGGvHkSS5auuk3hRDlnvokJ5qr4Q5gNUGu
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:613:: with SMTP id
 z19mr5363210qvw.2.1612546502427; Fri, 05 Feb 2021 09:35:02 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:39 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <14ffc4cd867e0b1ed58f7527e3b748a1b4ad08aa.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 05/13] kasan: unify large kfree checks
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
index e6ed969e74b3..14f72ec96492 100644
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

