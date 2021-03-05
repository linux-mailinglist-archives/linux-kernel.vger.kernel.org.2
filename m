Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD40032F6A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCEXhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:36:39 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CEC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 15:36:39 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e6so3065749qte.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=MNZ6L1aoJDnvOEvMxOUk5KgG8S0E1lmCTxqkRycD2ZQ=;
        b=lRxvY4KKDvqZKuNX1Tl3icHmQWAvffTqQRCvTpt+3V7sZsi7tYKqVnmaIlrt3u5Vzr
         bolx5J0c1YpV/Zh8eyNR9f64jABwRyTE7d6NDn31U9pqDHdIuHHVFYQXtx2LN/+E+/NM
         2ADrbneU1zRymqKO4sbeqpUDK3v6trsmMGr/L70Yo/IYR7CvJZS5kKVI2WmVp/uKSjO+
         4gDzyxUJgDjW5OR+/MDcECeY8Ss50TV3gMaGOyEkEADlwnzocPKzuaqT/gC0D/ugQbv8
         akyryxoC3ihls/98DC11ASKNeQqe2+0VsMuXZeqiZoNRhzUgfSrXpDVU3xJMAngWT48f
         +yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=MNZ6L1aoJDnvOEvMxOUk5KgG8S0E1lmCTxqkRycD2ZQ=;
        b=m61m/lEUYZwuYMet8zX0Vi9Ep0h5IGIysloAxP0ywOCqv9XOjr3u3bAbAcX+TsivVK
         nb0KRBxkF3dlJgfLP0Zpakjvc8vX+DE1G2y93MpIK6YmImYMx/W0t167FDmdO4SkwBDm
         RhzSbeOxRynp+kL6Gm7G5V6ZVXiLKUrL1UuG2ZxWH6ldRXyi1VEaQnNmKx/rrUu81hpT
         fcEgi3AHqcKErn8i6etJ1bvnoKUfup9efOP4ZtP9xsXwQ2lRmchnTqMqjmpRUbJXlNAR
         jdzV7wucm2xk671gSRBwJ8rpY1BHLLTwdDTAHS/PFKT5xV2A6C8k6f4kRDsOh7Jn5vEF
         J2ng==
X-Gm-Message-State: AOAM531LXOPyvtMMxNUPthqc42u7cpUmQJ/FkKNDr8C4GBKWSkUlvFmH
        Dykpjxocb34S+w4CGPHdkXCjN/m15dlXT9O5
X-Google-Smtp-Source: ABdhPJzd20tLO23T5pXp0bHE5QJ4BYRPW1FhEx+WK2EYa8ywF7Fp5O6OObSx4vmYzyLM7fcw9UWAo7D2s7PyojO9
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1144:: with SMTP id
 b4mr11326208qvt.12.1614987396545; Fri, 05 Mar 2021 15:36:36 -0800 (PST)
Date:   Sat,  6 Mar 2021 00:36:33 +0100
Message-Id: <24cd7db274090f0e5bc3adcdc7399243668e3171.1614987311.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
after debug_pagealloc_unmap_pages(). This causes a crash when
debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
unmapped page.

This patch puts kasan_free_nondeferred_pages() before
debug_pagealloc_unmap_pages() and arch_free_page(), which can also make
the page unavailable.

Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Move kasan_free_nondeferred_pages() before arch_free_page().

---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 969e7012fce0..0efb07b5907c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1304,6 +1304,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	kernel_poison_pages(page, 1 << order);
 
+	/*
+	 * With hardware tag-based KASAN, memory tags must be set before the
+	 * page becomes unavailable via debug_pagealloc or arch_free_page.
+	 */
+	kasan_free_nondeferred_pages(page, order, fpi_flags);
+
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
 	 * does this.  So nothing which can access the page's contents should
@@ -1313,8 +1319,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
-	kasan_free_nondeferred_pages(page, order, fpi_flags);
-
 	return true;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

