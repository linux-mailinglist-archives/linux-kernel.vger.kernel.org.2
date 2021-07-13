Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416613C72AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhGMO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 10:59:17 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:37517 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236763AbhGMO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:59:16 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 0582618E02F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 15:56:25 +0100 (IST)
Received: (qmail 18292 invoked from network); 13 Jul 2021 14:56:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Jul 2021 14:56:24 -0000
Date:   Tue, 13 Jul 2021 15:56:23 +0100
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
Message-ID: <20210713145623.GE3809@techsingularity.net>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-3-mgorman@techsingularity.net>
 <E7C50307-24D8-4D75-B65E-0D7CA7C08048@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <E7C50307-24D8-4D75-B65E-0D7CA7C08048@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 02:21:58PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 13, 2021, at 9:56 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > From: Yanfei Xu <yanfei.xu@windriver.com>
> > 
> > If the array passed in is already partially populated, we should
> > return "nr_populated" even failing at preparing arguments stage.
> > 
> > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Link: https://lore.kernel.org/r/20210709102855.55058-1-yanfei.xu@windriver.com
> > ---
> > mm/page_alloc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6ef86f338151..803414ce9264 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5255,7 +5255,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> > 	gfp &= gfp_allowed_mask;
> > 	alloc_gfp = gfp;
> > 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
> > -		return 0;
> > +		return nr_populated;
> 
> Can you restore the hunk in patch 3/4 that changes this "return nr_populated;"
> to "goto out;" ?
> 

I fixed that up in the series I sent out. I applied this patch first
then reconciled the collision with your patch.

-- 
Mel Gorman
SUSE Labs
