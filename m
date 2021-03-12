Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7933952A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhCLRiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:38:00 -0500
Received: from foss.arm.com ([217.140.110.172]:57984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhCLRhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:37:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB3B1FB;
        Fri, 12 Mar 2021 09:37:51 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF87A3F7D7;
        Fri, 12 Mar 2021 09:37:49 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 08/24] x86/resctrl: Walk the resctrl schema list instead
 of an arch list
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-9-james.morse@arm.com>
 <cb95b485-4d34-fa88-7c66-2d4d6fc62b5d@intel.com>
Message-ID: <d512c41e-7bea-873d-f209-debf1b963301@arm.com>
Date:   Fri, 12 Mar 2021 17:37:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cb95b485-4d34-fa88-7c66-2d4d6fc62b5d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 22:52, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> Now that resctrl has its own list of resources it is using, walk that
>> list instead of the architectures list. This means resctrl has somewhere
>> to keep schema properties with the resource that is using them.
>>
>> Most users of for_each_alloc_enabled_rdt_resource() are per-schema,
>> and also want a schema property, like the conf_type. Switch these to
>> walk the schema list. Schema were only created for alloc_enabled
>> resources so these two lists are currently equivalent.
>>
> 
> From what I understand based on this description the patch will essentially change
> instances of for_each_alloc_enabled_rdt_resource() to walking the schema list ....

>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 8ac104c634fe..d3f9d142f58a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -57,9 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct
>> rdt_resource *r)
>>       return true;
>>   }
>>   -int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
>> +int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>            struct rdt_domain *d)
>>   {
>> +    struct rdt_resource *r = s->res;
>>       unsigned long bw_val;
>>         if (d->have_new_ctrl) {
> 
> ... this change and also the ones to parse_cbm() and rdtgroup_cbm_overlaps() are not clear
> to me because it seems they replace the rdt_resource parameter with resctrl_schema, but
> all in turn use that to access rdt_resource again. That seems unnecessary?

I previously restructured the series to do the schema stuff first, as I thought it would
make it easier to follow. It looks like this patch has picked up other stuff - I 'll split
this up so those changes get their own commit message.

By the end of the series, the rdt_resource isn't unique, the same 'L3' is provided to
L3CODE and L3DATA. The things that make these different are stored in the schema. In both
these cases the configuration is read/written, where that should go depends on the type of
the schema, which lives in the schema struct.


Thanks,

James
