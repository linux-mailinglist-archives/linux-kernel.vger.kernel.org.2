Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0233952C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhCLRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:38:30 -0500
Received: from foss.arm.com ([217.140.110.172]:58006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232871AbhCLRiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:38:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 693401FB;
        Fri, 12 Mar 2021 09:38:10 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA57C3F7D7;
        Fri, 12 Mar 2021 09:38:08 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 10/24] x86/resctrl: Move the schema names into struct
 resctrl_schema
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-11-james.morse@arm.com>
 <30449b04-c5c8-9790-f36f-5843efdd2924@intel.com>
Message-ID: <149b51e9-c6c5-3236-8a27-94846bd784df@arm.com>
Date:   Fri, 12 Mar 2021 17:38:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <30449b04-c5c8-9790-f36f-5843efdd2924@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 23:11, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> Move the names used for the schemata file out of the resource and
>> into struct resctrl_schema. This allows one resource to have two
>> different names, based on the other schema properties.
>>
>> This patch copies the names, eventually resctrl will generate them.
> 
> Please remove "This patch".
> 
>>
>> Remove the arch code's max_name_width, this is now resctrl's
>> problem.

>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index a65ff53394ed..28d69c78c29e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> 
> ...
> 
>> @@ -391,7 +389,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema
>> *schema, int clo
>>       bool sep = false;
>>       u32 ctrl_val;
>>   -    seq_printf(s, "%*s:", max_name_width, r->name);
>> +    seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
> 
> From what I understand this changes what some users will see. In the original code the
> "max_name_width" is computed based on the maximum length of resources supported. Systems
> that only support MBA would thus show a schemata of:
> 
> MB:0=100;1=100
> 
> I expect the above change would change the output to:
>     MB:0=100;1=100

Aha! Despite the comment - I've totally miss-understood what this code is doing.


Thanks!

James
