Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAC30B0AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBATpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhBATob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:44:31 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03121C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:48 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l15so11362476qtp.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5os4NdBbDONsbLVxABgdrPD9x64VnOptbOzgU3pEDKs=;
        b=icvI25ft44tZNJLareqZm2eV6LU3rjKFoSzXua9cf+7734+1fWcCmnYf7hEl5Qbz+D
         X1HGWJkAzxbfnIv7aZkYjPhjP0onDk8oLebvt5EFUyH9inK3uQ5w7A/juLiNsTrOpW6D
         4QB/f/PJ605/JfJndxR6OL1twXraBxmad0by++3RFa1uvStOQIe+cLBvnXzyUaTfu+2v
         IDNsEAuTbXwUW2bZwOGOX6UO1kpsjI9ybzJEZjTQQpoYleLdUk5xqzFbAzvVhdKy/Qr8
         WEoqEGKqEd0hnV7F9350O0q+eRFF2yKHGuEA4AGGamvMh48mEenN5FlPFbNm7at+3K3H
         B7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5os4NdBbDONsbLVxABgdrPD9x64VnOptbOzgU3pEDKs=;
        b=DgtQahYbItWKyM8RollgtEQe3OfodN2mTW279RYEhPhkEG4K2TxPBrQcOXqqBMkssW
         LimM+qro8KYO6puvpuEgXvaU4V4b3oZO/7g8VgxIUxz9SZPuwv2TPNaFSiu+iDAftbrm
         4K9aEwAt00hSKFyFSwM22YNz/45niRhfWp7RHiP7Y0rrFBB2KNtLixDFmElknT1R7BQh
         dBg0rS9DkenouQ8fs1Ngs0kXhIMzTdy4gBixRkCJ/6TVHik8zizUDQBUyimG0dWYkHCl
         AlMmCrGD4ylQUdlBc0rQ6EYg52ippLsP18Yrn/YggmYh5gpDM26DXiqyDMJ8nch/LZcj
         gwXQ==
X-Gm-Message-State: AOAM531lylYIkNu0Qyu4YoN6uS9MwVL+Vuz8mkAMQ4DmzXMn0ZremoOk
        UKd1qzgvJcjHq8/DyfIFndohjjXDmtnx5ADR
X-Google-Smtp-Source: ABdhPJzR+YEpFc2Ch11Rl6BTXMIoXfaJyZzPai737uCYCgWg2fJznC+a5+pVgD+X3paVHk7gPsjQcrXSotCeIBAj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c488:: with SMTP id
 u8mr16899450qvi.9.1612208627196; Mon, 01 Feb 2021 11:43:47 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:27 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <8fdbf86842f4eaf2458ecd23d0844058dbc2c7a2.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 03/12] kasan: optimize large kmalloc poisoning
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

Similarly to kasan_kmalloc(), kasan_kmalloc_large() doesn't need
to unpoison the object as it as already unpoisoned by alloc_pages()
(or by ksize() for krealloc()).

This patch changes kasan_kmalloc_large() to only poison the redzone.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 128cb330ca73..a7eb553c8e91 100644
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

