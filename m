Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7D403502
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbhIHHN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:13:27 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51129 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349259AbhIHHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:13:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UnfT516_1631085126;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UnfT516_1631085126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 15:12:07 +0800
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <9fdb04b1-dbb8-069d-f5ef-d4e8c0f2a83e@zytor.com>
 <f84c2b3c-a880-502f-4f51-4624b3800a05@zytor.com>
 <638f3b2b-aff9-72e5-3a5d-fff5ef6b88fc@zytor.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <f76296d5-8d95-cf3d-b800-3f6b2e2d21fb@linux.alibaba.com>
Date:   Wed, 8 Sep 2021 15:12:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <638f3b2b-aff9-72e5-3a5d-fff5ef6b88fc@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/8 13:00, H. Peter Anvin wrote:
> On 9/7/21 9:42 PM, H. Peter Anvin wrote:
>>
>>
>> On 9/7/21 6:38 PM, H. Peter Anvin wrote:
>>> On 9/2/21 3:50 AM, Lai Jiangshan wrote:
>>>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>>>
>>>> There is no constrain/limition to force native_load_gs_index() to be in
>>>> ASM code.
>>>
>>> Hi,
>>>
>>> First of all, let me say I really like your patchset, and I will try to
>>> review it in detail ASAP (most of the initial read pass looks very sane
>>> to me.

Hello

Thank you for your review.

>>>
>>> However, I would like to object in part this specific patch. It adds a
>>> fair bit of extra code to the exception path, and adds jumps between
>>> files which makes the code much harder to read.

I tried putting all code into a single C function.
But I didn't know how to use a C-label in _ASM_EXTABLE and then I split it.

Your code is much better.

Thanks
Lai


>>>
>>> You end up doing one swapgs in assembly and one in C, which would seem
>>> to be a very good indication that really isn't an improvement.
>>>
>>> Note that this entire sequence is scheduled to be obsoleted by a single
>>> atomic hardware instruction, LKGS, which will replace ALL of
>>> native_load_gs_index(); it will no longer be necessary even to disable
>>> interrupts as there is no non-atomic state. In that sense, doing this as
>>> an out-of-line C function (with some inline assembly) is great, because
>>> it makes it far easier to use LKGS as an alternative; the only (small)
>>> disadvantage is that it ends up clobbering a lot of registers
>>> unnecessarily (in assembly it can be implemented clobbering only two
>>> registers; one if one uses pushf/popf to save the interrupt flag.)
>>>
>>
>> OK, here is a version which actually compiles:
>>
> 
> ... slightly shorter and minimally better compiled code ...
> 
> noinstr void native_load_gs_index(unsigned int selector)
> {
>      unsigned long flags;
> 
>      local_irq_save(flags);
>      native_swapgs();
> do_mov_gs:
>      asm_volatile_goto("1: mov %[seg],%%gs\n"
>                "2:\n"
>                _ASM_EXTABLE(1b,%l[bad_seg])
>                : : [seg] "r" (selector) : : bad_seg);
>      alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
>      native_swapgs();
>      local_irq_restore(flags);
>      return;
> 
> bad_seg:
>      /* The exception dispatch will have restored kernel GS */
>      native_swapgs();
>      alternative_input("", "mov %[seg],%%gs",
>                X86_BUG_NULL_SEG, [seg] "r" (__USER_DS));
>      selector = 0;
>      goto do_mov_gs;
> }
