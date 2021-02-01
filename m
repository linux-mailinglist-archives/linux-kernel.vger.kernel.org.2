Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EA30B0BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhBATq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhBATpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:45:24 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFDC061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:59 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 70so14118718qkh.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wTS7rGEWy/lmgEwVXVBE+5vzcvue/e9GmeYKwLI3/GI=;
        b=NM/EWWXfIO5X0CDVwGsXDCTqh8MrojXHR19eXM6kgDQheLb3UgxElTkZafjlwvJVMh
         hRX5SjP8nw46ZrfNSlgGwyvk51E5mCcJjGRICuKoVrBb2YwSa9i4QDptcJtNxcTGLJrj
         CeY1HpjU4xlSLRVgBGfO5+GLBbY3Lp0oNfGToUpZKWmAgO6jg6PmK+eLPiDFfbniYtjj
         0oFFptb75/P6D059sJVp3xp5O4JXmkbYqtDH8y1wuU6wR8rq4N02//J4aewnw8CWdPfK
         zE529RUGZuEtVrAuesBdVfQ/DsQqo1DTN6iIqW3q4M7STnfb18Ldteve0sFZw56OEXzt
         nmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wTS7rGEWy/lmgEwVXVBE+5vzcvue/e9GmeYKwLI3/GI=;
        b=bI6NMPmfqKwBLNevS3+tqFSM4GnhXzceMbj/g2TyQ+n8GJBPlZev+e6KCJh/gxGRqd
         zPtKgb01cYg4Zb/k3b7jBYK6NBwCfHq+2Kn0eQpsUzKsblVEcVZVlfYcVzB35bJsGyCg
         Fwawa30oYohvnfF1cQlngqPzspfu0RJyXQBeUa5uqTXBTv2fCl4hpKVfehDFfPfuCgf5
         Ly9HjhRdSE/jGXVW3lM3iL6c//QJU1pVVm3NMl0SXBfSdmCa3h51WYxOUD0xv0/RGgF4
         dZ7B6VNuqvdDPrg1ipiMweYewMr2y2oScqgZr2NFxwWiAdkC9guaQD6oCVkzt5doY9Cb
         YFfA==
X-Gm-Message-State: AOAM533Iju5/+cMF04S0vzaVVXAQkXDPlOLS6uhcOnzBUQFUiu06xCE3
        vDGqCOd4kDnDLLr9aKi5BtBzAi3FRnQ7++07
X-Google-Smtp-Source: ABdhPJzxW58GoVDg9DXe3VlIIu6Zz+FBlV301B0hIass2XkT/B7p+K717pXSiFgUHOf4CH1xC9QxDtyYCzLn2SR8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1110:: with SMTP id
 e16mr16696575qvs.62.1612208638752; Mon, 01 Feb 2021 11:43:58 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:32 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <431c6cfa0ac8fb2b33d7ab561a64aa84c844d1a0.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 08/12] kasan, mm: optimize krealloc poisoning
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
index 9c64a00bbf9c..a51d6ea580b0 100644
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
index dad70239b54c..821f657d38b5 100644
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
+		ks = __ksize(p);
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

