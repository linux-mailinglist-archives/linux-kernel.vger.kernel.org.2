Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102BB3577F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhDGWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:47:28 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52356 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhDGWrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:47:24 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 708AD5A22061; Wed,  7 Apr 2021 23:47:08 +0100 (BST)
Date:   Wed, 7 Apr 2021 23:47:08 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: page_owner: fetch backtrace only for tracked pages
Message-ID: <YG42bFWONQLRTr2N@sf>
References: <20210401212445.3534721-1-slyfox@gentoo.org>
 <0c18e497-07d1-887f-e49e-b6315f396ab8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c18e497-07d1-887f-e49e-b6315f396ab8@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:49:14PM +0200, Vlastimil Babka wrote:
> On 4/1/21 11:24 PM, Sergei Trofimovich wrote:
> > Very minor optimization.
> 
> I'm not entirely sure about accuracy of "only for tracked pages". Missing
> page_ext is something I'm not even sure how possible it is in practice, probably
> just an error condition (failed to be allocated?). Or did you observe this in
> practice? But anyway, the change is not wrong.

Never saw missing 'page_ext' in practice (I also did not check for
it explicitly). I agree "optimization" is misleading. "cleanup"
might be a better wording.

> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: linux-mm@kvack.org
> > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> > ---
> >  mm/page_owner.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > index 63e4ecaba97b..7147fd34a948 100644
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -140,14 +140,14 @@ void __reset_page_owner(struct page *page, unsigned int order)
> >  {
> >  	int i;
> >  	struct page_ext *page_ext;
> > -	depot_stack_handle_t handle = 0;
> > +	depot_stack_handle_t handle;
> >  	struct page_owner *page_owner;
> >  
> > -	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> > -
> >  	page_ext = lookup_page_ext(page);
> >  	if (unlikely(!page_ext))
> >  		return;
> > +
> > +	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> >  	for (i = 0; i < (1 << order); i++) {
> >  		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
> >  		page_owner = get_page_owner(page_ext);
> > 
> 

-- 

  Sergei
