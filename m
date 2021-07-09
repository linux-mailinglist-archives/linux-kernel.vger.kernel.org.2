Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0814E3C219C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhGIJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:33:30 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:54721 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhGIJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:33:26 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id A3410FB371
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:30:42 +0100 (IST)
Received: (qmail 27889 invoked from network); 9 Jul 2021 09:30:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jul 2021 09:30:42 -0000
Date:   Fri, 9 Jul 2021 10:30:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/14] mm/page_alloc: Make should_fail_alloc_page a
 static function should_fail_alloc_page static
Message-ID: <20210709093040.GX3840@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
 <20210520084809.8576-4-mgorman@techsingularity.net>
 <20210708211648.13659bb5@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210708211648.13659bb5@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:18:44PM +0200, Matteo Croce wrote:
> On Thu, 20 May 2021 09:47:58 +0100
> Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > make W=1 generates the following warning for mm/page_alloc.c
> > 
> >   mm/page_alloc.c:3651:15: warning: no previous prototype for
> > ???should_fail_alloc_page??? [-Wmissing-prototypes] noinline bool
> > should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> > ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > This function is deliberately split out for BPF to allow errors to be
> > injected. The function is not used anywhere else so it is local to
> > the file. Make it static which should still allow error injection
> > to be used similar to how block/blk-core.c:should_fail_bio() works.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  mm/page_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index aaa1655cf682..26cc1a4e639b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3648,7 +3648,7 @@ static inline bool
> > __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order) 
> >  #endif /* CONFIG_FAIL_PAGE_ALLOC */
> >  
> > -noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int
> > order) +static noinline bool should_fail_alloc_page(gfp_t gfp_mask,
> > unsigned int order) {
> >  	return __should_fail_alloc_page(gfp_mask, order);
> >  }
> 
> 
> Hi Mel,
> 
> It seems that this breaks builds with CONFIG_DEBUG_INFO_BTF=y.
> Maybe that warning was a false positive because
> should_fail_alloc_page() is referenced via a macro?
> 
> I proposed to revert it, feel free to propose another fix.
> 

The alternative fix of making the symbol global was rejected. eBPF needs
to figure out a way of instrumenting code that is is unused by the kernel
and not globally visible but I don't know how that might be achieved.

-- 
Mel Gorman
SUSE Labs
