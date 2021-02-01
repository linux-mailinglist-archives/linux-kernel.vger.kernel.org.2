Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFA30B0B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBATpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBATox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:44:53 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A17C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:53 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id d7so11038418wri.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BaU4zsBnF6d3TSTU+6bwjMLYV3de6hEhX75uuk8b+O4=;
        b=nJiXwOEo+jDWjutl3bPtMddLIEbYjySSqFB9nsRMPC/OyMH1cWW9MJCeCANQqWCKmB
         4mwP+1VFCx3hJfom58GEOvLp6QCaI9DthbxNDJt5E19vA2IenGYT//kFZ3tt5SKMwPII
         JUvkgGhGqUDAruV7bZhAZMJVREM4TVtH2aoavGSYKjlNdtFGTAYff54a63RosxywMuHm
         1rEjzRp24e2Mh+Qobh7XPtIFaq29nychvE8goMeWtgJmRCYM9XxEicpGU9vrO7yzeJf3
         0BwkX+2NT+5+L7FlbRszkE0nJeL7H4X8e4lzext+ZMwX8Dzov8Ow4AQrlTK8RDIsbmNp
         XaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BaU4zsBnF6d3TSTU+6bwjMLYV3de6hEhX75uuk8b+O4=;
        b=NB2QM9kxypoRz3mM3Bgh4nS0d1R3dB2ReP6OieojM1OqbutZJXxObUm46iwdIFGrF8
         5YKc/AwJf2QZ15vCkSEbaRLb98sKseuWNgmjhDwvtQ947A1VUPfXYT5Nmh3+FVYr5nlr
         q/Znw39/c3MrxMevdH0GwFWs7d9gNi2ZRIslPv7p5ayVgQto4gJLnLPBlEdWCSpmLLRd
         3Rj/m1ToaUjtWS/U3h/q0AattRxXC2pjzo+/q4a/3ag97tNJtK+YJW+kDVDrwBBfkpBt
         SVOLfqaxEK6tf4DbA2EwKxyFeqUPtpeWZwY5hKzgvRUvqF7TXV3FblyznWcpGuuiCF9c
         D7Pw==
X-Gm-Message-State: AOAM5325IRcbhBw7dU5VJTJ+KYLMa09l06UQdk4MJC9hF4uTUYcNQJgQ
        t0XvD782NSw7pTFRLot685PgKAaL4PESDgLh
X-Google-Smtp-Source: ABdhPJw57hRKvoeOE3jkg8dsfKFGhvdZTC70UClQcRWBXmSodKiJDsoN3TWrUtEegspLXmVAevtVI9fb+W66gF3H
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6a02:: with SMTP id
 f2mr447589wmc.36.1612208631997; Mon, 01 Feb 2021 11:43:51 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:29 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <dbef8131b70766f8d798d24bb1ab9ae75dadea61.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 05/12] kasan: unify large kfree checks
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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
index 086bb77292b6..9c64a00bbf9c 100644
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

