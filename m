Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D19446763
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhKEQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhKEQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:58:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288EEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d5uXSFr1WnJB99KKBnE/HYyj7JABz30hI7jfRafjzEw=; b=NlrFItveCVZZjGn3W9XmzwPu2g
        /GptzRzTqxNiVs5SiosRdcV/zuVxVPh6eAfaIR13cyP/K9Y2gv2GjxZHiozdwz/FeGz7IK0o0ythF
        R4MYZVYpXXk90VkjdrbpnORY+YFRpisedGo7SlXNRrL3Zlwyo8wzgXuflR7+nOaaFz2V1RtPkoY9H
        HGWs13ZQP3wkzRvGHdgwGYzahHl0Gmp8pKFaHZll9DO1Ai4N8awtgYF2iQ/rdvycqawB4ismD+yLT
        ayy79ANNCIedJ2Qt38gHg8v/BMQ0Mawdn3yoDoS2lf7VLkkYTazwk5RykeYSs0fgQnAURIxM8cdh6
        HMNpujYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2RI-006giS-5a; Fri, 05 Nov 2021 16:52:56 +0000
Date:   Fri, 5 Nov 2021 16:51:40 +0000
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
Message-ID: <YYVhHCJcm2DM2G9u@casper.infradead.org>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYU2YSOGHJFIrzmm@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 01:50:37PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > testing information I hope this can land.
> > > 
> > > Andrew did you see this patch?
> > 
> > I did now ;)
> > 
> > Tossed onto the post-rc1 pile, thanks,
> 
> This patch seems to have slipped through the gaps for a couple of cycles
> now?  I found a missed spot in it for CONFIG_HIGHMEM:

Ugh, sorry, wrong version of the patch.

---
 mm/highmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 471d9779a7f4..88f65f155845 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -382,7 +382,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
 
 			if (end1 > start1) {
-				kaddr = kmap_atomic(page + i);
+				kaddr = kmap_local_page(page + i);
 				memset(kaddr + start1, 0, this_end - start1);
 			}
 			end1 -= this_end;
@@ -397,7 +397,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 
 			if (end2 > start2) {
 				if (!kaddr)
-					kaddr = kmap_atomic(page + i);
+					kaddr = kmap_local_page(page + i);
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
 
-- 
2.33.0

