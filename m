Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC89345D99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCWMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCWMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:04:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E89C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:04:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a198so26224850lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0McvLaVTxZVttSdMtN3Jb8U0mekVzeUmfLS+AJkPhZI=;
        b=mfWR31dRkYqEv2jBXG+WNyZ/5Tx5jelLKPefoCAK5a1C7c+X4xbRBh421d742vIudS
         MeGXwwRciwNMxeOzp3+MG/fhRxixjQW9zbYv+1zU9x2jY7sF7Pk0532kIRJQ+A98DVlu
         oNxlC5+txocjihmM/atLN1iap9Dc+qGj/1pxzY6vjsetGS9kkji4ZDEizX8dHOfLmmKb
         Vx49o3DedaTcQ4PHwkuXBFO4/QAPM68A3jFu8FhtpCV5gUJuosIY9ShhR8QuYoQehAZV
         wpkMKgHoIzZTl/gSJsPpWpxG77GKtVcbC2BvviBCEAz/aUDM69s/a1AgO6sY0HIs5g59
         oWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0McvLaVTxZVttSdMtN3Jb8U0mekVzeUmfLS+AJkPhZI=;
        b=E7fC5rXdVbYYzhihq3/VE7Ti2eOKgGeafXthGCesZezIPE0ZjIPYMwd9q66+oHJ2M0
         Rn8n+5+cKh93z8iUW5+HmxG6rybL7Zkf+R1bQxx4kpIiJhzvhUiDzpBi+ffgrCRU2odg
         QQvP6vwDOs0OsyEvAdRsDb9wm2tsefikXOxoqyF6A2beP4vnqwx+h4ua3yGdqHvqOFO/
         s9hBoqyLra1PsWqfMk5nu2zsG9QssuzqP2wPyayhOvRSP35+qneeBtjVAQocTJkC60lV
         RMcpOyU7J8eYFbdUlzPb3KiipMOxIqsTyublwMFFWMYQFubFR/dOlKwQ/DLCkFhF4vUp
         i3Lg==
X-Gm-Message-State: AOAM531MDs1HV9pQLjWMM9fzzKqkPn7X+aGf0qkE67iZLJRRRyD719J4
        vjIKS9JqquK8l5MYxMZ2sKU=
X-Google-Smtp-Source: ABdhPJyyNz813XP/Hxih7grc7Qtii5H8oyCE0SpLIS8ryfx+j4F9j2Yi4y98n2af6gHVFfweE1MoTQ==
X-Received: by 2002:a05:6512:3283:: with SMTP id p3mr2354797lfe.570.1616501079576;
        Tue, 23 Mar 2021 05:04:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z81sm1829363lfc.149.2021.03.23.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:04:39 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Mar 2021 13:04:36 +0100
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
Message-ID: <20210323120436.GA1949@pc638.lan>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
 <20210322230311.GY1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322230311.GY1719932@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:03:11PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 11:36:19PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 22, 2021 at 07:38:20PM +0000, Matthew Wilcox (Oracle) wrote:
> > > If we're trying to allocate 4MB of memory, the table will be 8KiB in size
> > > (1024 pointers * 8 bytes per pointer), which can usually be satisfied
> > > by a kmalloc (which is significantly faster).  Instead of changing this
> > > open-coded implementation, just use kvmalloc().
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  mm/vmalloc.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 96444d64129a..32b640a84250 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2802,13 +2802,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  		gfp_mask |= __GFP_HIGHMEM;
> > >  
> > >  	/* Please note that the recursion is strictly bounded. */
> > > -	if (array_size > PAGE_SIZE) {
> > > -		pages = __vmalloc_node(array_size, 1, nested_gfp, node,
> > > +	pages = kvmalloc_node_caller(array_size, nested_gfp, node,
> > >  					area->caller);
> > > -	} else {
> > > -		pages = kmalloc_node(array_size, nested_gfp, node);
> > > -	}
> > > -
> > >  	if (!pages) {
> > >  		free_vm_area(area);
> > >  		return NULL;
> > > -- 
> > > 2.30.2
> > Makes sense to me. Though i expected a bigger difference:
> > 
> > # patch
> > single CPU, 4MB allocation, loops: 1000000 avg: 85293854 usec
> > 
> > # default
> > single CPU, 4MB allocation, loops: 1000000 avg: 89275857 usec
> 
> Well, 4.5% isn't something to leave on the table ... but yeah, I was
> expecting more in the 10-20% range.  It may be more significant if
> there's contention on the spinlocks (like if this crazy ksmbd is calling
> vmalloc(4MB) on multiple nodes simultaneously).
> 
Yep, it can be that simultaneous allocations will show even bigger
improvements because of lock contention. Anyway there is an advantage
in switching to SLAB - 5% is also a win :) 

>
> I suspect the vast majority of the time is spent calling alloc_pages_node()
> 1024 times.  Have you looked at Mel's patch to do ... well, exactly what
> vmalloc() wants?
> 
<snip>
-   97.37%     0.00%  vmalloc_test/0   [kernel.vmlinux]  [k] ret_from_fork                                                                                                              ◆
     ret_from_fork                                                                                                                                                                      ▒
     kthread                                                                                                                                                                            ▒
   - 0xffffffffc047373b                                                                                                                                                                 ▒
      - 52.67% 0xffffffffc047349f                                                                                                                                                       ▒
           __vmalloc_node                                                                                                                                                               ▒
         - __vmalloc_node_range                                                                                                                                                         ▒
            - 45.25% __alloc_pages_nodemask                                                                                                                                             ▒
               - 37.59% get_page_from_freelist                                                                                                                                          ▒
                    4.34% __list_del_entry_valid                                                                                                                                        ▒
                    3.67% __list_add_valid                                                                                                                                              ▒
                    1.52% prep_new_page                                                                                                                                                 ▒
                    1.20% check_preemption_disabled                                                                                                                                     ▒
              3.75% map_kernel_range_noflush                                                                                                                                            ▒
            - 0.64% kvmalloc_node_caller                                                                                                                                                ▒
                 __kmalloc_track_caller                                                                                                                                                 ▒
                 memset_orig                                                                                                                                                            ▒
      - 44.61% 0xffffffffc047348d                                                                                                                                                       ▒
         - __vunmap                                                                                                                                                                     ▒
            - 35.56% free_unref_page                                                                                                                                                    ▒
               - 22.48% free_pcppages_bulk                                                                                                                                              ▒
                  - 4.21% __mod_zone_page_state                                                                                                                                         ▒
                       2.78% check_preemption_disabled                                                                                                                                  ▒
                       0.80% __this_cpu_preempt_check                                                                                                                                   ▒
                    2.24% __list_del_entry_valid                                                                                                                                        ▒
                    1.84% __list_add_valid                                                                                                                                              ▒
               - 6.55% free_unref_page_commit                                                                                                                                           ▒
                    2.47% check_preemption_disabled                                                                                                                                     ▒
                    1.36% __list_add_valid                                                                                                                                              ▒
                 3.10% free_unref_page_prepare.part.88                                                                                                                                  ▒
                 0.72% free_pcp_prepare                                                                                                                                                 ▒
            - 6.26% remove_vm_area                                                                                                                                                      ▒
                 6.18% unmap_kernel_range_noflush                                                                                                                                       ▒
              2.31% __free_pages   
<snip>

__alloc_pages_nodemask() consumes lot of cycles because it is called
one time per a page and like you mentioned, for 4MB request it is invoked
1024 times!

>
> https://lore.kernel.org/linux-mm/20210322091845.16437-1-mgorman@techsingularity.net/
>
I saw it. It would be good to switch to the bulk interface for vmalloc
once it is settled and mainlined. Apart of that, i find it also useful
for the kvfree_rcu() code in a context of page-cache refilling :)

> 
> > One question. Should we care much about fragmentation? I mean
> > with the patch, allocations > 2MB will do request to SLAB bigger
> > then PAGE_SIZE.
> 
> We're pretty good about allocating memory in larger chunks these days.
> Looking at my laptop's slabinfo,
> kmalloc-8k           219    232   8192    4    8 : tunables    0    0    0 : sla
> bdata     58     58      0
> 
> That's using 8 pages per slab, so that's order-3 allocations.  There's a
> few more of those:
> 
> $ sudo grep '8 :' /proc/slabinfo |wc
>      42     672    4508
> 
> so I have confidence that kvmalloc() will manage to use kmalloc up to 16MB
> vmalloc allocations, and after that it'll tend to fall back to vmalloc.
>

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Vlad Rezki
