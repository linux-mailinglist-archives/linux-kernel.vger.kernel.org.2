Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9E42ADD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhJLUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhJLUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:32:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FCCC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:30:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v2so412675qve.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4GGg6YDFTFLvfSMfk2LZM8RdDFIaln1wMqw8oaDtqH0=;
        b=hNZgve4nfR/ktStdvmJ6sLJWUwUq36MrsEVqNlZKX0dwKLeUTDFKu4eRUdwJYcr8Cp
         X6logeGBS268aH1SnFYGh6rVHi1YJLJ46JtrC14GFV6BbSFVPk4PGhsG5+p2wIzgwJYz
         A+WkTqpWVKef8hANRXErpe9o2JSE5/o+aYXIYqtSYoyLIspNFq2+odUg5AFuHkWpZDcv
         mfdPN0tFwmaDXlp2bwWoJa4Zq8DBGQLztqG4mlQODEP+6Giyce04JLUa9WG4xNxydaTC
         PnNmWri8Zl/VFcra7SLHzpexF3Dwi8be0Oxtrf+o0TD1plKuaRfCLrTw0gMfNtDrb1X/
         gW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GGg6YDFTFLvfSMfk2LZM8RdDFIaln1wMqw8oaDtqH0=;
        b=ikcNsu4hl+fLlKU2cItaloRQA/lU98R9RQql8SjyE8fjzHHM1ikLfBd4IpOQgCpjZ/
         cGZXh/zvp9ShG6yzi7AU0BgzPUYTM2i4vgaLqrtAjdMpI6QGASU1B+Es70a2t/PVI900
         wkDVfUNzpf+QqHt8S6jEi2++wq8dhVT+By7TPeK0DVJq8EdaSy+XK7jhH8jqzPj98GA2
         oUlzkEdHsTenE6VxM+cfjU+rzMtrebA+yqcjsE7gGfCY/A+QQSlfSW+lOHq4erQ0Vu08
         6oQon6UMBnvhtfn1VEQ+nIzC6AEIpuAefvRq6Uqj+q9AWlL+zl1fQ9WssD/Lb7q8ytFw
         t94A==
X-Gm-Message-State: AOAM532TeQi4KDESpRxMxkWzICEJJVx9yenkYBrMgmO3px8Em7T1Snbc
        AZvzDVv57NWzbOA0jhwgyvES63PuYDwHag==
X-Google-Smtp-Source: ABdhPJyV2lDPfCvp+7pjPuF37tNMrECpOnmB3AI6jaSTSf2ekiJvsj1OL7GqFeobXSywhFk8k38nuA==
X-Received: by 2002:a0c:aa51:: with SMTP id e17mr32482978qvb.50.1634070621280;
        Tue, 12 Oct 2021 13:30:21 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id p7sm5022319qkg.77.2021.10.12.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:30:21 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:30:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWXwXINogE0Qb0Ip@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWXgrhRDIxcoBhA1@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:23:26PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 12, 2021 at 02:01:37PM -0400, Johannes Weiner wrote:
> > PageSlab() currently imposes a compound_head() call on all callsites
> > even though only very few situations encounter tailpages. This short
> > series bubbles tailpage resolution up to the few sites that need it,
> > and eliminates it everywhere else.
> > 
> > This is a stand-alone improvement. However, it's inspired by Willy's
> > patches to split struct slab from struct page. Those patches currently
> > resolve a slab object pointer to its struct slab as follows:
> > 
> > 	slab = virt_to_slab(p);		/* tailpage resolution */
> > 	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
> > 		do_slab_stuff(slab);
> > 	} else {
> > 		page = (struct page *)slab;
> > 		do_page_stuff(page);
> > 	}
> > 
> > which makes struct slab an ambiguous type that needs to self-identify
> > with the slab_test_cache() test (which in turn relies on PG_slab in
> > the flags field shared between page and slab).
> > 
> > It would be preferable to do:
> > 
> > 	page = virt_to_head_page(p);	/* tailpage resolution */
> > 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> > 		slab = page_slab(page);
> > 		do_slab_stuff(slab);
> > 	} else {
> > 		do_page_stuff(page);
> > 	}
> > 
> > and leave the ambiguity and the need to self-identify with struct
> > page, so that struct slab is a strong and unambiguous type, and a
> > non-NULL struct slab encountered in the wild is always a valid object
> > without the need to check another dedicated flag for validity first.
> > 
> > However, because PageSlab() currently implies tailpage resolution,
> > writing the virt->slab lookup in the preferred way would add yet more
> > unnecessary compound_head() call to the hottest MM paths.
> > 
> > The page flag helpers should eventually all be weaned off of those
> > compound_head() calls for their unnecessary overhead alone. But this
> > one in particular is now getting in the way of writing code in the
> > preferred manner, and bleeding page ambiguity into the new types that
> > are supposed to eliminate specifically that. It's ripe for a cleanup.
> 
> So what I had in mind was more the patch at the end (which I now realise
> is missing the corresponding changes to __ClearPageSlab()).  There is,
> however, some weirdness with kfence, which appears to be abusing PageSlab
> by setting it on pages which are not slab pages???
> 
> 	page = virt_to_page(p);
> 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> 		slab = page_slab(page);	/* tail page resolution */
> 		do_slab_stuff(slab);
> 	} else {
> 		do_page_stuff(page); /* or possibly compound_head(page) */
> 	}

Can you elaborate why you think this would be better?

If the object is sitting in a tailpage, the flag test itself could
avoid the compound_head(), but at the end of the day it's the slab or
the headpage that needs to be operated on in the fastpaths, and we
need to do the compound_head() whether the flag is set or not.

I suppose it could make some debugging checks marginally cheaper?

But OTOH it comes at the cost of the flag setting and clearing loops
in the slab allocation path, even when debugging checks are disabled.

And it would further complicate the compound page model by introducing
another distinct flag handling scheme (would there be other users for
it?). The open-coded loops as a means to ensure flag integrity seem
error prone; but creating Set and Clear variants that encapsulate the
loops sounds like a move in the wrong direction, given the pain the
compound_head() alone in them has already created.

> There could also be a PageTail check in there for some of the cases --
> catch people doing something like:
> 	kfree(kmalloc(65536, GFP_KERNEL) + 16384);
> which happens to work today, but should probably not.

I actually wondered about that when looking at the slob code. Its
kfree does this:

	sp = virt_to_page(block);
	if (PageSlab(compound_head(sp))) {
		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
		unsigned int *m = (unsigned int *)(block - align);
		slob_free(m, *m + align);
	} else {
		unsigned int order = compound_order(sp);
		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
				    -(PAGE_SIZE << order));
		__free_pages(sp, order);

	}

Note the virt_to_page(), instead of virt_to_head_page(). It does test
PG_slab correctly, but if this is a bypass page, it operates on
whatever tail page the kfree() argument points into. If you did what
you write above, it would leak the pages before the object.
