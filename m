Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4126833953E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhCLRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:41:42 -0500
Received: from foss.arm.com ([217.140.110.172]:58084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhCLRlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:41:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930CC1FB;
        Fri, 12 Mar 2021 09:41:36 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFA33F7D7;
        Fri, 12 Mar 2021 09:41:34 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 11/24] x86/resctrl: Group staged configuration into a
 separate struct
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-12-james.morse@arm.com>
 <28586ec7-608f-4857-19f9-f9a9d5c927f5@intel.com>
Message-ID: <867f26b9-cd03-fa32-ba7a-038a7873435b@arm.com>
Date:   Fri, 12 Mar 2021 17:41:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <28586ec7-608f-4857-19f9-f9a9d5c927f5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 23:28, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> Arm's MPAM may have surprisingly large bitmaps for its cache
>> portions as the architecture allows up to 4K portions. The size
>> exposed via resctrl may not be the same, some scaling may
>> occur.
>>
>> The values written to hardware may be unlike the values received
>> from resctrl, e.g. MBA percentages may be backed by a bitmap,
>> or a maximum value that isn't a percentage.
>>
>> Today resctrl's ctrlval arrays are written to directly by the

> If using a cryptic word like "ctrlval" it would be easier to understand what is meant if
> it matches the variable in the code, "ctrl_val".

I thought the non-underscore version was the preferred version, e.g:
setup_default_ctrlval(), domain_setup_ctrlval() and parse_ctrlval. I'll switch to the
underscore version for things other than functions if you think its clearer.


>> resctrl filesystem code. e.g. apply_config(). This is a problem
> 
> This sentence starts with "Today" implying what code does before this change but the
> example function, apply_config() is introduced in this patch.

I don't follow the problem here, 'today' refers to what the code does before the patch is
applied. "Before this patch" would make me unpopular, I'll try 'previously'.


>> if scaling or conversion is needed by the architecture.
>>
>> The arch code should own the ctrlval array (to allow scaling and
>> conversion), and should only need a single copy of the array for the
>> values currently applied in hardware.

> ok, but that is the case, no?

Its true for x86. But whether its true for MPAM depends on which side of the divide this
thing lands as the value from user-space may be different to what gets written to hardware.
If the filesystem code owned the list of values, there would need to be two copies to
allow MPAM to restore the values in hardware when CPUs come online.

(in particular, the MBA percentage control can be emulated with MPAMs bitmap or fractional
min/max, the driver has to choose at startup).

I'll try and bundle this as a clearer explanation into the commit message.


>> Move the new_ctrl bitmap value and flag into a struct for staged
>> configuration changes. This is created as an array to allow one per type
> 
> This is a bit cryptic as the reader may not know while reading this commit message what
> "new_ctrl" is or where it is currently hosted.

Sure, I'll add more explanation of the current code.


>> of configuration. Today there is only one element in the array, but
>> eventually resctrl will use the array slots for CODE/DATA/BOTH to detect
>> a duplicate schema being written.


>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 28d69c78c29e..0c95ed83eb05 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> 
> ...
> 
>> @@ -240,15 +244,30 @@ static int parse_line(char *line, struct resctrl_schema *s,
>>       return -EINVAL;
>>   }
>>   +static void apply_config(struct rdt_hw_domain *hw_dom,
>> +             struct resctrl_staged_config *cfg, int closid,
>> +             cpumask_var_t cpu_mask, bool mba_sc)
>> +{
>> +    struct rdt_domain *dom = &hw_dom->resctrl;
>> +    u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
>> +
>> +    if (cfg->new_ctrl != dc[closid]) {
>> +        cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
>> +        dc[closid] = cfg->new_ctrl;
>> +    }
>> +
>> +    cfg->have_new_ctrl = false;
> 
> Why is this necessary?

(hmm, its ended up in the wrong patch, but:) This was to ensure that once the resources
are merged, all the work for applying configuration changes is done by the first IPI,
ensuring if update_domains() is called for a second schema with the same resource, it
finds no new work to do.
But without this, the empty_bitmap check would still catch it. I'll remove it.


>> +}
>> +
>>   int update_domains(struct rdt_resource *r, int closid)
>>   {
>> +    struct resctrl_staged_config *cfg;
>>       struct rdt_hw_domain *hw_dom;
>>       struct msr_param msr_param;
>>       cpumask_var_t cpu_mask;
>>       struct rdt_domain *d;
>>       bool mba_sc;
>> -    u32 *dc;
>> -    int cpu;
>> +    int cpu, i;
>>         if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>>           return -ENOMEM;
>> @@ -260,10 +279,12 @@ int update_domains(struct rdt_resource *r, int closid)
>>       mba_sc = is_mba_sc(r);
>>       list_for_each_entry(d, &r->domains, list) {
>>           hw_dom = resctrl_to_arch_dom(d);
>> -        dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
>> -        if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
>> -            cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>> -            dc[closid] = d->new_ctrl;
>> +        for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {

> I understand it may make later patches easier but it seems too early to introduce this
> loop because apply_config() does not seem to be ready for it yet (it would just keep
> overwriting a closid's config).

Grouping these values is needed because they become a set, one per type of configuration.
This ended up here because its looping over the set, even its only got one entry at the
moment.

Sure, I'll move it into a later patch. Presumably you want the array indexing to move too.


>> +            cfg = &hw_dom->resctrl.staged_config[i];
>> +            if (!cfg->have_new_ctrl)
>> +                continue;
>> +
>> +            apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
>>           }
>>       }
>>   @@ -338,7 +359,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>>         list_for_each_entry(s, &resctrl_all_schema, list) {
>>           list_for_each_entry(dom, &s->res->domains, list)
>> -            dom->have_new_ctrl = false;
>> +            memset(dom->staged_config, 0, sizeof(dom->staged_config));
>>       }
>>         while ((tok = strsep(&buf, "\n")) != NULL) {
> 
> ...
> 
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 9f71f0238239..f1164bbb66c5 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -26,13 +26,21 @@ enum resctrl_conf_type {
>>       CDP_DATA,
>>   };
>>   +/**
>> + * struct resctrl_staged_config - parsed configuration to be applied
>> + * @new_ctrl:        new ctrl value to be loaded
>> + * @have_new_ctrl:    did user provide new_ctrl for this domain
> 
> The "for this domain" in this description is no longer appropriate after the copy.

This structure is still embedded in struct rdt_domain, but I'll rephrase it.


Thanks,

James


>> + */
>> +struct resctrl_staged_config {
>> +    u32            new_ctrl;
>> +    bool            have_new_ctrl;
>> +};

>> @@ -59,6 +65,7 @@ struct rdt_domain {
>>       int                cqm_work_cpu;
>>         struct pseudo_lock_region    *plr;
>> +    struct resctrl_staged_config    staged_config[1];
>>   };
