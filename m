Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB68C410F28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhITFFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:05:13 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34705 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhITFFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:05:12 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 36BE01BF208;
        Mon, 20 Sep 2021 05:03:41 +0000 (UTC)
Subject: Re: [PATCH] riscv: Flush current cpu icache before other cpus
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210918160221.111902-1-alex@ghiti.fr>
 <CAOnJCU++j8z1f6F8SPKe-SeSJYQYg1Sra27HPPTRFijyGXdOyA@mail.gmail.com>
From:   Alexandre ghiti <alex@ghiti.fr>
Message-ID: <71b47959-b878-e20f-caf7-fcaa08415e27@ghiti.fr>
Date:   Mon, 20 Sep 2021 07:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCU++j8z1f6F8SPKe-SeSJYQYg1Sra27HPPTRFijyGXdOyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On 9/19/21 4:35 AM, Atish Patra wrote:
> On Sat, Sep 18, 2021 at 9:03 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On SiFive Unmatched, I recently fell onto the following BUG when booting:
>>
>> [    0.000000] ftrace: allocating 36610 entries in 144 pages
>> [    0.000000] Oops - illegal instruction [#1]
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.1+ #5
>> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
>> [    0.000000] epc : riscv_cpuid_to_hartid_mask+0x6/0xae
>> [    0.000000]  ra : __sbi_rfence_v02+0xc8/0x10a
>> [    0.000000] epc : ffffffff80007240 ra : ffffffff80009964 sp : ffffffff81803e10
>> [    0.000000]  gp : ffffffff81a1ea70 tp : ffffffff8180f500 t0 : ffffffe07fe30000
>> [    0.000000]  t1 : 0000000000000004 t2 : 0000000000000000 s0 : ffffffff81803e60
>> [    0.000000]  s1 : 0000000000000000 a0 : ffffffff81a22238 a1 : ffffffff81803e10
>> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>> [    0.000000]  a5 : 0000000000000000 a6 : ffffffff8000989c a7 : 0000000052464e43
>> [    0.000000]  s2 : ffffffff81a220c8 s3 : 0000000000000000 s4 : 0000000000000000
>> [    0.000000]  s5 : 0000000000000000 s6 : 0000000200000100 s7 : 0000000000000001
>> [    0.000000]  s8 : ffffffe07fe04040 s9 : ffffffff81a22c80 s10: 0000000000001000
>> [    0.000000]  s11: 0000000000000004 t3 : 0000000000000001 t4 : 0000000000000008
>> [    0.000000]  t5 : ffffffcf04000808 t6 : ffffffe3ffddf188
>> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000002
>> [    0.000000] [<ffffffff80007240>] riscv_cpuid_to_hartid_mask+0x6/0xae
>> [    0.000000] [<ffffffff80009474>] sbi_remote_fence_i+0x1e/0x26
>> [    0.000000] [<ffffffff8000b8f4>] flush_icache_all+0x12/0x1a
>> [    0.000000] [<ffffffff8000666c>] patch_text_nosync+0x26/0x32
>> [    0.000000] [<ffffffff8000884e>] ftrace_init_nop+0x52/0x8c
>> [    0.000000] [<ffffffff800f051e>] ftrace_process_locs.isra.0+0x29c/0x360
>> [    0.000000] [<ffffffff80a0e3c6>] ftrace_init+0x80/0x130
>> [    0.000000] [<ffffffff80a00f8c>] start_kernel+0x5c4/0x8f6
>> [    0.000000] ---[ end trace f67eb9af4d8d492b ]---
>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>>
>> While ftrace is looping over a list of addresses to patch, it always failed
>> when patching the same function: riscv_cpuid_to_hartid_mask. Looking at the
>> backtrace, the illegal instruction is encountered in this same function.
>> However, patch_text_nosync, after patching the instructions, calls
>> flush_icache_range. But looking at what happens in this function:
>>
>> flush_icache_range -> flush_icache_all
>>                    -> sbi_remote_fence_i
>>                    -> __sbi_rfence_v02
>>                    -> riscv_cpuid_to_hartid_mask
>>
>> The icache and dcache of the current cpu are never synchronized between the
>> patching of riscv_cpuid_to_hartid_mask and calling this same function.
>>
>> So fix this by flushing the current cpu's icache before asking for the other
>> cpus to do the same.
>>
> Is this the same bugs described in this thread ?
>
> http://lkml.iu.edu/hypermail/linux/kernel/2108.1/05465.html

My issue can be explained this way:

This is what objdump output looks like in my case:

ffffffff8000723a
<riscv_cpuid_to_hartid_mask>:                                   
ffffffff8000723a:       0001                   
nop                              
ffffffff8000723c:       0001                   
nop                              
ffffffff8000723e:       0001                   
nop                              
ffffffff80007240:       0001                    nop            
ffffffff80007242:       0001                   
nop                              
ffffffff80007244:       0001                   
nop                              
ffffffff80007246:       0001                   
nop                              
ffffffff80007248:       0001                    nop

This will get patched to:

ffffffff8000723a
<riscv_cpuid_to_hartid_mask>:                                   
ffffffff8000723a:      
0013                                                  
ffffffff8000723c:       0000                   
nop                              
ffffffff8000723e:      
0013                                                  
ffffffff80007240:       0000                    nop           
ffffffff80007242:      
0013                                                  
ffffffff80007244:       0000                   
nop                              
ffffffff80007246:      
0013                                                  
ffffffff80007248:       0000                    nop

But 0xffffffff80007240 is the beginning of a new cache line, so actually
for some reason, the following will be in icache:

ffffffff8000723a
<riscv_cpuid_to_hartid_mask>:                                   
ffffffff8000723a:       0001                   
nop                              
ffffffff8000723c:       0001                   
nop                              
ffffffff8000723e:       0001                   
nop                              
ffffffff80007240:       0000                    unimp <- new cache
line            
ffffffff80007242:      
0013                                                  
ffffffff80007244:       0000                   
nop                              
ffffffff80007246:      
0013                                                  
ffffffff80007248:       0000                    nop

0x0001 at 0xffffffff8000723e is executed as a nop but then 0x0000 is an
invalid instruction, hence the trap.

Regarding Dimitri issue, given the address where it traps, the code
objdumped would look like:

ffffffff80007200:       0001                    nop
ffffffff80007202:       0001                    nop
                             
ffffffff80007204:       0001                   
nop                              
ffffffff80007206:       0001                    nop
                             
ffffffff80007208:       0001                    nop
ffffffff8000720a:       0001                    nop
                             
ffffffff8000720c:       0001                    nop       
ffffffff8000720e:       0001                    nop

Once patched it looks like:

ffffffff80007200:       0013                    nop
ffffffff80007202:       0000
                                                 
ffffffff80007204:       0013                   
nop                              
ffffffff80007206:       0000
                                                 
ffffffff80007208:       0013                    nop
ffffffff8000720a:       0000                    
                             
ffffffff8000720c:       0013                    nop       
ffffffff8000720e:       0000                   

So if we imagine that until 0xffffffff8000720c, the code that is
executed is the first unpatched version and then at 0xffffffff8000720e,
the cache line gets reloaded, that can explain the illegal instruction.
But it's a bit far-fetched.

Actually I don't understand how the whole thing can work, because
between the moment the code is patched and other harts are asked to sync
their caches, there's a large window where what I explained above can
happen right?

Alex


>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/mm/cacheflush.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> index 094118663285..89f81067e09e 100644
>> --- a/arch/riscv/mm/cacheflush.c
>> +++ b/arch/riscv/mm/cacheflush.c
>> @@ -16,6 +16,8 @@ static void ipi_remote_fence_i(void *info)
>>
>>  void flush_icache_all(void)
>>  {
>> +       local_flush_icache_all();
>> +
>>         if (IS_ENABLED(CONFIG_RISCV_SBI))
>>                 sbi_remote_fence_i(NULL);
>>         else
>> --
>> 2.30.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
