Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683B310D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhBEO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B81C061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:46:04 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id n15so5557901wrv.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ISHwxx5EnSKzUDUjZ1ysUZFyHBfF802klWxWhYA/428=;
        b=TwrM5M5Ch2ZUHOoLxcPnwrE6JjOif4wmSkb2jlervFb/bxU4iYzugCMCpwAcRbHq4H
         N1zF1OuUuYKeX9V3GLI1wTwMILzVeF8FretvHV0csoNee1X7kwhevOuPjyG+T+OnOkVJ
         WVDsEz8WQh3gM3Ee9A6eYiS0TvgVp3KTN2FD9pdhx0hXv1gZr+8B5bwofshs4ZnRH/0Z
         eWSpUIdzy4P9bv4dq+Rq9ApiCo6ZPg5NelpiqyibiKy77/qDeLoJXoNfUEujlZouAVVQ
         DkWq2ovXteNYiuO0JT92Mg8SxjluiRWLibM+8zqds5UuLj66AcJhYc0GAg6plxLo1Eru
         l8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ISHwxx5EnSKzUDUjZ1ysUZFyHBfF802klWxWhYA/428=;
        b=YLZrB63Dvet8W3hrLjMknaYYvU/6OAUFKR/W1HO95UABMt6atIsPvNN5xiHOg+Cjzt
         1jB4LSizVtnRPQ6jEZBsLNZqV78ozaG8J+jXPBczRKNQDvPadsqCb3y+cLkCHFyAZG2T
         m12HNnu7MOZeIQ+7YV/fEw+JkApv84t8RoDKZjEKkTm1abmxxIn37Q1E93+DpY6nWErM
         ePZJEwURvakIMkNHl/Naos8eHKXDQitb9q7XJEP11ksfzeAJWaqHQHg4ey78rhQ9pbQh
         ETelVLpnSTy0wzzaV4MVAkd/Zm2StVUB5kkWvFb0G2j2XMF2/nziz7k4RLfIVu1IVcdD
         GLLw==
X-Gm-Message-State: AOAM531cPNsf97te6e2/wm76nDyEvVIsZ7O4aAFPl/0hRxjBIm5pUm5r
        wY9x8+E9kQC61tk5pJ8xETkaUj/3KMXnyjDe
X-Google-Smtp-Source: ABdhPJxP6vMDfthzecVC5ecdLO+5Dv7Y8pBeoXM66UJWgdoywOg+JFnFIENVMygIhQfAgTki+HWSylKOMpIDzaAZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c5c1:: with SMTP id
 n1mr4107578wmk.163.1612539577356; Fri, 05 Feb 2021 07:39:37 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:09 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <1cf400f36ab1fd3c83e7626c3797cb11ebf9ef7f.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 08/12] kasan, mm: optimize krealloc poisoning
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

