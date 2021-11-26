Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF045E90C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353280AbhKZISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:18:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245061AbhKZIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:16:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D3C62212BE;
        Fri, 26 Nov 2021 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637914378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ua0rBLw8yMpkW2HLi3jHWYnyPiVI4NNJN3p9/B3y9s4=;
        b=UmvBkqt0lj5+Fgh0MMELE8rCv+KKdsojs+C+3ixFhsIH0s4g6pao9D5Iu4c8EVGr0uuP8C
        4tiD0kRX0jD2hWi//DKZTirv4d5cFg/b4J2BkonMJTAxzWJWxV5/MU6Aae73kIrqqPP1qI
        kOueYEXXZJeZUb8R0wjq5sl8joLDgbM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45A17A3B81;
        Fri, 26 Nov 2021 08:12:58 +0000 (UTC)
Date:   Fri, 26 Nov 2021 09:12:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [memcg, kmem]  58056f7750:  hackbench.throughput 10.3%
 improvement
Message-ID: <YaCXCJc4TD5YpDXX@dhcp22.suse.cz>
References: <20211124083435.GB18309@xsang-OptiPlex-9020>
 <YZ5v2LZlpzHieq/+@dhcp22.suse.cz>
 <20211126031748.GA11450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126031748.GA11450@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-11-21 11:17:48, Oliver Sang wrote:
> Hi Michal Hocko,
> 
> On Wed, Nov 24, 2021 at 06:01:12PM +0100, Michal Hocko wrote:
> > On Wed 24-11-21 16:34:35, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a 10.3% improvement of hackbench.throughput due to commit:
> > > 
> > > 
> > > commit: 58056f77502f3567b760c9a8fc8d2e9081515b2d ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > I am really surprised to see an improvement from this patch. I do not
> > expect your benchmarking would be using kmem limit. The above patch
> > hasn't really removed the page counter out of the picture so there
> > shouldn't be any real reason for performance improvement. I strongly
> > suspect this is just some benchmark artifact or unreliable evaluation.
> 
> Fengwei Yin helped further analyze this improvement.
> 
> The patch changed the behavior of function obj_cgroup_charge_pages. It's shown
> in the perf-callstack as following line:
> 
>    5.63 ± 11%      -5.6        0.00        perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
> 
> So Fengwei prepared a patch which reverting the changes in
> obj_cgroup_charge_pages in 58056f7750 (as attached mod.patch)
> 
> by this patch, the performance is similar to 16f6bf266c, the improvement
> disappear.

I am still quite surprised and do not understand it. The only practical
difference the said commit has done is
s@page_counter_try_charge@page_counter_charge@

Withtout a limit in place the try_charge always succeeds. There
should be only a single if (new > c->max) branch executed and always
false.
The code is also slightly larger but all that sounds like to little to
make such a larger change. Maybe this is some microarchitecture specific
result. Or can you reproduce on other HW as well.

-- 
Michal Hocko
SUSE Labs
