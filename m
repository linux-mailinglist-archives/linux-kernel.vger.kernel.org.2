Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398F935B0B3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhDJW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 18:26:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8FC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 15:26:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so4688830wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEvIGqDq830nRBaPG0mDLI6J8gDtfbuoNtQc3+MjfXU=;
        b=qxHO5WTC8oHGW9jSO2oWK7mN1tBtviBA4vyYKu8IxBL7g9RayqfgYS8vv8YO/ccKa5
         coB9zKdz+fVoKXNoNehOldrOYmVBQV6TM402B0N5pQRU1huGrJAuaw0EQ3FLjrGzziRA
         HXbTZ2sSXruZ0fr+GRCdTGmTgMtYczxA/GvlIF5suemNmirX4D72ZvjmCrP2SLoxCLa/
         OiCFl6Ehy9tLyzqJ7UAc4VQ88qgJR9yVyS/OgQtM3uxYziR6MstsosuAdDTNqr3/3sNX
         6nMUDFq5ShPtFQDEjYs0c0NgQejAac5QTyY9GYhBF9sMHSscGjRNHwvBMgHgyOt97k2v
         auzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEvIGqDq830nRBaPG0mDLI6J8gDtfbuoNtQc3+MjfXU=;
        b=jiR9EtQYC6vTjx9Mbp795cv+Fh8z7d+7avzYgIEFBoZa+PmtBuFvw8Z+OnNvPKefhk
         3BDtkTWuFm5bonySjFBzRZPX4Vu5uIxbxl4elyZy+Job4sl8FazqZZGk2QlCv0OZVXso
         rhUlNWn7ngKV8TTD/GQvBgptUh+VMEt+5NelfJOoKy5NnHAAD8vrIBFD3JKbz2zHJ5n0
         J4ah5c5mM0v78m/NpWCcSSvomPq5dzqVfM02gi4HZsIkOVM+Eglzm70Rw4BGIQ6CjplU
         avDd7BZWcya8Ly9fe6QGXd/YugmtgHYeil3bgFoWa+PPITmaiSRXk5rPvLWeLwS3JEpr
         jdcw==
X-Gm-Message-State: AOAM5322FRHMX9hNvQaSjFVG5G5vfaB2CeM3WZh9bOI42ZWrFDMmGu70
        tUETgrHKUk4kEx5Xbj4/LAEIBLEqgSf9PxhyBmKtSw==
X-Google-Smtp-Source: ABdhPJxy5RSDO/cJRdt8OckP/63VUi7zfpWbL9cpvL02nEZqaIw1RvWfUbyLUZvU1EMD27HIjxMFz3trYisz/wRKp6w=
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr12886733wmh.48.1618093560737;
 Sat, 10 Apr 2021 15:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210324083209.527427-1-ying.huang@intel.com> <20210324103104.GN15768@suse.de>
 <87a6qrj1hy.fsf@yhuang6-desk1.ccr.corp.intel.com> <20210325115721.GS15768@suse.de>
 <87o8f6h1ve.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87o8f6h1ve.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 10 Apr 2021 16:25:49 -0600
Message-ID: <CAOUHufbJg-OGnpZrb_EzQmiqXCwPHDU+hgTvYWtb72OiXy6CDg@mail.gmail.com>
Subject: Re: [RFC] mm: activate access-more-than-once page via NUMA balancing
To:     "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:21 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Mel Gorman <mgorman@suse.de> writes:
>
> > On Thu, Mar 25, 2021 at 12:33:45PM +0800, Huang, Ying wrote:
> >> > I caution against this patch.
> >> >
> >> > It's non-deterministic for a number of reasons. As it requires NUMA
> >> > balancing to be enabled, the pageout behaviour of a system changes when
> >> > NUMA balancing is active. If this led to pages being artificially and
> >> > inappropriately preserved, NUMA balancing could be disabled for the
> >> > wrong reasons.  It only applies to pages that have no target node so
> >> > memory policies affect which pages are activated differently. Similarly,
> >> > NUMA balancing does not scan all VMAs and some pages may never trap a
> >> > NUMA fault as a result. The timing of when an address space gets scanned
> >> > is driven by the locality of pages and so the timing of page activation
> >> > potentially becomes linked to whether pages are local or need to migrate
> >> > (although not right now for this patch as it only affects pages with a
> >> > target nid of NUMA_NO_NODE). In other words, changes in NUMA balancing
> >> > that affect migration potentially affect the aging rate.  Similarly,
> >> > the activate rate of a process with a single thread and multiple threads
> >> > potentially have different activation rates.
> >> >
> >> > Finally, the NUMA balancing scan algorithm is sub-optimal. It potentially
> >> > scans the entire address space even though only a small number of pages
> >> > are scanned. This is particularly problematic when a process has a lot
> >> > of threads because threads are redundantly scanning the same regions. If
> >> > NUMA balancing ever introduced range tracking of faulted pages to limit
> >> > how much scanning it has to do, it would inadvertently cause a change in
> >> > page activation rate.
> >> >
> >> > NUMA balancing is about page locality, it should not get conflated with
> >> > page aging.
> >>
> >> I understand your concerns about binding the NUMA balancing and page
> >> reclaiming.  The requirement of the page locality and page aging is
> >> different, so the policies need to be different.  This is the wrong part
> >> of the patch.
> >>
> >> From another point of view, it's still possible to share some underlying
> >> mechanisms (and code) between them.  That is, scanning the page tables
> >> to make pages unaccessible and capture the page accesses via the page
> >> fault.
> >
> > Potentially yes but not necessarily recommended for page aging. NUMA
> > balancing has to be careful about the rate it scans pages to avoid
> > excessive overhead so it's driven by locality. The scanning happens
> > within a tasks context so during that time, the task is not executing
> > its normal work and it incurs the overhead for faults. Generally, this
> > is not too much overhead because pages get migrated locally, the scan
> > rate drops and so does the overhead.
> >
> > However, if you want to drive page aging, that is constant so the rate
> > could not be easily adapted in a way that would be deterministic.
> >
> >> Now these page accessing information is used for the page
> >> locality.  Do you think it's a good idea to use these information for
> >> the page aging too (but with a different policy as you pointed out)?
> >>
> >
> > I'm not completely opposed to it but I think the overhead it would
> > introduce could be severe. Worse, if a workload fits in memory and there
> > is limited to no memory pressure, it's all overhead for no gain. Early
> > generations of NUMA balancing had to find a balance to sure the gains
> > from locality exceeded the cost of measuring locality and doing the same
> > for page aging in some ways is even more challenging.
>
> Yes.  I will think more about it from the overhead vs. gain point of
> view.  Thanks a lot for your sharing on that.
>
> >> From yet another point of view :-), in current NUMA balancing
> >> implementation, it's assumed that the node private pages can fit in the
> >> accessing node.  But this may be not always true.  Is it a valid
> >> optimization to migrate the hot private pages first?
> >>
> >
> > I'm not sure how the hotness of pages could be ranked. At the time of a
> > hinting fault, the page is by definition active now because it was been
> > accessed. Prioritising what pages to migrate based on the number of faults
> > that have been trapped would have to be stored somewhere.
>
> Yes.  We need to store some information about that.  In an old version
> of the patchset which uses NUMA balancing to promote hot pages from the
> PMEM to DRAM, we have designed a method to measure the hotness of the
> pages.  The basic idea is as follows,
>
> - When the page table of a process is scanned, the latest N scanning
>   address ranges and scan times are recorded in a ring buffer of
>   mm_struct.
>
> - In hint page fault handler, the ring buffer is search with the fault
>   address, to get the scan time.
>
> Then the hint page fault latency of the page is defined as,
>
>   hint page fault latency = fault time - scan time
>
> The shorter the hint page fault latency, the hotter the page.
>
> Then we need a way to determine the hot/cold threshold.  We used a rate
> limit based threshold adjustment method.  If the number of pages that
> pass the threshold is much more than the rate limit, then we will lower
> the threshold (more stricter), or vice versa.

Sorry for the late reply. I do see where you are coming from and I
agree in principle. The aging and the NUMA balancing should be talking
to each other, and IMO, it is easier for the aging to help the numa
balancing because it has to do the legwork anway.

My idea is to make the page table scanning in the multigenerational
LRU NUMA policy aware -- I don't have any concrete plan yet. But in
general, it can range from mildly skewing the aging of pages from
wrong nodes so they become preferable during eviction to aggressively
working against those pages like queue_pages_pte_range() does.
