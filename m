Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26D3B659A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhF1Pbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:31:31 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:39215 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235256AbhF1PGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:06:17 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 0CC88BEC93
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:03:50 +0100 (IST)
Received: (qmail 3938 invoked from network); 28 Jun 2021 15:03:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jun 2021 15:03:49 -0000
Date:   Mon, 28 Jun 2021 16:03:48 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Jones <davej@codemonkey.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_alloc: do bulk array bounds check after checking
 populated elements
Message-ID: <20210628150348.GD3840@techsingularity.net>
References: <20210618125102.GU30378@techsingularity.net>
 <20210628042759.GA19686@codemonkey.org.uk>
 <20210628115322.GA3840@techsingularity.net>
 <20210628144805.GA3687@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210628144805.GA3687@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:48:05AM -0400, Dave Jones wrote:
> On Mon, Jun 28, 2021 at 12:53:23PM +0100, Mel Gorman wrote:
> 
>  > > This made it into 5.13 final, and completely breaks NFSD for me (Serving tcp v3 mounts).
>  > > Existing mounts on clients hang, as do new mounts from new clients.
>  > > Rebooting the server back to rc7 everything recovers.  Bisect lands on
>  > > this commit.
>  > 
>  > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>  > index ef2265f86b91..04220581579c 100644
>  > --- a/mm/page_alloc.c
>  > +++ b/mm/page_alloc.c
>  > @@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  >  
>  >  	/* Already populated array? */
>  >  	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  > -		return 0;
>  > +		return nr_populated;
> 
> Yep, this works.
> 

Thanks Dave, it passed a dbench test over NFS locally as well so I sent
a proper version of the patch. Hopefully it'll be picked up relatively
quickly and appear in a 5.13.1 release.

-- 
Mel Gorman
SUSE Labs
