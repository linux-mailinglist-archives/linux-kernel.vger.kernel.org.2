Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7134372A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCVDOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:14:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:24674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhCVDN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:13:27 -0400
IronPort-SDR: BLE0mVBP+FeTbiU2ne39wDP5cxuQpc5rDmDJTZFjIcvUHwHsuC0qTaI6dC/oOGjlQNLHy2JK9W
 Ehoq+NELchrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="254191365"
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="254191365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 20:13:26 -0700
IronPort-SDR: 1j5/k/g9sMSsv+ysJsfdJdEbLkPi70nu7bKR0oSj4cs1yuGzOMHsVlEP6ndoNmfnwpah2kgHrs
 +WLhm1Hd6cag==
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="414308295"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 20:13:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
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
References: <20210313075747.3781593-1-yuzhao@google.com>
        <20210313075747.3781593-10-yuzhao@google.com>
        <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
        <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFAsjP7NIZM5Ld+m@google.com>
        <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFBktbCH9JFcT0rL@google.com>
        <87o8fixxfh.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFHeFslZ85/h3o/q@google.com>
Date:   Mon, 22 Mar 2021 11:13:19 +0800
In-Reply-To: <YFHeFslZ85/h3o/q@google.com> (Yu Zhao's message of "Wed, 17 Mar
        2021 04:46:46 -0600")
Message-ID: <87czvryj74.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Mar 17, 2021 at 11:37:38AM +0800, Huang, Ying wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> 
>> > On Tue, Mar 16, 2021 at 02:44:31PM +0800, Huang, Ying wrote:
>> > The scanning overhead is only one of the two major problems of the
>> > current page reclaim. The other problem is the granularity of the
>> > active/inactive (sizes). We stopped using them in making job
>> > scheduling decision a long time ago. I know another large internet
>> > company adopted a similar approach as ours, and I'm wondering how
>> > everybody else is coping with the discrepancy from those counters.
>> 
>> From intuition, the scanning overhead of the full page table scanning
>> appears higher than that of the rmap scanning for a small portion of
>> system memory.  But form your words, you think the reality is the
>> reverse?  If others concern about the overhead too, finally, I think you
>> need to prove the overhead of the page table scanning isn't too higher,
>> or even lower with more data and theory.
>
> There is a misunderstanding here. I never said anything about full
> page table scanning. And this is not how it's done in this series
> either. I guess the misunderstanding has something to do with the cold
> memory tracking you are thinking about?

If my understanding were correct, from the following code path in your
patch 10/14,

age_active_anon
  age_lru_gens
    try_walk_mm_list
      walk_mm_list
        walk_mm

So, in kswapd(), the page tables of many processes may be scanned
fully.  If the number of processes that are active are high, the
overhead may be high too.

> This series uses page tables to discover page accesses when a system
> has run out of inactive pages. Under such a situation, the system is
> very likely to have a lot of page accesses, and using the rmap is
> likely to cost a lot more because its poor memory locality compared
> with page tables.

This is the theory.  Can you verify this with more data?  Including the
CPU cycles or time spent scanning page tables?

> But, page tables can be sparse too, in terms of hot memory tracking.
> Dave has asked me to test the worst case scenario, which I'll do.
> And I'd be happy to share more data. Any specific workload you are
> interested in?

We can start with some simple workloads that are easier to be reasoned.
For example,

1. Run the workload with hot and cold pages, when the free memory
becomes lower than the low watermark, kswapd will be waken up to scan
and reclaim some cold pages.  How long will it take to do that?  It's
expected that almost all pages need to be scanned, so that page table
scanning is expected to have less overhead.  We can measure how well it
is.

2. Run the workload with hot and cold pages, if the whole working-set
cannot fit in DRAM, that is, the cold pages will be reclaimed and
swapped in regularly (for example tens MB/s).  It's expected that less
pages may be scanned with rmap, but the speed of page table scanning is
faster.

3. Run the workload with hot and cold pages, the system is
overcommitted, that is, some cold pages will be placed in swap.  But the
cold pages are cold enough, so there's almost no thrashing.  Then the
hot working-set of the workload changes, that is, some hot pages become
cold, while some cold pages becomes hot, so page reclaiming and swapin
will be triggered.

For each cases, we can use some different parameters.  And we can
measure something like the number of pages scanned, the time taken to
scan them, the number of page reclaimed and swapped in, etc.

Best Regards,
Huang, Ying
