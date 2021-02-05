Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC96311769
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhBEXqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhBEORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598FC061224
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:47:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b4so4505708pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tljlSxhBzcxqidAVSdVdhM6oUJ+nJ3d1xitEmX2Ppf0=;
        b=syVSGwpY7OBUajXhF+JU66oy4DayPtyhrZEKrCctZ7ZSEwdKPb5Fvf+ONRWcDtxp0K
         l36gKS8Yr71bsitJfXedVqVkHwOpQH2t/7/hBm4ZmVz/jpErYZ6yrtAzAzFjr4bLp1mg
         ZNGlS6epLYCc6jCq4C1m6SSWpMXkg7iVv0VbgQuORm2mYYrrw/8PmMphfXzVC3yZ6Lv6
         f992UftKMf+GCjLbYmegMakIMsmuEpSMOCwEwtz+LdHiElyCXXWkfY9EjfKHBoHqkLxc
         tuCvq3A1ZCy11mG8Rs7N3bouZpjWecOu83K6/n5Uzv6c/sKJo2krn++2hCMlongp3G5K
         c3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tljlSxhBzcxqidAVSdVdhM6oUJ+nJ3d1xitEmX2Ppf0=;
        b=j2OjBsjkzN7LEseBhmIGAb3f3Lg2wf7ADwyGdVNFTy51pnSTxNHglvpKSmnKU+ghrs
         vM0IZz6BR0mHU2bUtIr44byKFqeJvAJeywBap8rDNaz/ir3u9Rtc2ilPzkbNs7Uxa2Cx
         D4bWoZA3Y7xczK6oSFDhshcEDWxEwpGXUnSgjrFQMZ1+dxFcWWkCkYLQ3sCnCmTJus/A
         TLNMRQkz8RBuxIcFp5x1eHNhNxREA7AcDnOZaKQKPW48Zmvn8esQmpeYbt4hDzEBUYtr
         kmGFR0yDAJYvMxlDIVBEiIF2F2ovAufK5lKWmf8f54yxI4MT1t5DHxQQPhCIntNBcwdy
         IHmg==
X-Gm-Message-State: AOAM530AQVUVmdegMuP1rs3h4GJOQW7dEDvTzM7em1X18VKRNma8+Ms+
        M3Kk3PaitsWMtZYVXfUblpZUZCnpGNkKUpN5
X-Google-Smtp-Source: ABdhPJyO1MocpYFwZ1RXJ8jVPh8e1tllN7Hw4na0XycrZ5x/iFUpbgSITGryg5kyrNeA7pCK+1dElwIgxYqVy2a5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f94a:: with SMTP id
 i10mr4890478qvo.22.1612539565151; Fri, 05 Feb 2021 07:39:25 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:04 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <97581e50e594596e0bf8dd5bb3598d5e13013f18.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 03/12] kasan: optimize large kmalloc poisoning
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

