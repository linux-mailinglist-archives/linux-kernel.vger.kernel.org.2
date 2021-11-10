Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0144C8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhKJTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhKJTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:14:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:11:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so3514073pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqyzeCyoCvvYPV9DVCrFvaqu6R57AheLr6xAlpsogPI=;
        b=GFs9WOfYWUEgxxeQ4/2M8fM0pX/gUu7eNkTskOt/SgCSPfUU3nXMgs3iIxvUpraxgA
         lOudnZhmHbTM/WVo52+3xoc3EzUWXuWuuuBKH+5qnchVs+3jtYygzDhZwlzlEMXyKYX/
         AF3ipfHBwexMnz7NhaPy2SmxJDrqXY3o3aW+ijoLh2WuGD+W1kpXSyq1Wu4cQImznzFu
         Wzf4uhM9W0pGgOXzXw7pXhksvYJLXgZSmntZmisqkh0KVCLyDXLVEh8+jKib+TlQgPjH
         wZ9E4wDAKmZxcpKf9mUyxPl1h7lJdnIYSNB6IP5++BvSrgNDqJGCHrApxGOH4afsdBSL
         XTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OqyzeCyoCvvYPV9DVCrFvaqu6R57AheLr6xAlpsogPI=;
        b=wfdZHb0GqvvLz7iw0vgSP8LWtmH+Sxm3RjIVmwRAeah0QgQO5LKAMrRrzdGQFnRjfV
         ZBZOIsFjB3cGn0Y0NZnchq62HU3m8OklIv58gFDmYms1JmILMfWzl1ah6qNcpLCUC65z
         u0TE+FHQ2rS9eOgST/bk3lgXfVfw4OpJDhrO1UvWSae19B9CJOrO+Nt65T6u40iztnwQ
         9DOYNJGDV/+Dsu9qezEtKw45u0pGQ5oJ3Ba7t829v4WKdVVqCbhZl0dT3w64elo/3JDN
         ReYc5pXr21QV6hwCFyrj8MDEuHBdpUqeIjmwHQfveVnXqe6FYfNDu+wMwJxhhuH1bB9X
         xX0A==
X-Gm-Message-State: AOAM5316pmLfF1jotxtyq9kAlmijQnzyMR98Tw/1LN+UsFBZ1PHs2vdS
        r57WbkdOuWEG1mh0OUYwPz0=
X-Google-Smtp-Source: ABdhPJy3AVp4RRoT7gNVI7XlIFa4jVj+kqj6mCpMofJK/hurnGRFW8fZdgsAQ0MmQjfGP8ekK/DESw==
X-Received: by 2002:a05:6a00:b49:b0:49f:bad2:bd7c with SMTP id p9-20020a056a000b4900b0049fbad2bd7cmr1308709pfo.64.1636571488481;
        Wed, 10 Nov 2021 11:11:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:11d4:2de3:ab82:be64])
        by smtp.gmail.com with ESMTPSA id e15sm397567pfv.131.2021.11.10.11.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:11:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Nov 2021 11:11:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YYwZXrL3Fu8/vLZw@google.com>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-4-hannes@cmpxchg.org>
 <YS0oV23m5NfyMcJJ@google.com>
 <YYFT6VtNT1Fvl4Iz@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFT6VtNT1Fvl4Iz@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Nov 02, 2021 at 11:06:17AM -0400, Johannes Weiner wrote:
> Hi Minchan,
> 
> Sorry about the delay, I'm just now getting back to these patches.
> 
> On Mon, Aug 30, 2021 at 11:49:59AM -0700, Minchan Kim wrote:
> > Hi Johannes,
> > 
> > On Thu, Aug 19, 2021 at 03:55:33PM -0400, Johannes Weiner wrote:
> > > Currently it requires poking at debugfs to figure out the size of the
> > > zswap cache size on a host. There are no counters for reads and writes
> > > against the cache. This makes it difficult to understand behavior on
> > > production systems.
> > > 
> > > Print zswap memory consumption in /proc/meminfo, count zswapouts and
> > > zswapins in /proc/vmstat.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  fs/proc/meminfo.c             |  4 ++++
> > >  include/linux/swap.h          |  4 ++++
> > >  include/linux/vm_event_item.h |  4 ++++
> > >  mm/vmstat.c                   |  4 ++++
> > >  mm/zswap.c                    | 11 +++++------
> > >  5 files changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > index 6fa761c9cc78..2dc474940691 100644
> > > --- a/fs/proc/meminfo.c
> > > +++ b/fs/proc/meminfo.c
> > > @@ -86,6 +86,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >  
> > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > +#ifdef CONFIG_ZSWAP
> > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > 
> > Since we have zram as well as zswap, it would be great if
> > we can abstract both at once without introducing another
> > "Zram: " stuff in meminfo. A note: zram can support fs based on
> > on zram blk device as well as swap. Thus, term would be better
> > to say "compressed" rather than "swap".
> > 
> > How about this?
> > 
> > "Compressed: xx kB"
> 
> Wouldn't it make more sense to keep separate counters? Zswap and zram
> are quite different from each other.
> 
> From an MM perspective, zram is an opaque storage backend. zswap OTOH
> is an explicit MM cache stage which may in the future make different
> decisions than zram, be integrated into vmscan's LRU hierarchy
> etc. And in theory, you could put zswap with fast compression in front
> of a zram device with denser compression, right?

My view is the the allocators aims to store compressed memory.
Likewise slab allocator, we could use the allocator any places
and display the total memory usage from the allocator in meminfo
instead of each subsystem and look at slabinfo if we need further
break down. I think it could work for this case, too.

> 
> I agree zram should probably also have memory counters, but I think it
> makes sense to recognize zswap as a unique MM layer.

Under your view, I think it would introduce Zram-swap, Zram-block
as well as Zswap. If folks think it's better idea, I am fine and
happy to post a patch to merge it along with this patch.
