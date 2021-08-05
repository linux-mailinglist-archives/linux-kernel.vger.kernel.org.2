Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773FD3E03FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhHDPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:16:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:23524 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237114AbhHDPQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:16:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="277698232"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="277698232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 08:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="480212795"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2021 08:16:22 -0700
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Mel Gorman <mgorman@techsingularity.net>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        yangyicong <yangyicong@huawei.com>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
 <20210726102247.21437-9-mgorman@techsingularity.net>
 <9dde989df06b483790cc24dc7670a919@hisilicon.com>
 <20210804102613.GC6464@techsingularity.net>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
Date:   Thu, 5 Aug 2021 08:23:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804102613.GC6464@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 6:26 PM, Mel Gorman wrote:
> On Mon, Aug 02, 2021 at 10:41:13AM +0000, Song Bao Hua (Barry Song) wrote:
>> Hi Mel, Aubrey,
>> A similar thing Yicong and me has discussed is having a mask or a count for
>> idle cores. And then we can only scan idle cores in this mask in
>> select_idle_cpu().
>>
> 
> Either approach would require a lot of updates.
> 
>> A obvious problem is that has_idle_cores is a bool, it can seriously lag
>> from the real status. I mean, after system enters the status without idle
>> cores, has_idle_cores could be still true.
>>
> 
> True.
> 
>> Right now, we are setting has_idle_cores to true while cpu enters idle
>> and its smt sibling is also idle. But we are setting has_idle_cores to
>> false only after we scan all cores in a llc.
>>
>> So we have thought for a while to provide an idle core mask. But never
>> really made a workable patch.
>>
>> Mel's patch7/9 limits the number of cores which will be scanned in
>> select_idle_cpu(), it might somehow alleviate the problem we redundantly
>> scan all cores while we actually have no idle core even has_idle_cores
>> is true.
>>
> 
> I prototyped a patch that tracked the location of a known idle core and
> use it as a starting hint for a search. It's cleared if the core is
> selected for use. Unfortunately, it was not a universal win so was
> dropped for the moment but either way, improving the accurate of
> has_idle_cores without being too expensive would be niuce.

The idle core information is already in idle cpu mask, do we have a quick
and cheap way to extract out?


> 
>> However, if we can get idle core mask, it could be also good to
>> select_idle_core()? Maybe after that, we don't have to enforce
>> proportional scan limits while scanning for an idle core?
>>
> 
> To remove the limits entirely, it would have to be very accurate and
> it's hard to see how that can be done without having a heavily updated
> shared cache line.
> 

Bad idea, is it helpful to make a sparse cpu mask for this? :p

Thanks,
-Aubrey

