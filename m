Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5F41F1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355154AbhJAQDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:03:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355148AbhJAQDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:03:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1434101E;
        Fri,  1 Oct 2021 09:01:25 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F311C3F766;
        Fri,  1 Oct 2021 09:01:23 -0700 (PDT)
Subject: Re: [PATCH v1 13/20] x86/recstrl: Allow per-rmid arch private storage
 to be reset
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc:     'Fenghua Yu' <fenghua.yu@intel.com>,
        'Reinette Chatre' <reinette.chatre@intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'H Peter Anvin' <hpa@zytor.com>,
        'Babu Moger' <Babu.Moger@amd.com>,
        "'shameerali.kolothum.thodi@huawei.com'" 
        <shameerali.kolothum.thodi@huawei.com>,
        'Jamie Iles' <jamie@nuviainc.com>,
        'D Scott Phillips OS' <scott@os.amperecomputing.com>,
        "'lcherian@marvell.com'" <lcherian@marvell.com>,
        "'bobo.shaobowang@huawei.com'" <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-14-james.morse@arm.com>
 <TYAPR01MB633030707DD9C8AF6A2FEBA08BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <aef96d1b-0ffd-0f51-bade-9e7b7684d26e@arm.com>
Date:   Fri, 1 Oct 2021 17:01:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB633030707DD9C8AF6A2FEBA08BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaopeng Tan,

On 24/09/2021 07:34, tan.shaopeng@fujitsu.com wrote:
>> To abstract the rmid counters into a helper that returns the number of bytes
>> counted, architecture specific per-rmid state is needed.
>>
>> It needs to be possible to reset this hidden state, as the values may outlive the
>> life of an rmid, or the mount time of the filesystem.
>>
>> mon_event_read() is called with first = true when an rmid is first allocated in
>> mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid() and call it from
>> __mon_event_count()'s rr->first check.


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index af60e154f0ed..3b8b29470a5c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -137,7 +137,34 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>>  	return entry;
>>  }
>>
>> -static u64 __rmid_read(u32 rmid, u32 eventid)
>> +static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain
>> *hw_dom,
>> +						 u32 rmid,
>> +						 enum resctrl_event_id
>> eventid)
>> +{
>> +	switch (eventid) {
>> +	case QOS_L3_OCCUP_EVENT_ID:
>> +		return NULL;
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		return &hw_dom->arch_mbm_total[rmid];
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		return &hw_dom->arch_mbm_local[rmid];
>> +	}
>> +
> 
> Since it is unexpected to come here,
> it might be better to add WARN_ON.

Sure. (it'll be the 'once' version to avoid spamming the console)
I'm relying on the compiler generating a warning a built-time here if a new enum entry is
ever added, but it can't hurt to warning if someone passes something totally crazy to it.


> In addition, I have tested these patches on Intel(R) Xeon(R) Gold 6254 CPU with
> resctrl selftest. It is no problem.

Good to know, thanks!


Thanks,

James
