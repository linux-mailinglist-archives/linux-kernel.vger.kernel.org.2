Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DAA339542
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:43:53 -0500
Received: from foss.arm.com ([217.140.110.172]:58136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCLRnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:43:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C507A1FB;
        Fri, 12 Mar 2021 09:43:22 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42F903F7D7;
        Fri, 12 Mar 2021 09:43:21 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 12/24] x86/resctrl: Add closid to the staged config
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-13-james.morse@arm.com>
 <136b0a82-7d77-dc08-80ca-5265d4af30fd@intel.com>
Message-ID: <e213926b-01af-403f-3a71-0cb95f6ee7f8@arm.com>
Date:   Fri, 12 Mar 2021 17:43:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <136b0a82-7d77-dc08-80ca-5265d4af30fd@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 23:46, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> Once the L2/L2CODE/L2DATA resources are merged, there may be two
>> configurations staged for one resource when CDP is enabled. The
>> closid should always be passed with the type of configuration to the
>> arch code.
>>
>> Because update_domains() will eventually apply a set of configurations,
>> it should take the closid from the same place, so they pair up.
>>
>> Move the closid to be a staged parameter.
> 
> Move implies that it is taken from one location and added to another. This seems like a
> copy instead?

I'll rephrase it.


>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 0c95ed83eb05..b107c0202cfb 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -72,6 +72,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>       if (!bw_validate(data->buf, &bw_val, r))
>>           return -EINVAL;
>>       cfg->new_ctrl = bw_val;
>> +    cfg->closid = data->rdtgrp->closid;
>>       cfg->have_new_ctrl = true;
>>         return 0;
>> @@ -178,6 +179,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>       }
>>         cfg->new_ctrl = cbm_val;
>> +    cfg->closid = data->rdtgrp->closid;
>>       cfg->have_new_ctrl = true;

> rdtgrp is already available so it could just be:
> cfg->closid = rdtgrp->closid?

Yes, this is just trying to be identical to the earlier version.
I'll change it.


>>       return 0;
>> @@ -245,15 +247,15 @@ static int parse_line(char *line, struct resctrl_schema *s,
>>   }
>>     static void apply_config(struct rdt_hw_domain *hw_dom,
>> -             struct resctrl_staged_config *cfg, int closid,
>> +             struct resctrl_staged_config *cfg,
>>                cpumask_var_t cpu_mask, bool mba_sc)
>>   {
>>       struct rdt_domain *dom = &hw_dom->resctrl;
>>       u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
>>   -    if (cfg->new_ctrl != dc[closid]) {
>> +    if (cfg->new_ctrl != dc[cfg->closid]) {
>>           cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
>> -        dc[closid] = cfg->new_ctrl;
>> +        dc[cfg->closid] = cfg->new_ctrl;
>>       }
>>         cfg->have_new_ctrl = false;
>> @@ -284,7 +286,7 @@ int update_domains(struct rdt_resource *r, int closid)
>>               if (!cfg->have_new_ctrl)
>>                   continue;
>>   -            apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
>> +            apply_config(hw_dom, cfg, cpu_mask, mba_sc);
>>           }
>>       }

> It is not clear to me that storing the closid in the staged config is necessary. A closid
> is associated with a resource group so when the user writes to the schemata file all
> configurations would be (from the resource group perspective) for the same closid. This is
> the value provided here to update domains. Looking ahead in this series this closid is
> later used to compute the index (get_config_index()) that would use as input cfg->closid,
> but that cfg->closid would be identical for all resources/staged configs and then the new
> index would be computed based on the resource type. Having the closid in the staged config
> thus does not seem to be necessary, it could remain as this function parameter and be used
> for all staged configs?

Yes, when emulating CDP with MPAM, these can be two unrelated numbers, but it looks like I
lost track of the 'its always going to be the same value' for each invocation through the
filesystem.

An earlier version tried to push separate code/data closid values further into the resctrl
code, but I thought it was getting too confusing.
The x86 CDP behaviour is either 'configuration is twice the size' or 'an odd even
pair of closid' depending on how you look at it. For MPAM the equivalent feature is an
(arbitary!) pair of closid/partid.

Yes its not necessary for resctrl, I'll see how much of this I can unpick!


Thanks,

James
