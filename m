Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D737F174
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhEMC5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhEMC5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:57:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB48C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 19:56:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j26so25730857edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfLvpQkOXb/0mc5ID6W6SJ563fzW4AnWs2gl3gOGpKU=;
        b=iYg4BRRSJEjuIKdzPtyQBs3rZhK7U09uQ7ULwifgp/seJXBoxAsHU4eydyd0epyN1D
         L/XD99EiCbO8nNHGckQVYURJqPoiMXCh5pmVoBVik0mw/ZY942IQUStgtIaKLRQhAB3b
         Fmv/ssgLSC2jbl/Nul7kXMcbszjUfHP0eEhu8Hh1QCnstKI3h0/YOgDuoElWXbcSkHOg
         kE3ZRuUeAD8OfPvmDFsJBMve0B4Wi+ztxK6KHui0epib4y4dn36A1DOkqpnvGz4ePwo0
         KEM10Cg+ynK1ooTajnzFpq1lA5lvk63SgP/dx83+52K1mFBtuq80oacJvHJ9zQEgN95/
         w9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfLvpQkOXb/0mc5ID6W6SJ563fzW4AnWs2gl3gOGpKU=;
        b=FooeFIAvvdi1KwsqwtPIiThCXZIU3oQ5xqw7ozRrvE5KWNkvHPbdDCPeD5Iy3mzhoT
         +zOv/H8iOS34DYwwsyGpX1m8QRYos4WeOqmygSoVuOKBKlWLXUoR9DspGnd64O+ODN2Z
         5hcAZwi4RsG22dKRsr1+DW8GKuGPzJcBW0QrKPgnBSCjaXLQXEadpONOzlAhySFKOwmh
         IjzrbgFCAutz5h593GDtAkTW6Q70xWrARFYiyybwzmqE/TKa9/0EmLn8CAVGBsxTeuQ5
         QrXnm2Y+qqQ0coIoELJEOBxi1kF4FwwapdUxQ2qB44GOXxGEibH4YX/h5t6ilZ7mAzfE
         A91A==
X-Gm-Message-State: AOAM530xkJKQQPPfAteqLWZFBXvstBq95jEfNf+AmlbhZGDSfzwlW8G8
        O50kralmefcRxhBxJZOonsG6eQjbye7wR/Ag91qw9Q==
X-Google-Smtp-Source: ABdhPJxKqMzfAVkdnpbhLe5lHlfN9lCK6NxW6G40JdaUWpE9f++vzBOorWIbLAEOt2/zVuDTAfTqIV5HdmyMe5r0tT8=
X-Received: by 2002:a05:6402:13c3:: with SMTP id a3mr10612489edx.18.1620874588347;
 Wed, 12 May 2021 19:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com> <13f8d4117f7b871f20f53403167913803bef87c2.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <13f8d4117f7b871f20f53403167913803bef87c2.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 May 2021 19:56:18 -0700
Message-ID: <CAPcyv4ipWTv7yRyLHA0Un0KZDdXjpCZXMbrEn7SJXbdRhhn=jA@mail.gmail.com>
Subject: Re: [RFC v2 21/32] x86/boot: Add a trampoline for APs booting in
 64-bit mode
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:03 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Add a trampoline for booting APs in 64-bit mode via a software handoff
> with BIOS, and use the new trampoline for the ACPI MP wake protocol used
> by TDX.

Lets add a spec reference:

See section "4.1 ACPI-MADT-AP-Wakeup Table" in the Guest-Host
Communication Interface specification for TDX.

Although, there is not much "wake protocol" in this patch, this
appears to be the end of the process after the CPU has been messaged
to start.

> Extend the real mode IDT pointer by four bytes to support LIDT in 64-bit
> mode.  For the GDT pointer, create a new entry as the existing storage
> for the pointer occupies the zero entry in the GDT itself.
>
> Reported-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/realmode.h          |  1 +
>  arch/x86/kernel/smpboot.c                |  5 +++
>  arch/x86/realmode/rm/header.S            |  1 +
>  arch/x86/realmode/rm/trampoline_64.S     | 49 +++++++++++++++++++++++-
>  arch/x86/realmode/rm/trampoline_common.S |  5 ++-
>  5 files changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 5db5d083c873..5066c8b35e7c 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -25,6 +25,7 @@ struct real_mode_header {
>         u32     sev_es_trampoline_start;
>  #endif
>  #ifdef CONFIG_X86_64
> +       u32     trampoline_start64;
>         u32     trampoline_pgd;
>  #endif
>         /* ACPI S3 wakeup */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 16703c35a944..27d8491d753a 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1036,6 +1036,11 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>         unsigned long boot_error = 0;
>         unsigned long timeout;
>
> +#ifdef CONFIG_X86_64
> +       if (is_tdx_guest())
> +               start_ip = real_mode_header->trampoline_start64;
> +#endif

Perhaps wrap this into an inline helper in
arch/x86/include/asm/realmode.h so that this routine only does one
assignment to @start_ip at function entry?

> +
>         idle->thread.sp = (unsigned long)task_pt_regs(idle);
>         early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
>         initial_code = (unsigned long)start_secondary;
> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
> index 8c1db5bf5d78..2eb62be6d256 100644
> --- a/arch/x86/realmode/rm/header.S
> +++ b/arch/x86/realmode/rm/header.S
> @@ -24,6 +24,7 @@ SYM_DATA_START(real_mode_header)
>         .long   pa_sev_es_trampoline_start
>  #endif
>  #ifdef CONFIG_X86_64
> +       .long   pa_trampoline_start64
>         .long   pa_trampoline_pgd;
>  #endif
>         /* ACPI S3 wakeup */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index 84c5d1b33d10..12b734b1da8b 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -143,13 +143,20 @@ SYM_CODE_START(startup_32)
>         movl    %eax, %cr3
>
>         # Set up EFER
> +       movl    $MSR_EFER, %ecx
> +       rdmsr
> +       cmp     pa_tr_efer, %eax
> +       jne     .Lwrite_efer
> +       cmp     pa_tr_efer + 4, %edx
> +       je      .Ldone_efer
> +.Lwrite_efer:
>         movl    pa_tr_efer, %eax
>         movl    pa_tr_efer + 4, %edx
> -       movl    $MSR_EFER, %ecx
>         wrmsr

Is this hunk just a performance optimization to save an unnecessary
wrmsr when it is pre-populated with the right value? Is it required
for this patch? If "yes", it was not clear to me from the changelog,
if "no" seems like it belongs in a standalone optimization patch.

>
> +.Ldone_efer:
>         # Enable paging and in turn activate Long Mode
> -       movl    $(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
> +       movl    $(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax

It seems setting X86_CR0_NE is redundant when coming through
pa_trampoline_compat, is this a standalone fix to make sure that
'numeric-error' is enabled before startup_64?

>         movl    %eax, %cr0
>
>         /*
> @@ -161,6 +168,19 @@ SYM_CODE_START(startup_32)
>         ljmpl   $__KERNEL_CS, $pa_startup_64
>  SYM_CODE_END(startup_32)
>
> +SYM_CODE_START(pa_trampoline_compat)
> +       /*
> +        * In compatibility mode.  Prep ESP and DX for startup_32, then disable
> +        * paging and complete the switch to legacy 32-bit mode.
> +        */
> +       movl    $rm_stack_end, %esp
> +       movw    $__KERNEL_DS, %dx
> +
> +       movl    $(X86_CR0_NE | X86_CR0_PE), %eax
> +       movl    %eax, %cr0
> +       ljmpl   $__KERNEL32_CS, $pa_startup_32
> +SYM_CODE_END(pa_trampoline_compat)
> +
>         .section ".text64","ax"
>         .code64
>         .balign 4
> @@ -169,6 +189,20 @@ SYM_CODE_START(startup_64)
>         jmpq    *tr_start(%rip)
>  SYM_CODE_END(startup_64)
>
> +SYM_CODE_START(trampoline_start64)
> +       /*
> +        * APs start here on a direct transfer from 64-bit BIOS with identity
> +        * mapped page tables.  Load the kernel's GDT in order to gear down to
> +        * 32-bit mode (to handle 4-level vs. 5-level paging), and to (re)load
> +        * segment registers.  Load the zero IDT so any fault triggers a
> +        * shutdown instead of jumping back into BIOS.
> +        */
> +       lidt    tr_idt(%rip)
> +       lgdt    tr_gdt64(%rip)
> +
> +       ljmpl   *tr_compat(%rip)
> +SYM_CODE_END(trampoline_start64)
> +
>         .section ".rodata","a"
>         # Duplicate the global descriptor table
>         # so the kernel can live anywhere
> @@ -182,6 +216,17 @@ SYM_DATA_START(tr_gdt)
>         .quad   0x00cf93000000ffff      # __KERNEL_DS
>  SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
>
> +SYM_DATA_START(tr_gdt64)
> +       .short  tr_gdt_end - tr_gdt - 1 # gdt limit
> +       .long   pa_tr_gdt
> +       .long   0
> +SYM_DATA_END(tr_gdt64)
> +
> +SYM_DATA_START(tr_compat)
> +       .long   pa_trampoline_compat
> +       .short  __KERNEL32_CS
> +SYM_DATA_END(tr_compat)
> +
>         .bss
>         .balign PAGE_SIZE
>  SYM_DATA(trampoline_pgd, .space PAGE_SIZE)
> diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
> index 5033e640f957..506d5897112a 100644
> --- a/arch/x86/realmode/rm/trampoline_common.S
> +++ b/arch/x86/realmode/rm/trampoline_common.S
> @@ -1,4 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>         .section ".rodata","a"
>         .balign 16
> -SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
> +SYM_DATA_START_LOCAL(tr_idt)
> +       .short  0
> +       .quad   0
> +SYM_DATA_END(tr_idt)

Curious, is the following not equivalent?

-SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
+SYM_DATA_LOCAL(tr_idt, .fill 1, 10, 0)
