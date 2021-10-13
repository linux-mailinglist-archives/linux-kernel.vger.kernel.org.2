Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00742B3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 06:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJMEMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 00:12:24 -0400
Received: from foss.arm.com ([217.140.110.172]:46880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhJMEMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 00:12:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FF7D1FB;
        Tue, 12 Oct 2021 21:10:18 -0700 (PDT)
Received: from [10.163.74.158] (unknown [10.163.74.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72C963F70D;
        Tue, 12 Oct 2021 21:10:14 -0700 (PDT)
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Gavin Shan <gshan@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
 <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <40dd8b91-7f4f-0f5f-bf15-504c0960c802@arm.com>
Date:   Wed, 13 Oct 2021 09:40:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 12:04 AM, Linus Torvalds wrote:
> Adding x86 people (VM in particular). The tests were written primarily
> for ARM, but should work on x86 too.

Did a quick test on arm64 with 5.15-rc5 without any warning. There was a
recent rework from Gavin which does not seem to have changed anything on
this test in particular.

4cbde03bdb0b ("mm/debug_vm_pgtable: use struct pgtable_debug_args in PUD modifying tests")

===============
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
+static void __init pud_huge_tests(struct pgtable_debug_args *args)
 {
        pud_t pud;
 
-       if (!arch_vmap_pud_supported(prot))
+       if (!arch_vmap_pud_supported(args->page_prot))
                return;
 
        pr_debug("Validating PUD huge\n");
@@ -460,15 +451,15 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
         * X86 defined pud_set_huge() verifies that the given
         * PUD is not a populated non-leaf entry.
         */
-       WRITE_ONCE(*pudp, __pud(0));
-       WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
-       WARN_ON(!pud_clear_huge(pudp));
-       pud = READ_ONCE(*pudp);
+       WRITE_ONCE(*args->pudp, __pud(0));
+       WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn), args->page_prot));
+       WARN_ON(!pud_clear_huge(args->pudp));
+       pud = READ_ONCE(*args->pudp);
        WARN_ON(!pud_none(pud));
 }
===============

I have run this test on x86 platform many times before (although not recently)
without any problem and never had this bug report before. Wondering if there
are recent changes on x86 platform, causing these warning.

Gavin,

Although unlikely, was there something on the series which might have
changed pud_huge_tests() ?

> 
> That warning seems to be due to pud_set_huge() failing (the "line 438"
> one I don't know what it is - there's no warning on that line in my
> tree, so I worry a bit that Steven has other things in his tree).
> 
> On x86, that can fail due to mtrr differences, or if there's already
> an entry there. Neither _should_ be an issue during the boot-time
> tests, but who knows..
> 
> Or there's something wrong with the tests. The fact that it's not
> repeatable despite being a boot-time thing is a bit odd.
> 
>              Linus
> 
> On Tue, Oct 12, 2021 at 11:11 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> My tests have been triggering on this every so often. My code is based on
>> v5.15-rc3. Note, this is not fully reproducible.
>>
>> I also get errors an mm/debug_vm_pgtable.c:438
>>
>> And it also triggers the WARN_ON()s after that as well.
>>
>> Always happens at the debug_vm_pgtable() during boot up.
>>
>> Here's the last splat:
>>
>> ------------[ cut here ]------------
>>  WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:492 debug_vm_pgtable+0x1312/0x1693
>>  Modules linked in:
>>  CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3-test+ #24
>>  Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>>  RIP: 0010:debug_vm_pgtable+0x1312/0x1693
>>  Code: 38 ff ff ff 48 c7 00 00 00 00 00 48 8b 75 b8 48 8b 95 78 ff ff ff 48 8b bd 38 ff ff ff 48 c1 e6 0c e8 62 4e 62 fe 85 c0 75 02 <0f> 0b 48 8b bd 38 ff ff ff e8 e0 50 62 fe 85 c0 75 02 0f 0b 48 8b
>>  RSP: 0000:ffffa1eac0033da8 EFLAGS: 00010246
>>  RAX: 0000000000000000 RBX: bffffffffffffff7 RCX: 0000000000000000
>>  RDX: ffffffffffe00000 RSI: ffffffff8bb477d0 RDI: 0000000000000007
>>  RBP: ffffa1eac0033e98 R08: ffffa1eac0033d23 R09: 000000021ee00000
>>  R10: 000000021effffff R11: 0000000000000000 R12: ffff8cf1436da538
>>  R13: 00003e8b00000000 R14: 000fffffffe00000 R15: 0000000000000027
>>  FS:  0000000000000000(0000) GS:ffff8cf256800000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 0000000000000000 CR3: 000000020f612001 CR4: 00000000001706e0
>>  Call Trace:
>>   ? destroy_args+0x281/0x281
>>   do_one_initcall+0x68/0x2d0
>>   ? rcu_read_lock_sched_held+0x46/0x80
>>   kernel_init_freeable+0x1a5/0x1f4
>>   ? rest_init+0x280/0x280
>>   kernel_init+0x1a/0x120
>>   ret_from_fork+0x22/0x30
>>  irq event stamp: 880991
>>  hardirqs last  enabled at (881001): [<ffffffff8a1096ef>] __up_console_sem+0x6f/0x80
>>  hardirqs last disabled at (881016): [<ffffffff8a1096d4>] __up_console_sem+0x54/0x80
>>  softirqs last  enabled at (881014): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>>  softirqs last disabled at (881009): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>>  ---[ end trace 731534acace262b5 ]---
>>  ------------[ cut here ]------------
>>  WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493 debug_vm_pgtable+0x1324/0x1693
>>  Modules linked in:
>>  CPU: 3 PID: 1 Comm: swapper/0 Tainted: G        W         5.15.0-rc3-test+ #24
>>  Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>>  RIP: 0010:debug_vm_pgtable+0x1324/0x1693
>>  Code: 78 ff ff ff 48 8b bd 38 ff ff ff 48 c1 e6 0c e8 62 4e 62 fe 85 c0 75 02 0f 0b 48 8b bd 38 ff ff ff e8 e0 50 62 fe 85 c0 75 02 <0f> 0b 48 8b 85 38 ff ff ff 48 8b 00 48 a9 9f ff ff ff 74 02 0f 0b
>>  RSP: 0000:ffffa1eac0033da8 EFLAGS: 00010246
>>  RAX: 0000000000000000 RBX: bffffffffffffff7 RCX: 0000000000000000
>>  RDX: ffffffffffe00000 RSI: ffffffff8bb477d0 RDI: ffff8cf1436db160
>>  RBP: ffffa1eac0033e98 R08: 0000000000000000 R09: 000000021ee00000
>>  R10: 000000021effffff R11: 0000000000000000 R12: ffff8cf1436da538
>>  R13: 00003e8b00000000 R14: 000fffffffe00000 R15: 0000000000000027
>>  FS:  0000000000000000(0000) GS:ffff8cf256800000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 0000000000000000 CR3: 000000020f612001 CR4: 00000000001706e0
>>  Call Trace:
>>   ? destroy_args+0x281/0x281
>>   do_one_initcall+0x68/0x2d0
>>   ? rcu_read_lock_sched_held+0x46/0x80
>>   kernel_init_freeable+0x1a5/0x1f4
>>   ? rest_init+0x280/0x280
>>   kernel_init+0x1a/0x120
>>   ret_from_fork+0x22/0x30
>>  irq event stamp: 881327
>>  hardirqs last  enabled at (881337): [<ffffffff8a1096ef>] __up_console_sem+0x6f/0x80
>>  hardirqs last disabled at (881352): [<ffffffff8a1096d4>] __up_console_sem+0x54/0x80
>>  softirqs last  enabled at (881350): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>>  softirqs last disabled at (881345): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>>  ---[ end trace 731534acace262b6 ]---
>>
>> Config attached (this is x86_64).
>>
>> -- Steve
