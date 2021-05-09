Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B1C377865
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhEIUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEIUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4CC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJmXxlTN6rNvfW9sJ9K5q4pJoGjV9mdc8xEmZfcA8PA=; b=Cb6qMNlOzrOrWSTOYEUMxDgDmU
        s18pw/YUGFRKlGnLFOypDuscRPxoiAfTZD/vFgZkmW3tVRC3D1IECAUiFkGg78Bllplqdt8VTOhfj
        YtX5c6zuUSB/tZrGrT/bC37WcK+g5reZdWkxLKqaFJC58w1XjxPdeVrslT4NY/RfF+RLA8J3aR9BW
        5QJFTgCZrkW1sLVf/e9PqhC2JUCstdqzkK/4nMSiRRrN/FIwLwNQ1ukftdko8J8rPmIrfHeUFOxyy
        93V0aULj+wBVRU4aMbr7Tad1EQX0KSy+d9LB6cvmvN0JR9++0CYJ2Us1qnQdPN0uxsnL1n3nKKip2
        w+Qfnv1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfpt0-005OzZ-4l; Sun, 09 May 2021 20:18:48 +0000
Date:   Sun, 9 May 2021 21:18:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <YJhDpkpdUKiNEAnt@casper.infradead.org>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
 <20210509200519.GA3016@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509200519.GA3016@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 10:05:19PM +0200, Uladzislau Rezki wrote:
> On Sun, May 09, 2021 at 08:47:12PM +0100, Matthew Wilcox wrote:
> > > +++ b/mm/vmalloc.c
> > > @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	}
> > >  
> > >  	if (!area->pages) {
> > > -		free_vm_area(area);
> > >  		warn_alloc(gfp_mask, NULL,
> > >  			   "vmalloc size %lu allocation failure: "
> > >  			   "page array size %lu allocation failed",
> > >  			   nr_small_pages * PAGE_SIZE, array_size);
> > > +		free_vm_area(area);
> > >  		return NULL;
> > >  	}
> > 
> > I think this is a bad idea.  We're clearly low on memory (a memory
> > allocation just failed).  We should free the memory we have allocated
> > to improve the chances of the warning message making it out.
> Not sure if i fully follow you here. We do free the memory. The intention
> was to print a warning message first because, if, potentially, the
> free_vm_area(area) also does some prints it would be a bit messy from the
> point what has been broken first.
> 
> So, could you please clarify what was your concern?

We may need to allocate memory in order to emit the error message.
Your commit message didn't mention the potential confusion, and I think
that is worth adding for a v4.
