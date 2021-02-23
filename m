Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03132266A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhBWHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:31:57 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:40224 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhBWHby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:31:54 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11N7Qj0l023503
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 08:26:45 +0100
Received: from [167.87.244.56] ([167.87.244.56])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11N7Qhl4015837;
        Tue, 23 Feb 2021 08:26:44 +0100
Subject: Re: [PATCH] scripts/gdb: document lx_current is only supported by x86
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20210221213527.22076-1-song.bao.hua@hisilicon.com>
 <eac66671-f083-379a-c7b0-04b783e32d63@ideasonboard.com>
 <eb48406902a84282a400846607e7a37a@hisilicon.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <940e936d-d35b-105c-201c-8f2126222d15@siemens.com>
Date:   Tue, 23 Feb 2021 08:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eb48406902a84282a400846607e7a37a@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.21 22:18, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Kieran Bingham [mailto:kieran.bingham@ideasonboard.com]
>> Sent: Tuesday, February 23, 2021 12:06 AM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; corbet@lwn.net;
>> linux-doc@vger.kernel.org; jan.kiszka@siemens.com
>> Cc: linux-kernel@vger.kernel.org; linuxarm@openeuler.org
>> Subject: Re: [PATCH] scripts/gdb: document lx_current is only supported by x86
>>
>> Hi Barry
>>
>> On 21/02/2021 21:35, Barry Song wrote:
>>> lx_current depends on the per_cpu current_task which exists on x86 only:
>>>
>>> arch$ git grep current_task | grep -i per_cpu
>>> x86/include/asm/current.h:DECLARE_PER_CPU(struct task_struct *,
>> current_task);
>>> x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task)
>> ____cacheline_aligned =
>>> x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
>>> x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task)
>> = &init_task;
>>> x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
>>> x86/kernel/smpboot.c:	per_cpu(current_task, cpu) = idle;
>>>
>>> On other architectures, lx_current() will lead to a python exception:
>>> (gdb) p $lx_current().pid
>>> Python Exception <class 'gdb.error'> No symbol "current_task" in current
>> context.:
>>> Error occurred in Python: No symbol "current_task" in current context.
>>>
>>> To avoid more people struggling and wasting time in other architectures,
>>> document it.
>>>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>> ---
>>>  Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
>>>  scripts/gdb/linux/cpus.py                        | 10 ++++++++--
>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst
>> b/Documentation/dev-tools/gdb-kernel-debugging.rst
>>> index 4756f6b3a04e..1586901b683c 100644
>>> --- a/Documentation/dev-tools/gdb-kernel-debugging.rst
>>> +++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
>>> @@ -114,7 +114,7 @@ Examples of using the Linux-provided gdb helpers
>>>      [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
>> reserved
>>>      ....
>>>
>>> -- Examine fields of the current task struct::
>>> +- Examine fields of the current task struct(supported by x86 only)::
>>>
>>>      (gdb) p $lx_current().pid
>>>      $1 = 4998
>>> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
>>> index 008e62f3190d..f382762509d3 100644
>>> --- a/scripts/gdb/linux/cpus.py
>>> +++ b/scripts/gdb/linux/cpus.py
>>> @@ -156,6 +156,13 @@ Note that VAR has to be quoted as string."""
>>>
>>>  PerCpu()
>>>
>>> +def get_current_task(cpu):
>>> +    if utils.is_target_arch("x86"):
>>> +         var_ptr = gdb.parse_and_eval("&current_task")
>>> +         return per_cpu(var_ptr, cpu).dereference()
>>> +    else:
>>> +        raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>>> +                           "supported with this arch")
>>
>> I've wondered in the past how we should handle the architecture specific
>> layers.
>>
>> Perhaps we need to have an interface of functionality to implement on
>> each architecture so that we can create a per-arch set of helpers.
>>
>> or break it up into arch specific subdirs at least...
>>
>>
>>>  class LxCurrentFunc(gdb.Function):
>>>      """Return current task.
>>> @@ -167,8 +174,7 @@ number. If CPU is omitted, the CPU of the current context
>> is used."""
>>>          super(LxCurrentFunc, self).__init__("lx_current")
>>>
>>>      def invoke(self, cpu=-1):
>>> -        var_ptr = gdb.parse_and_eval("&current_task")
>>> -        return per_cpu(var_ptr, cpu).dereference()
>>> +        return get_current_task(cpu)
>>>
>>
>> And then perhaps we simply shouldn't even expose commands which can not
>> be supported on those architectures?
> 
> I feel it is better to tell users this function is not supported on its arch
> than simply hiding the function.
> 
> If we hide it, users still have many chances to try it as they have got
> information of lx_current from google or somewhere.
> They will try, if it turns out the lx_current is not in the list and an
> error like  "invalid data type for function to be called", they will
> probably suspect their gdb/python environment is not set up correctly,
> and continue to waste time in checking their environment. 
> Finally they figure out this function is not supported by its arch so it is
> not exposed. But they have wasted a couple of hours before knowing that.
> 
> It seems it is more friendly to directly tell users this is not supported
> on its arch explicitly and clearly than reporting a "invalid data type
> for function to be called.
> 
>>
>> Is it easy to disable this command if it's not supportable on the
>> architecture?
>>
> 
> TBH, I'm not a python expert. I don't know how to do that in an elegant
> way :-)  on the other hand, it seems lx_current isn’t a command like
> lx-dmesg. Lx_current is actually similar with lx_per_cpu, we use gdb's
> print(p) command to show its content.
> 
>> Presumably you are working on non-x86, have you investigated adding this
>> support for your architecture (arm/arm64?)?
> 
> Yes. I've thought about it. But It would be quite trivial to bring up
> this function on arm64.
> 
> arch/arm64/include/asm/current.h:
> static __always_inline struct task_struct *get_current(void)
> {
> 	unsigned long sp_el0;
> 
> 	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
> 
> 	return (struct task_struct *)sp_el0;
> }
> 
> We have to read a special register named sp_el0 and convert it to
> task_struct while we are running in kernel mode. In gdb I can do
> it by:
> (gdb)p/x $SP_EL0
> $20 = 0xffffffc011492400
> (gdb)p ((struct task_struct *0xffffffc011492400))->pid
> $21 = 0
> 
> What is more complex is that if we are running in user mode(EL0), this
> register doesn't describe current task any more. so we have to
> differentiate the modes of processor and make sure it only returns
> current task while we are running in EL1(processor's kernel mode).

Is all information needed for this available via gdb?

> 
>>
>> The fact you have run the command implies it would be useful for you ?
>>
> 
> Yes. I think it is a common requirement to get current task. lx_current
> convenience function can help everyone. Since there is a document saying
> this command exists, everyone using scripts/gdb would like to try it
> I guess.
> 
> The simplest way would be adding current_task per_cpu variable for other
> arch, but I believe hardly arch maintainers will accept it as its only
> benefit is bringing up the lx_current. So 99.9% no maintainer wants it.
> 
> Thus, for the time being, I moved to just stop people from wasting time
> like what I had done with a couple of hours.
> 

I agree with the warning, also as potential motivation to add support
for other archs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
