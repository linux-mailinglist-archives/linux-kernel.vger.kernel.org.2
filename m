Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329AF437C94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhJVScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:32:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhJVScd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:32:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9B71396;
        Fri, 22 Oct 2021 11:30:15 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FF53F73D;
        Fri, 22 Oct 2021 11:30:13 -0700 (PDT)
Subject: Re: [PATCH v2 05/23] x86/resctrl: Add domain online callback for
 resctrl work
To:     Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-6-james.morse@arm.com>
 <26c3ef82-6c1f-5852-891a-7ba2e4cfe971@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <73573b55-f852-f9f4-ead8-a0dc498e9f40@arm.com>
Date:   Fri, 22 Oct 2021 19:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <26c3ef82-6c1f-5852-891a-7ba2e4cfe971@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 20/10/2021 00:19, Babu Moger wrote:
> On 10/1/21 11:02 AM, James Morse wrote:
>> Because domains are exposed to user-space via resctrl, the filesystem
>> must update its state when CPU hotplug callbacks are triggered.
>>
>> Some of this work is common to any architecture that would support
>> resctrl, but the work is tied up with the architecture code to
>> allocate the memory.
>>
>> Move domain_setup_mon_state(), the monitor subdir creation call and the
>> mbm/limbo workers into a new resctrl_online_domain() call. These bits
>> are not specific to the architecture. Grouping them in one function
>> allows that code to be moved to /fs/ and re-used by another architecture.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e243c7d15b81..19691f9ab061 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -3236,6 +3233,64 @@ static int __init rdtgroup_setup_root(void)
>>  	return ret;
>>  }
>>  
>> +static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	size_t tsize;
>> +
>> +	if (is_llc_occupancy_enabled()) {
>> +		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
>> +		if (!d->rmid_busy_llc)
>> +			return -ENOMEM;
>> +	}
>> +	if (is_mbm_total_enabled()) {
>> +		tsize = sizeof(*d->mbm_total);
>> +		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> +		if (!d->mbm_total) {
>> +			bitmap_free(d->rmid_busy_llc);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +	if (is_mbm_local_enabled()) {
>> +		tsize = sizeof(*d->mbm_local);
>> +		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> +		if (!d->mbm_local) {
>> +			bitmap_free(d->rmid_busy_llc);
>> +			kfree(d->mbm_total);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	int err;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);

> Looks like lockdep_assert_held was not there in this sequence.
> Are you concerned about this lock not being held?

Its partly paranoia, partly documentation.

This is to document that the caller has to take this mutex, it protects the domain
pointers that are written in domain_setup_mon_state(), and read by __mon_event_count() and
the like.

I have a patch later in the tree that splits the locking done by the arch-code from the
locking done by the filesystem. Today those are both rdtgroup_mutex.



Thanks,

James
