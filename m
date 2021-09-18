Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7472A410488
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhIRG61 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Sep 2021 02:58:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:47115 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232728AbhIRG60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:58:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="245319229"
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="245319229"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 23:57:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="546843351"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 23:57:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        "Keith Busch" <kbusch@kernel.org>
Subject: Re: [PATCH] mm/migrate: fix CPUHP state to update node demotion order
References: <20210918025849.88901-1-ying.huang@intel.com>
        <ccf79d4d-4dd6-14c3-bab6-4fac034d8e22@nextfour.com>
Date:   Sat, 18 Sep 2021 14:56:58 +0800
In-Reply-To: <ccf79d4d-4dd6-14c3-bab6-4fac034d8e22@nextfour.com> ("Mika
        =?utf-8?Q?Penttil=C3=A4=22's?= message of "Sat, 18 Sep 2021 07:04:41
 +0300")
Message-ID: <87bl4qcqx1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Penttilä <mika.penttila@nextfour.com> writes:

> Hi!
>
> On 18.9.2021 5.58, Huang Ying wrote:
>> The node demotion order needs to be updated during CPU hotplug.
>> Because whether a NUMA node has CPU may influence the demotion order.
>> The update function should be called during CPU online/offline after
>> the node_states[N_CPU] has been updated.  That is done in
>> CPUHP_AP_ONLINE_DYN during CPU online and in CPUHP_MM_VMSTAT_DEAD
>> during CPU offline.  But in commit 884a6e5d1f93 ("mm/migrate: update
>> node demotion order on hotplug events"), the function to update node
>> demotion order is called in CPUHP_AP_ONLINE_DYN during CPU
>> online/offline.  This doesn't satisfy the order requirement.  So in
>> this patch, we added CPUHP_AP_MM_DEMOTION_ONLINE and
>> CPUHP_MM_DEMOTION_OFFLINE to be called after CPUHP_AP_ONLINE_DYN and
>> CPUHP_MM_VMSTAT_DEAD during CPU online/offline, and register the
>> update function on them.
>>
>> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Greg Thelen <gthelen@google.com>
>> Cc: Keith Busch <kbusch@kernel.org>
>> ---
>>   include/linux/cpuhotplug.h | 2 ++
>>   mm/migrate.c               | 8 +++++---
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 832d8a74fa59..5a92ea56f21b 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -72,6 +72,7 @@ enum cpuhp_state {
>>   	CPUHP_SLUB_DEAD,
>>   	CPUHP_DEBUG_OBJ_DEAD,
>>   	CPUHP_MM_WRITEBACK_DEAD,
>> +	CPUHP_MM_DEMOTION_OFFLINE,
>>   	CPUHP_MM_VMSTAT_DEAD,
>>   	CPUHP_SOFTIRQ_DEAD,
>>   	CPUHP_NET_MVNETA_DEAD,
>> @@ -240,6 +241,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>>   	CPUHP_AP_ONLINE_DYN,
>>   	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
>> +	CPUHP_AP_MM_DEMOTION_ONLINE,
>>   	CPUHP_AP_X86_HPET_ONLINE,
>>   	CPUHP_AP_X86_KVM_CLK_ONLINE,
>>   	CPUHP_AP_DTPM_CPU_ONLINE,
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a6a7743ee98f..77d107a4577f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -3278,9 +3278,8 @@ static int __init migrate_on_reclaim_init(void)
>>   {
>>   	int ret;
>>   -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on
>> reclaim",
>> -				migration_online_cpu,
>> -				migration_offline_cpu);
>> +	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_OFFLINE, "mm/demotion:offline",
>> +					NULL, migration_offline_cpu);
>>   	/*
>>   	 * In the unlikely case that this fails, the automatic
>>   	 * migration targets may become suboptimal for nodes
>> @@ -3288,6 +3287,9 @@ static int __init migrate_on_reclaim_init(void)
>>   	 * rare case, do not bother trying to do anything special.
>>   	 */
>>   	WARN_ON(ret < 0);
>> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
>> +					migration_online_cpu, NULL);
>>
>
> You changed to _nocalls variant, how does this handle initialization
> for cpus present at boot?

You are right! Thanks!

There are some discussion about CPUHUP in anther thread as follows,

https://lore.kernel.org/lkml/CAAPL-u_Tig1jK=mv_r=j-A-hR3Kpu7txiSFbPR3a8O1qhM1s-Q@mail.gmail.com/

I will wait for discussion in that thread too before the next step.

Best Regards,
Huang, Ying
