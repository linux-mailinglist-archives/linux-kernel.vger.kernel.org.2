Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B53784DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhEJKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhEJKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF11BC061342
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:33:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o16so20199163ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6q3FouuvAK/dFHwqvkwMOvxpXrjcuEE0+n+l7JtwzA=;
        b=F/UCZb3JYWgQnakd5gk2goJqoPmHVglv1/XY+YBl+tG3yrsDL0ypUYqp43ssEeAghj
         8vB+59rOCgv25+YLwQgL0oNIv243jLEVzioAax1K2wyDHY7zy+y6HTLHlV/D7efo1ahg
         tV8QvwDqiYW3FJC9/lg5vyZzz/VmT7LFAWU45NcV2fsgPa8QDmTyrzEToSdlLjM35tvB
         UMM4lAfYLkIWnEXivfxcAaogqH87VnWld5cVuYRAs5Feuh1qnlvyum2BMcAJznTBgRw4
         J0XCfnCaSOiq3jsbUhQZwLS9zkKrwAApGQ1+UYEH/RLgDyNMHAVf/dyjtMTiNq4IjS6S
         vvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6q3FouuvAK/dFHwqvkwMOvxpXrjcuEE0+n+l7JtwzA=;
        b=cUBc22laM1tnvVf87E4SUgBTx1lBsCqC2FpPhXlnnp1ov33oEVzTez+NmDY7TLu0rH
         eiImyUK40gxbKHn1fCGrvZWwYFaU3S/8Rq9MzcABFe0prxa438enFAit/fu2QGpzXsg/
         bvLgOa6Tby5Y61M9NKZY2mHpqoUJ5oCqeUe+PI96Fm6XHjz9hNXBMP/GZIoDZ2JnIs0z
         nGJHQuAbJ7UZY0IURzxk7Sc+BEJfYF0/zjCqYI6mMINdeVnImsR47SAQIxhSzSNbNV7n
         tJMlI0mAUntRZ31xGnozMR4J+WDFxuCLYtGKbmAJu4faAr0fsBwfMWXzLM3n0fY8yCdZ
         1gyg==
X-Gm-Message-State: AOAM531+8ZQ5l8kWJA/uOA5sIlTXWGQIclZcdXlr6CQuiJ6ewfySZPEy
        TRlrenhJrR2avnRDrMevl8Y=
X-Google-Smtp-Source: ABdhPJySY1nrJBc3C+FYQPeHcMMrZKNHaQ9ZECqFCNJ06J05nLJMHN/66jDqwoS9jyC99Xr9WUn0wQ==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr19992756ljm.66.1620642824224;
        Mon, 10 May 2021 03:33:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 26sm3066077ljv.140.2021.05.10.03.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:33:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 10 May 2021 12:33:42 +0200
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <20210510103342.GA2169@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
 <20210509200519.GA3016@pc638.lan>
 <YJhDpkpdUKiNEAnt@casper.infradead.org>
 <20210509212641.GA3220@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509212641.GA3220@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 11:26:41PM +0200, Uladzislau Rezki wrote:
> On Sun, May 09, 2021 at 09:18:46PM +0100, Matthew Wilcox wrote:
> > On Sun, May 09, 2021 at 10:05:19PM +0200, Uladzislau Rezki wrote:
> > > On Sun, May 09, 2021 at 08:47:12PM +0100, Matthew Wilcox wrote:
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > > >  	}
> > > > >  
> > > > >  	if (!area->pages) {
> > > > > -		free_vm_area(area);
> > > > >  		warn_alloc(gfp_mask, NULL,
> > > > >  			   "vmalloc size %lu allocation failure: "
> > > > >  			   "page array size %lu allocation failed",
> > > > >  			   nr_small_pages * PAGE_SIZE, array_size);
> > > > > +		free_vm_area(area);
> > > > >  		return NULL;
> > > > >  	}
> > > > 
> > > > I think this is a bad idea.  We're clearly low on memory (a memory
> > > > allocation just failed).  We should free the memory we have allocated
> > > > to improve the chances of the warning message making it out.
> > > Not sure if i fully follow you here. We do free the memory. The intention
> > > was to print a warning message first because, if, potentially, the
> > > free_vm_area(area) also does some prints it would be a bit messy from the
> > > point what has been broken first.
> > > 
> > > So, could you please clarify what was your concern?
> > 
> > We may need to allocate memory in order to emit the error message.
> >
> > Your commit message didn't mention the potential confusion, and I think
> > that is worth adding for a v4.
> I agree that the commit message should be updated in regard of potential
> confusion, because it was the main intention of this patch.
> 
> I will upload a v4 tomorrow.
> 
Please find the v4 version of the patch that is in question:

From 7e27e4ac8f299ae244e9e0e90e0292ae2c08d37d Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Sat, 8 May 2021 23:41:21 +0200
Subject: [PATCH v4 1/1] mm/vmalloc: Print a warning message first on failure

When a memory allocation for array of pages are not succeed
emit a warning message as a first step and then perform the
further cleanup.

The reason it should be done in a right order is the clean
up function which is free_vm_area() can potentially also
follow its error paths what can lead to confusion what was
broken first.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dbc6744400d5..1f664a17d9ea 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		free_vm_area(area);
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "page array size %lu allocation failed",
 			   nr_small_pages * PAGE_SIZE, array_size);
+		free_vm_area(area);
 		return NULL;
 	}
 
-- 
2.20.1

--
Vlad Rezki
