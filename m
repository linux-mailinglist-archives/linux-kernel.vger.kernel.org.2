Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6533480D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhCXSlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhCXSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:41:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18064C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:41:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 184so31507548ljf.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Lmgab50l2WbnE1Y1ChETHsaXAH3JIp5+u9sDf2Xz+2k=;
        b=K6n0Khh72xDM7iiKzQUHkPfe2SthSYZUSmx30mcQXYAGnlu+SnV1IzETMD4EF32r+W
         GwCjzIgG5PsbyQIwI1as+Ds+NcqRw3gsCQkQf1eb/RExDivWq3EbQk8yAGPNqqvK2f93
         2j0jq3v0xNskXTc8JRMFsnId3Cxaqapwny/SSAREuDN0qniuRTbYFRkn3n6DwMTTpt9+
         SCwu+ACFQz9Qjod9AwsN2HPDdQYmWw3hazUPYhPvE/Vtfw0X78Ctlh0UXlsXFqYUUOj2
         Cfjd/+4eNB1YlQS/duiAzfXVlLYJyMwghCKhqk8FaKi/TlBhlJjFh1HIiLSCSYY61yBX
         Lgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Lmgab50l2WbnE1Y1ChETHsaXAH3JIp5+u9sDf2Xz+2k=;
        b=A25OteSf9hhgoo3YBZpxA3cWU5Tn37w+YCrSX0mUzIfX5FgKdjH/oyVmWv8U3EaDBm
         hxlMNVICZ4nt0NGUlN10nctOqUAne4J5YSLy2FTw6r6njv6abo9z0y+0gjGG+9MY1mxC
         Ud/qE2/aorf5f9+S0WaVrG3zOQk97bMBIJSQjiRouIfWuNkcxNMDMVIruOHvH4xVkm8r
         8Xr/drrCzZtiGdsQEEv5eHqc4r0nABv2d2VzeBPx3Nuw64IKISld0rAUrgZa3eD6N0Hf
         jwpf3dZYJSUFZaVUe6O09/7wA4mBACNMClTKj+Im7ReyJsd+BuYM9POGm0TSQftx2EAd
         2oHg==
X-Gm-Message-State: AOAM5332ee1/QcursV6FaMWxp9S9k+Ad1dxXkkBmZc0/uk/awY+khSQw
        DVMi4Et/AuKekUXuOeOjKWs=
X-Google-Smtp-Source: ABdhPJzqqSFYVfsF7DpZqSX2LgvZ6x327mJHK44eKP+/VvVqlrwCa4uIBPAzL0DyUHzyoTcMsSRupw==
X-Received: by 2002:a2e:1649:: with SMTP id 9mr3112697ljw.74.1616611281496;
        Wed, 24 Mar 2021 11:41:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id g14sm409662ljj.3.2021.03.24.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:41:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 24 Mar 2021 19:41:19 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        urezki@gmail.com
Subject: Re: [PATCH 2/2] mm/vmalloc: Use kvmalloc to allocate the table of
 pages
Message-ID: <20210324184119.GA25852@pc638.lan>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
 <20210322230311.GY1719932@casper.infradead.org>
 <20210323120436.GA1949@pc638.lan>
 <20210323123913.GD1719932@casper.infradead.org>
 <20210323203924.GA52881@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323203924.GA52881@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:39:24PM +0100, Uladzislau Rezki wrote:
> > On Tue, Mar 23, 2021 at 01:04:36PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Mar 22, 2021 at 11:03:11PM +0000, Matthew Wilcox wrote:
> > > > I suspect the vast majority of the time is spent calling alloc_pages_node()
> > > > 1024 times.  Have you looked at Mel's patch to do ... well, exactly what
> > > > vmalloc() wants?
> > > > 
> > > <snip>
> > >          - __vmalloc_node_range
> > >             - 45.25% __alloc_pages_nodemask
> > >                - 37.59% get_page_from_freelist
> > [...]
> > >       - 44.61% 0xffffffffc047348d
> > >          - __vunmap
> > >             - 35.56% free_unref_page
> > 
> > Hmm!  I hadn't been thinking about the free side of things.
> > Does this make a difference?
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 4f5f8c907897..61d5b769fea0 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2277,16 +2277,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
> >  	vm_remove_mappings(area, deallocate_pages);
> >  
> >  	if (deallocate_pages) {
> > -		int i;
> > -
> > -		for (i = 0; i < area->nr_pages; i++) {
> > -			struct page *page = area->pages[i];
> > -
> > -			BUG_ON(!page);
> > -			__free_pages(page, 0);
> > -		}
> > +		release_pages(area->pages, area->nr_pages);
> >  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> > -
> >  		kvfree(area->pages);
> >  	}
> >
> Same test. 4MB allocation on a single CPU:
> 
> default: loops: 1000000 avg: 93601889 usec
> patch:   loops: 1000000 avg: 98217904 usec
> 
> <snip default>
>             - __vunmap
>                - 41.17% free_unref_page
>                   - 28.42% free_pcppages_bulk
>                      - 6.38% __mod_zone_page_state
>                           4.79% check_preemption_disabled
>                        2.63% __list_del_entry_valid
>                        2.63% __list_add_valid
>                   - 7.50% free_unref_page_commit
>                        2.15% check_preemption_disabled
>                        2.01% __list_add_valid
>                     2.31% free_unref_page_prepare.part.86
>                     0.70% free_pcp_prepare
> <snip default>
> 
> <snip patch>
>         - __vunmap
>                - 45.36% release_pages
>                   - 37.70% free_unref_page_list
>                      - 24.70% free_pcppages_bulk
>                         - 5.42% __mod_zone_page_state
>                              4.23% check_preemption_disabled
>                           2.31% __list_add_valid
>                           2.07% __list_del_entry_valid
>                      - 7.58% free_unref_page_commit
>                           2.47% check_preemption_disabled
>                           1.75% __list_add_valid
>                        3.43% free_unref_page_prepare.part.86
>                   - 2.39% mem_cgroup_uncharge_list
>                        uncharge_page
> <snip patch>
> 
> It is obvious that the default version is slightly better. It requires
> less things to be done comparing with release_pages() variant.
> 
> > 
> > release_pages does a bunch of checks that are unnecessary ... we could
> > probably just do:
> > 
> > 		LIST_HEAD(pages_to_free);
> > 
> > 		for (i = 0; i < area->nr_pages; i++) {
> > 			struct page *page = area->pages[i];
> > 			if (put_page_testzero(page))
> > 				list_add(&page->lru, &pages_to_free);
> > 		}
> > 		free_unref_page_list(&pages_to_free);
> > 
> > but let's see if the provided interface gets us the performance we want.
> >  
> I will test it tomorrow. From the first glance it looks like a more light version :)
> 
Here we go:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c907897..349024768ba6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2254,6 +2254,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 static void __vunmap(const void *addr, int deallocate_pages)
 {
        struct vm_struct *area;
+       LIST_HEAD(pages_to_free);
 
        if (!addr)
                return;
@@ -2282,11 +2283,12 @@ static void __vunmap(const void *addr, int deallocate_pages)
                for (i = 0; i < area->nr_pages; i++) {
                        struct page *page = area->pages[i];
 
-                       BUG_ON(!page);
-                       __free_pages(page, 0);
+                       if (put_page_testzero(page))
+                               list_add(&page->lru, &pages_to_free);
                }
-               atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
+               free_unref_page_list(&pages_to_free);
+               atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
                kvfree(area->pages);
        }
<snip>

# patch
4MB allocation, single cpu, loops: 1000000 avg: 89065758 usec
4MB allocation, single cpu, loops: 1000000 avg: 90258523 usec
4MB allocation, single cpu, loops: 1000000 avg: 89363057 usec
4MB allocation, single cpu, loops: 1000000 avg: 89271685 usec
4MB allocation, single cpu, loops: 1000000 avg: 89247375 usec

# default
4MB allocation, single cpu, loops: 1000000 avg: 89258814 usec
4MB allocation, single cpu, loops: 1000000 avg: 89364194 usec
4MB allocation, single cpu, loops: 1000000 avg: 89226816 usec
4MB allocation, single cpu, loops: 1000000 avg: 89247360 usec
4MB allocation, single cpu, loops: 1000000 avg: 89330116 usec

Do not see any difference.

See below some profiling regarding cache misses:

<snip>
         - __vunmap
            - 32.15% free_unref_page_list                                                                                                                                               
               - 23.54% free_pcppages_bulk
                  - 6.33% __mod_zone_page_state
                       4.65% check_preemption_disabled
<snip>

free_unref_page_list():
       │        free_unref_page_list():
       │ffffffff8125152a:   mov    0x8(%rbp),%rax
 31.81 │ffffffff8125152e:   lea    0x8(%rbp),%r12                                                                                                                                        
       │ffffffff81251532:   mov    %rbp,%r14
 14.40 │ffffffff81251535:   lea    -0x8(%rax),%rbp  


(gdb) l *0xffffffff8125152e
0xffffffff8125152e is in free_unref_page_list (mm/page_alloc.c:3271).
3266            struct page *page, *next;
3267            unsigned long flags, pfn;
3268            int batch_count = 0;
3269
3270            /* Prepare pages for freeing */
3271            list_for_each_entry_safe(page, next, list, lru) {
3272                    pfn = page_to_pfn(page);
3273                    if (!free_unref_page_prepare(page, pfn))
3274                            list_del(&page->lru);
3275                    set_page_private(page, pfn);
(gdb)

free_pcppages_bulk():
       │        PageBuddy():
  0.59 │ffffffff8124f523:   mov        0x30(%rax),%edi
 13.59 │ffffffff8124f526:   and        $0xf0000080,%edi    

(gdb) l *0xffffffff8124f526
0xffffffff8124f526 is in free_pcppages_bulk (./include/linux/page-flags.h:742).
737
738     /*
739      * PageBuddy() indicates that the page is free and in the buddy system
740      * (see mm/page_alloc.c).
741      */
742     PAGE_TYPE_OPS(Buddy, buddy)
743
744     /*
745      * PageOffline() indicates that the page is logically offline although the
746      * containing section is online. (e.g. inflated in a balloon driver or
(gdb)

Looks like it would be good to have a free_pages_bulk_array() :)

--
Vlad Rezki
