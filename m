Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4759840FE41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbhIQQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244985AbhIQQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB651063;
        Fri, 17 Sep 2021 09:57:55 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1243F99C;
        Fri, 17 Sep 2021 09:57:52 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 07/20] x86/resctrl: Remove architecture copy of
 mbps_val
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
 <20210729223610.29373-8-james.morse@arm.com>
 <d52bee12-5c6c-04da-3044-7121a2c15f12@intel.com>
Message-ID: <2dd5ef98-9734-d1c4-e165-a290b5bcd1a7@arm.com>
Date:   Fri, 17 Sep 2021 17:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d52bee12-5c6c-04da-3044-7121a2c15f12@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:26, Reinette Chatre wrote:
> On 7/29/2021 3:35 PM, James Morse wrote:
>> The resctrl arch code provides a second configuration array mbps_val[]
>> for the mba socftware controller.
> 
> "mba socftware" -> "MBA software"

(fixed)

>> Since resctrl switched over to allocating and freeing its own array
>> when needed, nothing uses the arch code version.
>>
>> Remove it.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 56b3541617b5..e864dbc6fe3d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c

>> @@ -406,12 +406,9 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>>        * Initialize the Control MSRs to having no control.
>>        * For Cache Allocation: Set all bits in cbm
>>        * For Memory Allocation: Set b/w requested to 100%
>> -     * and the bandwidth in MBps to U32_MAX
>>        */
>> -    for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
>> +    for (i = 0; i < hw_res->num_closid; i++, dc++)
>>           *dc = r->default_ctrl;
>> -        *dm = MBA_MAX_MBPS;
>> -    }
> 
> Since this function used to reset the array to default I was expecting its callers to now
> reset the new array (more below).

dm/mbps_val? Its initialised when its allocated by mba_sc_domain_allocate() when the
filesystem is mounted, or the domain online callback is made.


>>   }
>>     static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 185f9bb992d1..297c20491549 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1906,7 +1906,7 @@ static int set_mba_sc(bool mba_sc)
>>       r->membw.mba_sc = mba_sc;
>>       list_for_each_entry(d, &r->domains, list) {
>>           hw_dom = resctrl_to_arch_dom(d);
>> -        setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
>> +        setup_default_ctrlval(r, hw_dom->ctrl_val);
>>       }
>>   
> 
> I am wondering why new array is not reset instead of original at this call site?

set_mba_sc() doesn't need to. During mount mba_sc is set to true in rdt_enable_ctx(),
which is before the mbps_val[] array is allocated. Once its allocated, its initialised.
While the filesystem is mounted, and domains come and go, the array is re-allocated and
re-initialised. On unmount, the array is freed when the schemata list is destroyed.

I think moving the allocation/free into set_mba_sc() will make this clearer.

> oh ... I
> see it is removed in following patch BUT it mentions that it is ok because
> reset_all_ctrls() does similar reset ... but it does not seem to do so for mbps_val.

That is about the ctrl_val[] array. The reset_all_ctrls() call should reset the hardware
that the arch code looks after. After these changes the mbps_val[] array is a resctrl
filesystem thing that the arch code doesn't need to know anything about.


Thanks,

James
