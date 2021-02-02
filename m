Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D520430B8DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhBBHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhBBHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:43:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 23:43:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e12so2785820pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9Nw580wH3Szzy6jZrbEdWTwwu/44aSoeKZJwWuqyC8=;
        b=b457j4Gmg5klxsfuGHZrELOa2VJ4zDoVlGwRl4nSBVgXc3EjoVUgv9Zb+rHaLY9dIg
         kwT+jKRelaPd/N3Ux+BY0X5p77NbwF4Gx1TP3HBCk7PTSJ77XpQfq4w7QdVL0yrS4Geq
         QHJ8KuTRBf5ddKO6RzQ0xReir16SdZqHhfKeX0Os/DH9aJfk3EVyhc384RG6Nf5dDWVT
         M3kAHXADFfKdnqJ8TZkPJPBF9WafIAr5aDAQZSN1B2Otm6rG4sqg4MqhzTn6aQHNGj6g
         IwwelUBDBn0RU5ZAvfW8DwgHNnwlgaUzChJ0UCtEronuSP8tc8wmWSmAY4c1qojWFJId
         aDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9Nw580wH3Szzy6jZrbEdWTwwu/44aSoeKZJwWuqyC8=;
        b=F29DHgROFA1YUWa0FkXBRPje7a9eeTkuAWV7hvwWlr77mxImgs8qxAot6pFPgQZahs
         WVWDqEVxGbcpvbT+NL1NY64bVJ5NuglYWpucqtbOyP7rUBC2P76aOQq0dpmZOz3j3Ev3
         sDc9qYPBMNYEuxkrFb1jPjOheuh2d8P4udtRpu0bmYbxGtpPiNrgeH5seiYycQUMVNTe
         bMFjyErIa8cAvgDsrEFAGGEPJxK1prDxdozlnAs55j8LlwlTNkvh2Z7+6ph8Z9Cm3NiA
         C43dFXKJ8JRAvE1+0ztfuLIEbBgukc6Q5nvbqSfxDrl8ZGFf338zLaXbTBPPVbY20mR7
         IwdA==
X-Gm-Message-State: AOAM531hENWnmnBtQRkqACXtsCxINgcWuhkyg3rE/g3fiyCGRNCBCEbO
        95KS3PUCqgkr2gZLw4iavmD5Cu3Z8eVljEcv
X-Google-Smtp-Source: ABdhPJwYaj9NsQfk2aFiaaxxwPb0QuUVoBoFbB+lXAZFw81/W8L3kSJxFZ415rN1dAlpnOlaaTbKOA==
X-Received: by 2002:a17:902:e881:b029:de:593d:82ca with SMTP id w1-20020a170902e881b02900de593d82camr21492197plg.82.1612251797593;
        Mon, 01 Feb 2021 23:43:17 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3035:c597:b9c3:41be:d23e])
        by smtp.gmail.com with ESMTPSA id z13sm20507118pgf.89.2021.02.01.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:43:17 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 1/1] mm: Optimizing hugepage zeroing in arm64
Date:   Tue,  2 Feb 2021 13:12:24 +0530
Message-Id: <20210202074225.7244-2-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202074225.7244-1-prathu.baronia@oneplus.com>
References: <20210202074225.7244-1-prathu.baronia@oneplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In !HIGHMEM cases, specially in 64-bit architectures, we don't need temp
mapping of pages. Hence, k(map|unmap)_atomic() acts as nothing more than
multiple barrier() calls, for example for a 2MB hugepage in
clear_huge_page() these are called 512 times i.e. to map and unmap each
subpage that means in total 2048 barrier calls. This called for
optimization. Simply getting VADDR from page in the form of kmap_local_*
APIs does the job for us.  We profiled clear_huge_page() using ftrace
and observed an improvement of 62%.

Setup:-
Below data has been collected on Qualcomm's SM7250 SoC THP enabled
(kernel
v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76) switched on
and set to max frequency, also DDR set to perf governor.

FTRACE Data:-

Base data:-
Number of iterations: 48
Mean of allocation time: 349.5 us
std deviation: 74.5 us

v1 data:-
Number of iterations: 48
Mean of allocation time: 131 us
std deviation: 32.7 us

The following simple userspace experiment to allocate
100MB(BUF_SZ) of pages and writing to it gave us a good insight,
we observed an improvement of 42% in allocation and writing timings.
-------------------------------------------------------------
Test code snippet
-------------------------------------------------------------
      clock_start();
      buf = malloc(BUF_SZ); /* Allocate 100 MB of memory */

        for(i=0; i < BUF_SZ_PAGES; i++)
        {
                *((int *)(buf + (i*PAGE_SIZE))) = 1;
        }
      clock_end();
-------------------------------------------------------------

Malloc test timings for 100MB anon allocation:-

Base data:-
Number of iterations: 100
Mean of allocation time: 31831 us
std deviation: 4286 us

v1 data:-
Number of iterations: 100
Mean of allocation time: 18193 us
std deviation: 4915 us

Reported-by: Chintan Pandya <chintan.pandya@oneplus.com>
Signed-off-by: Prathu Baronia <prathu.baronia@oneplus.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d2c70d3772a3..444df139b489 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -146,9 +146,9 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	void *addr = kmap_atomic(page);
+	void *addr = kmap_local_page(page);
 	clear_user_page(addr, vaddr, page);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 #endif
 
-- 
2.17.1

