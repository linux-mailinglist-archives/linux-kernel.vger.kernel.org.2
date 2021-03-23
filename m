Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7223346A09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhCWUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhCWUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:39:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D600C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:39:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f26so27408137ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qC7b8v4Q+0qPdJx76mAI6LXaP6YKiU6yuyomNDv0YZY=;
        b=CycMhQSWo2WmQtelRTK9BeW9n1yCPxXthlnE0svr6eDnSiZ5pQsmLIMHBO8Wv7qnan
         pkBp/gqDQms7RylKWgEYKs/6b+PZHYmUdfVcDb05b8OXRSj6T0B8G4wCebRamuSE54MU
         Qvr5tlhNmoyKPI5T+pWUC7OL/3ULhymq08nt84/l/G+hdd+JF7swsO22X2bibuzWjv6x
         9bxpfdi3DUcOznWhpzw+C2yfWPw+VHqwrGifX44K37Oqdxe6VpY5offYahUHAz3iptIN
         7isoSbXllBz/C2v9e5l4egpIAM2TU2JxYpKEMmVbpmtzFj42ZVMAj2BVqgI5gzCWEQV2
         e8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qC7b8v4Q+0qPdJx76mAI6LXaP6YKiU6yuyomNDv0YZY=;
        b=STTPA2wIc2mz1WKYu1zBY/MymFTgdtLAcbKB6tG4f0C9jPD69Vcud1FuVgNiAznNc2
         idkQjoxtimFAExU+p/tO5J+TPkhkpJ4jblIKnk2VQaqwq5swV6X9GMrbCK3eIp5Vot8b
         MJeTBOdPF3Jyi6RlyiPJwuB9Qs2R7fukZli7wHKswM7jmK9zKClE+/nbqiDa70Fn6mfh
         DcDD0pPDnaNKrDAfMpXbmCCLGQ/Y1kaFrjfxkSs/2zQKzsjZsr1/j5VP8+YMBlUktVKG
         uDTtP+gloMR0kMX9PGAZh4B7hZDvBU68E2b65/BFti7UcuTp19SOXgbMzp+/yr1/vsYU
         ZEUQ==
X-Gm-Message-State: AOAM532Qbf6OUlQ0kobIfDRgdoCBvg3FAjKdE+B1G8Kj7VO+vS0cBZx8
        USP/GNjkT9oljT12iYWFcWs=
X-Google-Smtp-Source: ABdhPJykr+lN/opGosRl7fwLcWKoDDml0RmmHt4dmvwyNC8JeToPeUGidqw4WVf1qfohVjmu4ZzJeA==
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr4173151ljk.40.1616531967091;
        Tue, 23 Mar 2021 13:39:27 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m27sm12796lfc.222.2021.03.23.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:39:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Mar 2021 21:39:24 +0100
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
Message-ID: <20210323203924.GA52881@pc638.lan>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
 <20210322230311.GY1719932@casper.infradead.org>
 <20210323120436.GA1949@pc638.lan>
 <20210323123913.GD1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323123913.GD1719932@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 23, 2021 at 01:04:36PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 22, 2021 at 11:03:11PM +0000, Matthew Wilcox wrote:
> > > I suspect the vast majority of the time is spent calling alloc_pages_node()
> > > 1024 times.  Have you looked at Mel's patch to do ... well, exactly what
> > > vmalloc() wants?
> > > 
> > <snip>
> >          - __vmalloc_node_range
> >             - 45.25% __alloc_pages_nodemask
> >                - 37.59% get_page_from_freelist
> [...]
> >       - 44.61% 0xffffffffc047348d
> >          - __vunmap
> >             - 35.56% free_unref_page
> 
> Hmm!  I hadn't been thinking about the free side of things.
> Does this make a difference?
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4f5f8c907897..61d5b769fea0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2277,16 +2277,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	vm_remove_mappings(area, deallocate_pages);
>  
>  	if (deallocate_pages) {
> -		int i;
> -
> -		for (i = 0; i < area->nr_pages; i++) {
> -			struct page *page = area->pages[i];
> -
> -			BUG_ON(!page);
> -			__free_pages(page, 0);
> -		}
> +		release_pages(area->pages, area->nr_pages);
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> -
>  		kvfree(area->pages);
>  	}
>
Same test. 4MB allocation on a single CPU:

default: loops: 1000000 avg: 93601889 usec
patch:   loops: 1000000 avg: 98217904 usec

<snip default>
            - __vunmap
               - 41.17% free_unref_page
                  - 28.42% free_pcppages_bulk
                     - 6.38% __mod_zone_page_state
                          4.79% check_preemption_disabled
                       2.63% __list_del_entry_valid
                       2.63% __list_add_valid
                  - 7.50% free_unref_page_commit
                       2.15% check_preemption_disabled
                       2.01% __list_add_valid
                    2.31% free_unref_page_prepare.part.86
                    0.70% free_pcp_prepare
<snip default>

<snip patch>
        - __vunmap
               - 45.36% release_pages
                  - 37.70% free_unref_page_list
                     - 24.70% free_pcppages_bulk
                        - 5.42% __mod_zone_page_state
                             4.23% check_preemption_disabled
                          2.31% __list_add_valid
                          2.07% __list_del_entry_valid
                     - 7.58% free_unref_page_commit
                          2.47% check_preemption_disabled
                          1.75% __list_add_valid
                       3.43% free_unref_page_prepare.part.86
                  - 2.39% mem_cgroup_uncharge_list
                       uncharge_page
<snip patch>

It is obvious that the default version is slightly better. It requires
less things to be done comparing with release_pages() variant.

> 
> release_pages does a bunch of checks that are unnecessary ... we could
> probably just do:
> 
> 		LIST_HEAD(pages_to_free);
> 
> 		for (i = 0; i < area->nr_pages; i++) {
> 			struct page *page = area->pages[i];
> 			if (put_page_testzero(page))
> 				list_add(&page->lru, &pages_to_free);
> 		}
> 		free_unref_page_list(&pages_to_free);
> 
> but let's see if the provided interface gets us the performance we want.
>  
I will test it tomorrow. From the first glance it looks like a more light version :)

--
Vlad Rezki
