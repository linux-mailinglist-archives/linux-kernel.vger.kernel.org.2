Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5206339452
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCLRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:10:35 -0500
Received: from foss.arm.com ([217.140.110.172]:57526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhCLRKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:10:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE9D1FB;
        Fri, 12 Mar 2021 09:10:08 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC243F7D7;
        Fri, 12 Mar 2021 09:10:06 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 01/24] x86/resctrl: Split struct rdt_resource
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-2-james.morse@arm.com>
 <8a49d89f-a68b-bd10-60c1-33f59258ea9f@intel.com>
Message-ID: <2e159387-384b-794a-0d9e-1405e5333276@arm.com>
Date:   Fri, 12 Mar 2021 17:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8a49d89f-a68b-bd10-60c1-33f59258ea9f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 19:20, Reinette Chatre wrote:
> On 10/30/2020 9:10 AM, James Morse wrote:
>> Splitting rdt_domain up in a similar way happens in the next patch.
>> No change in behaviour, this patch just moves types around.
> 
> Please remove the "this patch" term.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index e5f4ee8f4c3b..470661f2eb68 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c

>> @@ -912,9 +938,14 @@ static __init bool get_rdt_resources(void)
>>     static __init void rdt_init_res_defs_intel(void)
>>   {
>> +    struct rdt_hw_resource *hw_res;
>>       struct rdt_resource *r;
>> +    int i;
>> +
>> +    for (i = 0; i < RDT_NUM_RESOURCES; i++) {
>> +        hw_res = &rdt_resources_all[i];
>> +        r = &rdt_resources_all[i].resctrl;
>>   -    for_each_rdt_resource(r) {
>>           if (r->rid == RDT_RESOURCE_L3 ||
>>               r->rid == RDT_RESOURCE_L3DATA ||
>>               r->rid == RDT_RESOURCE_L3CODE ||
> 
> Could using for_each_rdt_resource() remain with the additional assignment of hw_res?
> Similar to the later usage of for_each_alloc_enabled_rdt_resource()?

Sure. I didn't do it here because of the back-to-back container_of(), even though the
array is defined in the same file. But the compiler will remove all of that.


>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index c877642e8a14..ab6e584c9d2d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -284,10 +284,12 @@ int update_domains(struct rdt_resource *r, int closid)
>>   static int rdtgroup_parse_resource(char *resname, char *tok,
>>                      struct rdtgroup *rdtgrp)
>>   {
>> +    struct rdt_hw_resource *hw_res;
>>       struct rdt_resource *r;
>>         for_each_alloc_enabled_rdt_resource(r) {
>> -        if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
>> +        hw_res = resctrl_to_arch_res(r);
>> +        if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
>>               return parse_line(tok, r, rdtgrp);
>>       }

> This is the usage of for_each_alloc_enabled_rdt_resource() I refer to earlier.

(if it helps, the difference in treatment is because this one is to do with the filesystem
interface, the others were clearly arch code)


Thanks,

James
