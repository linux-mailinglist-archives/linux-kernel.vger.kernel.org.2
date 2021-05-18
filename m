Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087A38700D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbhERCya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:54:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:18385 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhERCy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:54:29 -0400
IronPort-SDR: csTxDLbKIPnXY1NirKwDQxXedgnSZ8hLlOYt8/nyrBQgE+dqZcoU9VWHtmsCV+KJRR6uRRsoid
 WtqM1V65kPUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221661595"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221661595"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 19:53:11 -0700
IronPort-SDR: zf55Xp2jX6fZE1hqG92JwDxnU6fi+fO9KI8cLaQVyaOf4qxLBrt5U5c9b5FZii3UuOwDVRAsrq
 jNYbiodoo3PQ==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="543928534"
Received: from daltonda-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.182.28])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 19:53:10 -0700
Subject: Re: [RFC v2-fix 1/1] x86/boot: Add a trampoline for APs booting in
 64-bit mode
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
References: <CAPcyv4ipWTv7yRyLHA0Un0KZDdXjpCZXMbrEn7SJXbdRhhn=jA@mail.gmail.com>
 <20210518005404.258660-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hvFe5v72zm5+4mpmsv1u4pEizXMCcjFysKZAEkkOSrGw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <861a316c-09f6-5969-6238-e402fca917db@linux.intel.com>
Date:   Mon, 17 May 2021 19:53:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hvFe5v72zm5+4mpmsv1u4pEizXMCcjFysKZAEkkOSrGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/21 7:06 PM, Dan Williams wrote:
> I notice that you have [RFC v2-fix 1/1] as the prefix for this patch.
> b4 recently gained support for partial series re-rolls [1], but I
> think you would need to bump the version number [RFC PATCH v3 21/32]
> and maintain the patch numbering. In this case with changes moving
> between patches, and those other patches being squashed any chance of
> automated reconstruction of this series is likely lost.

Ok. I will make sure to bump the version in next partial re-roll.

If I am fixing this patch as per your comments, do I need bump the
patch version for it as well?

> 
> Just wanted to note that for future reference in case you were hoping
> to avoid resending full series in the future. For now, some more
> comments below:

Thanks.

> 
> [1]: https://lore.kernel.org/tools/20210517161317.teawoh5qovxpmqdc@nitro.local/
> 
> On Mon, May 17, 2021 at 5:54 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Add a trampoline for booting APs in 64-bit mode via a software handoff
>> with BIOS, and use the new trampoline for the ACPI MP wake protocol used
>> by TDX. You can find MADT MP wake protocol details in ACPI specification
>> r6.4, sec 5.2.12.19.
>>
>> Extend the real mode IDT pointer by four bytes to support LIDT in 64-bit
>> mode.  For the GDT pointer, create a new entry as the existing storage
>> for the pointer occupies the zero entry in the GDT itself.
>>
>> Reported-by: Kai Huang <kai.huang@intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since RFC v2:
>>   * Removed X86_CR0_NE and EFER related changes from this changes
> 
> This was only partially done, see below...
> 
>>     and moved it to patch titled "x86/boot: Avoid #VE during
>>     boot for TDX platforms"
>>   * Fixed commit log as per Dan's suggestion.
>>   * Added inline get_trampoline_start_ip() to set start_ip.
> 
> You also added a comment to tr_idt, but didn't mention it here, so I
> went to double check. Please take care to document all changes to the
> patch from the previous review.

Ok. I will make sure change log is current.

> 
>>
>>   arch/x86/boot/compressed/pgtable.h       |  2 +-
>>   arch/x86/include/asm/realmode.h          | 10 +++++++
>>   arch/x86/kernel/smpboot.c                |  2 +-
>>   arch/x86/realmode/rm/header.S            |  1 +
>>   arch/x86/realmode/rm/trampoline_64.S     | 38 ++++++++++++++++++++++++
>>   arch/x86/realmode/rm/trampoline_common.S |  7 ++++-
>>   6 files changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
>> index 6ff7e81b5628..cc9b2529a086 100644
>> --- a/arch/x86/boot/compressed/pgtable.h
>> +++ b/arch/x86/boot/compressed/pgtable.h
>> @@ -6,7 +6,7 @@
>>   #define TRAMPOLINE_32BIT_PGTABLE_OFFSET        0
>>
>>   #define TRAMPOLINE_32BIT_CODE_OFFSET   PAGE_SIZE
>> -#define TRAMPOLINE_32BIT_CODE_SIZE     0x70
>> +#define TRAMPOLINE_32BIT_CODE_SIZE     0x80
>>
>>   #define TRAMPOLINE_32BIT_STACK_END     TRAMPOLINE_32BIT_SIZE
>>
>> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
>> index 5db5d083c873..3328c8edb200 100644
>> --- a/arch/x86/include/asm/realmode.h
>> +++ b/arch/x86/include/asm/realmode.h
>> @@ -25,6 +25,7 @@ struct real_mode_header {
>>          u32     sev_es_trampoline_start;
>>   #endif
>>   #ifdef CONFIG_X86_64
>> +       u32     trampoline_start64;
>>          u32     trampoline_pgd;
>>   #endif
>>          /* ACPI S3 wakeup */
>> @@ -88,6 +89,15 @@ static inline void set_real_mode_mem(phys_addr_t mem)
>>          real_mode_header = (struct real_mode_header *) __va(mem);
>>   }
>>
>> +static inline unsigned long get_trampoline_start_ip(void)
> 
> I'd prefer this helper take a 'struct real_mode_header *rmh' as an
> argument rather than assume a global variable.

I am fine with it. But existing inline functions also directly read/writes
the real_mode_header. So I just followed the same format.

I will fix this in next version.

> 
>> +{
>> +#ifdef CONFIG_X86_64
>> +        if (is_tdx_guest())
>> +                return real_mode_header->trampoline_start64;
>> +#endif
>> +       return real_mode_header->trampoline_start;
>> +}
>> +
>>   void reserve_real_mode(void);
>>
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 16703c35a944..0b4dff5e67a9 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1031,7 +1031,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>                         int *cpu0_nmi_registered)
>>   {
>>          /* start_ip had better be page-aligned! */
>> -       unsigned long start_ip = real_mode_header->trampoline_start;
>> +       unsigned long start_ip = get_trampoline_start_ip();
>>
>>          unsigned long boot_error = 0;
>>          unsigned long timeout;
>> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
>> index 8c1db5bf5d78..2eb62be6d256 100644
>> --- a/arch/x86/realmode/rm/header.S
>> +++ b/arch/x86/realmode/rm/header.S
>> @@ -24,6 +24,7 @@ SYM_DATA_START(real_mode_header)
>>          .long   pa_sev_es_trampoline_start
>>   #endif
>>   #ifdef CONFIG_X86_64
>> +       .long   pa_trampoline_start64
>>          .long   pa_trampoline_pgd;
>>   #endif
>>          /* ACPI S3 wakeup */
>> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
>> index 84c5d1b33d10..754f8d2ac9e8 100644
>> --- a/arch/x86/realmode/rm/trampoline_64.S
>> +++ b/arch/x86/realmode/rm/trampoline_64.S
>> @@ -161,6 +161,19 @@ SYM_CODE_START(startup_32)
>>          ljmpl   $__KERNEL_CS, $pa_startup_64
>>   SYM_CODE_END(startup_32)
>>
>> +SYM_CODE_START(pa_trampoline_compat)
>> +       /*
>> +        * In compatibility mode.  Prep ESP and DX for startup_32, then disable
>> +        * paging and complete the switch to legacy 32-bit mode.
>> +        */
>> +       movl    $rm_stack_end, %esp
>> +       movw    $__KERNEL_DS, %dx
>> +
>> +       movl    $(X86_CR0_NE | X86_CR0_PE), %eax
> 
> Before this patch the startup path did not touch X86_CR0_NE. I assume
> it was added opportunistically for the TDX case? If it is to stay in
> this patch it deserves a code comment / mention in the changelog, or
> it needs to move to the other patch that fixes up the CR0 setup for
> TDX.

I will move X86_CR0_NE related update to the patch that has other
X86_CR0_NE related updates.

> 
> 
>> +       movl    %eax, %cr0
>> +       ljmpl   $__KERNEL32_CS, $pa_startup_32
>> +SYM_CODE_END(pa_trampoline_compat)
>> +
>>          .section ".text64","ax"
>>          .code64
>>          .balign 4
>> @@ -169,6 +182,20 @@ SYM_CODE_START(startup_64)
>>          jmpq    *tr_start(%rip)
>>   SYM_CODE_END(startup_64)
>>
>> +SYM_CODE_START(trampoline_start64)
>> +       /*
>> +        * APs start here on a direct transfer from 64-bit BIOS with identity
>> +        * mapped page tables.  Load the kernel's GDT in order to gear down to
>> +        * 32-bit mode (to handle 4-level vs. 5-level paging), and to (re)load
>> +        * segment registers.  Load the zero IDT so any fault triggers a
>> +        * shutdown instead of jumping back into BIOS.
>> +        */
>> +       lidt    tr_idt(%rip)
>> +       lgdt    tr_gdt64(%rip)
>> +
>> +       ljmpl   *tr_compat(%rip)
>> +SYM_CODE_END(trampoline_start64)
>> +
>>          .section ".rodata","a"
>>          # Duplicate the global descriptor table
>>          # so the kernel can live anywhere
>> @@ -182,6 +209,17 @@ SYM_DATA_START(tr_gdt)
>>          .quad   0x00cf93000000ffff      # __KERNEL_DS
>>   SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
>>
>> +SYM_DATA_START(tr_gdt64)
>> +       .short  tr_gdt_end - tr_gdt - 1 # gdt limit
>> +       .long   pa_tr_gdt
>> +       .long   0
>> +SYM_DATA_END(tr_gdt64)
>> +
>> +SYM_DATA_START(tr_compat)
>> +       .long   pa_trampoline_compat
>> +       .short  __KERNEL32_CS
>> +SYM_DATA_END(tr_compat)
>> +
>>          .bss
>>          .balign PAGE_SIZE
>>   SYM_DATA(trampoline_pgd, .space PAGE_SIZE)
>> diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
>> index 5033e640f957..ade7db208e4e 100644
>> --- a/arch/x86/realmode/rm/trampoline_common.S
>> +++ b/arch/x86/realmode/rm/trampoline_common.S
>> @@ -1,4 +1,9 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>          .section ".rodata","a"
>>          .balign 16
>> -SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
>> +
>> +/* .fill cannot be used for size > 8. So use short and quad */
> 
> If there is to be a comment here it should be to clarify why @tr_idt
> is 10 bytes, not necessarily a quirk of the assembler.

Got it. I will fix the comment or remove it.

> 
>> +SYM_DATA_START_LOCAL(tr_idt)
> 
> The .fill restriction is only for @size, not @repeat. So, what's wrong
> with SYM_DATA_LOCAL(tr_idt, .fill 2, 5, 0)?

Any reason to prefer above change over previous code ?

SYM_DATA_START_LOCAL(tr_idt)
         .short  0
         .quad   0
SYM_DATA_END(tr_idt)

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
