Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1572F42C1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhJMNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhJMNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:51:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E1BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:49:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w2so2609464qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJQpzp92jlpsIHuhT3uoPe846KsfiTHQYVgPjp2++jk=;
        b=M8yDJRapXgBYF3DBi2MpZ0dnTyIJ6gw97UqQmZCsTxI3IaWAVdJY8yHwglkTf4sSsl
         DnUGX3jP1oCvbxllE6+huFzqabBL/+KaKMVdnl0zgz/4DFGn28GJTpDHQ6yuzx7B5hrS
         dGhLCG11nZG+aYoLukipBgo6hiLKvoCc+0E59sqvuvGXMmagUyf/zv+2wSCvRszkHu/B
         8KVPiFGk6se2nER5XTSMDMxpu0Bxm4MiI9pgh4rff3jlEik5bAb3tSLCfYddXOeHQHa6
         tsHBa0YmzhOyfovTPCMwsJfSat6yoLiRanrAO0SLYDW/OJ62J3I6O0a9+kNEic26KgdG
         zw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJQpzp92jlpsIHuhT3uoPe846KsfiTHQYVgPjp2++jk=;
        b=XtHqaA1ti7MPWVESpsRGo1xSo9h8PDxz6z0g3qHvyzP9Nh0Afl2JgDtAiXP5DfJJW9
         pKkp6tG1hjUb0sg5oHirEp4Ei/8h3G9TXW024iSVY9KUoB1PSdG1kqW7C70Jenmf/HGy
         p+GA0lhv4LN71okyQrP4Ps3FtLgcamYB2U+dUZPEYT8BLclzPIH/NRDF3SiFbXqDIwib
         8lFtX5uiySLCnTzGJe9C0ieW7RF1IF8GqolTXJkFyEu20Q3PdzUJV7Z3c/VhrQxPr48i
         UrX9k0u0vToA+uiRPtdz4xqHURnMFYMj8Muwdo82tu5JutYGfwUfq9MJvow38nXR8rEA
         mn+w==
X-Gm-Message-State: AOAM530D8FC+5gb55w6vcnVcFdX4Q+iLCLhUIP1lfTQBjsgi6qRZ6XFo
        AL9vZ8swbmisZyZUzfrMFmiF9g==
X-Google-Smtp-Source: ABdhPJzaOMXZ2gi+hT32IJISLOUb8weVRxrenYBFo18Xt6RSEWlNzYw5Q1T7cuzV4I7pD/n2Pu+odg==
X-Received: by 2002:a05:622a:4cc:: with SMTP id q12mr22516735qtx.308.1634132972887;
        Wed, 13 Oct 2021 06:49:32 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id v8sm8613680qta.21.2021.10.13.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:49:32 -0700 (PDT)
Date:   Wed, 13 Oct 2021 09:49:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWbj6+myCposUKk1@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
 <YWXwXINogE0Qb0Ip@cmpxchg.org>
 <YWZQNj+axlIQrD5C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWZQNj+axlIQrD5C@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:19:18AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 12, 2021 at 04:30:20PM -0400, Johannes Weiner wrote:
> > On Tue, Oct 12, 2021 at 08:23:26PM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 12, 2021 at 02:01:37PM -0400, Johannes Weiner wrote:
> > > > PageSlab() currently imposes a compound_head() call on all callsites
> > > > even though only very few situations encounter tailpages. This short
> > > > series bubbles tailpage resolution up to the few sites that need it,
> > > > and eliminates it everywhere else.
> > > > 
> > > > This is a stand-alone improvement. However, it's inspired by Willy's
> > > > patches to split struct slab from struct page. Those patches currently
> > > > resolve a slab object pointer to its struct slab as follows:
> > > > 
> > > > 	slab = virt_to_slab(p);		/* tailpage resolution */
> > > > 	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
> > > > 		do_slab_stuff(slab);
> > > > 	} else {
> > > > 		page = (struct page *)slab;
> > > > 		do_page_stuff(page);
> > > > 	}
> > > > 
> > > > which makes struct slab an ambiguous type that needs to self-identify
> > > > with the slab_test_cache() test (which in turn relies on PG_slab in
> > > > the flags field shared between page and slab).
> > > > 
> > > > It would be preferable to do:
> > > > 
> > > > 	page = virt_to_head_page(p);	/* tailpage resolution */
> > > > 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> > > > 		slab = page_slab(page);
> > > > 		do_slab_stuff(slab);
> > > > 	} else {
> > > > 		do_page_stuff(page);
> > > > 	}
> > > > 
> > > > and leave the ambiguity and the need to self-identify with struct
> > > > page, so that struct slab is a strong and unambiguous type, and a
> > > > non-NULL struct slab encountered in the wild is always a valid object
> > > > without the need to check another dedicated flag for validity first.
> > > > 
> > > > However, because PageSlab() currently implies tailpage resolution,
> > > > writing the virt->slab lookup in the preferred way would add yet more
> > > > unnecessary compound_head() call to the hottest MM paths.
> > > > 
> > > > The page flag helpers should eventually all be weaned off of those
> > > > compound_head() calls for their unnecessary overhead alone. But this
> > > > one in particular is now getting in the way of writing code in the
> > > > preferred manner, and bleeding page ambiguity into the new types that
> > > > are supposed to eliminate specifically that. It's ripe for a cleanup.
> > > 
> > > So what I had in mind was more the patch at the end (which I now realise
> > > is missing the corresponding changes to __ClearPageSlab()).  There is,
> > > however, some weirdness with kfence, which appears to be abusing PageSlab
> > > by setting it on pages which are not slab pages???
> > > 
> > > 	page = virt_to_page(p);
> > > 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> > > 		slab = page_slab(page);	/* tail page resolution */
> > > 		do_slab_stuff(slab);
> > > 	} else {
> > > 		do_page_stuff(page); /* or possibly compound_head(page) */
> > > 	}
> > 
> > Can you elaborate why you think this would be better?
> > 
> > If the object is sitting in a tailpage, the flag test itself could
> > avoid the compound_head(), but at the end of the day it's the slab or
> > the headpage that needs to be operated on in the fastpaths, and we
> > need to do the compound_head() whether the flag is set or not.
> > 
> > I suppose it could make some debugging checks marginally cheaper?
> > 
> > But OTOH it comes at the cost of the flag setting and clearing loops
> > in the slab allocation path, even when debugging checks are disabled.
> > 
> > And it would further complicate the compound page model by introducing
> > another distinct flag handling scheme (would there be other users for
> > it?). The open-coded loops as a means to ensure flag integrity seem
> > error prone; but creating Set and Clear variants that encapsulate the
> > loops sounds like a move in the wrong direction, given the pain the
> > compound_head() alone in them has already created.
> 
> I see this as a move towards the dynamically allocated future.
> In that future, I think we'll do something like:
> 
> static inline struct slab *alloc_slab_pages(...)
> {
> 	struct page *page;
> 	struct slab *slab = kmalloc(sizeof(struct slab), gfp);
> 	if (!slab)
> 		return -ENOMEM;
> 	... init slab ...
> 	page = palloc(slab, MEM_TYPE_SLAB, node, gfp, order);
> 	if (!page) {
> 		kfree(slab);
> 		return -ENOMEM;
> 	}
> 	slab->virt = page_address(page);
> 
> 	return slab;
> }
> 
> where palloc() does something like:
> 
> 	unsigned long page_desc = mem_type | (unsigned long)mem_desc;
> 
> 	... allocates the struct pages ...
> 
> 	for (i = 0; i < (1 << order); i++)
> 		page[i] = page_desc;
> 	
> 	return page;
> }

Yeah having the page point to the full descriptor makes sense. That's
efficient. And it's very simple, conceptually...

> For today, testing PageSlab on the tail page helps the test proceed
> in parallel with the action.  Looking at slub's kfree() for an example:
> 
>         page = virt_to_head_page(x);
>         if (unlikely(!PageSlab(page))) {
>                 free_nonslab_page(page, object);
>                 return;
>         }
>         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> 
> Your proposal is certainly an improvement (since gcc doesn't know
> that compound_head(compound_head(x)) == compound_head(x)), but I
> think checking on the tail page is even better:
> 
> 	page = virt_to_page(x);
> 	if (unlikely(!PageSlab(page))) {
> 		free_nonslab_page(compound_head(page), object);
> 		return;
> 	}
> 	slab = page_slab(page);
> 	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> 
> The compound_head() parts can proceed in parallel with the check of
> PageSlab().
>
> As far as the cost of setting PageSlab, those cachelines are already
> dirty because we set compound_head on each of those pages already
> (or in the case of freeing, we're about to clear compound_head on
> each of those pages).

... but this is not. I think the performance gains from this would
have to be significant to justify complicating page flags further.
