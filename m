Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5543CF06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbhJ0Qwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:52:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243003AbhJ0Qwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:52:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB330ED1;
        Wed, 27 Oct 2021 09:50:16 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0D33F70D;
        Wed, 27 Oct 2021 09:50:14 -0700 (PDT)
Subject: Re: [PATCH v2 14/23] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
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
 <20211001160302.31189-15-james.morse@arm.com>
 <091863be-f15c-18cf-9f1e-1f447f216098@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f59842eb-887d-4134-c913-75376bc35fd4@arm.com>
Date:   Wed, 27 Oct 2021 17:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <091863be-f15c-18cf-9f1e-1f447f216098@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:28, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>> second. It reads the hardware register, calculates the bandwidth and
>> updates m->prev_bw_msr which is used to hold the previous hardware register
>> value.
>>
>> Operating directly on hardware register values makes it difficult to make
>> this code architecture independent, so that it can be moved to /fs/,
>> making the mba_sc feature something resctrl supports with no additional
>> support from the architecture.
>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>> register using __mon_event_count().
> 
> Looking back I think 06c5fe9b12dd ("x86/resctrl: Fix incorrect local bandwidth when mba_sc
> is enabled") may explain how the code ended up the way it is.
> 
>> Change mbm_bw_count() to use the current chunks value from
>> __mon_event_count() to calculate bandwidth. This means it no longer
>> operates on hardware register values.
> 
> ok ... so could the patch just do this as it is stated here? The way it is implemented is
> very complicated and hard (for me) to verify the correctness (more below).

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 6c8226987dd6..a1232462db14 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>>   {
>>       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>>       struct mbm_state *m = &rr->d->mbm_local[rmid];
>> -    u64 tval, cur_bw, chunks;
>> +    u64 cur_bw, chunks, cur_chunks;
>>   -    tval = __rmid_read(rmid, rr->evtid);
>> -    if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
>> -        return;
>> +    cur_chunks = rr->val;
>> +    chunks = cur_chunks - m->prev_bw_chunks;
>> +    m->prev_bw_chunks = cur_chunks;
>>   -    chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
>> -    cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
>> +    cur_bw = (chunks * hw_res->mon_scale) >> 20;

> I find this quite confusing. What if a new m->prev_chunks is introduced instead and
> initialized in __mon_event_count() to the value of chunks, and then here in mbm_bw_count
> it could just retrieve it (chunks = m->prev_chunks).

(I agree the diff is noisy, it may be easier as a new function as this is a replacement
not a transform of the existing function)

__mon_event_count() can also be triggered by user-space reading the file, so any of its
'prev' values should be ignored, as they aren't updated on the 1-second timer needed to
get this in MB/s.
__mon_event_count()'s chunks values hasn't been through get_corrected_mbm_count(), so it
would need to be rr->val, which is what this code starts with for the "number of chunks
ever read by this counter".


The variable 'chunks' has been used too much here, so its lost its meaning. How about:
|	current_chunk_count = rr->val;
|	delta_counter = current_chunk_count - m->prev_chunk_count;
|	cur_bw = (delta_counter * hw_res->mon_scale) >> 20;
|
|	m->prev_chunk_count = current_chunk_count;


The 'delta_counter' step was previously hidden in mbm_overflow_count(), which also had to
do with overflow of the hardware counter. Because a previously sanitised value is being
used, the hardware counters resolution doesn't need to be considered.
(which helps make mba_sc architecture independent)


Thanks,

James
