Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9F33CB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCPCZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCPCZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:25:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 19:25:03 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id g9so11342868ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8bXXxVKUm/wku6nIA5mKFHhS+mmzHtA4BcT1Vr9wqvk=;
        b=U9b5JDWV5YGhulk55tuMt6WYK9ty1mA9i+hJqTBVXklujtTKxEcJDupfnX4FvoSMoA
         mNVQzZLkK5mjC2vMKTipeRhrMtVY7m9UTefXymRRgTguWWxEQsR27LWcggZcQPoIsDXX
         D0YrUQ7IKB0RTGvvAO6KprA5fTU0C/3fJ27Y8FfsDAH2F2wMIYjwEM9IJQd3qSBu14f4
         7TxmbX+pfgXd2h0zTydAfUmRGKj3dt5NuleYGhIMkUqQFvasRq30clbVls+I/UCrBQGU
         L48voceS64M+B1UiIQGFaFL+16hx0g4Ww3Y15l13ZVyduw54n9KI0hix79tP6Akm2psL
         dVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bXXxVKUm/wku6nIA5mKFHhS+mmzHtA4BcT1Vr9wqvk=;
        b=r/0rLHzONlL+LOYC3u+9q0HgXaOumg7gufeXSZ0KPUvGFTDNj/JCt6XO815pgTdLf9
         8T4k2Q9QlfSF52ZZ+pMH3YuvgY8BTswOjPIun2H7xutFjKa/hW/mKmc91ooDdJPuxFqQ
         GNJJ3ms0BRJk807gmkt9PixhAN1kMWjt9gDCZfYdCSaeAXC4FaEVv8KbdQXM26pK9X/V
         yNpiiRdczv99AWTfuqcESaYVS8DnWBs3heSFnIjHVMZ9clSAct1EmxCeS48dzTMpd+gt
         SCtfZDByG5qLtZk9DqEL/CaJgwSozAboieaNI6oZZDzfDwjrzRGm6SvHfKxEQfxL0vb4
         q8fw==
X-Gm-Message-State: AOAM530HzcnfUHvxmX/NK6J+c01BAY4+p9QH0llCtJfN7pv1q33Hva+E
        GHaq4jktaXeUb1yKnswavSmgXg==
X-Google-Smtp-Source: ABdhPJzXHpkwMAMIcTOsGhUthl6jva3VuX+YFfsdeVMGTV64642RDtt7DednAvRwvWRgifK+CCGQbg==
X-Received: by 2002:a92:cb49:: with SMTP id f9mr1918127ilq.0.1615861502423;
        Mon, 15 Mar 2021 19:25:02 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id f13sm8457772ila.51.2021.03.15.19.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:25:01 -0700 (PDT)
Date:   Mon, 15 Mar 2021 20:24:56 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Message-ID: <YFAW+PtJS7DEngFZ@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:00:06AM -0700, Dave Hansen wrote:
> On 3/12/21 11:57 PM, Yu Zhao wrote:
> > Background
> > ==========
> > DRAM is a major factor in total cost of ownership, and improving
> > memory overcommit brings a high return on investment. Over the past
> > decade of research and experimentation in memory overcommit, we
> > observed a distinct trend across millions of servers and clients: the
> > size of page cache has been decreasing because of the growing
> > popularity of cloud storage. Nowadays anon pages account for more than
> > 90% of our memory consumption and page cache contains mostly
> > executable pages.
> 
> This makes a compelling argument that current reclaim is not well
> optimized for anonymous memory with low rates of sharing.  Basically,
> anonymous rmap is very powerful, but we're not getting enough bang for
> our buck out of it.
> 
> I also understand that the workloads you reference are anonymous-heavy
> and that page cache isn't a *major* component.
> 
> But, what does happens to page-cache-heavy workloads?  Does this just
> effectively force databases that want to use shmem over to hugetlbfs?

No, they should benefit too. In terms of page reclaim, shmem pages are
basically considered anon: they are on anon lru and dirty shmem pages
can only be swapped (we can safely assume clean shmem pages are
virtually nonexistent) in contrast to file pages that have backing
storage and need to be written back.

I should have phrased it better: our accounting is based on what the
kernel provides, i.e., anon/file (lru) sizes you listed below.

> How bad does this scanning get in the worst case if there's a lot of
> sharing?

Actually the improvement is larger when there is more sharing, i.e.,
higher map_count larger improvement. Let's assume we have a shmem
page mapped by two processes. To reclaim this page, we need to make
sure neither PTE from the two sets of page tables has the accessed
bit. The current page reclaim uses the rmap, i.e., rmap_walk_file().
It first looks up the two VMAs (from the two processes mapping this
shmem file) in the interval tree of this shmem file, then from each
VMA, it goes through PGD/PUD/PMD to reach the PTE. The page can't be
reclaimed if either of the PTEs has the accessed bit, therefore cost
of the scanning is more than proportional to the number of accesses,
when there is a lot sharing.

Why this series makes it better? We track the usage of page tables.
Specifically, we work alongside switch_mm(): if one of the processes
above hasn't be scheduled since the last scan, we don't need to scan
its page tables. So the cost is roughly proportional to the number of
accesses, regardless of how many processes. And instead of scanning
pages one by one, we do it in large batches. However, page tables can
be very sparse -- this is not a problem for the rmap because it knows
exactly where the PTEs are (by vma_address()). We only know ranges (by
vma->vm_start/vm_end). This is where the accessed bit on non-leaf
PMDs can be of help.

But I guess you are wondering what downsides are. Well, we haven't
seen any (yet). We do have page cache (non-shmem) heavy workloads,
but not at a scale large enough to make any statistically meaningful
observations. We are very interested in working with anybody who has
page cache (non-shmem) heavy workloads and is willing to try out this
series.

> I'm kinda surprised by this, but my 16GB laptop has a lot more page
> cache than I would have guessed:
> 
> > Active(anon):    4065088 kB
> > Inactive(anon):  3981928 kB
> > Active(file):    2260580 kB
> > Inactive(file):  3738096 kB
> > AnonPages:       6624776 kB
> > Mapped:           692036 kB
> > Shmem:            776276 kB
> 
> Most of it isn't mapped, but it's far from all being used for text.

We have categorized two groups:
  1) average users that haven't experienced memory pressure since
  their systems have booted. The booting process fills up page cache
  with one-off file pages, and they remain until users experience
  memory pressure. This can be confirmed by looking at those counters
  of a freshly rebooted and idle system. My guess this is the case for
  your laptop.
  2) engineering users who store git repos and compile locally. They
  complained about their browsers being janky because anon memory got
  swapped even though their systems had a lot of stale file pages in
  page cache, with the current page reclaim. They are what we consider
  part of the page cache (non-shmem) heavy group.
