Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82DA339516
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCLRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:36:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbhCLRgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:36:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7B51FB;
        Fri, 12 Mar 2021 09:36:14 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEFEB3F7D7;
        Fri, 12 Mar 2021 09:36:12 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 07/24] x86/resctrl: Label the resources with their
 configuration type
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-8-james.morse@arm.com>
 <2de84538-9741-c902-9be0-5b279bbe162f@intel.com>
Message-ID: <bb37577e-ffec-590b-74b8-7865776aa609@arm.com>
Date:   Fri, 12 Mar 2021 17:36:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2de84538-9741-c902-9be0-5b279bbe162f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 22:30, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> Before the name for the schema can be generated, the type of the
>> configuration being applied to the resource needs to be known. Label
>> all the entries in rdt_resources_all[], and copy that value in to struct
> 
> s/in to/into/ or s/in to/to/ ?
> 
>> resctrl_schema.
>>
> 
> This commit message does not explain why it is needed to copy this value.
> 
>> Subsequent patches will generate the schema names in what will become
>> the fs code. Eventually the fs code will generate pairs of CODE/DATA if
>> the platform supports CDP for this resource.
> 
> Explaining how the copy is a step towards accomplishing this goal would be very helpful.

(I've added text about what this is used for, and why it can't assign the values it wants
at this point in the series)


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1bd785b1920c..628e5eb4d7a9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2141,6 +2141,7 @@ static int create_schemata_list(void)
>>             s->res = r;
>>           s->num_closid = resctrl_arch_get_num_closid(r);
> 
> Above seems to be last user of this helper remaining ... why is helper needed instead of
> something similar to below?

Great question, resctrl_to_arch_res(r)->num_closid? That won't work for MPAM, or would at
least force all architectures to copy x86's arch-specific structure.

schemata_list_create() needs to be part of the filesystem code after the split, but it
can't touch the hw structure like the conf_type is doing here.

This is mentioned in the commit message of the first two patches:
| resctrl code paths touching a 'hw' struct indicates where an abstraction is needed.

I evidently need to make that clearer.


>> +        s->conf_type = resctrl_to_arch_res(r)->conf_type;

I'll to do this temporarily, as by then end of the series schemata_list_create() chooses
the value, so this disappears.


Thanks,

James
