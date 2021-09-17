Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA240FE44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbhIQQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:39 -0400
Received: from foss.arm.com ([217.140.110.172]:55592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245049AbhIQQ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B0311B3;
        Fri, 17 Sep 2021 09:58:00 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1343F59C;
        Fri, 17 Sep 2021 09:57:58 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 05/20] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-6-james.morse@arm.com>
 <638a0c73-ed1b-c4d6-f5f2-2af3c2e39a35@intel.com>
Message-ID: <075ebc5d-4a04-b006-dba7-e33e1bf65b03@arm.com>
Date:   Fri, 17 Sep 2021 17:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <638a0c73-ed1b-c4d6-f5f2-2af3c2e39a35@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:22, Reinette Chatre wrote:
> On 7/29/2021 3:35 PM, James Morse wrote:
>> To support resctrl's MBA software controller, the architecture must provide
>> a second configuration array to hold the mbps_val from user-space.
>>
>> This complicates the interface between the architecture code.
> 
> This sentence seems incomplete. I was expecting something like " complicates the interface
> between the architecture code and ..."

Yup, looks like I got distracted while writing that.


>> Make the filesystem parts of resctrl create an array for the mba_sc
>> values when the struct resctrl_schema is created. The software controller
>> can be changed to use this, allowing the architecture code to only
>> consider the values configured in hardware.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index cf0db0b7a5d0..185f9bb992d1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2030,6 +2030,60 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>                    struct rdtgroup *prgrp,
>>                    struct kernfs_node **mon_data_kn);
>>   +static int mba_sc_domain_allocate(struct rdt_resource *res,
>> +                  struct rdt_domain *d)
>> +{
>> +    u32 num_closid = closid_free_map_len;
>> +    int cpu = cpumask_any(&d->cpu_mask);
>> +    int i;
>> +
>> +    d->mba_sc = kcalloc_node(num_closid, sizeof(*d->mba_sc),
>> +                 GFP_KERNEL, cpu_to_node(cpu));
>> +    if (!d->mba_sc)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num_closid; i++)
>> +        d->mba_sc[i].mbps_val = MBA_MAX_MBPS;
>> +
>> +    return 0;
>> +}
>> +
> 
> I had the same initial reaction as Jamie and noted your answer to him. Considering the
> intricate flow here could you please add some comments to these functions that explains
> the calling flows in support of their safety?

After a shuffle to make this allocated at a more obvious time, it has this comment:
|	/*
|	 * d->mbps_val is allocated by a call to this function in set_mba_sc(),
|	 * and domain_setup_mon_state(). Both calls are guarded by is_mba_sc(),
|	 * which can only return true while the filesystem is mounted. The
|	 * two calls are prevented from racing as rdt_get_tree() takes the
|	 * cpuhp read lock before calling rdt_enable_ctx(ctx), which prevents
|	 * it running concurrently with resctrl_online_domain().
|	 */


>>   /**
>>    * struct rdt_domain - group of CPUs sharing a resctrl resource
>>    * @list:        all instances of this resource
>> @@ -53,6 +64,7 @@ struct resctrl_staged_config {
>>    * @cqm_work_cpu:    worker CPU for CQM h/w counters
>>    * @plr:        pseudo-locked region (if any) associated with domain
>>    * @staged_config:    parsed configuration to be applied
>> + * @mba_sc:    the mba software controller properties, indexed by closid
>>    */
>>   struct rdt_domain {
>>       struct list_head        list;
>> @@ -67,6 +79,7 @@ struct rdt_domain {
>>       int                cqm_work_cpu;
>>       struct pseudo_lock_region    *plr;
>>       struct resctrl_staged_config    staged_config[CDP_NUM_TYPES];
>> +    struct resctrl_mba_sc        *mba_sc;
>>   };
> 
> Why is this additional abstraction needed? As I understand the usage struct resctrl_mba_sc
> would always only have the one member so why not have mbps_val within rdt_domain?

Probably because I thought some form of prev_bw/delta_bw would go in here too, once the
variables need to calculate bytes had moved to be part of the architecture specific code.
In the end it didn't make sense because there are two mbm_state arrays, so can't be a
single struct array.

I'll roll it out,


Thanks,

James
