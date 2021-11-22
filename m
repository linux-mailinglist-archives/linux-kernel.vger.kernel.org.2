Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12732458957
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhKVGfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:35:01 -0500
Received: from foss.arm.com ([217.140.110.172]:37712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhKVGe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:34:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94DA31042;
        Sun, 21 Nov 2021 22:31:53 -0800 (PST)
Received: from [10.163.79.55] (unknown [10.163.79.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 355723F5A1;
        Sun, 21 Nov 2021 22:31:49 -0800 (PST)
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Shan <gshan@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
 <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
 <20211012145540.343541e9@gandalf.local.home>
 <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
 <20211022083845.08fe5754@gandalf.local.home>
 <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
 <20211118114746.3329bd33@gandalf.local.home>
 <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <61262547-b9ad-7041-18e2-75840b5d784d@arm.com>
Date:   Mon, 22 Nov 2021 12:01:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/21 12:03 AM, Linus Torvalds wrote:
> On Thu, Nov 18, 2021 at 8:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>> Triggered it again with the new update:
>>
>> [   24.751779] IPI shorthand broadcast: enabled
>> [   24.761177] sched_clock: Marking stable (23431856262, 1329270511)->(28163092341, -3401965568)
>> [   24.770495] device: 'cpu_dma_latency': device_add
>> [   24.775232] PM: Adding info for No Bus:cpu_dma_latency
>> [   24.780929] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
>> [   24.799490] mtrr_type_lookup() returned 0 (0)
> Ok, so that's MTRR_TYPE_UNCACHABLE, and "uniform" is 0.
> 
> Anyway, either the mtrr code is confused, or more likely it just does
> the right thing, and  pud_set_huge() is simply expected to return 0 in
> this situation, and that WARN_ON() in pud_huge_tests() is simply wrong
> to trigger at all.
> 
> I didn't look at what all the code in debug_vm_pgtable() is trying to
> set up to test. Honestly, it's all very opaque.
> 
> But I do notice that the pfn that the test uses ends up basically
> being something random, where the "fixed" pfn is
> 
>         phys = __pa_symbol(&start_kernel);
>         ...
>         args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
> 
> rather than being an allocated real PUD-sized page. That can be a
> problem in itself.
> 
> So I think the problem is that depending on where the kernel is
> allocated, the fixed_pud_pfn ends up being in an area with MTRR
> settings. In fact, I'm surprised it's not *always* in that area, since
> presumabl;y you have the normal fixed MTRR issues with the 640k-1M
> range.
> 
> But I didn't look - probably the MTRR code doesn't actually check the
> special fixed MTRR's.
> 
> Anyway, I think that the end result is simply that the tests in
> mm/debug_vm_pgtable.c are simply buggy, and the WARN_ON() is not a
> sign of anything wrong in the mm, but with the tests themselves.
> 
> So the fixed_pud_pfn is dodgy, but it looks like the non-fixed
> 'pud_pfn' allocation may be dodgy too:
> 
>   #ifdef CONFIG_CONTIG_ALLOC
>         if (order >= MAX_ORDER) {
>                 page = alloc_contig_pages((1 << order), GFP_KERNEL,
>                                           first_online_node, NULL);
> 
> because afaik, alloc_contig_pages() does allocate a contiguous region,
> but it doesn't necessarily allocate a _aligned_ contiguous region.
> 
> So I think _all_ those PUD tests are likely broken, but honestly, I
> don't know the code well enough to be entirely sure, I'm just seeing
> code that looks dodgy to me.
> 
> I don't think the breakage is x86-specific. Quite the reverse. I think
> the x86 code just happens to randomly show it when some MTRR ends up
> being used.
> 
> Maybe pfn_pud() should verify that it's actually given an aligned argument?
> 
> Gavin, Anshuman? Feel free to tell me what I missed.

Hi Linus,

These PUD tests have been subtle (including their problems as seen here
in this report) on certain platforms. I will definitely take a detailed
look, but probably after an week (leave, travel etc). Thank you.

- Anshuman
