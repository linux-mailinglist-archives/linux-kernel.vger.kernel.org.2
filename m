Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0643CF08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhJ0QxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:53:01 -0400
Received: from foss.arm.com ([217.140.110.172]:45470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243037AbhJ0QxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:53:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B91ED1;
        Wed, 27 Oct 2021 09:50:34 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55B93F70D;
        Wed, 27 Oct 2021 09:50:32 -0700 (PDT)
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-18-james.morse@arm.com>
 <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
 <dfe2f33c-6103-9699-42f9-73983fa62057@intel.com>
 <81826a4f-c3de-787f-8059-4808815b4800@amd.com>
 <71efc804-4ca0-f31b-4485-005b3ad6e4d4@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <859c5573-b025-7754-94bf-294c7da3abdc@arm.com>
Date:   Wed, 27 Oct 2021 17:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <71efc804-4ca0-f31b-4485-005b3ad6e4d4@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette, Babu,

On 20/10/2021 21:28, Reinette Chatre wrote:
> On 10/20/2021 12:22 PM, Babu Moger wrote:
>> On 10/20/21 1:15 PM, Reinette Chatre wrote:
>>> On 10/19/2021 4:20 PM, Babu Moger wrote:
>>>> On 10/1/21 11:02 AM, James Morse wrote:
>>>>> __rmid_read() selects the specified eventid and returns the counter
>>>>> value from the msr. The error handling is architecture specific, and
>>>>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>>>>
>>>>> Error handling should be handled by architecture specific code, as
>>>>> a different architecture may have different requirements. MPAM's
>>>>> counters can report that they are 'not ready', requiring a second
>>>>> read after a short delay. This should be hidden from resctrl.
>>>>>
>>>>> Make __rmid_read() the architecture specific function for reading
>>>>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>>>>> handling into it.


>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> index 25baacd331e0..c8ca7184c6d9 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>>>>> *arg)
>>>>>          mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>>>>>    -    if (rr.val & RMID_VAL_ERROR)
>>>>> +    if (rr.err == -EIO)
>>>>>            seq_puts(m, "Error\n");
>>>>> -    else if (rr.val & RMID_VAL_UNAVAIL)
>>>>> +    else if (rr.err == -EINVAL)
>>>>>            seq_puts(m, "Unavailable\n");
>>>>>        else
>>>>>            seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
>>>>
>>>> This patch breaks the earlier fix
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv5.15-rc6%26id%3D064855a69003c24bd6b473b367d364e418c57625&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C85219a5827114935cdaa08d993f59fa0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703505420472920%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yP8awDgGGZ%2BWj5ZItdTNJItTVuK828yGnibwq%2BrVaf0%3D&amp;reserved=0

Aha!


>>>> When the user reads the events on the default monitoring group with
>>>> multiple subgroups, the events on all subgroups are consolidated
>>>> together. In case if the last rmid read was resulted in error then whole
>>>> group will be reported as error. The err field needs to be cleared.
>>>>
>>>> Please add this patch to clear the error.

>>> Good catch, thank you.
>>>
>>> Even so, I do not think mon_event_count()'s usage of __mon_event_count()
>>> was taken into account by this patch and needs a bigger rework than the
>>> above fixup. For example, if I understand correctly ret_val is the error
>>> and rr->val no longer expected to contain the error after this patch. So
>>> keeping that assignment to rr->val is not correct.
>>
>> Yes. You are right. rr->val is not expected to contain the error.
>> Hopefully, this should help.

> Yes, this looks good. If the first __mon_event_count() succeeds but a following one fails
> then the data still needs to be reported so the error code needs to be fixed up afterwards
> and cannot be done inside __mon_event_count(). Thank you very much.

Thanks both! I should have worked this out when splitting msr_val into two values, which
end up getting set the same.

I think the 'Unavailable' issue is subtle enough that it deserves a block comment.
I've replaced the rr->val chunk with:
|	/*
|	 * __mon_event_count() calls for newly created monitor groups may
|	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
|	 * If the first call for the control group succeed, discard any error
|	 * set by reads of monitor groups.
|	 */
|	if (ret_val == 0)
|		rr->err = 0;


Thanks.

James
