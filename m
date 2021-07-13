Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D463C7315
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhGMPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:24:27 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:54231 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237033AbhGMPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:24:24 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 11932FAE73
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:21:33 +0100 (IST)
Received: (qmail 16828 invoked from network); 13 Jul 2021 15:21:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Jul 2021 15:21:32 -0000
Date:   Tue, 13 Jul 2021 16:21:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/page_alloc: correct return value when failing at
 preparing
Message-ID: <20210713152131.GH3809@techsingularity.net>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-3-mgorman@techsingularity.net>
 <E7C50307-24D8-4D75-B65E-0D7CA7C08048@oracle.com>
 <20210713145623.GE3809@techsingularity.net>
 <38D7DF36-4425-4D8B-9091-CE49CE046D6A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <38D7DF36-4425-4D8B-9091-CE49CE046D6A@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 03:01:24PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 13, 2021, at 10:56 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > On Tue, Jul 13, 2021 at 02:21:58PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Jul 13, 2021, at 9:56 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
> >>> 
> >>> From: Yanfei Xu <yanfei.xu@windriver.com>
> >>> 
> >>> If the array passed in is already partially populated, we should
> >>> return "nr_populated" even failing at preparing arguments stage.
> >>> 
> >>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> >>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >>> Link: https://lore.kernel.org/r/20210709102855.55058-1-yanfei.xu@windriver.com
> >>> ---
> >>> mm/page_alloc.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 6ef86f338151..803414ce9264 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -5255,7 +5255,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >>> 	gfp &= gfp_allowed_mask;
> >>> 	alloc_gfp = gfp;
> >>> 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
> >>> -		return 0;
> >>> +		return nr_populated;
> >> 
> >> Can you restore the hunk in patch 3/4 that changes this "return nr_populated;"
> >> to "goto out;" ?
> >> 
> > 
> > I fixed that up in the series I sent out. I applied this patch first
> > then reconciled the collision with your patch.
> 
> 3/4 still needs to change this "return nr_populated;" to "goto out;"
> as part of the clean up.
> 

Sorry, I had that in my git tree but didn't refresh the broken-out
series properly before sending. I've sent a v2.

-- 
Mel Gorman
SUSE Labs
