Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2878A4303D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhJPQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJPQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:48:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A533C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:46:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so55816877lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MHi8iUm6z8exyNOhpdqOYyCJmhXx9wPOdYtdzWSL6CY=;
        b=YfaNYvXft4KDDtZcv5w1GfZj/jYJaKtSsB5G/kB51tMwXR4Bbsz9trsYlKblXH1c8K
         Qwj1s5+0lRC8vnRd9IPO9ABjhfrT2IzY1p1qluxd0zIqoj+sp83azCyXdcMrjbuLh6D2
         dLDHHfZLR9balnpnbLZN+l3qT3qh0iK6RFgBLTFePbSr6D0rYIZHzWeL/T4mbmKXdrz0
         ciBAGYZ2jPknr5MD3qlAh69OgE+Hj7CRCm8ieXFwQ92PaLUtBKwXGfhpix9cUP2tdcax
         1aZsYqr907t0JdtKwzeYbPm8Pwj0flbZ8p57QmfutzQlxV3YPg7vj554Gv/OFLvAULqL
         1EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MHi8iUm6z8exyNOhpdqOYyCJmhXx9wPOdYtdzWSL6CY=;
        b=bpoYyCxfI3+DB885iF+fxUX6glim70QR8a/9teWv0+pyDdHaxxLbMZ+l/Mn426ev8t
         rLgTs1SOXNrN9jKS9a8YPdtTbujDtyDEelXPVnobaDljq4XR1GpyRuHibKcW+NTtvB4Y
         d0u3WzuwcSDHJf7jl4tWOM6p8FZ9PF8eQBK2NRuz/2KEwANHagPGkopdQkASwpj5M+92
         dV8prLVfZ95uUfYwee87Slx6YdHjl7Ohb6NOXkaPd9hJzfK1n94Cvc3RRUmNkFKZJ4lE
         fyEccH0aLM73VweW2N2h2WemD5igsU78kL2b/odihSleHkRHFyVzEnT4OT5aDJDNhahC
         pRXA==
X-Gm-Message-State: AOAM532OHP8mFNpVAdxl6bg9tp07PwzCZ/SyShA3i3qDotRl+9/poTyu
        KKSaD/ck4FTn0uY0kV39px8=
X-Google-Smtp-Source: ABdhPJxoaeGlHU9K+JrScNAuAtLsFAHLn7whEqYfdGxLtkzUr887+e6GhcIZkDmXEtoUJ9X3Ehb0Kg==
X-Received: by 2002:a2e:8746:: with SMTP id q6mr20254963ljj.84.1634402787968;
        Sat, 16 Oct 2021 09:46:27 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j18sm898491lfu.84.2021.10.16.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 09:46:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 16 Oct 2021 18:46:24 +0200
To:     Nicholas Piggin <npiggin@gmail.com>,
        Chen Wandun <chenwandun@huawei.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, guohanjun@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
Message-ID: <20211016164624.GA1932@pc638.lan>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
 <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
 <1634261360.fed2opbgxw.astroid@bobo.none>
 <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com>
 <1634281763.ecsq6l88ia.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1634281763.ecsq6l88ia.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 05:11:25PM +1000, Nicholas Piggin wrote:
> Excerpts from Chen Wandun's message of October 15, 2021 12:31 pm:
> > 
> > 
> > 在 2021/10/15 9:34, Nicholas Piggin 写道:
> >> Excerpts from Chen Wandun's message of October 14, 2021 6:59 pm:
> >>>
> >>>
> >>> 在 2021/10/14 5:46, Shakeel Butt 写道:
> >>>> On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wrote:
> >>>>>
> >>>>> Eric Dumazet reported a strange numa spreading info in [1], and found
> >>>>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> >>>>> this issue [2].
> >>>>>
> >>>>> Dig into the difference before and after this patch, page allocation has
> >>>>> some difference:
> >>>>>
> >>>>> before:
> >>>>> alloc_large_system_hash
> >>>>>       __vmalloc
> >>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
> >>>>>               __vmalloc_node_range
> >>>>>                   __vmalloc_area_node
> >>>>>                       alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
> >>>>>                           alloc_pages_current
> >>>>>                               alloc_page_interleave /* can be proved by print policy mode */
> >>>>>
> >>>>> after:
> >>>>> alloc_large_system_hash
> >>>>>       __vmalloc
> >>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
> >>>>>               __vmalloc_node_range
> >>>>>                   __vmalloc_area_node
> >>>>>                       alloc_pages_node /* choose nid by nuam_mem_id() */
> >>>>>                           __alloc_pages_node(nid, ....)
> >>>>>
> >>>>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> >>>>> it will allocate memory in current node instead of interleaving allocate
> >>>>> memory.
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
> >>>>>
> >>>>> [2]
> >>>>> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
> >>>>>
> >>>>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> >>>>> Reported-by: Eric Dumazet <edumazet@google.com>
> >>>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> >>>>> ---
> >>>>>    mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
> >>>>>    1 file changed, 26 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>>>> index f884706c5280..48e717626e94 100644
> >>>>> --- a/mm/vmalloc.c
> >>>>> +++ b/mm/vmalloc.c
> >>>>> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >>>>>                   unsigned int order, unsigned int nr_pages, struct page **pages)
> >>>>>    {
> >>>>>           unsigned int nr_allocated = 0;
> >>>>> +       struct page *page;
> >>>>> +       int i;
> >>>>>
> >>>>>           /*
> >>>>>            * For order-0 pages we make use of bulk allocator, if
> >>>>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >>>>>           if (!order) {
> >>>>
> >>>> Can you please replace the above with if (!order && nid != NUMA_NO_NODE)?
> >>>>
> >>>>>                   while (nr_allocated < nr_pages) {
> >>>>>                           unsigned int nr, nr_pages_request;
> >>>>> +                       page = NULL;
> >>>>>
> >>>>>                           /*
> >>>>>                            * A maximum allowed request is hard-coded and is 100
> >>>>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >>>>>                            */
> >>>>>                           nr_pages_request = min(100U, nr_pages - nr_allocated);
> >>>>>
> >>>>
> >>>> Undo the following change in this if block.
> >>>
> >>> Yes, It seem like more simpler as you suggested, But it still have
> >>> performance regression, I plan to change the following to consider
> >>> both mempolcy and alloc_pages_bulk.
> >> 
> >> Thanks for finding and debugging this. These APIs are a maze of twisty
> >> little passages, all alike so I could be as confused as I was when I
> >> wrote that patch, but doesn't a minimal fix look something like this?
> > 
> > Yes, I sent a patch，it looks like as you show, besides it also
> > contains some performance optimization.
> > 
> > [PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to 
> > accelerate memory allocation
> 
> Okay. It would be better to do it as two patches. First the minimal fix 
> so it can be backported easily and have the Fixes: tag pointed at my 
> commit. Then the performance optimization.
> 
It is not only your commit. It also fixes my one :)

<snip>
commit 5c1f4e690eecc795b2e4d4408e87302040fceca4
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Mon Jun 28 19:40:14 2021 -0700

    mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()
<snip>

I agree there should be two separate patches which fix NUMA balancing
issue, tagged with "Fixes" flag. One is located here:

https://lkml.org/lkml/2021/10/15/1172

second one should be that fixes a second place where "big" pages are
allocated, basically your patch.

--
Vlad Rezki
