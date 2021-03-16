Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0B33CE11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCPGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:44:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:43881 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhCPGon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:44:43 -0400
IronPort-SDR: N7a87IcEWEQouSZ4BhJ6ef8kVvedfRsOY/YOC6E86lEYT+J8A3AvVAnq2ud6p7J9E6pc6ahkz4
 CvvQGNN8h4Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253226886"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253226886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:44:43 -0700
IronPort-SDR: eNmOZakmhI06o2A0kjTHywFOxYoT+vz/BMfSadEOXIQoseu2BtbLhq0M4oALVwjYLdXenMQZjK
 syr4bLsumLVg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="412104182"
Received: from unknown (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:44:38 -0700
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
Date:   Tue, 16 Mar 2021 14:44:31 +0800
In-Reply-To: <YFAsjP7NIZM5Ld+m@google.com> (Yu Zhao's message of "Mon, 15 Mar
        2021 21:57:00 -0600")
Message-ID: <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Tue, Mar 16, 2021 at 10:07:36AM +0800, Huang, Ying wrote:
>> Rik van Riel <riel@surriel.com> writes:
>> 
>> > On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
>> >
>> >> +/*
>> >> + * After pages are faulted in, they become the youngest generation.
>> >> They must
>> >> + * go through aging process twice before they can be evicted. After
>> >> first scan,
>> >> + * their accessed bit set during initial faults are cleared and they
>> >> become the
>> >> + * second youngest generation. And second scan makes sure they
>> >> haven't been used
>> >> + * since the first.
>> >> + */
>> >
>> > I have to wonder if the reductions in OOM kills and 
>> > low-memory tab discards is due to this aging policy
>> > change, rather than from the switch to virtual scanning.
>
> There are no policy changes per se. The current page reclaim also
> scans a faulted-in page at least twice before it can reclaim it.
> That said, the new aging yields a better overall result because it
> discovers every page that has been referenced since the last scan,
> in addition to what Ying has mentioned. The current page scan stops
> stops once it finds enough candidates, which may seem more
> efficiently, but actually pays the price for not finding the best.
>
>> If my understanding were correct, the temperature of the processes is
>> considered in addition to that of the individual pages.  That is, the
>> pages of the processes that haven't been scheduled after the previous
>> scanning will not be scanned.  I guess that this helps OOM kills?
>
> Yes, that's correct.
>
>> If so, how about just take advantage of that information for OOM killing
>> and page reclaiming?  For example, if a process hasn't been scheduled
>> for long time, just reclaim its private pages.
>
> This is how it works. Pages that haven't been scanned grow older
> automatically because those that have been scanned will be tagged with
> younger generation numbers. Eviction does bucket sort based on
> generation numbers and attacks the oldest.

Sorry, my original words are misleading.  What I wanted to say was that
is it good enough that

- Do not change the core algorithm of current page reclaiming.

- Add some new logic to reclaim the process private pages regardless of
  the Accessed bits if the processes are not scheduled for some long
  enough time.  This can be done before the normal page reclaiming.

So this is an one small step improvement to the current page reclaiming
algorithm via taking advantage of the scheduler information.  It's
clearly not sophisticated as your new algorithm, for example, the cold
pages in the hot processes will not be reclaimed in this stage.  But it
can reduce the overhead of scanning too.

All in all, some of your ideas may help the original LRU algorithm too.
Or some can be experimented without replacing the original algorithm.

But from another point of view, your solution can be seen as a kind of
improvement on top of the original LRU algorithm too.  It moves the
recently accessed pages to kind of multiple active lists based on
scanning page tables directly (instead of reversely).

Best Regards,
Huang, Ying

