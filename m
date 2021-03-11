Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57925336E43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhCKIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:53:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:53102 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhCKIwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:52:54 -0500
IronPort-SDR: //5I95iAgZOVs3K3btG2fUa3odfCKTJ2vOQy+YiGFUHgqJbVisixxz3flisA/OhhcRyIYD1Kjp
 TNtYCONN6+yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175748252"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="175748252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:52:50 -0800
IronPort-SDR: W+qFg0eWwfOI4rWoPmPB+dSnRTtJZL/4f3zCci8E3l2BBsarZFzkG7nmBfpq1GfTrVAyUl7J6B
 ZL6L14FCK2Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="409416800"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.130])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 00:52:47 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] vmscan: retry without cache trim mode if nothing scanned
References: <20210311004449.1170308-1-ying.huang@intel.com>
        <CALvZod7QNEXdKCJ3H3eoZKsRj5jtOESkmHm1dTC-ZjSBAcW7ng@mail.gmail.com>
Date:   Thu, 11 Mar 2021 16:52:47 +0800
In-Reply-To: <CALvZod7QNEXdKCJ3H3eoZKsRj5jtOESkmHm1dTC-ZjSBAcW7ng@mail.gmail.com>
        (Shakeel Butt's message of "Wed, 10 Mar 2021 16:57:49 -0800")
Message-ID: <87v99yvzq8.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Butt,

Shakeel Butt <shakeelb@google.com> writes:

> On Wed, Mar 10, 2021 at 4:47 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> From: Huang Ying <ying.huang@intel.com>
>>
>> In shrink_node(), to determine whether to enable cache trim mode, the
>> LRU size is gotten via lruvec_page_state().  That gets the value from
>> a per-CPU counter (mem_cgroup_per_node->lruvec_stat[]).  The error of
>> the per-CPU counter from CPU local counting and the descendant memory
>> cgroups may cause some issues.  We run into this in 0-Day performance
>> test.
>>
>> 0-Day uses the RAM file system as root file system, so the number of
>> the reclaimable file pages is very small.  In the swap testing, the
>> inactive file LRU list will become almost empty soon.  But the size of
>> the inactive file LRU list gotten from the per-CPU counter may keep a
>> much larger value (say, 33, 50, etc.).  This will enable cache trim
>> mode, but nothing can be scanned in fact.  The following pattern
>> repeats for long time in the test,
>>
>> priority        inactive_file_size      cache_trim_mode
>> 12              33                      0
>> 11              33                      0
>> ...
>> 6               33                      0
>> 5               33                      1
>> ...
>> 1               33                      1
>>
>> That is, the cache_trim_mode will be enabled wrongly when the scan
>> priority decreases to 5.  And the problem will not be recovered for
>> long time.
>>
>> It's hard to get the more accurate size of the inactive file list
>> without much more overhead.  And it's hard to estimate the error of
>> the per-CPU counter too, because there may be many descendant memory
>> cgroups.  But after the actual scanning, if nothing can be scanned
>> with the cache trim mode, it should be wrong to enable the cache trim
>> mode.  So we can retry with the cache trim mode disabled.  This patch
>> implement this policy.
>
> Instead of playing with the already complicated heuristics, we should
> improve the accuracy of the lruvec stats. Johannes already fixed the
> memcg stats using rstat infrastructure and Tejun has suggestions on
> how to use rstat infrastructure efficiently for lruvec stats at
> https://lore.kernel.org/linux-mm/YCFgr300eRiEZwpL@slm.duckdns.org/.

Thanks for your information!  It should be better if we can improve the
accuracy of lruvec stats without much overhead.  But that may be not a
easy task.

If my understanding were correct, what Tejun suggested is to add a fast
read interface to rstat to be used in hot path.  And its accuracy is
similar as that of traditional per-CPU counter.  But if we can regularly
update the lruvec rstat with something like vmstat_update(), that should
be OK for the issue described in this patch.

Best Regards,
Huang, Ying
