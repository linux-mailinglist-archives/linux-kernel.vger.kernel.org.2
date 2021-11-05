Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB0446476
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhKENyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhKENya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:54:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F277C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uB26i/GpUuIPYUVcF2WyVQ4MrTliX9jWGUk0z0aWGG8=; b=tgne2CVCiuoOcMmED1JDLkNmRe
        xTNUfXvmJ31a8VUkl/Se8XKdofL8XYOqHYctLCoA7tM/TM67FVpZZhtPIydGetcjkXvDlKf5kZizH
        KFMh37+yYo0C9IK7MRsFdoVrrHflTU77avd8lIpaO8HGt53NR8TiWdHfZnDA57mgJjir4hpeFGlIa
        ewedz6GZd090ht4v9DsIQw9NnMFyhqqVTYbRFB/o7nyDtCrebAT/gTPvKIGIXDgTQD01i6gaEnhLm
        zLQE76qhy446CACQVzxF8+6Qf/ObPvdhlR7wVYaAki5VpZPm50hyR/C+hsl+/qS989Vcro6yBfk2V
        IcsmpLxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mizar-006aVK-Fd; Fri, 05 Nov 2021 13:49:48 +0000
Date:   Fri, 5 Nov 2021 13:49:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <YYU2YSOGHJFIrzmm@casper.infradead.org>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > testing information I hope this can land.
> > 
> > Andrew did you see this patch?
> 
> I did now ;)
> 
> Tossed onto the post-rc1 pile, thanks,

This patch seems to have slipped through the gaps for a couple of cycles
now?  I found a missed spot in it for CONFIG_HIGHMEM:

diff --git a/mm/highmem.c b/mm/highmem.c
index 471d9779a7f4..82d8c5ab6e8d 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -382,7 +382,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
 
 			if (end1 > start1) {
-				kaddr = kmap_atomic(page + i);
+				kaddr = kmap_local(page + i);
 				memset(kaddr + start1, 0, this_end - start1);
 			}
 			end1 -= this_end;
@@ -397,7 +397,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 
 			if (end2 > start2) {
 				if (!kaddr)
-					kaddr = kmap_atomic(page + i);
+					kaddr = kmap_local(page + i);
 				memset(kaddr + start2, 0, this_end - start2);
 			}
 			end2 -= this_end;
@@ -405,7 +405,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 		}
 
 		if (kaddr) {
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 			flush_dcache_page(page + i);
 		}
 
