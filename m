Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A223842CA21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhJMTfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhJMTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:35:05 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:33:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y10so3309960qkp.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wCRjJ1PPa7v42X/iGBbgqz1JFtaAMtKf+gspWWexJBs=;
        b=ZrcBvhj5jVLF2XeVrTE0jWjbxYKwZ4hThHUdNINSy4FY70gDhf2sA3WHehI+RexRls
         JSPu1gAe0sJtY8D9MjrtdzFZgIqvBpDzN31PQce2i/SceCb+Ey5j2ndv114H6ySL3fqI
         jX8ZOT5u1d4cgKS6kUFou0Y3z40uCUWfEQJQSmDjkF5v11WHCuL8eoU8KVLg1NaiX6jh
         KR6iLlUIlsXsOae+UYD7gNkzGuilpAMoovz9PMREXWQU3csutfSq6Sk6eleDDYEtYuIh
         o3f+OAG6rNvuAnY+qDjKQCMAzwAvKnFCwkN4TkVBvKMuLszSO1HQWlc5lC2/PQL/QsL/
         exTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wCRjJ1PPa7v42X/iGBbgqz1JFtaAMtKf+gspWWexJBs=;
        b=tlFNkyuR+daEmCCmzgpohV+s+3j+4NsKlKugfiyoLma7ncvE1wPAs0RptvuioRLoUJ
         dhqiispsRNLPWDir1FIHIY/C8ydRQUAOIUUO8IkwyIpM/5pau8hELChQAZJ6cE9/LETL
         sQNqpwaa++/fo45Ej3B4GrMRBEskSNPi2MnxY8LhK4q9ojXDOJYTpuDkHEW8V0ZBf1Gc
         RVM1S6NlvGs3HsMjiUJmz3ThdRjglFVf4BOPFvV6KaMSCyERAMuD0sjIKXHx8a3wRXC6
         DPc2jjoqWjO2w+I25uvy+Ns5cUezLbMrTL1Ezv6TqZS+7WCKFZif0xFysPqoqah4hkYp
         49Wg==
X-Gm-Message-State: AOAM530HFAW0k5WqPH7hR6ruIZXAkZErHnakGsSjDwka0i4w9KSOoAMb
        6/jIZ8mtQgINlO9waNlXOW051w==
X-Google-Smtp-Source: ABdhPJynIqPB/USmQeMrvjS1kK2O8gDO0OkFlWcNGiFpu1UzNqJnaiSq4qpAim7/hAYAegqaPhZ0mQ==
X-Received: by 2002:a05:620a:1a89:: with SMTP id bl9mr1097648qkb.108.1634153580511;
        Wed, 13 Oct 2021 12:33:00 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id g11sm306652qko.31.2021.10.13.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:33:00 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:32:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWc0a7zlWAdUSCdT@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
 <YWXwXINogE0Qb0Ip@cmpxchg.org>
 <YWZQNj+axlIQrD5C@casper.infradead.org>
 <YWbj6+myCposUKk1@cmpxchg.org>
 <YWcdoktn30ofnsPO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWcdoktn30ofnsPO@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:55:46PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 13, 2021 at 09:49:31AM -0400, Johannes Weiner wrote:
> > On Wed, Oct 13, 2021 at 04:19:18AM +0100, Matthew Wilcox wrote:
> > > For today, testing PageSlab on the tail page helps the test proceed
> > > in parallel with the action.  Looking at slub's kfree() for an example:
> > > 
> > >         page = virt_to_head_page(x);
> > >         if (unlikely(!PageSlab(page))) {
> > >                 free_nonslab_page(page, object);
> > >                 return;
> > >         }
> > >         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> > > 
> > > Your proposal is certainly an improvement (since gcc doesn't know
> > > that compound_head(compound_head(x)) == compound_head(x)), but I
> > > think checking on the tail page is even better:
> > > 
> > > 	page = virt_to_page(x);
> > > 	if (unlikely(!PageSlab(page))) {
> > > 		free_nonslab_page(compound_head(page), object);
> > > 		return;
> > > 	}
> > > 	slab = page_slab(page);
> > > 	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> > > 
> > > The compound_head() parts can proceed in parallel with the check of
> > > PageSlab().
> > >
> > > As far as the cost of setting PageSlab, those cachelines are already
> > > dirty because we set compound_head on each of those pages already
> > > (or in the case of freeing, we're about to clear compound_head on
> > > each of those pages).
> > 
> > ... but this is not. I think the performance gains from this would
> > have to be significant to justify complicating page flags further.
> 
> My argument isn't really "this is more efficient", because I think
> the performance gains are pretty minimal.  More that I would like to
> be able to write code in the style which we'll want to use when we're
> using dynamically allocated memory descriptors.  It's all just code,
> and we can change it at any time, but better to change it to something
> that continues to work well in the future.
> 
> I don't think we end up with "virt_to_head_page()" in a dynamically
> allocated memory descriptor world.  The head page contains no different
> information from the tail pages, and indeed the tail pages don't know
> that they're tail pages, or where the head page is.  Or maybe they're
> all tail pages.

I agree with that, but future-provisioning is a tradeoff.

It'll be trivial to replace virt_to_head_page() with virt_to_page()
and remove compound_head() calls when whatever is left of struct page
will unconditionally point to a memory descriptor. And that can be
part of the changes that make it so.

But in today's codebase, maintaining type flags in the tail pages
while having to go through the headpage to find the type descriptor
makes things unnecessarily complicated in an area that already has
accrued too much tech debt.

I don't think that's a sensible thing to do as of today.

> I could see a world where we had a virt_to_memdesc() which returned
> a generic memory descriptor that could be cast to a struct slab if
> the flags within that memdesc said it was a slab.  But I think it works
> out better to tag the memory descriptor pointer with a discriminator
> that defines what the pointer is.  Plus it saves a page flag.
> 
> Maybe that's the best way to approach it -- how would you want to write
> this part of kfree() when memory descriptors are dynamically allocated?

There are still many question marks on how the split out memory
descriptors actually will look like, and which state is tracked
where. 'struct slab' is an excellent trial balloon.

It's good to have common north stars to set the direction of where to
place efforts ("small struct page, dynamically allocated descriptors
etc.") but I don't think it makes sense to take on yet more tech debt
in this area for a future that may not pan out the way we think now.
