Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7E339451
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhCLRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:10:35 -0500
Received: from foss.arm.com ([217.140.110.172]:57548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhCLRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:10:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C351063;
        Fri, 12 Mar 2021 09:10:15 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5B0C3F7D7;
        Fri, 12 Mar 2021 09:10:13 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 03/24] x86/resctrl: Add resctrl_arch_get_num_closid()
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-4-james.morse@arm.com>
 <0d34167f-17b6-61f8-aa3e-7d49747ca95a@intel.com>
Message-ID: <6055954e-babb-483a-8ce0-e0e7e07fb531@arm.com>
Date:   Fri, 12 Mar 2021 17:10:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0d34167f-17b6-61f8-aa3e-7d49747ca95a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 19:57, Reinette Chatre wrote:
> On 10/30/2020 9:10 AM, James Morse wrote:
>> resctrl chooses whether to enable CDP, once it does, half the number
>> of closid are available. MPAM doesn't behave like this, an in-kernel user
>> of MPAM could be 'using CDP' while resctrl is not.
>>
>> To move the 'half the closids' behaviour to be part of the core code,
>> each schema would have a num_closids. This may be different from the
>> single resources num_closid if CDP is in use.
>>
>> Add a helper to read the resource's num_closid, this should return the
>> number of closid that the resource supports, regardless of whether CDP
>> is in use.
>>
>> For now return the hw_res->num_closid, which is already adjusted for CDP.
>> Once the CODE/DATA/BOTH resources are merged, resctrl can make the
>> adjustment when copying the value to the schema's num_closid.


>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 97040a54cc9a..5d5b566c4359 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -443,6 +443,11 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource
>> *r)
>>       return NULL;
>>   }
>>   +u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
>> +{
>> +    return resctrl_to_arch_res(r)->num_closid;
>> +}
>> +

> Helper returns the value but also changes the type. Could you please add motivation for
> this in a comment?

That was just sloppiness. The values from the MPAM driver are unsigned, and this saved casts.

I do think any cross-architecture bits should use types like u32 to avoid nasty surprises.
(the value in struct rdtgroup is already unsigned)

I'll do this better, and fix the commit message.


>>   void rdt_ctrl_update(void *arg)
>>   {
>>       struct msr_param *m = arg;

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b55861ff4e34..df10135f021e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -100,15 +100,13 @@ int closids_supported(void)
>>     static void closid_init(void)
>>   {
>> -    struct rdt_hw_resource *hw_res;
>> +    u32 rdt_min_closid = 32;
>>       struct rdt_resource *r;
>> -    int rdt_min_closid = 32;
>>         /* Compute rdt_min_closid across all resources */
>> -    for_each_alloc_enabled_rdt_resource(r) {
>> -        hw_res = resctrl_to_arch_res(r);
>> -        rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
>> -    }
>> +    for_each_alloc_enabled_rdt_resource(r)
>> +        rdt_min_closid = min(rdt_min_closid,
>> +                     resctrl_arch_get_num_closid(r));
>>         closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>>   @@ -847,10 +845,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
>>                   struct seq_file *seq, void *v)
>>   {
>>       struct rdt_resource *r = of->kn->parent->priv;
>> -    struct rdt_hw_resource *hw_res;
>>   -    hw_res = resctrl_to_arch_res(r);
>> -    seq_printf(seq, "%d\n", hw_res->num_closid);
>> +    seq_printf(seq, "%d\n", resctrl_arch_get_num_closid(r));
>>       return 0;
> 
> Now that this type is changed this will need to be %u?

Oops,


>>   diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f5af59b8f2a9..dfb0f32b73a1 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -163,4 +163,7 @@ struct rdt_resource {
>>     };
>>   +/* The number of closid supported by this resource regardless of CDP */
>> +u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>> +
>>   #endif /* _RESCTRL_H */


> The purpose of this change is unclear and introducing confusion. It introduces a helper
> that returns the num_closid associated with a resource but it does not use the helper in
> all the cases where this value is needed. After this change some code uses this new helper
> while other code continue to access the value directly.

This is the split between the bits that are fs/resctrl and architecture-specific emerging.
Those functions that legitimately use struct rdt_hw_resource directly don't need the
helper. e.g. reset_all_ctrls() remains part of the architecture-specific code.

The aim is none of the code in fs/resctrl would ever touch those structs, it would always
use the helper.

I agree the commit message is over-focussed on why you can't reach in and grab a value.


> Could you please elaborate in the commit message why this helper is not used everywhere
> and how the places that were changed were chosen?

These three are obviously part of the filesystem interface:
rdt_num_closids_show()
rdtgroup_parse_resource()
rdtgroup_schemata_show()

closid_init() initialises resctrl's bitmaps, and remains part of the filesystem code.

reset_all_ctrls() is setting up a structure for modifying the hardware, its part of the
architecture code, the maximum closid should be the maximum value the hardware has,
regardless of what was described to resctrl.

Everything in core.c is architecture specifc.


I'll include this list in the commit message.


> Seems like the places that _don't_ need
> the (eventual) value of resctrl_arch_get_num_closid() are changed (so that it is easier to
> move to the schema's num_closid later) while the places that actually do need the helper
> are not changed?

I don't follow this. Yes most of these become a read of the num_closid from the schema
once the CDP correction moves to be part of the filesystem bits of resctrl. Doing this now
removes the arch-specific struct from functions like rdtgroup_parse_resource(), taking one
step closer to a distinction between the arch-specific and filesystem parts of the code.

Yes some lines get changed a second time later in the series, but for a different reason.
I've juggled the patch order, which should avoid this.


Hopefully the list above will have improved the commit message for v2.


Thanks!

James
