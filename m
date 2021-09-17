Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE56540F491
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhIQJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:14:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:7579 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhIQJNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:13:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="219570525"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="219570525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 02:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="509774547"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2021 02:12:12 -0700
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Barry Song <21cnbao@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, peterz@infradead.org, song.bao.hua@hisilicon.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        yangyicong@huawei.com
References: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
 <20210917041539.7862-1-21cnbao@gmail.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <865702ea-b1c1-e39d-94ea-d55bf03b86db@linux.intel.com>
Date:   Fri, 17 Sep 2021 17:11:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210917041539.7862-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 12:15 PM, Barry Song wrote:
>> @@ -4965,6 +4965,7 @@ void scheduler_tick(void)
>>
>>  #ifdef CONFIG_SMP
>> 	rq->idle_balance = idle_cpu(cpu);
>> +	update_idle_cpumask(cpu, rq->idle_balance);
>>  	trigger_load_balance(rq);
>>  #endif
>> }
> 
> might be stupid, a question bothering yicong and me is that why don't we
> choose to update_idle_cpumask() while idle task exits and switches to a
> normal task?

I implemented that way and we discussed before(RFC v1 ?), updating a cpumask
at every enter/exit idle is more expensive than we expected, though it's
per LLC domain, Vincent saw a significant regression IIRC. You can also
take a look at nohz.idle_cpus_mask as a reference.

> for example, before tick comes, cpu has exited from idle, but we are only
> able to update it in tick. this makes idle_cpus_span inaccurate, thus we
> will scan cpu which isn't actually idle in select_idle_sibling.
> is it because of the huge update overhead?
> 

Yes, we'll have false positive but we don't miss true positive. So things
won't be worse than the current way.

Thanks,
-Aubrey
