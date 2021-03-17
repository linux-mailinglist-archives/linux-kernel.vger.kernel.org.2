Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39433EEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCQKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhCQKqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:46:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBA9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:46:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n14so40446237iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EcLzHfwNPr9gGEtA+CwtCHVdRs0StUxL7B8m523U/P4=;
        b=spjqwtfz/oJIKZs9makfe2go6mKd9bV4cTuNl5By1eJkDKwc655dP9Y+0jspa8V4y+
         uZAIzNzl1d4sFEj7Dm47s9D5D8RnnPDPrEeHysDYdIosJtEMfLXkVa3LxaeH+KnB4/4H
         dzIEcscnC+jfcDW46MrbOVXX+ll6tXAbXLAr/61NHcCACbTL8A3eilSjP1w9TCVOrCOJ
         8LenI+M0sVQP3ae5HEdbER0F4/ej+ZHejRbZNro43Kn2im1Jk1X6hATVDZKFwaLhhXik
         vc43/ASeaOtEKsiQMqN4Kuw0Ht0aR3NcqMLrIzW9AJhmHdkIopdoKor370KjV6orwA9r
         4hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcLzHfwNPr9gGEtA+CwtCHVdRs0StUxL7B8m523U/P4=;
        b=Jk4+AB20b8FN/RwYnd1MyO25eBTMX8QjX3WWAmtByGHIGXw/bEkI0mhQspSpb3o3u7
         /znD4BSfdDzzfcVIhFWa4ew5iShpv10pC6ioK3gmZ+9y0tXdL54/yjUdjDLS25sExR4R
         s6o1QT0s2q4q8KXz/5X4fEMr8LoEe6NEqU182CZAONhie1Hkpfx/hNuyUDrMXoyRDwPA
         /+DZpcOMUZPYAj4BRSY/OCTK29hIRCTS96kjF1rXbFYFW0jvC3KFOqv6i8q6IPslHSQJ
         /3vnqGTcegZKPDJd+cj4rES7DufJtTjUo6bGVjGhayd2nzb7HeaQn7T+e8cbpn97KHeT
         6qlg==
X-Gm-Message-State: AOAM532sPl29pBi6G4mDPTHsI6r5e9RGbxaUkv+Y9GwNT1sTVgJlSXjO
        DZNcE0cAPpBMsA6m9IrbwICv/Q==
X-Google-Smtp-Source: ABdhPJzORvg+qeqzSdKR1+f1IMU+oK5a8htF4//PRyfmZLe8tfdiLYz1254gp1+CaXupcgk6mPgxIg==
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr6400739iob.75.1615978013518;
        Wed, 17 Mar 2021 03:46:53 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:85db:6a0d:7a4d:5606])
        by smtp.gmail.com with ESMTPSA id i4sm10636156ila.70.2021.03.17.03.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:46:52 -0700 (PDT)
Date:   Wed, 17 Mar 2021 04:46:46 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
Message-ID: <YFHeFslZ85/h3o/q@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-10-yuzhao@google.com>
 <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
 <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <YFAsjP7NIZM5Ld+m@google.com>
 <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <YFBktbCH9JFcT0rL@google.com>
 <87o8fixxfh.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8fixxfh.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:37:38AM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > On Tue, Mar 16, 2021 at 02:44:31PM +0800, Huang, Ying wrote:
> >> Yu Zhao <yuzhao@google.com> writes:
> >> 
> >> > On Tue, Mar 16, 2021 at 10:07:36AM +0800, Huang, Ying wrote:
> >> >> Rik van Riel <riel@surriel.com> writes:
> >> >> 
> >> >> > On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
> >> >> >
> >> >> >> +/*
> >> >> >> + * After pages are faulted in, they become the youngest generation.
> >> >> >> They must
> >> >> >> + * go through aging process twice before they can be evicted. After
> >> >> >> first scan,
> >> >> >> + * their accessed bit set during initial faults are cleared and they
> >> >> >> become the
> >> >> >> + * second youngest generation. And second scan makes sure they
> >> >> >> haven't been used
> >> >> >> + * since the first.
> >> >> >> + */
> >> >> >
> >> >> > I have to wonder if the reductions in OOM kills and 
> >> >> > low-memory tab discards is due to this aging policy
> >> >> > change, rather than from the switch to virtual scanning.
> >> >
> >> > There are no policy changes per se. The current page reclaim also
> >> > scans a faulted-in page at least twice before it can reclaim it.
> >> > That said, the new aging yields a better overall result because it
> >> > discovers every page that has been referenced since the last scan,
> >> > in addition to what Ying has mentioned. The current page scan stops
> >> > stops once it finds enough candidates, which may seem more
> >> > efficiently, but actually pays the price for not finding the best.
> >> >
> >> >> If my understanding were correct, the temperature of the processes is
> >> >> considered in addition to that of the individual pages.  That is, the
> >> >> pages of the processes that haven't been scheduled after the previous
> >> >> scanning will not be scanned.  I guess that this helps OOM kills?
> >> >
> >> > Yes, that's correct.
> >> >
> >> >> If so, how about just take advantage of that information for OOM killing
> >> >> and page reclaiming?  For example, if a process hasn't been scheduled
> >> >> for long time, just reclaim its private pages.
> >> >
> >> > This is how it works. Pages that haven't been scanned grow older
> >> > automatically because those that have been scanned will be tagged with
> >> > younger generation numbers. Eviction does bucket sort based on
> >> > generation numbers and attacks the oldest.
> >> 
> >> Sorry, my original words are misleading.  What I wanted to say was that
> >> is it good enough that
> >> 
> >> - Do not change the core algorithm of current page reclaiming.
> >> 
> >> - Add some new logic to reclaim the process private pages regardless of
> >>   the Accessed bits if the processes are not scheduled for some long
> >>   enough time.  This can be done before the normal page reclaiming.
> >
> > This is a good idea, which being used on Android and Chrome OS. We
> > call it per-process reclaim, and I've mentioned here:
> > https://lore.kernel.org/linux-mm/YBkT6175GmMWBvw3@google.com/
> >   On Android, our most advanced simulation that generates memory
> >   pressure from realistic user behavior shows 18% fewer low-memory
> >   kills, which in turn reduces cold starts by 16%. This is on top of
> >   per-process reclaim, a predecessor of ``MADV_COLD`` and
> >   ``MADV_PAGEOUT``, against background apps.
> 
> Thanks, now I see your improvement compared with the per-process
> reclaim.  How about the per-process reclaim compared with the normal
> page reclaiming for the similar test cases?
> 
> My intention behind this is that your solution includes several
> improvements,
> 
> a) take advantage of scheduler information
> b) more fine-grained active/inactive dividing
> c) page table scanning instead of rmap
> 
> Is it possible to evaluate the benefit of the each step?  And is there
> still some potential to optimize the current LRU based algorithm before
> adopting a totally new algorithm?

Well, there isn't really any new algorithm -- it's still the LRU
(algorithm). But I do see your point. In another survey we posted
here:
https://lore.kernel.org/linux-mm/YBkT6175GmMWBvw3@google.com/
we stated:
  Why not try to improve the existing code?
  -----------------------------------------
  We have tried but concluded the two limiting factors [note]_ in the
  existing code are fundamental, and therefore changes made atop them
  will not result in substantial gains on any of the aspects above.

We learned this the hard way.

> > The patches landed not long a ago :) See mm/madvise.c
> 
> :) I'm too out-dated.
> 
> >> So this is an one small step improvement to the current page reclaiming
> >> algorithm via taking advantage of the scheduler information.  It's
> >> clearly not sophisticated as your new algorithm, for example, the cold
> >> pages in the hot processes will not be reclaimed in this stage.  But it
> >> can reduce the overhead of scanning too.
> >
> > The general problems with the direction of per-process reclaim:
> >   1) we can't find the coldest pages, as you have mentioned.
> >   2) we can't reach file pages accessed via file descriptors only,
> >   especially those caching config files that were read only once.
> 
> In theory, this is possible, we can build a inode list based on the
> accessing time too.  Although this may not be necessary.  We can reclaim
> the read-once file cache before the per-process reclaim in theory.

You have to search for unmapped clean pages in page cache. Generally
searching page cache is a lot more expensive than walking lru lists
because page cache can be sparse but lru lists can't.

> >   3) we can't reclaim lru pages and slab objects proportionally and
> >   therefore we leave many stale slab objects behind.
> >   4) we have to be proactive, as you suggested (once again, you were
> >   right), and this has a serious problem: client's battery life can
> >   be affected.
> 
> Why can this not be done reactively? We can start per-process reclaim
> under memory pressure.

Under memory pressure, we could scan a lot of idle processes and find
nothing to reclaim, e.g., mlockall(). In addition, address spaces can
be sparse too.

You are now looking at the direction of cold memory tracking using
page tables, which is not practical. Apparent this series has given
you a bad idea... Page tables are only good at discovering hot memory.
Take my word for it :)

> This has been used in phone and laptop now, so
> there's a solution for this issue?

madvise() is called based on user behavior, which we don't have in
kernel space.

> > The scanning overhead is only one of the two major problems of the
> > current page reclaim. The other problem is the granularity of the
> > active/inactive (sizes). We stopped using them in making job
> > scheduling decision a long time ago. I know another large internet
> > company adopted a similar approach as ours, and I'm wondering how
> > everybody else is coping with the discrepancy from those counters.
> 
> From intuition, the scanning overhead of the full page table scanning
> appears higher than that of the rmap scanning for a small portion of
> system memory.  But form your words, you think the reality is the
> reverse?  If others concern about the overhead too, finally, I think you
> need to prove the overhead of the page table scanning isn't too higher,
> or even lower with more data and theory.

There is a misunderstanding here. I never said anything about full
page table scanning. And this is not how it's done in this series
either. I guess the misunderstanding has something to do with the cold
memory tracking you are thinking about?

This series uses page tables to discover page accesses when a system
has run out of inactive pages. Under such a situation, the system is
very likely to have a lot of page accesses, and using the rmap is
likely to cost a lot more because its poor memory locality compared
with page tables.

But, page tables can be sparse too, in terms of hot memory tracking.
Dave has asked me to test the worst case scenario, which I'll do.
And I'd be happy to share more data. Any specific workload you are
interested in?
