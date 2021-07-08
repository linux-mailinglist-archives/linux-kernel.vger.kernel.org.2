Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A23C14ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGHORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:17:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E41C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 07:14:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v189so692828ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dpcXBje5o+IzAkJod12omjIPO6Vrqtw2W0UJN0YcO0c=;
        b=tQNI/XkUCMWgpn1REnUEdj6p65V1BVDeRoIFxZjcw5pTaEcgP70Zq6DObVom5V0kps
         u+DZPQk9lrZp+kcRgz+hFCJxXFj2f++n+eB8cwTUCbhJM2EUAxUb1bvTMXPXDrFvk3yk
         m/GTSzLsilEnGsATlLTdfD7y+Q1g95geDwuZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dpcXBje5o+IzAkJod12omjIPO6Vrqtw2W0UJN0YcO0c=;
        b=V6jCcKqiLkur6gXzO7nFjtyuQcJbFgfpML6uNkFoIqYBnN7lkpXqIsbhWKcpNPr3Fs
         7NIAl55KCl8rMf/1d7o2YdhFMmyV3waDRBI1Xsu368R+Vt7Y0b2syQaFKGMfFn9xBM0v
         YXEgX9EkYIl3NeCeM2BCJlIW1cVOYxbICzafvZzqd02saKS3tua7a+D9yPGUfnNdLvy0
         sOg3JQN0Oki+iXt1QOpYVcbLOMKyAsU8bSaPdfZMPlvAPEq/RV0eXMHF7PhvM9HA550x
         MO/lV2msOJXEFxV+asU29QbJvAhlFpqKF6qeDFb9axhM1sw8wKYxlL+a2QeiKHBQEQvg
         KQrA==
X-Gm-Message-State: AOAM531mU01yrOrR27fpA2EWHwOa6GLyKl7Pv8HkZ7UPL9Osjwa6/4zu
        YqDs0EyjeMGcXX7JCikm4wt4qn6WF4thjDSiy0sxSQ==
X-Google-Smtp-Source: ABdhPJw+8pWFY64jlwW6mxRAMiUbaMbWGnJHMPdH7rH5x6NtUNzjHwaFgUjUMWRISk0h7LlLLLBlUJBUW98wJ5JDJDE=
X-Received: by 2002:a25:2e02:: with SMTP id u2mr22584439ybu.359.1625753662010;
 Thu, 08 Jul 2021 07:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210618142353.2114854-1-alex@ghiti.fr> <23a3fc82-ecd9-4cdf-dc91-2d0fb996260a@ghiti.fr>
In-Reply-To: <23a3fc82-ecd9-4cdf-dc91-2d0fb996260a@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 8 Jul 2021 16:14:11 +0200
Message-ID: <CAM4kBBJSrf=LuwQ=ktfZQgT6TRY0ufmBZNdNOjyn8D-H7MCF-g@mail.gmail.com>
Subject: Re: [PATCH RFC] riscv: Remove all XIP fixups by initializing MMU in memory
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Jul 8, 2021 at 1:43 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 18/06/2021 =C3=A0 16:23, Alexandre Ghiti a =C3=A9crit :
> > For XIP kernel, the variables that are accessed when the MMU is off mus=
t be
> > fixup and it is currently achieved by adding a preprocessor macro for a=
ll
> > those variables. This comes with a few drawbacks:
> >
> > - it adds a lot of code, especially in mm/init.c which gets overloaded,
> > - it easily breaks XIP kernels as anyone accessing a global variable be=
fore
> >    the MMU is on must fixup this variable,
> > - it prevents the usage of those fixup variables anywhere outside
> >    mm/init.c: kernel addresses conversion macros would benefit to switc=
h
> >    to inline functions.
> >
> > This patch makes the data fixups unnecessary by initializing the MMU in=
 the
> > memory rather than in flash. Indeed, very soon in the boot process, the
> > kernel is copied to memory and the execution continues from there until
> > the kernel mapping is established where the execution jumps back in
> > flash. Then the offsets from the PC are preserved and no fixup is
> > necessary. And the kernel text in memory is never reserved so it is fre=
e
> > to use later on.
> >
> > This solution has the following drawbacks:
> >
> > - XIP kernel boot is longer because of the copy to memory, but can be
> >    improved by copying only necessary parts,
> > - in the current implementation, it creates a hole at the beginning of
> >    the memory which could prevent large contiguous allocation,
> > - it actually just inverts what needs to be fixup: now rodata and text
> >    symbols accessed during the initialization of the MMU must be fixup
> >    whereas it was data before. However, I found a single fixup to be
> >    necessary and it is the dtb physical address in case CONFIG_BUILTIN_=
DTB
> >    is set.
> >
>
> @Vitaly; Any thought about that? Could you take some time to review/test
> this approach?

thanks for the heads-up. In my opinion, this thing with XIP on RISC-V
is currently going in the completely wrong direction. I would like to
see less data copying and less RAM usage, not more data copying and
more RAM usage.

I would also like to see kernel_mapping_pa_to_va /
kernel_mapping_va_to_pa simplified but that is a different story. I
might come up with something soon though.

Best regards,
   Vitaly

> Thanks!
>
> Alex
>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >   arch/riscv/include/asm/page.h    | 12 ++---
> >   arch/riscv/include/asm/pgtable.h | 22 +-------
> >   arch/riscv/kernel/head.S         | 87 +++++++++++++++++++++++--------=
-
> >   arch/riscv/kernel/setup.c        |  2 +-
> >   arch/riscv/mm/init.c             | 59 +++-------------------
> >   5 files changed, 78 insertions(+), 104 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 5d4622a44b09..97a950bbd3bf 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -105,11 +105,11 @@ extern unsigned long kernel_virt_addr;
> >       ((x) >=3D PAGE_OFFSET && (x) < kernel_virt_addr)
> >
> >   #define linear_mapping_pa_to_va(x)  ((void *)((unsigned long)(x) + va=
_pa_offset))
> > -#define kernel_mapping_pa_to_va(y)   ({                               =
               \
> > -     unsigned long _y =3D y;                                          =
                 \
> > -     (_y >=3D CONFIG_PHYS_RAM_BASE) ?                                 =
                 \
> > -             (void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_=
OFFSET) :      \
> > -             (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset); =
               \
> > +#define kernel_mapping_pa_to_va(y)   ({                               =
       \
> > +     unsigned long _y =3D y;                                          =
         \
> > +     (_y >=3D CONFIG_PHYS_RAM_BASE) ?                                 =
         \
> > +             (void *)((unsigned long)(_y) + va_kernel_pa_offset) :    =
       \
> > +             (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset); =
       \
> >       })
> >   #define __pa_to_va_nodebug(x)               linear_mapping_pa_to_va(x=
)
> >
> > @@ -118,7 +118,7 @@ extern unsigned long kernel_virt_addr;
> >       unsigned long _y =3D y;                                          =
         \
> >       (_y < kernel_virt_addr + XIP_OFFSET) ?                           =
       \
> >               ((unsigned long)(_y) - va_kernel_xip_pa_offset) :        =
       \
> > -             ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);=
       \
> > +             ((unsigned long)(_y) - va_kernel_pa_offset);             =
       \
> >       })
> >
> >   #define __va_to_pa_nodebug(x)       ({                               =
               \
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 3ccd2dc52e85..99ec99384bf0 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -95,17 +95,6 @@
> >   #include <asm/pgtable-32.h>
> >   #endif /* CONFIG_64BIT */
> >
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define XIP_FIXUP(addr) ({                                            =
       \
> > -     uintptr_t __a =3D (uintptr_t)(addr);                             =
         \
> > -     (__a >=3D CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ=
_16M) ?  \
> > -             __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_O=
FFSET :\
> > -             __a;                                                     =
       \
> > -     })
> > -#else
> > -#define XIP_FIXUP(addr)              (addr)
> > -#endif /* CONFIG_XIP_KERNEL */
> > -
> >   #ifdef CONFIG_MMU
> >   /* Number of entries in the page global directory */
> >   #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> > @@ -683,15 +672,8 @@ static inline pmd_t pmdp_establish(struct vm_area_=
struct *vma,
> >   #define kern_addr_valid(addr)   (1) /* FIXME */
> >
> >   extern char _start[];
> > -extern void *_dtb_early_va;
> > -extern uintptr_t _dtb_early_pa;
> > -#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
> > -#define dtb_early_va (*(void **)XIP_FIXUP(&_dtb_early_va))
> > -#define dtb_early_pa (*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
> > -#else
> > -#define dtb_early_va _dtb_early_va
> > -#define dtb_early_pa _dtb_early_pa
> > -#endif /* CONFIG_XIP_KERNEL */
> > +extern void *dtb_early_va;
> > +extern uintptr_t dtb_early_pa;
> >
> >   void paging_init(void);
> >   void misc_mem_init(void);
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 89cc58ab52b4..7ac7d2bd1a53 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -17,14 +17,33 @@
> >
> >   #ifdef CONFIG_XIP_KERNEL
> >   .macro XIP_FIXUP_OFFSET reg
> > -     REG_L t0, _xip_fixup
> > +     li t0, CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR
> >       add \reg, \reg, t0
> >   .endm
> > -_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_O=
FFSET
> > +
> > +.macro MEM_FIXUP_OFFSET reg
> > +     li t0, CONFIG_XIP_PHYS_ADDR - CONFIG_PHYS_RAM_BASE
> > +     add \reg, \reg, t0
> > +.endm
> > +
> > +.macro XIP_JUMP_TO_MEM
> > +     la t1, 0f
> > +     XIP_FIXUP_OFFSET t1
> > +     jalr ra, t1, 0
> > +0:
> > +     /* Reload the global pointer: we are now in memory! */
> > +.option push
> > +.option norelax
> > +     la gp, __global_pointer$
> > +.option pop
> > +.endm
> >   #else
> > -.macro XIP_FIXUP_OFFSET reg
> > +.macro MEM_FIXUP_OFFSET reg
> > +.endm
> > +
> > +.macro XIP_JUMP_TO_MEM
> >   .endm
> > -#endif /* CONFIG_XIP_KERNEL */
> > +#endif
> >
> >   __HEAD
> >   ENTRY(_start)
> > @@ -82,7 +101,6 @@ pe_head_start:
> >   relocate:
> >       /* Relocate return address */
> >       la a1, kernel_virt_addr
> > -     XIP_FIXUP_OFFSET a1
> >       REG_L a1, 0(a1)
> >       la a2, _start
> >       sub a1, a1, a2
> > @@ -105,7 +123,6 @@ relocate:
> >        * to ensure the new translations are in use.
> >        */
> >       la a0, trampoline_pg_dir
> > -     XIP_FIXUP_OFFSET a0
> >       srl a0, a0, PAGE_SHIFT
> >       or a0, a0, a1
> >       sfence.vma
> > @@ -159,9 +176,7 @@ secondary_start_sbi:
> >
> >       slli a3, a0, LGREG
> >       la a4, __cpu_up_stack_pointer
> > -     XIP_FIXUP_OFFSET a4
> >       la a5, __cpu_up_task_pointer
> > -     XIP_FIXUP_OFFSET a5
> >       add a4, a3, a4
> >       add a5, a3, a5
> >       REG_L sp, (a4)
> > @@ -173,7 +188,6 @@ secondary_start_common:
> >   #ifdef CONFIG_MMU
> >       /* Enable virtual memory and relocate to virtual address */
> >       la a0, swapper_pg_dir
> > -     XIP_FIXUP_OFFSET a0
> >       call relocate
> >   #endif
> >       call setup_trap_vector
> > @@ -253,14 +267,12 @@ pmp_done:
> >       tail .Lsecondary_park
> >   .Lgood_cores:
> >   #endif
> > -
> >   #ifndef CONFIG_XIP_KERNEL
> >       /* Pick one hart to run the main boot sequence */
> >       la a3, hart_lottery
> >       li a2, 1
> >       amoadd.w a3, a2, (a3)
> >       bnez a3, .Lsecondary_start
> > -
> >   #else
> >       /* hart_lottery in flash contains a magic number */
> >       la a3, hart_lottery
> > @@ -270,17 +282,43 @@ pmp_done:
> >       amoswap.w t0, t1, (a2)
> >       /* first time here if hart_lottery in RAM is not set */
> >       beq t0, t1, .Lsecondary_start
> > -
> > -     la sp, _end + THREAD_SIZE
> > -     XIP_FIXUP_OFFSET sp
> > +     /*
> > +      * Copy the kernel text and data to memory: the virtual mapping w=
ill be
> > +      * established from there, and then we will jump back to using fl=
ash
> > +      * resident text. This avoids to fixup global symbols when the co=
de
> > +      * is executed from flash and targets data in memory before the M=
MU is
> > +      * enabled.
> > +      * We must preserve a0, a1 and we have no stack yet (__memcpy doe=
s not
> > +      * spill anything).
> > +      */
> >       mv s0, a0
> > -     call __copy_data
> > +     mv s1, a1
> > +
> > +     li a0, CONFIG_PHYS_RAM_BASE
> > +     la a1, _xiprom
> > +     la a2, _exiprom
> > +     sub a2, a2, a1
> > +     add a2, a2, 1
> > +     call __memcpy
> > +
> > +     li a0, CONFIG_PHYS_RAM_BASE + XIP_OFFSET
> > +     la a1, _sdata
> > +     la a2, _end
> > +     sub a2, a2, a1
> > +     add a2, a2, 1
> > +     call __memcpy
> > +
> > +     fence.i
> >
> > -     /* Restore a0 copy */
> >       mv a0, s0
> > -#endif
> > +     mv a1, s1
> >
> > -#ifndef CONFIG_XIP_KERNEL
> > +     /*
> > +      * From here, the code will be executed from memory and we'll jum=
p back
> > +      * to flash once the MMU is enabled.
> > +      */
> > +     XIP_JUMP_TO_MEM
> > +#endif
> >       /* Clear BSS for flat non-ELF images */
> >       la a3, __bss_start
> >       la a4, __bss_stop
> > @@ -290,27 +328,24 @@ clear_bss:
> >       add a3, a3, RISCV_SZPTR
> >       blt a3, a4, clear_bss
> >   clear_bss_done:
> > -#endif
> >       /* Save hart ID and DTB physical address */
> >       mv s0, a0
> >       mv s1, a1
> >
> >       la a2, boot_cpu_hartid
> > -     XIP_FIXUP_OFFSET a2
> >       REG_S a0, (a2)
> >
> >       /* Initialize page tables and relocate to virtual addresses */
> >       la sp, init_thread_union + THREAD_SIZE
> > -     XIP_FIXUP_OFFSET sp
> >   #ifdef CONFIG_BUILTIN_DTB
> >       la a0, __dtb_start
> > +     MEM_FIXUP_OFFSET a0
> >   #else
> >       mv a0, s1
> >   #endif /* CONFIG_BUILTIN_DTB */
> >       call setup_vm
> >   #ifdef CONFIG_MMU
> >       la a0, early_pg_dir
> > -     XIP_FIXUP_OFFSET a0
> >       call relocate
> >   #endif /* CONFIG_MMU */
> >
> > @@ -329,15 +364,19 @@ clear_bss_done:
> >
> >   .Lsecondary_start:
> >   #ifdef CONFIG_SMP
> > +     /*
> > +      * From here, XIP kernel will be executed from memory and we'll j=
ump back
> > +      * to flash once the MMU is enabled.
> > +      */
> > +     XIP_JUMP_TO_MEM
> > +
> >       /* Set trap vector to spin forever to help debug */
> >       la a3, .Lsecondary_park
> >       csrw CSR_TVEC, a3
> >
> >       slli a3, a0, LGREG
> >       la a1, __cpu_up_stack_pointer
> > -     XIP_FIXUP_OFFSET a1
> >       la a2, __cpu_up_task_pointer
> > -     XIP_FIXUP_OFFSET a2
> >       add a1, a3, a1
> >       add a2, a3, a2
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 8b7f1c791821..8b7958b30a05 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -279,7 +279,7 @@ void __init setup_arch(char **cmdline_p)
> >   #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >       unflatten_and_copy_device_tree();
> >   #else
> > -     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > +     if (early_init_dt_verify(__va(dtb_early_pa)))
> >               unflatten_device_tree();
> >       else
> >               pr_err("No DTB found in kernel mappings\n");
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 3d77b04bec54..a70cdd77b2be 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -33,7 +33,6 @@
> >   unsigned long kernel_virt_addr =3D KERNEL_LINK_ADDR;
> >   EXPORT_SYMBOL(kernel_virt_addr);
> >   #ifdef CONFIG_XIP_KERNEL
> > -#define kernel_virt_addr       (*((unsigned long *)XIP_FIXUP(&kernel_v=
irt_addr)))
> >   extern char _xiprom[], _exiprom[];
> >   #endif
> >
> > @@ -43,8 +42,8 @@ EXPORT_SYMBOL(empty_zero_page);
> >
> >   extern char _start[];
> >   #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> > -void *_dtb_early_va __initdata;
> > -uintptr_t _dtb_early_pa __initdata;
> > +void *dtb_early_va __initdata;
> > +uintptr_t dtb_early_pa __initdata;
> >
> >   struct pt_alloc_ops {
> >       pte_t *(*get_pte_virt)(phys_addr_t pa);
> > @@ -203,33 +202,18 @@ static void __init setup_bootmem(void)
> >   }
> >
> >   #ifdef CONFIG_MMU
> > -static struct pt_alloc_ops _pt_ops __initdata;
> > -
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> > -#else
> > -#define pt_ops _pt_ops
> > -#endif
> > +static struct pt_alloc_ops pt_ops __initdata;
> >
> >   /* Offset between linear mapping virtual address and kernel load addr=
ess */
> >   unsigned long va_pa_offset __ro_after_init;
> >   EXPORT_SYMBOL(va_pa_offset);
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define va_pa_offset   (*((unsigned long *)XIP_FIXUP(&va_pa_offset)))
> > -#endif
> >   /* Offset between kernel mapping virtual address and kernel load addr=
ess */
> >   #ifdef CONFIG_64BIT
> >   unsigned long va_kernel_pa_offset __ro_after_init;
> >   EXPORT_SYMBOL(va_kernel_pa_offset);
> >   #endif
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define va_kernel_pa_offset    (*((unsigned long *)XIP_FIXUP(&va_kerne=
l_pa_offset)))
> > -#endif
> >   unsigned long va_kernel_xip_pa_offset __ro_after_init;
> >   EXPORT_SYMBOL(va_kernel_xip_pa_offset);
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define va_kernel_xip_pa_offset        (*((unsigned long *)XIP_FIXUP(&=
va_kernel_xip_pa_offset)))
> > -#endif
> >   unsigned long pfn_base __ro_after_init;
> >   EXPORT_SYMBOL(pfn_base);
> >
> > @@ -239,12 +223,6 @@ static pte_t fixmap_pte[PTRS_PER_PTE] __page_align=
ed_bss;
> >
> >   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> >
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> > -#define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
> > -#define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> > -#endif /* CONFIG_XIP_KERNEL */
> > -
> >   void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_=
t prot)
> >   {
> >       unsigned long addr =3D __fix_to_virt(idx);
> > @@ -320,12 +298,6 @@ static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_align=
ed_bss;
> >   static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> >   static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SI=
ZE);
> >
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
> > -#define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
> > -#define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
> > -#endif /* CONFIG_XIP_KERNEL */
> > -
> >   static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> >   {
> >       /* Before MMU is enabled */
> > @@ -442,19 +414,6 @@ static uintptr_t __init best_map_size(phys_addr_t =
base, phys_addr_t size)
> >       return PMD_SIZE;
> >   }
> >
> > -#ifdef CONFIG_XIP_KERNEL
> > -/* called from head.S with MMU off */
> > -asmlinkage void __init __copy_data(void)
> > -{
> > -     void *from =3D (void *)(&_sdata);
> > -     void *end =3D (void *)(&_end);
> > -     void *to =3D (void *)CONFIG_PHYS_RAM_BASE;
> > -     size_t sz =3D (size_t)(end - from + 1);
> > -
> > -     memcpy(to, from, sz);
> > -}
> > -#endif
> > -
> >   #ifdef CONFIG_STRICT_KERNEL_RWX
> >   static __init pgprot_t pgprot_from_va(uintptr_t va)
> >   {
> > @@ -511,16 +470,10 @@ static __init pgprot_t pgprot_from_va(uintptr_t v=
a)
> >
> >   static uintptr_t load_pa __initdata;
> >   uintptr_t load_sz;
> > -#ifdef CONFIG_XIP_KERNEL
> > -#define load_pa        (*((uintptr_t *)XIP_FIXUP(&load_pa)))
> > -#define load_sz        (*((uintptr_t *)XIP_FIXUP(&load_sz)))
> > -#endif
> >
> >   #ifdef CONFIG_XIP_KERNEL
> >   static uintptr_t xiprom __initdata;
> >   static uintptr_t xiprom_sz __initdata;
> > -#define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
> > -#define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
> >
> >   static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t m=
ap_size,
> >                                           __always_unused bool early)
> > @@ -538,7 +491,7 @@ static void __init create_kernel_page_table(pgd_t *=
pgdir, uintptr_t map_size,
> >       end_va =3D kernel_virt_addr + XIP_OFFSET + load_sz;
> >       for (va =3D kernel_virt_addr + XIP_OFFSET; va < end_va; va +=3D m=
ap_size)
> >               create_pgd_mapping(pgdir, va,
> > -                                load_pa + (va - (kernel_virt_addr + XI=
P_OFFSET)),
> > +                                load_pa + (va - kernel_virt_addr),
> >                                  map_size, PAGE_KERNEL);
> >   }
> >   #else
> > @@ -648,7 +601,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >        * whereas dtb_early_va will be used before setup_vm_final instal=
ls
> >        * the linear mapping.
> >        */
> > -     dtb_early_va =3D kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
> > +     dtb_early_va =3D kernel_mapping_pa_to_va(dtb_pa);
> >   #else
> >       dtb_early_va =3D __va(dtb_pa);
> >   #endif /* CONFIG_64BIT */
> > @@ -664,7 +617,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       dtb_early_va =3D (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZ=
E - 1));
> >   #else /* CONFIG_BUILTIN_DTB */
> >   #ifdef CONFIG_64BIT
> > -     dtb_early_va =3D kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
> > +     dtb_early_va =3D kernel_mapping_pa_to_va(dtb_pa);
> >   #else
> >       dtb_early_va =3D __va(dtb_pa);
> >   #endif /* CONFIG_64BIT */
> >
