Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE731DE92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhBQRqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbhBQRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:46:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:45:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a24so7778718plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Th2rBrQf0xivjZpxGz4MWrvo0rVQSj3VaD7SN2MtDyY=;
        b=lBHLQReA/7O65lJ3ZtEEu7KLtKIx1UBxtaP7rQeRMdHAQg43bRyKwbQNKvWuSncR81
         UCfTsoe8QIq2BWF/qYGoDEj1DhK1bGLM6yXkeX9/Xg6USw83GT9C7KPMIqIZVBmT56dT
         cA7PNtEOwXK+GpoDF+O7esVIGyzr6kCgNPljWpNWcHxYFa79XiGJNeJOTA4IzBlnbxeX
         WflX3qYq7LXGGdAPTAW+/q5L/mB5rpAqeMn9qEVcSaIeZW+rJC4crDKM45YuFOiqZbZ7
         3JWZf/L+XVfI+hWvOGUJALYB8WVqIR+7rLMxmMU4xhCljll0XpIekjGI8fKLVOjlPt/U
         AITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Th2rBrQf0xivjZpxGz4MWrvo0rVQSj3VaD7SN2MtDyY=;
        b=KY7Hya94hq/KZ1vfApdZR49wX50WhNANIjlLyGGhWYTMlDTTmXHI3KbWlzSmIRnfza
         khIB9l0c/jgZCNkEMJ78+8W/pm8RbuwMeVJgOxHxxQ2n8FH99PT6BaXo7PwvDKe2GkDr
         GWeflemcCy/RfwIWGslzMZwL0hlWqpR0rdsWQA91mkxFUYtMceuC08c2N0vwlR7x+MBE
         Zd2OtfRVRW9IG4NiX1RFrwArPJ2mJd5SltTNn74+7/gD9/cYOLL4jTk5SrE/QMVGmKmh
         tVyt7sEUfOpwtmYOzw+nqNT4jJ0DChcEvMKv4DXuOsSI8thhQODbZ6Fd0ALhgaC2ho7a
         gZrg==
X-Gm-Message-State: AOAM530X9WcJ9JiBV3qrMIlGlBwb0XiBSDuZa++HJGdirwCm61G7nEXA
        KkRKR3RIQKWMiuzgDSs79g6EQgCSQng=
X-Google-Smtp-Source: ABdhPJz/p6j4HMadmLD6c+JI0OqrpX+YSC4dsnRiAD2jV7j9ebD3NuDSpQDonFErz5Q9zDqe4VrObg==
X-Received: by 2002:a17:902:ac88:b029:e3:8a26:35bb with SMTP id h8-20020a170902ac88b02900e38a2635bbmr377944plr.45.1613583929836;
        Wed, 17 Feb 2021 09:45:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:cdf7:1c5d:c444:e341])
        by smtp.gmail.com with ESMTPSA id k24sm2992496pfg.40.2021.02.17.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:45:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 09:45:27 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC1WN1rQONAnt5M9@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <854d4ec8-1eb9-3595-b867-3e50f5a0e6a8@redhat.com>
 <YC1RtmdhUR40gAzq@google.com>
 <0f201a5a-caaf-2861-59f2-b66152fe9c53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f201a5a-caaf-2861-59f2-b66152fe9c53@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 06:34:13PM +0100, David Hildenbrand wrote:
> On 17.02.21 18:26, Minchan Kim wrote:
> > On Wed, Feb 17, 2021 at 05:51:27PM +0100, David Hildenbrand wrote:
> > > On 17.02.21 17:36, Minchan Kim wrote:
> > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > It's critical if the page migration fails on those areas so
> > > > dump more debugging message like memory_hotplug unless user
> > > > specifiy __GFP_NOWARN.
> > > > 
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > >    mm/page_alloc.c | 16 +++++++++++++++-
> > > >    1 file changed, 15 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 0b55c9c95364..67f3ee3a1528 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -8486,6 +8486,15 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> > > >    				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> > > >    	}
> > > >    	if (ret < 0) {
> > > > +		if (!(cc->gfp_mask & __GFP_NOWARN)) {
> > > > +			struct page *page;
> > > > +
> > > > +			list_for_each_entry(page, &cc->migratepages, lru) {
> > > > +				pr_warn("migrating pfn %lx failed ret:%d ",
> > > > +						page_to_pfn(page), ret);
> > > > +				dump_page(page, "migration failure");
> > > > +			}
> > > 
> > > This can create *a lot* of noise. For example, until huge pages are actually
> > > considered, we will choke on each end every huge page - and might do so over
> > > and over again.
> > 
> > I am not familiar with huge page status at this moment but why couldn't
> > they use __GFP_NOWARN if they are supposed to fail frequently?
> 
> any alloc_contig_range() user will fail on hugetlbfs pages right now when
> they are placed into CMA/ZONE_MOVABLE. Oscar is working on that upstream.

Until then, how about adding this under !CONFIG_HUGETLBFS?

> 
> > 
> > > 
> > > This might be helpful for debugging, but is unacceptable for production
> > > systems for now I think. Maybe for now, do it based on CONFIG_DEBUG_VM.
> > 
> > If it's due to huge page you mentioned above and caller passes
> > __GFP_NOWARN in that case, couldn't we enable always-on?
> 
> It would make sense to add that for virito-mem when calling
> alloc_contig_range(). For now I didn't do so, because there were not that
> many messages yet - alloc_contig_range() essentially didn't understand
> __GFP_NOWARN.
> 
> We should then also stop printing the "PFNs busy ..." part from
> alloc_contig_range() with __GFP_NOWARN.

Yub.

> 
> > 
> > Actually, I am targeting cma allocation failure, which should
> > be rather rare compared to other call sites but critical to fail.
> > If it's concern to emit too many warning message, I will scope
> > down for site for only cma allocation.
> 
> If you add "__GFP_NOWARN" when !ZONE_MOVABLE, how would you ever print
> something for CMA? What am I missing? CMA is usually not on ZONE_MOVABLE.

If the caller of cma_alloc passed __GFP_NOWARN, I don't care since
caller explictly declare it's not critical. What I'd like to catch up
is cma_alloc with !__GFP_NOWARN sites.
