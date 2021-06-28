Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F893B5D69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhF1L4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:56:17 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:49323 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhF1L4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:56:14 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id EC6F516C018
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:53:47 +0100 (IST)
Received: (qmail 18831 invoked from network); 28 Jun 2021 11:53:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jun 2021 11:53:47 -0000
Date:   Mon, 28 Jun 2021 12:53:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_alloc: do bulk array bounds check after checking
 populated elements
Message-ID: <20210628115322.GA3840@techsingularity.net>
References: <20210618125102.GU30378@techsingularity.net>
 <20210628042759.GA19686@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210628042759.GA19686@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:27:59AM -0400, Dave Jones wrote:
> On Fri, Jun 18, 2021 at 01:51:02PM +0100, Mel Gorman wrote:
>  > Dan Carpenter reported the following
>  > 
>  >   The patch 0f87d9d30f21: "mm/page_alloc: add an array-based interface
>  >   to the bulk page allocator" from Apr 29, 2021, leads to the following
>  >   static checker warning:
>  > 
>  >         mm/page_alloc.c:5338 __alloc_pages_bulk()
>  >         warn: potentially one past the end of array 'page_array[nr_populated]'
>  > 
>  > The problem can occur if an array is passed in that is fully populated. That
>  > potentially ends up allocating a single page and storing it past the end of
>  > the array. This patch returns 0 if the array is fully populated.
>  > 
>  > Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
>  > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>  > Signed-off-by: Mel Gorman <mgorman@techsinguliarity.net>
>  > ---
>  >  mm/page_alloc.c | 4 ++++
>  >  1 file changed, 4 insertions(+)
>  > 
>  > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>  > index 7124bb00219d..ef2265f86b91 100644
>  > --- a/mm/page_alloc.c
>  > +++ b/mm/page_alloc.c
>  > @@ -5056,6 +5056,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  >  	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
>  >  		nr_populated++;
>  >  
>  > +	/* Already populated array? */
>  > +	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  > +		return 0;
>  > +
>  >  	/* Use the single page allocator for one page. */
>  >  	if (nr_pages - nr_populated == 1)
>  >  		goto failed;
> 
> 
> This made it into 5.13 final, and completely breaks NFSD for me (Serving tcp v3 mounts).
> Existing mounts on clients hang, as do new mounts from new clients.
> Rebooting the server back to rc7 everything recovers.  Bisect lands on
> this commit.
> 

Thanks Dave, can you try this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef2265f86b91..04220581579c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return 0;
+		return nr_populated;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
