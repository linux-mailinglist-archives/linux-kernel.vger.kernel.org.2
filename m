Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF93D9FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhG2Igu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:36:50 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:52316 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234886AbhG2Igt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:36:49 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id EE591CAED6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:36:45 +0100 (IST)
Received: (qmail 32396 invoked from network); 29 Jul 2021 08:36:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jul 2021 08:36:45 -0000
Date:   Thu, 29 Jul 2021 09:36:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 049/138] mm/memcg: Add folio_lruvec_relock_irq() and
 folio_lruvec_relock_irqsave()
Message-ID: <20210729083644.GD3809@techsingularity.net>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-50-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-50-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:35AM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of relock_page_lruvec_irq() and
> folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
> to folio_matches_lruvec().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

When build testing what you had in your for-next branch, I got a new
warning for powerpc defconfig

 In file included from ./include/linux/mmzone.h:8,
                  from ./include/linux/gfp.h:6,
                  from ./include/linux/mm.h:10,
                  from mm/swap.c:17:
 mm/swap.c: In function 'release_pages':
 ./include/linux/spinlock.h:290:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
   290 |   _raw_spin_unlock_irqrestore(lock, flags); \
       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 mm/swap.c:906:16: note: 'flags' was declared here
   906 |  unsigned long flags;
       |                ^~~~~

I'm fairly sure it's a false positive and the compiler just cannot figure
out that flags are only accessed when lruvec is !NULL and once lruvec is
!NULL, flags are valid

diff --git a/mm/swap.c b/mm/swap.c
index 6f382abeccf9..96a23af8d1c7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -903,7 +903,7 @@ void release_pages(struct page **pages, int nr)
 	int i;
 	LIST_HEAD(pages_to_free);
 	struct lruvec *lruvec = NULL;
-	unsigned long flags;
+	unsigned long flags = 0;
 	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
