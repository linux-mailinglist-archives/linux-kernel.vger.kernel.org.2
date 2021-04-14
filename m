Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2B35FAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352759AbhDNSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhDNSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:45:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:45:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so17105687wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFpeLrhMRSdhJjwJx9ecxuPIGzNMIfh4rcmuAZslJ+Q=;
        b=Sx/j0bN4OrtpNE53iwqgZgaw1DFQ+JAZmUdABSI/p4AjJG8qwTXufwtPlTZ/SqA5al
         7PzjBnQeyTP5433vmjKhTkbOPesbNIugbNOjCxqPCRVYtQ7bvLJybRuPUVrvnJ3oPMQw
         z125pIPCJKN9j3JVv6Pqah0rwr85YO7UeYH2BoIZDEf2TJPZ/ZazG3kFmPllpO5CVLFf
         QZfRjCbHiilOOmb5i87VjEFD28hFQj5BAgYUhBs+bdTPPWPPlpIMCTZ5rVZlBqGW+brk
         2RvQ2pzWYsm/4qXVMB8xtW3vQhwY12Gzsz0eQhhxrRGTZPk6L3WZ9xT0KnMUs6bzY7AW
         z/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFpeLrhMRSdhJjwJx9ecxuPIGzNMIfh4rcmuAZslJ+Q=;
        b=saCBZX2VY01Qrw9rsiUjLGz/sF1SYC3t6jvoEh+KcDKOhVL9BvjXZE/CuVU7wl82Ob
         ZurYJLFJb8YqKVP5yg7RoNiSZED/2+OyFD0nUT5dN/8BjKTDc9mRSn/P9BfIHzSU23x6
         Czp4YZfBw3AP9uZ3Mt8By5dbZIEjhSCO5Cwbyn6B1dxp9UripfywxwqRDC3A11Rz61f1
         QWYvoXMIZBzX37GaxCGMrQgJzfliCZGilUCILq9wSrkvFa/KpwFFH+ib07UT4Qx0BzzB
         ISC1i9Dj98kf5DZoJd71EgbZZopq1Q3FH/m7AZtoqibnVfFb6XrJMDbqFE/Au7BuNqj1
         rT9A==
X-Gm-Message-State: AOAM5310MwheDrBIevUR9RLunIw3Qxyp/zOYtsGYThybPa6SkTa5PvT6
        F+ke5gtpTs7ZAqdjUGxCRNZoneR0kb+01ZCPaqLEMQ==
X-Google-Smtp-Source: ABdhPJymPOy/aXX6oaknlaD0xZPd9W+iv0ifBqXzMjbxPFg71rQLLZ64GYMYoSEB5mAo3bHcPkvPIgZ+BVL6o9zPjVA=
X-Received: by 2002:adf:9148:: with SMTP id j66mr44600646wrj.124.1618425924205;
 Wed, 14 Apr 2021 11:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com> <CAOUHufbk=TVOpEOvTNRBe0uoOWNZ=wf3umQ628ZFZ=QYhNqsHA@mail.gmail.com>
 <87lf9lqnit.fsf@yhuang6-desk1.ccr.corp.intel.com> <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
In-Reply-To: <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 12:45:12 -0600
Message-ID: <CAOUHufY_++Zr3uN=RCjj22qZHE=650eihyAFWnaPSSC3jS1Xhg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Rik van Riel <riel@surriel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 7:52 AM Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2021-04-14 at 16:27 +0800, Huang, Ying wrote:
> > Yu Zhao <yuzhao@google.com> writes:
> >
> > > On Wed, Apr 14, 2021 at 12:15 AM Huang, Ying <ying.huang@intel.com>
> > > wrote:
> > > >
> > > NUMA Optimization
> > > -----------------
> > > Support NUMA policies and per-node RSS counters.
> > >
> > > We only can move forward one step at a time. Fair?
> >
> > You don't need to implement that now definitely.  But we can discuss
> > the
> > possible solution now.
>
> That was my intention, too. I want to make sure we don't
> end up "painting ourselves into a corner" by moving in some
> direction we have no way to get out of.
>
> The patch set looks promising, but we need some plan to
> avoid the worst case behaviors that forced us into rmap
> based scanning initially.

Hi Rik,

By design, we voluntarily fall back to the rmap when page tables of a
process are too sparse. At the moment, we have

bool should_skip_mm()
{
    ...
    /* leave the legwork to the rmap if mapped pages are too sparse */
    if (RSS < mm_pgtables_bytes(mm) / PAGE_SIZE)
        return true;
    ....
}

So yes, I agree we have more work to do in this direction, the
fallback should be per VMA and NUMA aware. Note that once the fallback
happens, it shares the same path with the existing implementation.

Probably I should have clarified that this patchset does not replace
the rmap with page table scanning. It conditionally uses page table
scanning when it thinks most of the pages on a system could have been
referenced, i.e., when it thinks walking the rmap would be less
efficient, based on generations.

It *unconditionally* walks the rmap to scan each of the pages it
eventually tries to evict, because scanning page tables for a small
batch of pages it wants to evict is too costly.

One of the simple ways to look at how the mixture of page table
scanning and the rmap works is:
  1) it scans page tables (but might fallback to the rmap) to
deactivate pages from the active list to the inactive list, when the
inactive list becomes empty
  2) it walks the rmap (not page table scanning) when it evicts
individual pages from the inactive list.
Does it make sense?

I fully agree "the mixture" is currently statistically decided, and it
must be made worst-case scenario proof.

> > Note that it's possible that only some processes are bound to some
> > NUMA
> > nodes, while other processes aren't bound.
>
> For workloads like PostgresQL or Oracle, it is common
> to have maybe 70% of memory in a large shared memory
> segment, spread between all the NUMA nodes, and mapped
> into hundreds, if not thousands, of processes in the
> system.

I do plan to reach out to the PostgreSQL community and ask for help to
benchmark this patchset. Will keep everybody posted.

> Now imagine we have an 8 node system, and memory
> pressure in the DMA32 zone of node 0.
>
> How will the current VM behave?

At the moment, we don't plan to make the DMA32 zone reclaim a
priority. Rather, I'd suggest
  1) stay with the existing implementation
  2) boost the watermark for DMA32

> What will the virtual scanning need to do?

The high priority items are:

To-do List
==========
KVM Optimization
----------------
Support shadow page table scanning.

NUMA Optimization
-----------------
Support NUMA policies and per-node RSS counters.

We are just trying to focus our resources on the trending use cases. Reasonable?

> If we can come up with a solution to make virtual
> scanning scale for that kind of workload, great.

It won't be easy, but IMO nothing worth doing is easy :)

> If not ... if it turns out most of the benefits of
> the multigeneratinal LRU framework come from sorting
> the pages into multiple LRUs, and from being able
> to easily reclaim unmapped pages before having to
> scan mapped ones, could it be an idea to implement
> that first, independently from virtual scanning?

This option is on the table considering the possibilities
  1) there are unforeseeable problems we couldn't solve
  2) sorting pages alone has demonstrated its standalone value

I guess 2) alone will help people heavily using page cache. Google
isn't one of them though. Personally I'm neutral (at least trying to
be), and my goal is to accommodate everybody as best as I can.

> I am all for improving
> our page reclaim system, I
> just want to make sure we don't revisit the old traps
> that forced us where we are today :)

Yeah, I do see your concerns and we need more data. Any suggestions on
benchmarks you'd be interested in?

Thanks.
