Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD31731113D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhBERuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhBEPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:54:33 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF308C061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:10 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id ew14so5491621qvb.21
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ISHwxx5EnSKzUDUjZ1ysUZFyHBfF802klWxWhYA/428=;
        b=RwM46b1OK05tP9oh3ZvOyyqP5DeUCm5WEgXs9WIi2QDZ10b7a1JK5ykxxwcHrHcz9b
         eDMl73sT/lR0Hw6RbGi7n8FmxAtam+z6WvhhjYDN0jIge9F1av+HlKfQ0YVNHLJwTL4a
         wYltM3xRPcjR+cLRrDGpWcNlDeVQ0jGBPh5FGQNKahJiLulk3hX2Cp1yjBVRjR+/+5Jb
         tLWvCNv5ECt+IWcvAMdNWQlPComv7q0GUtli6S3pwLuKz9J3Ab96/KplUlWGVJ5DCNPP
         OUmhAtwjQXJraW/q+HNZTthQdlqCfh8OL9LVIJ6y66/8ZaTjbezpHKnepMfZm+KLEc5v
         HBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ISHwxx5EnSKzUDUjZ1ysUZFyHBfF802klWxWhYA/428=;
        b=PAR1ZmYEx2yK61Zq+0AwvLnkFqGbLSqdL8GtzYjpBC3E1oXWyCulFCC8FurSp5MkI7
         Fz+gsDvXieuX8UrF/EyD8OyRvQq2qJP8i90TqEt660/wQBcbpfYVHx4hZpTNRsLG53qI
         dvq+SjqDdYESPpiFX8OSy6hxF9xoXNBKNYE01ArWsLTzb8mX4VdGDAaYdiTEdLYR9hcW
         onb+f5dl4cHKNmbJuH9rSRllbaDQgkepmJ9RryuDmkSvS1VObD6SC1PmCoAb0Z94eGi/
         VthFEecSFYk3u7/ZdZNgguRgDZ7eqf3Y5NpZ0JHEV5dYZjNCfBT/90YYh1Z8v0dTFQWq
         vc0Q==
X-Gm-Message-State: AOAM531GIEJ9m0hvNPuasMwkZ5riBaAlhj3NCgks6WMHUFXcPO7LEMxK
        ILsCHoyrcr0gatuo1QT73/7rsGGwHQ952wBi
X-Google-Smtp-Source: ABdhPJzeuGXvKwDVMKQZvPztFjBxnrWar5viffIlpldRL8/ioMWlXHOlQwfTr/fGJyK6XQY22n8CnOgwdlEcN5sq
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c687:: with SMTP id
 d7mr5237396qvj.17.1612546510164; Fri, 05 Feb 2021 09:35:10 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:42 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <9bef90327c9cb109d736c40115684fd32f49e6b0.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 08/13] kasan, mm: optimize krealloc poisoning
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

Currently, krealloc() always calls ksize(), which unpoisons the whole
object including the redzone. This is inefficient, as kasan_krealloc()
repoisons the redzone for objects that fit into the same buffer.

This patch changes krealloc() instrumentation to use uninstrumented
__ksize() that doesn't unpoison the memory. Instead, kasan_kreallos()
is changed to unpoison the memory excluding the redzone.

For objects that don't fit into the old allocation, this patch disables
KASAN accessibility checks when copying memory into a new object instead
of unpoisoning it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 12 ++++++++++--
 mm/slab_common.c  | 20 ++++++++++++++------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7ea643f7e69c..a8a67dca5e55 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -476,7 +476,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 
 	/*
 	 * The object has already been unpoisoned by kasan_slab_alloc() for
-	 * kmalloc() or by ksize() for krealloc().
+	 * kmalloc() or by kasan_krealloc() for krealloc().
 	 */
 
 	/*
@@ -526,7 +526,7 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 
 	/*
 	 * The object has already been unpoisoned by kasan_alloc_pages() for
-	 * alloc_pages() or by ksize() for krealloc().
+	 * alloc_pages() or by kasan_krealloc() for krealloc().
 	 */
 
 	/*
@@ -554,8 +554,16 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return (void *)object;
 
+	/*
+	 * Unpoison the object's data.
+	 * Part of it might already have been unpoisoned, but it's unknown
+	 * how big that part is.
+	 */
+	kasan_unpoison(object, size);
+
 	page = virt_to_head_page(object);
 
+	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
 	if (unlikely(!PageSlab(page)))
 		return __kasan_kmalloc_large(object, size, flags);
 	else
diff --git a/mm/slab_common.c b/mm/slab_common.c
index dad70239b54c..60a2f49df6ce 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1140,19 +1140,27 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 	void *ret;
 	size_t ks;
 
-	if (likely(!ZERO_OR_NULL_PTR(p)) && !kasan_check_byte(p))
-		return NULL;
-
-	ks = ksize(p);
+	/* Don't use instrumented ksize to allow precise KASAN poisoning. */
+	if (likely(!ZERO_OR_NULL_PTR(p))) {
+		if (!kasan_check_byte(p))
+			return NULL;
+		ks = kfence_ksize(p) ?: __ksize(p);
+	} else
+		ks = 0;
 
+	/* If the object still fits, repoison it precisely. */
 	if (ks >= new_size) {
 		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}
 
 	ret = kmalloc_track_caller(new_size, flags);
-	if (ret && p)
-		memcpy(ret, p, ks);
+	if (ret && p) {
+		/* Disable KASAN checks as the object's redzone is accessed. */
+		kasan_disable_current();
+		memcpy(ret, kasan_reset_tag(p), ks);
+		kasan_enable_current();
+	}
 
 	return ret;
 }
-- 
2.30.0.365.g02bc693789-goog

