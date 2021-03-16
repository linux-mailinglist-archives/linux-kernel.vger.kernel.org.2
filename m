Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D133CEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhCPH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhCPH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:56:43 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68180C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:56:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f10so11833434ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KK5H1cWLW+T5NeYfSobXbOYYO/Cyw/6ADUsxHBOqG+E=;
        b=YImhSXBrU/IGRXBc5fcSAin0FWnehwYP4u1ZvxnwpV5QTHlTRtUT2/+5bFNlkU5kDl
         efV2YWpCzK6smA2oGGEMfbxaNdhUf/C55X1GNhf98rQ0klXxRpdh+cQFLr1XuUg0Os+Z
         osyoA2iZltmgfWxy5utmAhRGAvn4zoYzLBqU0sWV4yU4Nm+yjft/cgrtS99XB6DDj7w2
         Bs/qRKlw+Ehd9BInyv0R9o9fjy1duV4y9iXs3jkCurzkzw90Dxx34hUAYi8Nc3nkQ4qv
         YEFglgTbhC1NZ68S57B0fGs4Ar30FbADLGzh39HSVQo9n+FXNjldgo9kjFd71E3IiXQ2
         tZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KK5H1cWLW+T5NeYfSobXbOYYO/Cyw/6ADUsxHBOqG+E=;
        b=Z97ngFrRGPCDAT9L96nPAMWY1w99y0a3S6wP59Omp8NQXYPh4q6p3W3v4QdLJXOyn7
         QPd775ps/U83fzTdjm6dLeGujMiHmWZG8ZONiGdhniS+TvesAhheKk0idq3Vtf4dQost
         axDlcvofOtEdZ/pRT+Wf6P+VFvGOFMiBNPt6Y+of0Rc915uhkGAurT4/LwZq0wXmpLAB
         6qVbkk69hgXOaNPEf5+lfxCk7wxYMPHkJStpVHofwulfGjDbV8jrK9Ti3io6f+dT4V85
         /hZQh0XEv6CPyLupfTDo5mQOm14Uzh4TjgyzLgyVQ9mxItP3oM4w7RnvrhWtuYhIHCx1
         4Fnw==
X-Gm-Message-State: AOAM533m7+j/M9E/YGbbdX/MBpvAYxp7YK++w0vz96qFJLwaqUnV9a7R
        haUGvwW50E0UO8IQz5CdiDKZjg==
X-Google-Smtp-Source: ABdhPJwYHVB5on0NjhXmVsCJ3pIl8CkZIs/pszN+sRsq2znkHj1R0l2ImEZZH+ntik+KneWAEyEqvw==
X-Received: by 2002:a92:c6ca:: with SMTP id v10mr2901958ilm.195.1615881402716;
        Tue, 16 Mar 2021 00:56:42 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id b5sm8085688ioq.7.2021.03.16.00.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 00:56:41 -0700 (PDT)
Date:   Tue, 16 Mar 2021 01:56:37 -0600
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
Message-ID: <YFBktbCH9JFcT0rL@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-10-yuzhao@google.com>
 <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
 <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <YFAsjP7NIZM5Ld+m@google.com>
 <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:44:31PM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > On Tue, Mar 16, 2021 at 10:07:36AM +0800, Huang, Ying wrote:
> >> Rik van Riel <riel@surriel.com> writes:
> >> 
> >> > On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
> >> >
> >> >> +/*
> >> >> + * After pages are faulted in, they become the youngest generation.
> >> >> They must
> >> >> + * go through aging process twice before they can be evicted. After
> >> >> first scan,
> >> >> + * their accessed bit set during initial faults are cleared and they
> >> >> become the
> >> >> + * second youngest generation. And second scan makes sure they
> >> >> haven't been used
> >> >> + * since the first.
> >> >> + */
> >> >
> >> > I have to wonder if the reductions in OOM kills and 
> >> > low-memory tab discards is due to this aging policy
> >> > change, rather than from the switch to virtual scanning.
> >
> > There are no policy changes per se. The current page reclaim also
> > scans a faulted-in page at least twice before it can reclaim it.
> > That said, the new aging yields a better overall result because it
> > discovers every page that has been referenced since the last scan,
> > in addition to what Ying has mentioned. The current page scan stops
> > stops once it finds enough candidates, which may seem more
> > efficiently, but actually pays the price for not finding the best.
> >
> >> If my understanding were correct, the temperature of the processes is
> >> considered in addition to that of the individual pages.  That is, the
> >> pages of the processes that haven't been scheduled after the previous
> >> scanning will not be scanned.  I guess that this helps OOM kills?
> >
> > Yes, that's correct.
> >
> >> If so, how about just take advantage of that information for OOM killing
> >> and page reclaiming?  For example, if a process hasn't been scheduled
> >> for long time, just reclaim its private pages.
> >
> > This is how it works. Pages that haven't been scanned grow older
> > automatically because those that have been scanned will be tagged with
> > younger generation numbers. Eviction does bucket sort based on
> > generation numbers and attacks the oldest.
> 
> Sorry, my original words are misleading.  What I wanted to say was that
> is it good enough that
> 
> - Do not change the core algorithm of current page reclaiming.
> 
> - Add some new logic to reclaim the process private pages regardless of
>   the Accessed bits if the processes are not scheduled for some long
>   enough time.  This can be done before the normal page reclaiming.

This is a good idea, which being used on Android and Chrome OS. We
call it per-process reclaim, and I've mentioned here:
https://lore.kernel.org/linux-mm/YBkT6175GmMWBvw3@google.com/
  On Android, our most advanced simulation that generates memory
  pressure from realistic user behavior shows 18% fewer low-memory
  kills, which in turn reduces cold starts by 16%. This is on top of
  per-process reclaim, a predecessor of ``MADV_COLD`` and
  ``MADV_PAGEOUT``, against background apps.

The patches landed not long a ago :) See mm/madvise.c

> So this is an one small step improvement to the current page reclaiming
> algorithm via taking advantage of the scheduler information.  It's
> clearly not sophisticated as your new algorithm, for example, the cold
> pages in the hot processes will not be reclaimed in this stage.  But it
> can reduce the overhead of scanning too.

The general problems with the direction of per-process reclaim:
  1) we can't find the coldest pages, as you have mentioned.
  2) we can't reach file pages accessed via file descriptors only,
  especially those caching config files that were read only once.
  3) we can't reclaim lru pages and slab objects proportionally and
  therefore we leave many stale slab objects behind.
  4) we have to be proactive, as you suggested (once again, you were
  right), and this has a serious problem: client's battery life can
  be affected.

The scanning overhead is only one of the two major problems of the
current page reclaim. The other problem is the granularity of the
active/inactive (sizes). We stopped using them in making job
scheduling decision a long time ago. I know another large internet
company adopted a similar approach as ours, and I'm wondering how
everybody else is coping with the discrepancy from those counters.

> All in all, some of your ideas may help the original LRU algorithm too.
> Or some can be experimented without replacing the original algorithm.
> 
> But from another point of view, your solution can be seen as a kind of
> improvement on top of the original LRU algorithm too.  It moves the
> recently accessed pages to kind of multiple active lists based on
> scanning page tables directly (instead of reversely).

We hope this series can be a framework or an infrastructure flexible
enough that people can build their complex use cases upon, e.g.,
proactive reclaim (machine-wide, not per process), cold memory
estimation (for job scheduling), AEP demotion, specifically, we want
people to use it with what you and Dave are working on here:
https://patchwork.kernel.org/project/linux-mm/cover/20210304235949.7922C1C3@viggo.jf.intel.com/
