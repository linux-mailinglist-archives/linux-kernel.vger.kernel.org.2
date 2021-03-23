Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB4346A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCWUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCWUtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:49:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E3EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:49:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f3so20316523lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ovYAdVajAyXtjN+CNCMcxEXjoG9u3DCv652EWDHLb+U=;
        b=dH+1Vra1FvaZnh3o1V2Xcbmb7AAAnhDf2KJGsfCWjWS+AZN1/hZj14WTDG49On1bWs
         ijeyOOSibU7EHfF/a4XSfhQ2Mey64CmyElQZlJ6jrOsa4n9AzENYAIPtQCyu5EJo9cye
         wVI7SKnO2woPUaAQnHtUYIQ4ivgUwOAZesVvi66TvyXvUewU2oFND5o7MEc8vj7m8GWL
         DlFnzRyTQocy5WwKM2byImdIiNG0iwv3W1hU+hEJjxqKV8B0RDzwCMe3vyXHV7yP6nNP
         avS6dCvc/aLhaEHpZZ4JiBoeI8hfy0FSkybt556eHQBewX48INB0sea8uebysicx4oSS
         C+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ovYAdVajAyXtjN+CNCMcxEXjoG9u3DCv652EWDHLb+U=;
        b=IUCGvZeQRPNRN8Hb1hZ8v/kEFAHZYyBqhw9tPiMHce412jBpIutRhC481yGSQ/eVa0
         Y6HcEoi7K2i/yuMPB/V/SuLX3gGOv7A5sTcf+jJmwhE24p3Xo/ltOW0i1t1f1tjxBhob
         pwgXWNMYaHwkNNmwPMIiiwxa5+BMoUiVuMznZMKSsMnVgvT2uomydFRnRNY+IBPCCpqN
         8VqZ7PtFd9c0KWt2GJzsLiBHJgOOXh91XwIrdYe7upvWB1gyuYBCSOVTiOnmeBFnWpjs
         +2wFToLLw3gDS8lEGy5mzNDdFLzabNjFf67nB7ik9wOwQaZE1WTi6Yvz7ZzRfB91SVb3
         o0KA==
X-Gm-Message-State: AOAM532tzq6okMWp6iyQs43hwUxb8E3K0e7fd4Dx6pQXxHl5zTsMtsqf
        ZnhrqSV9bZRBjsbJyIuI3gY=
X-Google-Smtp-Source: ABdhPJzU56a+X3rwCrMwEZT0dt02LSMyA5QJrFOLR2BYBtGE6sn91UufLCUMvTgX/xPRNvMD+Gm4hw==
X-Received: by 2002:a05:6512:991:: with SMTP id w17mr3629952lft.85.1616532582884;
        Tue, 23 Mar 2021 13:49:42 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 196sm18178lfo.29.2021.03.23.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:49:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Mar 2021 21:49:40 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: Use kvmalloc to allocate the table of
 pages
Message-ID: <20210323204940.GB52881@pc638.lan>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
 <20210322230311.GY1719932@casper.infradead.org>
 <20210323120436.GA1949@pc638.lan>
 <20210323123913.GD1719932@casper.infradead.org>
 <20210323133948.GA10046@pc638.lan>
 <20210323140722.GG1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323140722.GG1719932@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:07:22PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 02:39:48PM +0100, Uladzislau Rezki wrote:
> > On Tue, Mar 23, 2021 at 12:39:13PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 23, 2021 at 01:04:36PM +0100, Uladzislau Rezki wrote:
> > > > On Mon, Mar 22, 2021 at 11:03:11PM +0000, Matthew Wilcox wrote:
> > > > > I suspect the vast majority of the time is spent calling alloc_pages_node()
> > > > > 1024 times.  Have you looked at Mel's patch to do ... well, exactly what
> > > > > vmalloc() wants?
> > > > > 
> > > > <snip>
> > > >          - __vmalloc_node_range
> > > >             - 45.25% __alloc_pages_nodemask
> > > >                - 37.59% get_page_from_freelist
> > > [...]
> > > >       - 44.61% 0xffffffffc047348d
> > > >          - __vunmap
> > > >             - 35.56% free_unref_page
> > > 
> > > Hmm!  I hadn't been thinking about the free side of things.
> > > Does this make a difference?
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 4f5f8c907897..61d5b769fea0 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2277,16 +2277,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
> > >  	vm_remove_mappings(area, deallocate_pages);
> > >  
> > >  	if (deallocate_pages) {
> > > -		int i;
> > > -
> > > -		for (i = 0; i < area->nr_pages; i++) {
> > > -			struct page *page = area->pages[i];
> > > -
> > > -			BUG_ON(!page);
> > > -			__free_pages(page, 0);
> > > -		}
> > > +		release_pages(area->pages, area->nr_pages);
> > >  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> > > -
> > >  		kvfree(area->pages);
> > >  	}
> > > 
> > Will check it today!
> > 
> > > release_pages does a bunch of checks that are unnecessary ... we could
> > > probably just do:
> > > 
> > > 		LIST_HEAD(pages_to_free);
> > > 
> > > 		for (i = 0; i < area->nr_pages; i++) {
> > > 			struct page *page = area->pages[i];
> > > 			if (put_page_testzero(page))
> > > 				list_add(&page->lru, &pages_to_free);
> > > 		}
> > > 		free_unref_page_list(&pages_to_free);
> > > 
> > > but let's see if the provided interface gets us the performance we want.
> > >  
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > Thanks!
> > > 
> > > Thank you!
> > You are welcome. A small nit:
> > 
> >   CC      mm/vmalloc.o
> > mm/vmalloc.c: In function ‘__vmalloc_area_node’:
> > mm/vmalloc.c:2492:14: warning: passing argument 4 of ‘kvmalloc_node_caller’ makes integer from pointer without a cast [-Wint-conversion]
> >           area->caller);
> >           ~~~~^~~~~~~~
> > In file included from mm/vmalloc.c:12:
> > ./include/linux/mm.h:782:7: note: expected ‘long unsigned int’ but argument is of type ‘const void *’
> >  void *kvmalloc_node_caller(size_t size, gfp_t flags, int node,
> 
> Oh, thank you!  I confused myself by changing the type halfway through.
> vmalloc() uses void * to match __builtin_return_address while most
> of the rest of the kernel uses unsigned long to match _RET_IP_.
> I'll submit another patch to convert vmalloc to use _RET_IP_.
> 
Thanks!

> > As for the bulk-array interface. I have checked the:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-bulk-rebase-v6r2
> > 
> > applied the patch that is in question + below one:
> > 
> > <snip>
> > @@ -2503,25 +2498,13 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >         area->pages = pages;
> >         area->nr_pages = nr_pages;
> >  
> > -       for (i = 0; i < area->nr_pages; i++) {
> > -               struct page *page;
> > -
> > -               if (node == NUMA_NO_NODE)
> > -                       page = alloc_page(gfp_mask);
> > -               else
> > -                       page = alloc_pages_node(node, gfp_mask, 0);
> > -
> > -               if (unlikely(!page)) {
> > -                       /* Successfully allocated i pages, free them in __vfree() */
> > -                       area->nr_pages = i;
> > -                       atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > -                       goto fail;
> > -               }
> > -               area->pages[i] = page;
> > -               if (gfpflags_allow_blocking(gfp_mask))
> > -                       cond_resched();
> > +       ret = alloc_pages_bulk_array(gfp_mask, area->nr_pages, area->pages);
> > +       if (ret == nr_pages)
> > +               atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > +       else {
> > +               area->nr_pages = ret;
> > +               goto fail;
> >         }
> > -       atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > <snip>
> > 
> > single CPU, 4MB allocation, 1000000 avg: 70639437 usec
> > single CPU, 4MB allocation, 1000000 avg: 89218654 usec
> > 
> > and now we get ~21% delta. That is very good :)
> 
> Amazing!  That's great news for Mel's patch as well as the kvmalloc
> change.
> 
Cool! I am glad if it gives some points to the bulk-array interface :)

--
Vlad Rezki
