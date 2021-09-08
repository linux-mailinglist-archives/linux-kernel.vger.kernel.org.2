Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9D40336B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhIHEoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 00:44:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51857 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhIHEoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:44:22 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 1884gmMC4009948
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 7 Sep 2021 21:42:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 1884gmMC4009948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631076170;
        bh=DnirN5yaca29dOLsh4n68jgYNnFGlrSSGZfm3YYegs0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dqSY2N0Q/8vJvbsnX0Yj8YIcg68vKIE2atnp7dU++urrugHLoq+EJt2Dwiqs/oLu0
         O6qVPRkdxLd2Hf+ncBpvXsw3E8ion33RdFiLF5YVFu8gvWNx2BXMJmn02WzqySmxY0
         k+/VdnhEa7jMqT135Fvcwhhon/BVkrnBioUGAbFXzIk1+7gaQVcQyZrjlJJ3xSxp0t
         MXrbWtBLbxe9y1SD02YduZIRukR8wjKj/J30OEN3MsFABLKrT/nBzZwAxMUWZQq/PC
         XuInz6eI5u2rpJCp7oM1zv9M7OHKBcXSc60ecHryni4PmTwSR9/KG3xH+gtiUtyXm1
         osfH0g8eQ/n5A==
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <f84c2b3c-a880-502f-4f51-4624b3800a05@zytor.com>
Date:   Tue, 7 Sep 2021 21:42:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9fdb04b1-dbb8-069d-f5ef-d4e8c0f2a83e@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/21 6:38 PM, H. Peter Anvin wrote:
> On 9/2/21 3:50 AM, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> There is no constrain/limition to force native_load_gs_index() to be in
>> ASM code.
> 
> Hi,
> 
> First of all, let me say I really like your patchset, and I will try to
> review it in detail ASAP (most of the initial read pass looks very sane
> to me.
> 
> However, I would like to object in part this specific patch. It adds a
> fair bit of extra code to the exception path, and adds jumps between
> files which makes the code much harder to read.
> 
> You end up doing one swapgs in assembly and one in C, which would seem
> to be a very good indication that really isn't an improvement.
> 
> Note that this entire sequence is scheduled to be obsoleted by a single
> atomic hardware instruction, LKGS, which will replace ALL of
> native_load_gs_index(); it will no longer be necessary even to disable
> interrupts as there is no non-atomic state. In that sense, doing this as
> an out-of-line C function (with some inline assembly) is great, because
> it makes it far easier to use LKGS as an alternative; the only (small)
> disadvantage is that it ends up clobbering a lot of registers
> unnecessarily (in assembly it can be implemented clobbering only two
> registers; one if one uses pushf/popf to save the interrupt flag.)
> 

OK, here is a version which actually compiles:

(It makes me wonder if it would be useful to have an _ASM_EXTABLE_GOTO() 
macro to highlight the use of an asm goto C label.)

noinstr void native_load_gs_index(unsigned int selector)
{
	unsigned long flags;

	local_irq_save(flags);
	native_swapgs();

do_mov_gs:
	asm_volatile_goto("1: mov %[seg],%%gs\n"
			  "2:\n"
			  _ASM_EXTABLE(1b,%l[bad_seg])
			  : : [seg] "r" (selector) : : bad_seg);

	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
	native_swapgs();
	local_irq_restore(flags);
	return;

bad_seg:
	selector = 0;

	/* The exception dispatch will have restored kernel GS */
	native_swapgs();

	if (static_cpu_has_bug(X86_BUG_NULL_SEG))
		asm volatile("mov %[seg],%%gs"
			     : : [seg] "r" (__USER_DS));
	goto do_mov_gs;
}

