Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C893437C97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhJVScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:32:43 -0400
Received: from foss.arm.com ([217.140.110.172]:57660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhJVScj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:32:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F3D147A;
        Fri, 22 Oct 2021 11:30:21 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196F83F73D;
        Fri, 22 Oct 2021 11:30:19 -0700 (PDT)
Subject: Re: [PATCH v2 08/23] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
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
 <20211001160302.31189-9-james.morse@arm.com>
 <facea348-2c54-fe52-09b9-8feccd15db2d@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <96e481ad-f544-dd7d-294d-461f905bcb1e@arm.com>
Date:   Fri, 22 Oct 2021 19:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <facea348-2c54-fe52-09b9-8feccd15db2d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:26, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
>> To support resctrl's MBA software controller, the architecture must provide
>> a second configuration array to hold the mbps_val from user-space.
>>
>> This complicates the interface between the architecture code.
> 
> This complicates the interface between the architecture code and ... ?

and the filesystem parts ... fixed.


>> Make the filesystem parts of resctrl create an array for the mba_sc
>> values when is_mba_sc() is set to true. The software controller
>> can be changed to use this, allowing the architecture code to only
>> consider the values configured in hardware.

> This changes significantly more than just where the mbps_val array is hosted. It also
> changes how the life cycle of this array is managed. Previously it followed the domain,
> whether mba_sc was enabled or not. Now that it depends on mba_sc it is managed quite
> differently.

> Could the changelog be upfront about this change and its motivation? Stating this would
> make this much easier to review and also the later patches where the original mbps_val
> initialization code is removed without replacement.

Yes, I'd not considered those as different things. I'll split this into two patches, and
move the change that only allocates the memory if its going to be used to the end of the
series.


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 38670bb810cb..9d402bc8bdff 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3291,6 +3355,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct
>> rdt_domain *d)
>>           }
>>       }
>>   +    if (is_mba_sc(r))
>> +        return mba_sc_domain_allocate(r, d);
>> +
>>       return 0;
>>   }
>>   

> Could this be done symmetrically? That is, allocate in resctrl_online_domain() and free in
> resctrl_offline_domain().

Yes, that would be better!


>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 5d283bdd6162..355660d46612 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
>>     #endif
>>   +/* max value for struct resctrl_mba_sc's mbps_val */
>> +#define MBA_MAX_MBPS   U32_MAX
> 
> struct resctrl_mba_sc?

Was squashed out of the previous version as it only had one member.
This should be struct rdt_domain.


>>   /**
>>    * enum resctrl_conf_type - The type of configuration.
>>    * @CDP_NONE:    No prioritisation, both code and data are controlled or monitored.
>> @@ -53,6 +56,8 @@ struct resctrl_staged_config {
>>    * @cqm_work_cpu:    worker CPU for CQM h/w counters
>>    * @plr:        pseudo-locked region (if any) associated with domain
>>    * @staged_config:    parsed configuration to be applied
>> + * @mbps_val:        Array of user specified control values for mba_sc,
>> + *            indexed by closid

> Could this inherit some of the useful kerneldoc associated with the mbps_val being
> replaced? That is, it exists when mba_sc is enabled and contains bandwidth values in MBps.

Yup, done.


Thanks,

James
