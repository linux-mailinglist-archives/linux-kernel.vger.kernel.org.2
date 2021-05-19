Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B638918A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbhESOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354428AbhESOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:41:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74737C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:39:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p20so15918261ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nc6CsOmLYlYhosQDHmPH7JIfTt0CJg9Ts/YiX/jQHwY=;
        b=HgA1pDo4XeJYXNKY/iAMwblUWkBN77xsngRBcrzHq/iE8eRT2HRRgc686wcHtnVpan
         HZ4AKQuxDcR+0mTInQCOuhqbINIHOD9G8LpebL7znluHF9OiwJr/le986aBiNxpxkxE5
         sQVwBPPSFOKgRF1dwWf6jHve9KfSQZYLZiBitx8/LFExcIxFSECkV4R8pmZMK/OKX1vj
         mTqf5DCtP2ivd5R1BYfI95LmItjedS3frHGqMcNtcnFW+Jc8J6sUiH0yEL15LODlfoBw
         f3PD5/5fb5yyqDeVFXGdv91WgajlbJirXxjzXXboi1pGFt9PfuYvJgD5s+FrcvrA94rX
         IpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nc6CsOmLYlYhosQDHmPH7JIfTt0CJg9Ts/YiX/jQHwY=;
        b=MNwFhCEdMWQSHBu8H7nfnifDhpzVEOpNCEMiw3pBKXr9qVVXS9ffRNbuZ/RkJkaV3o
         YW21MHaykTqEVtwusot//6MCf4HIHjNxznGs8X2i+ObMs/Kjpkxo21gokIFZz9D1IWFQ
         qkVvMnOK8gcKvi94Q9q39xsLvaGc4cKctlz5mY54e6trr7/lTe1yX5/8G0lxb2dIhk7Z
         ETENhRh/QT8xlfWEmyWCepI1/fEM6C2EfxNN/7Gb1yMLTPq5FmsxHqNqHxU9DBnuobQD
         IY8nt+bb5dq7U86/gu39C7jL+r3N5lM3LEj1PQH830VD4vkLP0guBH0U4+gh+JS3oVzD
         XBAw==
X-Gm-Message-State: AOAM530Y/ughdZWIAErHq3DEq7dijf8V87FcicBCTAZ4ZnxAKeBW0OlJ
        TFX2zRdoM+tW0R5QixCpQr4=
X-Google-Smtp-Source: ABdhPJwE/Sq+JLDSB8vi2c8j5QBIicU2jCY0aUPL5ychSGfim18/GS5+IjIi9qEou+22wg5pyItXBA==
X-Received: by 2002:a2e:6c1a:: with SMTP id h26mr9434973ljc.478.1621435143358;
        Wed, 19 May 2021 07:39:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m4sm3698096ljc.20.2021.05.19.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:39:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 19 May 2021 16:39:00 +0200
To:     Christoph Hellwig <hch@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <20210519143900.GA2262@pc638.lan>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
 <YKUWKFyLdqTYliwu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKUWKFyLdqTYliwu@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:44:08PM +0100, Christoph Hellwig wrote:
> > +	if (!page_order) {
> > +		area->nr_pages = alloc_pages_bulk_array_node(
> > +			gfp_mask, node, nr_small_pages, area->pages);
> > +	} else {
> > +		/*
> > +		 * Careful, we allocate and map page_order pages, but tracking is done
> > +		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
> 
> Comments over 80 lines are completely unreadable, so please avoid them.
> 
That i can fix by separate patch.

> > +		 * the physical/mapped size.
> > +		 */
> > +		while (area->nr_pages < nr_small_pages) {
> > +			struct page *page;
> > +			int i;
> > +
> > +			/* Compound pages required for remap_vmalloc_page */
> > +			page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
> > +			if (unlikely(!page))
> > +				break;
> >  
> > +			for (i = 0; i < (1U << page_order); i++)
> > +				area->pages[area->nr_pages + i] = page + i;
> >  
> > +			if (gfpflags_allow_blocking(gfp_mask))
> > +				cond_resched();
> > +
> > +			area->nr_pages += 1U << page_order;
> > +		}
> 
> In fact splitting this whole high order allocation logic into a little
> helper would massivel benefit the function by ordering it more logical
> and reducing a level of indentation.
> 
I can put it into separate function. Actually i was thinking about it.

> > +	/*
> > +	 * If not enough pages were obtained to accomplish an
> > +	 * allocation request, free them via __vfree() if any.
> > +	 */
> > +	if (area->nr_pages != nr_small_pages) {
> > +		warn_alloc(gfp_mask, NULL,
> > +			"vmalloc size %lu allocation failure: "
> > +			"page order %u allocation failed",
> > +			area->nr_pages * PAGE_SIZE, page_order);
> > +		goto fail;
> > +	}
> 
> From reading __alloc_pages_bulk not allocating all pages is something
> that cn happen fairly easily.  Shouldn't we try to allocate the missing
> pages manually and/ore retry here?
> 
It is a good point. The bulk-allocator, as i see, only tries to access
to pcp-list and falls-back to a single allocator once it fails, so the
array may not be fully populated.

In that case probably it makes sense to manually populate it using
single page allocator.

Mel, could you please also comment on it?

> > +
> > +	if (vmap_pages_range(addr, addr + size, prot, area->pages, page_shift) < 0) {
> 
> Another pointlessly long line.
Yep. Will fix it by a separate patch. Actually the checkpatch.pl also
complains on splitting the text like below:

    warn_alloc(gfp_mask, NULL,
        "vmalloc size %lu allocation failure: "
        "page order %u allocation failed",
        area->nr_pages * PAGE_SIZE, page_order);


Thanks for the comments!

--
Vlad Rezki
