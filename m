Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7C310EFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhBEQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhBEPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:18 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3BEC061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:34:59 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id d7so5742668wri.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tljlSxhBzcxqidAVSdVdhM6oUJ+nJ3d1xitEmX2Ppf0=;
        b=EooVbzbfAmq8G1bWgvLByZcRTJzsGaZsM+gbsnttAHt59SZ03efBEYHdViNV3NOcBb
         AIV9WF6XYYWGw3mRwID1biNz4Xd/YnW9mVfWF3MqcCeTu8ZEhARSrRcHYLM1RcDt/U8i
         v3YvXKISbDMp6LV5R+hWQKWdH3XDXXiz6Y8YegizUaUeJw9yV1lF2WpCyTeZiZQMLUSY
         laKMOHx3s2jUXdJJtzLun9LBT3MD0Y52b8M44RMyqTJV6KG7pYS+FryEe+WFupRVaQW6
         nT3pdbQDrilZswBy/TGLAEBB7NbLJO0EwX6HQFv7HTOCg1BW07zGmBMyOMgF1P3Aima1
         hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tljlSxhBzcxqidAVSdVdhM6oUJ+nJ3d1xitEmX2Ppf0=;
        b=k+giXJhuPS+KMPv3dVmF2JEAh/SMfGN+alzPNSrgZ+OjAVywpxPomEYHuscjJxDsil
         dp1kIEL1JTmVxOnkMJtGoYF7ZJbb3dRTG0/DeNJXtFNArTAZKhrMsA9VlESgHKurLe7L
         zQVgynm62FHgljEUOpZ/EH5suN1/gvBPBOn7DCbaQIr8wE1iDfMnUxWQareaoqLzaO4I
         wKlFg58SOlpQ/bWlCDxWe4pMMBLFKta3mxbA/Cv/b0Lc6OaaJxG7EwSkNoGrfpafoouB
         wQ05dN+cFCRfxBBjR430Oyyr8cHYK7yIyvheHgL+wNifrmNuWA8QYXZNyf6Ts9+pdEpd
         O7UA==
X-Gm-Message-State: AOAM531w/ZJWVuxl6z6KRWgMm6ZX1yGAU3cHzxmQf8SWCeHk8xv+f0pj
        lDGmXLxklIgUB9f67CtC7N+quvRuT7kaR+jG
X-Google-Smtp-Source: ABdhPJwsjA/F6RHWX96VY6maj/IIDJ50rvRshw+Hr4yR+j1mTxQLGy8N+h/cCmJm78A4s33ZYOd8+8tTyP3YonbL
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a5d:53c3:: with SMTP id
 a3mr6032044wrw.43.1612546497774; Fri, 05 Feb 2021 09:34:57 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:37 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <33dee5aac0e550ad7f8e26f590c9b02c6129b4a3.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 03/13] kasan: optimize large kmalloc poisoning
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

Similarly to kasan_kmalloc(), kasan_kmalloc_large() doesn't need
to unpoison the object as it as already unpoisoned by alloc_pages()
(or by ksize() for krealloc()).

This patch changes kasan_kmalloc_large() to only poison the redzone.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 00edbc3eb32e..f2a6bae13053 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -494,7 +494,6 @@ EXPORT_SYMBOL(__kasan_kmalloc);
 void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 						gfp_t flags)
 {
-	struct page *page;
 	unsigned long redzone_start;
 	unsigned long redzone_end;
 
@@ -504,12 +503,23 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 	if (unlikely(ptr == NULL))
 		return NULL;
 
-	page = virt_to_page(ptr);
+	/*
+	 * The object has already been unpoisoned by kasan_alloc_pages() for
+	 * alloc_pages() or by ksize() for krealloc().
+	 */
+
+	/*
+	 * The redzone has byte-level precision for the generic mode.
+	 * Partially poison the last object granule to cover the unaligned
+	 * part of the redzone.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		kasan_poison_last_granule(ptr, size);
+
+	/* Poison the aligned part of the redzone. */
 	redzone_start = round_up((unsigned long)(ptr + size),
 				KASAN_GRANULE_SIZE);
-	redzone_end = (unsigned long)ptr + page_size(page);
-
-	kasan_unpoison(ptr, size);
+	redzone_end = (unsigned long)ptr + page_size(virt_to_page(ptr));
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
 		     KASAN_PAGE_REDZONE);
 
-- 
2.30.0.365.g02bc693789-goog

