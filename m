Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8906A43CF01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbhJ0Qw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:52:28 -0400
Received: from foss.arm.com ([217.140.110.172]:45370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243009AbhJ0Qw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FF94ED1;
        Wed, 27 Oct 2021 09:50:01 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 786063F70D;
        Wed, 27 Oct 2021 09:49:59 -0700 (PDT)
Subject: Re: [PATCH v2 13/23] x86/resctrl: Allow update_mba_bw() to update
 controls directly
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-14-james.morse@arm.com>
 <777770fa-c2fb-f091-13f8-a204869d8ab5@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6ab52eb2-4f21-e018-0c9d-0ab35c12658d@arm.com>
Date:   Wed, 27 Oct 2021 17:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <777770fa-c2fb-f091-13f8-a204869d8ab5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:28, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 9f45207a6c74..25baacd331e0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -282,6 +282,27 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
>>       return false;
>>   }
>>   +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>> +                u32 closid, enum resctrl_conf_type t, u32 cfg_val)
>> +{
>> +    struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +    u32 idx = get_config_index(closid, t);
>> +    struct msr_param msr_param;
>> +
>> +    if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>> +        return -EINVAL;
>> +
>> +    hw_dom->ctrl_val[idx] = cfg_val;
>> +
>> +    msr_param.res = r;
>> +    msr_param.low = idx;
>> +    msr_param.high = idx + 1;
>> +
>> +    rdt_ctrl_update(&msr_param);
>> +
> 
> rdt_ctrl_update() will take its parameters and recompute the domain that is already
> available here ... seems to take a few steps back and then do the needed. Could msr_update
> be called directly here instead?

Even better!


Thanks,

James
