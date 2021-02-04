Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B834530ED70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhBDHeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhBDHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:34:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C0C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:33:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g3so1308703plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4AX1mVSMgbaVkW2N7V2vqh/dEgp7K7IJyIacPWakPqg=;
        b=JdE6Y5S9r0e0kMDTQmw4qtsJFmKZWQ51Iqo/JpDUJAp8qY3rn0pOv6peBWfiNLtthL
         WzgkABi+v1NSoV3587fjsTiFBSNhfW5aVFhNAnvKum1bEkXDRx/51p9noBlGa/prH1aY
         VegSqWPYNNKxNaQMBtTrC7CUJ1jaxrceLmEVEtr6a/QbP/ebR9ncISLEf8vEeK2CYdU0
         EqNTFcEBrEf8hhovIh/D2G9qHkEhlYomNfrATEF5b/bANf0w+UgVqnKaQUtcceVHiYNe
         kDYLf9Ne2gpX4MqfQioMqx8t2ep8ic4+0jqe1LSmQxrt3TM5k36/2XUReSRoq7PbOVNN
         i5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4AX1mVSMgbaVkW2N7V2vqh/dEgp7K7IJyIacPWakPqg=;
        b=khyOJoH3/zn3yKDGHkOjvsliO7yZG7Zjt5QsKzc1/IhX+Sjp4S0muLN3E1kyL6fDe6
         tWH6hUtZjhkiYcKE1srPYzBpuue3eQJd2A6jIybO/RSiAL7Gbfif/lDPYwRM5VrpjdIq
         TkdzP1aTywZaKALeLRg8I1bkIAaeh63U5/qw08f1It5HVhr0G/EchQVJw/6RJlPUlZYf
         BnZrYtDVTjd2M6XDOM5IT4tEpJ4kNwM/ITibHdQJkyOuR2WoU0hWZ3hDlqtm5HSHYVAd
         +NjOlDTcIXICgUTctBGungfgSU1rpC420Q6C4vJFjHi7ulGVCIfP4da7QP7k7m9Ieu5C
         YUZg==
X-Gm-Message-State: AOAM531h5z9Bltm5bRW9fQk4xUjbxE78jVlGYnACU9EWhKoeKRrnBTVQ
        OHAhGSyvAsFbjTyQe6RthHMvVqnW9xIInNqgSC8=
X-Google-Smtp-Source: ABdhPJzkSTvI807kXGfiIpKXjQ/Q+iwzECXbFs8+JLo/iEuKMZaTBl/M5gECUZPa2eMBEMdT2hvv7g==
X-Received: by 2002:a17:902:b411:b029:e0:8f0:5ba with SMTP id x17-20020a170902b411b02900e008f005bamr6876013plr.19.1612424023884;
        Wed, 03 Feb 2021 23:33:43 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3835:fc1d:bd99:95a3:b044])
        by smtp.gmail.com with ESMTPSA id y22sm4572020pfb.132.2021.02.03.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:33:43 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com, Ira Weiny <ira.weiny@intel.com>,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Date:   Thu,  4 Feb 2021 13:02:53 +0530
Message-Id: <20210204073255.20769-2-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204073255.20769-1-prathu.baronia@oneplus.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap_atomic() is being deprecated in favor of kmap_local_page().

Replace the uses of kmap_atomic() within the highmem code.

On profiling clear_huge_page() using ftrace an improvement
of 62% was observed on the below setup.

Setup:-
Below data has been collected on Qualcomm's SM7250 SoC THP enabled
(kernel v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76)
switched on and set to max frequency, also DDR set to perf governor.

FTRACE Data:-

Base data:-
Number of iterations: 48
Mean of allocation time: 349.5 us
std deviation: 74.5 us

v4 data:-
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

v4 data:-
Number of iterations: 100
Mean of allocation time: 18193 us
std deviation: 4915 us

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Prathu Baronia <prathu.baronia@oneplus.com>
[Updated commit text with test data]
---
 include/linux/highmem.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d2c70d3772a3..9a202c7e4e26 100644
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
 
@@ -199,9 +199,9 @@ alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 
 static inline void clear_highpage(struct page *page)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	clear_page(kaddr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 /*
@@ -216,7 +216,7 @@ static inline void zero_user_segments(struct page *page,
 		unsigned start1, unsigned end1,
 		unsigned start2, unsigned end2)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	unsigned int i;
 
 	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
@@ -227,7 +227,7 @@ static inline void zero_user_segments(struct page *page,
 	if (end2 > start2)
 		memset(kaddr + start2, 0, end2 - start2);
 
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	for (i = 0; i < compound_nr(page); i++)
 		flush_dcache_page(page + i);
 }
@@ -252,11 +252,11 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_user_page(vto, vfrom, vaddr, to);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 }
 
 #endif
@@ -267,11 +267,11 @@ static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 }
 
 #endif
-- 
2.17.1

