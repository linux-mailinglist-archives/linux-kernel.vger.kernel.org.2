Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8443E3FFADD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347584AbhICHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:12:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:7207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234713AbhICHMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:12:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198896066"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="198896066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:11:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="533761935"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.90]) ([10.238.4.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:11:35 -0700
Subject: Re: [LKP] Re: [mm] 8cc621d2f4: fio.write_iops -21.8% regression
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Minchan Kim <minchan.kim@gmail.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com> <YK0oQ76zX0uVZCwQ@google.com>
 <5abc4469d16535119818e8e72173398d@codeaurora.org>
From:   "Xing, Zhengjun" <zhengjun.xing@intel.com>
Message-ID: <034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com>
Date:   Fri, 3 Sep 2021 15:11:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5abc4469d16535119818e8e72173398d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

     Do you have time to look at this? I re-test it in  v5.14, the 
regression still existed. Thanks.

On 5/26/2021 12:57 AM, Chris Goldsworthy wrote:
> On 2021-05-25 09:39, Minchan Kim wrote:
>> On Tue, May 25, 2021 at 08:16:03AM -0700, Minchan Kim wrote:
>>
>> < snip >
>>
>>> > > On Thu, May 20, 2021 at 04:31:44PM +0800, kernel test robot wrote:
>>> > > >
>>> > > >
>>> > > > Greeting,
>>> > > >
>>> > > > FYI, we noticed a -21.8% regression of fio.write_iops due to 
>>> commit:
>>> > > >
>>> > > >
>>> > > > commit: 8cc621d2f45ddd3dc664024a647ee7adf48d79a5 ("mm: fs:
>>> > > > invalidate BH LRU during page migration")
>>> > > > 
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>> > > >
>>> > > >
>>> > > > in testcase: fio-basic
>>> > > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 
>>> 6252 CPU
>>> > > > @ 2.10GHz with 256G memory
>>> > > > with following parameters:
>>> > > >
>>> > > >     disk: 2pmem
>>> > > >     fs: ext4
>>> > > >     runtime: 200s
>>> > > >     nr_task: 50%
>>> > > >     time_based: tb
>>> > > >     rw: randwrite
>>> > > >     bs: 4k
>>> > > >     ioengine: libaio
>>> > > >     test_size: 200G
>>> > > >     cpufreq_governor: performance
>>> > > >     ucode: 0x5003006
>>> > > >
>>> > > > test-description: Fio is a tool that will spawn a number of 
>>> threads
>>> > > > or processes doing a particular type of I/O action as 
>>> specified by
>>> > > > the user.
>>> > > > test-url: https://github.com/axboe/fio
>>> > > >
>>> > > >
>>> > > >
>>> > > > If you fix the issue, kindly add following tag
>>> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
>>> > > >
>>> > > >
>>> > > > Details are as below:
>>> > > > 
>>> -------------------------------------------------------------------------------------------------->
>>> > > >
>>> > > >
>>> > > > To reproduce:
>>> > > >
>>> > > >         git clone https://github.com/intel/lkp-tests.git
>>> > > >         cd lkp-tests
>>> > > >         bin/lkp install job.yaml  # job file is
>>> > > > attached in this email
>>> > > >         bin/lkp split-job --compatible job.yaml  # generate 
>>> the yaml
>>> > > > file for lkp run
>>> > > >         bin/lkp run generated-yaml-file
>>> > >
>>> > > Hi,
>>> > >
>>> > > I tried to insall the lkp-test in my machine by following above 
>>> guide
>>> > > but failed
>>> > > due to package problems(I guess it's my problem since I use 
>>> something
>>> > > particular
>>> > > environement). However, I guess it comes from increased miss 
>>> ratio of
>>> > > bh_lrus
>>> > > since the patch caused more frequent invalidation of the bh_lrus 
>>> calls
>>> > > compared
>>> > > to old. For example, lru_add_drain could be called from several hot
>>> > > places(e.g.,
>>> > > unmap and pagevec_release from several path) and it could keeps
>>> > > invalidating
>>> > > bh_lrus.
>>> > >
>>> > > IMO, we should move the overhead from such hot path to cold one. 
>>> How
>>> > > about this?
>>> > >
>>> > > From ebf4ede1cf32fb14d85f0015a3693cb8e1b8dbfe Mon Sep 17 
>>> 00:00:00 2001
>>> > > From: Minchan Kim <minchan@kernel.org>
>>> > > Date: Thu, 20 May 2021 11:17:56 -0700
>>> > > Subject: [PATCH] invalidate bh_lrus only at lru_add_drain_all
>>> > >
>>> > > Not-Yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
>>> > > ---
>>> > >  mm/swap.c | 15 +++++++++++++--
>>> > >  1 file changed, 13 insertions(+), 2 deletions(-)
>>> > >
>>> > > diff --git a/mm/swap.c b/mm/swap.c
>>> > > index dfb48cf9c2c9..d6168449e28c 100644
>>> > > --- a/mm/swap.c
>>> > > +++ b/mm/swap.c
>>> > > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>>> > >          pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>>> > >
>>> > >      activate_page_drain(cpu);
>>> > > -    invalidate_bh_lrus_cpu(cpu);
>>> > >  }
>>> > >
>>> > >  /**
>>> > > @@ -725,6 +724,17 @@ void lru_add_drain(void)
>>> > >      local_unlock(&lru_pvecs.lock);
>>> > >  }
>>> > >
>>> > > +void lru_and_bh_lrus_drain(void)
>>> > > +{
>>> > > +    int cpu;
>>> > > +
>>> > > +    local_lock(&lru_pvecs.lock);
>>> > > +    cpu = smp_processor_id();
>>> > > +    lru_add_drain_cpu(cpu);
>>> > > +    local_unlock(&lru_pvecs.lock);
>>> > > +    invalidate_bh_lrus_cpu(cpu);
>>> > > +}
>>> > > +
>>> >
>>> > Nit: drop int cpu?
>>>
>>> Do you mean to suggest using smp_processor_id at both places
>>> instead of local varaible? Since the invalidate_bh_lrus_cpu
>>> is called out of the lru_pvecs.lock, I wanted to express
>>> the draining happens at the same CPU via storing the CPU.
>>>
>>> >
>>> > >  void lru_add_drain_cpu_zone(struct zone *zone)
>>> > >  {
>>> > >      local_lock(&lru_pvecs.lock);
>>> > > @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
>>> > > lru_add_drain_work);
>>> > >
>>> > >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>>> > >  {
>>> > > -    lru_add_drain();
>>> > > +    lru_and_bh_lrus_drain();
>>> > >  }
>>> > >
>>> > >  /*
>>> > > @@ -881,6 +891,7 @@ void lru_cache_disable(void)
>>> > >      __lru_add_drain_all(true);
>>> > >  #else
>>> > >      lru_add_drain();
>>> > > +    invalidate_bh_lrus_cpu(smp_processor_id());
>>> > >  #endif
>>> > >  }
>>> >
>>> > Can't we replace the call to lru_add_drain() and
>>> > invalidate_bh_lrus_cpu(smp_processor_id()) with a single call to
>>> > lru_and_bh_lrus_drain()?
>>>
>>> Good idea.
>>
>> From 8caadeb49d82403a08643dfbdb0b7749017c00bb Mon Sep 17 00:00:00 2001
>> From: Minchan Kim <minchan@kernel.org>
>> Date: Tue, 25 May 2021 08:19:17 -0700
>> Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path
>>
>> kernel test robot reported the regression of fio.write_iops[1]
>> with [2].
>>
>> Since lru_add_drain is called frequently, invalidate bh_lrus
>> there could increase bh_lrus cache miss ratio, which needs
>> more IO in the end.
>>
>> This patch moves the bh_lrus invalidation from the hot path(
>> e.g., zap_page_range, pagevec_release) to cold path(i.e.,
>> lru_add_drain_all, lru_cache_disable).
>>
>> [1] 
>> https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
>> [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
>> Cc: Xing, Zhengjun <zhengjun.xing@intel.com>
>> Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>> ---
>>  mm/swap.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 1958d5feb148..3e25d99a9dbb 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>>          pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>>
>>      activate_page_drain(cpu);
>> -    invalidate_bh_lrus_cpu(cpu);
>>  }
>>
>>  /**
>> @@ -725,6 +724,17 @@ void lru_add_drain(void)
>>      local_unlock(&lru_pvecs.lock);
>>  }
>>
>> +static void lru_add_and_bh_lrus_drain(void)
>> +{
>> +    int cpu;
>> +
>> +    local_lock(&lru_pvecs.lock);
>> +    cpu = smp_processor_id();
>> +    lru_add_drain_cpu(cpu);
>> +    local_unlock(&lru_pvecs.lock);
>> +    invalidate_bh_lrus_cpu(cpu);
>> +}
>> +
>>  void lru_add_drain_cpu_zone(struct zone *zone)
>>  {
>>      local_lock(&lru_pvecs.lock);
>> @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
>> lru_add_drain_work);
>>
>>  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>>  {
>> -    lru_add_drain();
>> +    lru_add_and_bh_lrus_drain();
>>  }
>>
>>  /*
>> @@ -880,7 +890,7 @@ void lru_cache_disable(void)
>>       */
>>      __lru_add_drain_all(true);
>>  #else
>> -    lru_add_drain();
>> +    lru_add_and_bh_lrus_drain();
>>  #endif
>>  }
>
> Feel free to add:
> Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
>

-- 
Zhengjun Xing

