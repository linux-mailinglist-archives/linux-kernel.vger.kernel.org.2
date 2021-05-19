Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6389E389710
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhESTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhESTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:53:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:52:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so2171035ljd.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACFRqWVclL3GjOA8uYfDIKSmoewur8fyl+9CJwIkoV8=;
        b=Q+8/nv//kl1pdXF2NhiGsxHdk4rC3fFr4ALonC6Rmxa9A8gb7poO0Yc0lWakFVYdbM
         0XNxUpqc9RBK08WDB5gPFqYnBPNGmzskFzZUZTWs/K/+eIPBFMTEm9Z3waJiTPoFnjpj
         3uSPCjQrHOjbVPYdf2vZWZS0R/6g++zsm2gMPT3CnN1M1vOeHL/Ke/96pIOFYiEknddt
         i9jn17hBlHR52/3XVhA/h4ACvkQg5bM9WnSKH4majixMjTxOaXj+z3B3DOa3dEIfv9Ff
         rnrIXG8vrLgm4M2XyLEzrb1fb4stdP0y7Prcw7TMn5Kt9YXYa7hqaA5nQjI2rUkK4cNG
         uprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACFRqWVclL3GjOA8uYfDIKSmoewur8fyl+9CJwIkoV8=;
        b=hcC0hY0wu5UElJyNVKUKIGWMYB7e1pZg9aANjibQuf8Y6uVyfFkQHjRBK17h0Pev8V
         sfa81e0+nufnbqhwqSNnfr07lpy3PcFP9lG3mfNBvA19pLQduUa+QdQqObT8kHH0A10m
         2FJuE5DQCB1dmPihFuc/c3eiG6PwWZp205ZSyMiYfRcI+TZE0WkhV3XoI4Z+muhZ+0NQ
         qIy1pGaxD8AJYuU3yNpKEh+BW4JH6Zf/Q5ZE/TTL7fOiP8pPkGSGYetZHTP2jM9s7/rQ
         JtLAJKNSYQHK02GpjANgYCLAP7PxPoTl6Yyy8jqO8/yL05j+ETVBZ2WepelvO9N93CWq
         KhaA==
X-Gm-Message-State: AOAM533jVwSVxB+2qrmKp+CeJHge2N0+xo9KSl+X5hFxzq6Dtc1ceQwY
        gv01as7jgSYQhhTGY4xbFzc=
X-Google-Smtp-Source: ABdhPJz4FAQ7eD8Hkdy/RsERUEH3+kGYwCs1uFu+jRqFvHHUoxYnpxMPkw3bWJHwDDb1PJB248BHKg==
X-Received: by 2002:a2e:9615:: with SMTP id v21mr604137ljh.184.1621453937422;
        Wed, 19 May 2021 12:52:17 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m4sm23745ljo.127.2021.05.19.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:52:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 19 May 2021 21:52:14 +0200
To:     Mel Gorman <mgorman@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <20210519195214.GA2343@pc638.lan>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
 <YKUWKFyLdqTYliwu@infradead.org>
 <20210519143900.GA2262@pc638.lan>
 <20210519155630.GD3672@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519155630.GD3672@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 19, 2021 at 04:39:00PM +0200, Uladzislau Rezki wrote:
> > > > +	/*
> > > > +	 * If not enough pages were obtained to accomplish an
> > > > +	 * allocation request, free them via __vfree() if any.
> > > > +	 */
> > > > +	if (area->nr_pages != nr_small_pages) {
> > > > +		warn_alloc(gfp_mask, NULL,
> > > > +			"vmalloc size %lu allocation failure: "
> > > > +			"page order %u allocation failed",
> > > > +			area->nr_pages * PAGE_SIZE, page_order);
> > > > +		goto fail;
> > > > +	}
> > > 
> > > From reading __alloc_pages_bulk not allocating all pages is something
> > > that cn happen fairly easily.  Shouldn't we try to allocate the missing
> > > pages manually and/ore retry here?
> > > 
> >
> > It is a good point. The bulk-allocator, as i see, only tries to access
> > to pcp-list and falls-back to a single allocator once it fails, so the
> > array may not be fully populated.
> > 
> 
> Partially correct. It does allocate via the pcp-list but the pcp-list will
> be refilled if it's empty so if the bulk allocator returns fewer pages
> than requested, it may be due to hitting watermarks or the local zone is
> depleted. It does not take any special action to correct the situation
> or stall e.g.  wake kswapd, enter direct reclaim, allocate from a remote
> node etc.
> 
> If no pages were allocated, it'll try allocate at least one page via a
> single allocation request in case the bulk failure would push the zone
> over the watermark but 1 page does not. That path as a side-effect would
> also wake kswapd.
> 
OK. A single page allocator can enter a slow path i mean direct reclaim,
etc to adjust watermarks.

> > In that case probably it makes sense to manually populate it using
> > single page allocator.
> > 
> > Mel, could you please also comment on it?
> > 
> 
> It is by design because it's unknown if callers can recover or if so,
> how they want to recover and the primary intent behind the bulk allocator
> was speed. In the case of network, it only wants some pages quickly so as
> long as it gets 1, it makes progress. For the sunrpc user, it's willing
> to wait and retry. For vmalloc, I'm unsure what a suitable recovery path
> should be as I do not have a good handle on workloads that are sensitive
> to vmalloc performance. The obvious option would be to loop and allocate
> single pages with alloc_pages_node understanding that the additional
> pages may take longer to allocate.
> 
I got it. At least we should fall-back for a single allocator, that is how
we used to allocate before(now it is for high-order pages). If it also fails
to obtain a page we are done.

Basically a single-page allocator is more permissive so it is a higher
chance to success. Therefore a fallback to it makes sense.

Thanks.

--
Vlad Rezki
