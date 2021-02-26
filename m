Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62B325B47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBZB0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBZB03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:26:29 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170ACC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:25:49 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b7so5465643qtj.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fGyKOr2NOKevbTthD2lHJMlPg4rW22LG13Q09TJ/Cwo=;
        b=uJ3kYZFMxLlqqaX2Rpd/bNsgXGp/tuRktWkUVuBsiZevS3FWcgeedNlg1NIP9RR05Q
         OiW5+84gPyysjLwJ8tA1/8rRWRei2XESjivD4O/4daEgXJgiPjvKT0VL1nqeB84Hh7yX
         BuK3Q8feeTPXniLZYAVwdHCAOIL8JVWc6NDK1SyFQXQrCXxf43qF+Xe4QRoOL7wA7Q88
         wELUKvoBH4Sf9kgavRQ6xhikOYJpXlqip6C7sZqhsFreA5lTLNBUP56ebjqNH3XccEGg
         emX6/RAwlaw2MJ+mmOvc8i8Cz7fAnP4iZeIWP2aj+YEj+aWYEjoh9hR1FziZwUDwoIPw
         a6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fGyKOr2NOKevbTthD2lHJMlPg4rW22LG13Q09TJ/Cwo=;
        b=T63e14ZswBNXcdxd0IONFAnHCIv/IJvCISWNNiIJFFDjqImWaznO8YEgYB1XojpWdw
         MGo2wblzWdx/aMbD6yosjjxfFMlaFd77H4buDnankkesfGJQWZb0i5iZIeDgnSI8Jcm0
         Bj1k6FyRHzoe6CNE4tt46P584uRHV/G+Kv0FVgQ4RY+/YzFLqc9PmDh5hmCHj9fv77a2
         mnq5cS494EA1zoT5+oyduWk/K0XCjkt6lA3+H5EEVQDM86kwl1Bbahcjo7M2+U9ifoXG
         6+er2SriuYLVpXL3kQ0Mggzy7gSD0rBCTHalrReb1aJlErFqBnL0CfrDfgibzKauI5Iq
         mjhw==
X-Gm-Message-State: AOAM532R/T6ovXzBn+i+rHhZHlzHhsj63mc+e/WB9kHuJleiWz/DIpPl
        q36g+mHtO37BYC2dUdVsGTlUDnrK/DP2ClD+
X-Google-Smtp-Source: ABdhPJwII1GzAbYJNaOMVsGMPtlc/00QWGiqENeLlq67efnXAPi4UcPrIte++d+RVfnvXx9+70ONFd2zGgWbbbPp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5c80:fb1e:3d1d:d709])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ec4e:: with SMTP id
 n14mr518858qvq.34.1614302748187; Thu, 25 Feb 2021 17:25:48 -0800 (PST)
Date:   Fri, 26 Feb 2021 02:25:37 +0100
Message-Id: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
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

Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
after debug_pagealloc_unmap_pages(). This causes a crash when
debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
unmapped page.

This patch puts kasan_free_nondeferred_pages() before
debug_pagealloc_unmap_pages().

Besides fixing the crash, this also makes the annotation order consistent
with debug_pagealloc_map_pages() preceding kasan_alloc_pages().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c89e7b107514..54bc237fd319 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1311,10 +1311,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 */
 	arch_free_page(page, order);
 
-	debug_pagealloc_unmap_pages(page, 1 << order);
-
+	/*
+	 * With hardware tag-based KASAN, memory tags must be set
+	 * before unmapping the page with debug_pagealloc.
+	 */
 	kasan_free_nondeferred_pages(page, order, fpi_flags);
 
+	debug_pagealloc_unmap_pages(page, 1 << order);
+
 	return true;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

