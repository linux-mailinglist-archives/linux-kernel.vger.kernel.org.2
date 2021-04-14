Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821A35F88F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbhDNP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352707AbhDNP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:59:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E91C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:59:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o16so23847435ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nw9XoSWLF/lbloHZk5v1ZuW1BtLC1PdKJBw9usU2gQI=;
        b=A5tw8XeSwq+jA9n7FPOt0Mgv8oEzWPt8AjVPF7ltD8uF+jKouH88BeIUGUlgp0TvOq
         dyncM+o+W/B+r4TT9W0grbDpGIY1M8PnpvX0GBzebHxiH7+NCfSqFZ0eTSkcgpnY99CA
         xgBBWPnvRAehJaEZLUO+BmQc7c/q3J11H1YjrsVJD+W735SeEAhoT3XWH0FltIcLDE+l
         7xnxdQHLbnoOiYBEFt0F7Ggg8WMyy/BUPx9eBnQopRgvATyOavcV/6k1kX7qFS3T3n2K
         2gSWIVknQMtd9eAt4I1CGm8xAPFTr2BrVzvDG4ga2gNRWHPEvUxnRm+xuvt9F0a3mPWB
         6skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nw9XoSWLF/lbloHZk5v1ZuW1BtLC1PdKJBw9usU2gQI=;
        b=Pf8N096AtQQ3aLY0vK6tIHBBt+wlCGN/IUsBYvPU8hTcRCcu2Q9uTpTEI5tEXzAJZD
         R1YfbLCWJwny6cXBfi8jD7kmX8EjgKWRGgg7B86RpCH8mwpb54YFEsi2NnOIMz1HPdQc
         Mug+U3JXB7H6wkW9kJuo+CRRsVXLTMI8lgvLlGZd8JratY6deY7RjfLSf1O3Iw/0DloK
         EkQ/71pU3OkGne4T/0DDLWrj49OSmUrwlvloZFvMZseQTFbQd4bM1aaYOK5Fd88QXptS
         gykaoa57J59q7JyUVQ4+xeuVsQrUxjWo/mPGYIIAj6b+sv7HaWValymWCR1t9jFH4qKi
         GA5A==
X-Gm-Message-State: AOAM530s+ijnpM+8meEwsxGbn/Zra56fM7+lL+hbnx1drVDVztCc20WJ
        puE5VqDd9hLTI/2aVP8E/66g2+gmNk2eQpO4PbWyGw==
X-Google-Smtp-Source: ABdhPJw/3oYqJpS76cT+/fGrsZXpWQ8TJmCFedFydR6GaBHuQnfuE2PzG69m/AE6KlWJAwKhCn2t5nz6ZqeAsXDs2zU=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr14306858lji.0.1618415947897;
 Wed, 14 Apr 2021 08:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com> <CAOUHufbk=TVOpEOvTNRBe0uoOWNZ=wf3umQ628ZFZ=QYhNqsHA@mail.gmail.com>
 <87lf9lqnit.fsf@yhuang6-desk1.ccr.corp.intel.com> <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
In-Reply-To: <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 14 Apr 2021 08:58:56 -0700
Message-ID: <CALvZod5jbmw5KPoxpwam212LzH0NJm_JXJ1uiUX2v1LvbRLB_Q@mail.gmail.com>
Subject: Re: [page-reclaim] Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Rik van Riel <riel@surriel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
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

On Wed, Apr 14, 2021 at 6:52 AM Rik van Riel <riel@surriel.com> wrote:
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
>
> > Note that it's possible that only some processes are bound to some
> > NUMA
> > nodes, while other processes aren't bound.
>
> For workloads like PostgresQL or Oracle, it is common
> to have maybe 70% of memory in a large shared memory
> segment, spread between all the NUMA nodes, and mapped
> into hundreds, if not thousands, of processes in the
> system.
>
> Now imagine we have an 8 node system, and memory
> pressure in the DMA32 zone of node 0.
>
> How will the current VM behave?
>
> Wha
> t will the virtual scanning need to do?
>
> If we can come up with a solution to make virtual
> scanning scale for that kind of workload, great.
>
> If not ... if it turns out most of the benefits of
> the multigeneratinal LRU framework come from sorting
> the pages into multiple LRUs, and from being able
> to easily reclaim unmapped pages before having to
> scan mapped ones, could it be an idea to implement
> that first, independently from virtual scanning?
>
> I am all for improving
> our page reclaim system, I
> just want to make sure we don't revisit the old traps
> that forced us where we are today :)
>

One potential idea is to take the hybrid 'of rmap and virtual
scanning' approach. If the number of pages that are targeted to be
scanned is below some threshold, do rmap otherwise virtual scanning. I
think we can experimentally find good value for that threshold.
