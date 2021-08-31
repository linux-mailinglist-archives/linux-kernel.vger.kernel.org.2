Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF043FCB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhHaQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:25:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhHaQZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:25:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 359606D;
        Tue, 31 Aug 2021 09:24:13 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 118043F766;
        Tue, 31 Aug 2021 09:24:10 -0700 (PDT)
Subject: Re: [PATCH v1 05/20] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
To:     Jamie Iles <jamie@nuviainc.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-6-james.morse@arm.com> <YRP7g5/T2kJ9BypS@hazel>
From:   James Morse <james.morse@arm.com>
Message-ID: <10e2bb45-30a8-a7ce-7005-f12b594b991d@arm.com>
Date:   Tue, 31 Aug 2021 17:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YRP7g5/T2kJ9BypS@hazel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On 11/08/2021 17:32, Jamie Iles wrote:
> On Thu, Jul 29, 2021 at 10:35:55PM +0000, James Morse wrote:
>> To support resctrl's MBA software controller, the architecture must provide
>> a second configuration array to hold the mbps_val from user-space.
>>
>> This complicates the interface between the architecture code.
>>
>> Make the filesystem parts of resctrl create an array for the mba_sc
>> values when the struct resctrl_schema is created. The software controller
>> can be changed to use this, allowing the architecture code to only
>> consider the values configured in hardware.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index cf0db0b7a5d0..185f9bb992d1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2030,6 +2030,60 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>  			     struct rdtgroup *prgrp,
>>  			     struct kernfs_node **mon_data_kn);
>>  
>> +static int mba_sc_domain_allocate(struct rdt_resource *res,
>> +				  struct rdt_domain *d)
>> +{
>> +	u32 num_closid = closid_free_map_len;
>> +	int cpu = cpumask_any(&d->cpu_mask);
>> +	int i;
>> +
>> +	d->mba_sc = kcalloc_node(num_closid, sizeof(*d->mba_sc),
>> +				 GFP_KERNEL, cpu_to_node(cpu));
>> +	if (!d->mba_sc)
>> +		return -ENOMEM;
> 
> If a CPU was hotplugged before resctrl is mounted then isn't it possible 
> for this to already be allocated?  I might be misunderstanding the flows 
> here though...

Yeah, its tortuous. All this is behind an is_mba_sc(r), check, which can only return true
while the filesystem is mounted. cpus_read_lock() is what ensures the mount-time setup
doesn't race with the hotplug callbacks.


>> +	for (i = 0; i < num_closid; i++)
>> +		d->mba_sc[i].mbps_val = MBA_MAX_MBPS;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mba_sc_allocate(struct rdt_resource *r)
>> +{
>> +	struct rdt_domain *d;
>> +	int ret;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	if (!is_mba_sc(r))
>> +		return 0;
>> +
>> +	list_for_each_entry(d, &r->domains, list) {
>> +		ret = mba_sc_domain_allocate(r, d);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}


>> @@ -3287,6 +3353,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>>  		}
>>  	}
>>  
>> +	if (is_mba_sc(r))
>> +		mba_sc_domain_allocate(r, d);
> 
> This looks to be missing an error check.

Fixed, thanks.

James
