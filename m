Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42BF3E9969
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHKUM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:12:28 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F9C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:12:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z24so3114192qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dseBtZhhg9TsasXaHWSLbsjrv3u/VkKskBnthNFAxT4=;
        b=hvzuQOAZu6QoXPV3ctaRS+JQBK2U322/9mTsXzYjnDwldMWR9zenMkNZXC50YrigSX
         JqAwY9JGBj1vTZg1ujQZQBFc2cgfTVO/T6CBUaiQzF+Uba8a7Hb9eRYdqBppmT6cia4Z
         rw84fr5+fHMv3f7+TRh04LB3M1alBfygFd3S048oec2VQY3a0Xjn0t362Reb720wqzJe
         6CT4sljeyFyi7w6ZV0/6uBnCoEyYkFd02rwgtmSUGXHc2TNpboGDwLxeM0pkfcZpredt
         RbC39ozGmqI14YoCIMjDt3ft2UjCnhYuuj9oY1UTc5TjXbi2OsoRs9M+cGgS7WnDQL8f
         nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dseBtZhhg9TsasXaHWSLbsjrv3u/VkKskBnthNFAxT4=;
        b=UHWbgz3ZurCKSKK/6UN5ROKJfOVtgzO5FPxnxjMtskaSBvgmoSQmidJQXWWOd7O03E
         d60vH3yuAiLq5MwC91HRXeHj3P1yBNP9t274Rp9k0ajIexonDsJ569evre7pInWVFrWD
         ElG3WgiI/BZv1DWHhdP+JFIhiWF9QMzaciJU8WiVad61/zUJPnTDshnfDchnPdfRhAOy
         c4ij21zGIIhKkqv5h/SeDGjR5AJxaXtd9/lv53ETHlSXfEBtU5Rm2zmJIwiefXUgwzY2
         6WP7qbFm8ZVanTPvDs4dvvoX8o6sA44+h1CZFPFHl2zFhQwEti+OE/W+72MnmJE4WyXV
         PAAA==
X-Gm-Message-State: AOAM530DM8x4ugOvTlJBELqYx7rJhspLVbjr0oryYaTG1zQZleVEpYyn
        tP2wk+rVL+kjH6IkF7hRxt+kTw==
X-Google-Smtp-Source: ABdhPJzNZ9lfXuQCnyXb83m2lGZDVT13lnlDbqNXUjiS8EBWAJYAmyoSK30V7waZFnq1G8iebJ2SwA==
X-Received: by 2002:ac8:e4f:: with SMTP id j15mr476657qti.124.1628712723577;
        Wed, 11 Aug 2021 13:12:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d9fa])
        by smtp.gmail.com with ESMTPSA id j185sm132039qkf.28.2021.08.11.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:12:02 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:12:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <YRQvEbMSUqIkuMnk@cmpxchg.org>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:59:53PM -1000, Linus Torvalds wrote:
> On Tue, Aug 10, 2021 at 4:59 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -36.4% regression of vm-scalability.throughput due to commit:
> > 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
> 
> Hmm. I guess some cost is to be expected, but that's a big regression.
> 
> I'm not sure what the code ends up doing, and how relevant this test
> is, but Johannes - could you please take a look?
> 
> I can't make heads nor tails of the profile. The profile kind of points at this:
> 
> >       2.77 ą 12%     +27.4       30.19 ą  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> >       2.86 ą 12%     +27.4       30.29 ą  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
> >       2.77 ą 12%     +27.4       30.21 ą  8%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
> >       4.26 ą 10%     +28.1       32.32 ą  7%  perf-profile.children.cycles-pp.lru_cache_add
> >       4.15 ą 10%     +28.2       32.33 ą  7%  perf-profile.children.cycles-pp.__pagevec_lru_add
> 
> and that seems to be from the chain __do_fault -> shmem_fault ->
> shmem_getpage_gfp -> lru_cache_add -> __pagevec_lru_add ->
> lock_page_lruvec_irqsave -> _raw_spin_lock_irqsave ->
> native_queued_spin_lock_slowpath.
> 
> That shmem_fault codepath being hot may make sense for sokme VM
> scalability test. But it seems to make little sense when I look at the
> commit that it bisected to.
> 
> We had another report of this commit causing a much more reasonable
> small slowdown (-2.8%) back in May.
> 
> I'm not sure what's up with this new report. Johannes, does this make
> sense to you?
> 
> Is it perhaps another "unlucky cache line placement" thing? Or has the
> statistics changes just changed the behavior of the test?

I'm at a loss as well.

The patch only changes how we aggregate the cgroup's memory.stat file,
it doesn't influence reclaim/LRU operations.

The test itself isn't interacting with memory.stat either - IIRC it
doesn't even run inside a dedicated cgroup in this test
environment. The patch should actually reduce accounting overhead here
because we switched from batched percpu flushing during updates to
only flushing when the stats are *read* - which doesn't happen here.

That would leave cachelines. But the cachelines the patch touched are
in struct mem_cgroup, whereas the lock this profile points out is in a
separately allocated per-node structure. The cache footprint on the
percpu data this test is hammering also didn't increase; it actually
decreased a bit, but not sure where this could cause conflicts.

I'll try to reproduce this on a smaller setup. But I have to say, I've
seen a few of these bisection reports now that didn't seem to make any
sense, which is why I've started to take these with a grain of salt.
