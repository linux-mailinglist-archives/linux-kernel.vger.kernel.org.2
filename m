Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DB31DE23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhBQR1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhBQR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:26:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:26:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x136so8859720pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KfJENNomm0u1yDPE/3P/mDju/zU9mlMVzfZQ10n5yXs=;
        b=Fmjf3a9zfQSt5m5VVLr9vi0HB78rGgbfHbSrkmZDE2X4oMN+4CiJuZuucPqOTlb8VK
         f6pafPewDu81KXRlsmQpevZR+d5x6F4uCugBw78bXlAz/+gEMu5JPSAVg2qkSOs41bP1
         3m3Lsgep9ryRq3ua/jK5z+w2loFjnzkzuV53xUR39UElHCxR36qlonpT85KCaZTPOHjg
         af4zEiFw1yYoFEKGDu8V6NlOiI/QPs+ADvtLdSkxFqPUvH/xMU/qJyRvSu5zv+XS6NYl
         +iWM1xEtFFCzuYHYThNcUi+fHwktaKm7vLZELYV7wC7Z4+ZYyq8ftbea8DAZZFTj9BRN
         Wz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KfJENNomm0u1yDPE/3P/mDju/zU9mlMVzfZQ10n5yXs=;
        b=MDrOq8ln+bcBLT5I7hA7AjrLlk8PmzzRLd+tGqARezbFCfK7kGwVEkQ9X/BZKW0E9H
         4BY3aSAamnopj2/ME0Qnx2NVJWL5Pjys+xnu9d6unxSulM6q+O2tCt0/IX/k1wnZhPGK
         focUPPfAFRUIOz1eAX8ddIA/rY2AGUMqHUUP/gGCbyjWPZJ/ITKeIo54GNjkForKfuQN
         uTy33qFQ5/PAJoX/tchNQqUEJA6c0OgYbfhveyu+RksHfpea3J79CJCIVHoxpONiax+E
         xEFa+Q+qQbKghOfP2LKbBDrli3eB6v8vA8u06KuteJzd6elIWjXpswNTiXq1qjbQqesH
         ZpvQ==
X-Gm-Message-State: AOAM533sUU1R17S36A5YiKZg1ZHa05Fzgz4IMNWmfmg8QKW059ILTXl5
        Nn17DTzL9Z0h4PkvBq7On5c=
X-Google-Smtp-Source: ABdhPJzcCx5TjtY9QiP5moYJdajoHlLBG0k7JaeWbjVqS2qr7d7Ja4wpluAoYn2+kxfSgY+hjh3dAQ==
X-Received: by 2002:a63:da4a:: with SMTP id l10mr393986pgj.222.1613582776967;
        Wed, 17 Feb 2021 09:26:16 -0800 (PST)
Received: from google.com ([2620:15c:211:201:cdf7:1c5d:c444:e341])
        by smtp.gmail.com with ESMTPSA id m6sm2797216pjg.39.2021.02.17.09.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:26:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 09:26:14 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC1RtmdhUR40gAzq@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <854d4ec8-1eb9-3595-b867-3e50f5a0e6a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854d4ec8-1eb9-3595-b867-3e50f5a0e6a8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:51:27PM +0100, David Hildenbrand wrote:
> On 17.02.21 17:36, Minchan Kim wrote:
> > alloc_contig_range is usually used on cma area or movable zone.
> > It's critical if the page migration fails on those areas so
> > dump more debugging message like memory_hotplug unless user
> > specifiy __GFP_NOWARN.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >   mm/page_alloc.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0b55c9c95364..67f3ee3a1528 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8486,6 +8486,15 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> >   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> >   	}
> >   	if (ret < 0) {
> > +		if (!(cc->gfp_mask & __GFP_NOWARN)) {
> > +			struct page *page;
> > +
> > +			list_for_each_entry(page, &cc->migratepages, lru) {
> > +				pr_warn("migrating pfn %lx failed ret:%d ",
> > +						page_to_pfn(page), ret);
> > +				dump_page(page, "migration failure");
> > +			}
> 
> This can create *a lot* of noise. For example, until huge pages are actually
> considered, we will choke on each end every huge page - and might do so over
> and over again.

I am not familiar with huge page status at this moment but why couldn't
they use __GFP_NOWARN if they are supposed to fail frequently?

> 
> This might be helpful for debugging, but is unacceptable for production
> systems for now I think. Maybe for now, do it based on CONFIG_DEBUG_VM.

If it's due to huge page you mentioned above and caller passes
__GFP_NOWARN in that case, couldn't we enable always-on?

Actually, I am targeting cma allocation failure, which should
be rather rare compared to other call sites but critical to fail.
If it's concern to emit too many warning message, I will scope
down for site for only cma allocation.

> 
> > +		}
> >   		putback_movable_pages(&cc->migratepages);
> >   		return ret;
> >   	}
> > @@ -8728,6 +8737,8 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
> >   		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> >   		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
> >   			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
> > +				unsigned long gfp_flags;
> > +
> >   				/*
> >   				 * We release the zone lock here because
> >   				 * alloc_contig_range() will also lock the zone
> > @@ -8736,8 +8747,11 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
> >   				 * and cause alloc_contig_range() to fail...
> >   				 */
> >   				spin_unlock_irqrestore(&zone->lock, flags);
> > +
> > +				if (zone_idx(zone) != ZONE_MOVABLE)
> > +					gfp_flags = gfp_mask | __GFP_NOWARN;
> 
> This feels wrong. It might be better to make that decision inside
> __alloc_contig_migrate_range() based on cc->zone.

CMA could be any normal zone and the suggestion will make it slient.
