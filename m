Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A93FCB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhHaQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:26:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhHaQ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69AD06D;
        Tue, 31 Aug 2021 09:25:10 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417CF3F766;
        Tue, 31 Aug 2021 09:25:08 -0700 (PDT)
Subject: Re: [PATCH v1 12/20] x86/recstrl: Add per-rmid arch private storage
 for overflow and chunks
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
 <20210729223610.29373-13-james.morse@arm.com> <YRQFY+/vwsfTBeTd@hazel>
From:   James Morse <james.morse@arm.com>
Message-ID: <5caa74a5-a73d-a5ce-9169-396ad3727386@arm.com>
Date:   Tue, 31 Aug 2021 17:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YRQFY+/vwsfTBeTd@hazel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On 11/08/2021 18:14, Jamie Iles wrote:
> On Thu, Jul 29, 2021 at 10:36:02PM +0000, James Morse wrote:
>> resctrl_arch_rmid_read() is intended as the function that an
>> architecture agnostic resctrl filesystem driver can use to
>> read a value in bytes from a counter. Currently the function returns
>> the mbm values in chunks directly from hardware. For bandwidth
>> counters the resctrl filesystem provides the number of bytes
>> ever seen. Internally mba_sc uses a second prev_bw_msr to calculate
>> the bytes read since the last mba_sc invocation.
>>
>> MPAM's scaling of counters can be changed at runtime, reducing the
>> resolution but increasing the range. When this is changed the prev_msr
>> values need to be converted by the architecture code.
>>
>> Add storage for per-rmid private storage. The prev_msr and chunks
>> values will move here to allow resctrl_arch_rmid_read() to always
>> return the number of bytes read by this counter.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 8a3c13c6c19f..27c93d12ca27 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -432,6 +432,28 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)

>> +static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>> +{
>> +	size_t tsize;
>> +
>> +	if (is_mbm_total_enabled()) {
>> +		tsize = sizeof(*hw_dom->arch_mbm_total);
>> +		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
>> +		if (!hw_dom->arch_mbm_total)
>> +			return -ENOMEM;
>> +	}
>> +	if (is_mbm_local_enabled()) {
>> +		tsize = sizeof(*hw_dom->arch_mbm_local);
>> +		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
>> +		if (!hw_dom->arch_mbm_local) {
>> +			kfree(hw_dom->arch_mbm_total);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +

>> @@ -481,6 +503,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>  		return;
>>  	}
>>  
>> +	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>> +		kfree(d);
> 
> Does this error path and subsequent ones in domain_add_cpu also need to 
> undo the allocations from arch_domain_mbm_alloc?

This one needs to free the ctrl_val array, as does the path from resctrl_online_domain().
Yes, resctrl_online_domain() needs to free the two mbm arrays. Thanks!

Its probably cleanest to add some helper in patch 3 that kfree()s anything that might have
been allocated, and add-to/remote-from that over time. The root structure is kzalloc()d ,
so shouldn't need an elaborate and verbose unwind/goto-nest.


Thanks,

James
