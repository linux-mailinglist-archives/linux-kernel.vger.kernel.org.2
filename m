Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763AF35377C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhDDIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhDDIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 04:39:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59667C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 01:39:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 12so13265973lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6+PbAO3p2uBblEGAfbKP2zFkuBt5ZCUvt8Q6uHucXjw=;
        b=FXSycRO4pYfN9NKhmft6TPZJ9uWxRcJjIv+c7/OJ1Wp3AvFtxBYpmg+BiM//HIdjrv
         eCU+YUGtpeGaCO8YFv+PBfK4BVmadyo2J07PB8BCm374LZk9ZW+CZc3xKapjPzPZWLJI
         qCDR/fGIdpnQaXAHOkztiGCg/18yBPcZ4NiAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+PbAO3p2uBblEGAfbKP2zFkuBt5ZCUvt8Q6uHucXjw=;
        b=We5EB0w9CpLIK5XhTPi0GfEX3Axcleky5fTps1UmM4j7fwRVcT8jdJ5OCMvmfuI5gD
         4I4FzhN51gZ359RLWVacje/IvNSCMFhlLzk92LqPRpva8jn0BZodrv/ti+N6SvEhk3lt
         vo0jT/OuNstZ/lymqZjx104bLKUE8iFKvf1CcSrfSoqyfRiVpz34dn2ntnWxCK0QcnDz
         1byAej1R+HK9iKTJ1rOqYnCj1uNQc1lHLaF/tOfYm/mfC0QkDIFY6vqzZJvXppMkLY2E
         9tI7ngTA8F3tdN/uLhBhgSvfOLEfdPI9EAii8tvHKmorUnnJOtCUDcuSzxWA7KvQoBHx
         Z9GQ==
X-Gm-Message-State: AOAM5303fvKLiMruLerLb6W/jQtOlbZ0tgz6pe6Z3pxqQxbttFgcIEYu
        KQfxZsJozo6CFAdU7HeZCELLvezaAXvouTeblPPPfw==
X-Google-Smtp-Source: ABdhPJzJogUpOIS0Oih/p+PGVoivOGBnZBOwVi5X71xEZRAFv/0a7T9Et8Xr0Njrikr5GnJBijvbXLVQASqA17PvY+Y=
X-Received: by 2002:a19:b49:: with SMTP id 70mr14731362lfl.342.1617525556031;
 Sun, 04 Apr 2021 01:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-add8fe77-f966-42ee-97b7-3d78f48fb103@palmerdabbelt-glaptop>
 <ac54f74d-adab-e844-ad46-733b1560ece1@ghiti.fr> <324299b7-eef4-0961-239c-ee72100f2e85@ghiti.fr>
 <CAM4kBBL8pDrZT0aGygsjVLTKfRf8y2-YQeyGPDEBcujmaOZCyg@mail.gmail.com>
 <32a6ac11-f274-71ee-e5d0-dc60ba841495@ghiti.fr> <b9fe823e-5e7e-9f0d-3540-784dbf9480e1@ghiti.fr>
In-Reply-To: <b9fe823e-5e7e-9f0d-3540-784dbf9480e1@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 4 Apr 2021 10:39:04 +0200
Message-ID: <CAM4kBBJcb0fBnAGFJQTVoT2HDMks3mzg0_-DWrHVPhMk8Mf8dQ@mail.gmail.com>
Subject: Re: [PATCH v6] RISC-V: enable XIP
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 12:00 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Vitaly,
>
> Le 4/1/21 =C3=A0 7:10 AM, Alex Ghiti a =C3=A9crit :
> > Le 4/1/21 =C3=A0 4:52 AM, Vitaly Wool a =C3=A9crit :
> >> Hi Alex,
> >>
> >> On Thu, Apr 1, 2021 at 10:11 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Le 3/30/21 =C3=A0 4:04 PM, Alex Ghiti a =C3=A9crit :
> >>>> Le 3/30/21 =C3=A0 3:33 PM, Palmer Dabbelt a =C3=A9crit :
> >>>>> On Tue, 30 Mar 2021 11:39:10 PDT (-0700), alex@ghiti.fr wrote:
> >>>>>>
> >>>>>>
> >>>>>> Le 3/30/21 =C3=A0 2:26 AM, Vitaly Wool a =C3=A9crit :
> >>>>>>> On Tue, Mar 30, 2021 at 8:23 AM Palmer Dabbelt
> >>>>>>> <palmerdabbelt@google.com> wrote:
> >>>>>>>>
> >>>>>>>> On Sun, 21 Mar 2021 17:12:15 PDT (-0700), vitaly.wool@konsulko.c=
om
> >>>>>>>> wrote:
> >>>>>>>>> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> >>>>>>>>> It allows code to be executed directly from non-volatile storag=
e
> >>>>>>>>> directly addressable by the CPU, such as QSPI NOR flash which c=
an
> >>>>>>>>> be found on many RISC-V platforms. This makes way for significa=
nt
> >>>>>>>>> optimization of RAM footprint. The XIP kernel is not compressed
> >>>>>>>>> since it has to run directly from flash, so it will occupy more
> >>>>>>>>> space on the non-volatile storage. The physical flash address u=
sed
> >>>>>>>>> to link the kernel object files and for storing it has to be kn=
own
> >>>>>>>>> at compile time and is represented by a Kconfig option.
> >>>>>>>>>
> >>>>>>>>> XIP on RISC-V will for the time being only work on MMU-enabled
> >>>>>>>>> kernels.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> >>>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> Changes in v2:
> >>>>>>>>> - dedicated macro for XIP address fixup when MMU is not enabled
> >>>>>>>>> yet
> >>>>>>>>>     o both for 32-bit and 64-bit RISC-V
> >>>>>>>>> - SP is explicitly set to a safe place in RAM before
> >>>>>>>>> __copy_data call
> >>>>>>>>> - removed redundant alignment requirements in vmlinux-xip.lds.S
> >>>>>>>>> - changed long -> uintptr_t typecast in __XIP_FIXUP macro.
> >>>>>>>>> Changes in v3:
> >>>>>>>>> - rebased against latest for-next
> >>>>>>>>> - XIP address fixup macro now takes an argument
> >>>>>>>>> - SMP related fixes
> >>>>>>>>> Changes in v4:
> >>>>>>>>> - rebased against the current for-next
> >>>>>>>>> - less #ifdef's in C/ASM code
> >>>>>>>>> - dedicated XIP_FIXUP_OFFSET assembler macro in head.S
> >>>>>>>>> - C-specific definitions moved into #ifndef __ASSEMBLY__
> >>>>>>>>> - Fixed multi-core boot
> >>>>>>>>> Changes in v5:
> >>>>>>>>> - fixed build error for non-XIP kernels
> >>>>>>>>> Changes in v6:
> >>>>>>>>> - XIP_PHYS_RAM_BASE config option renamed to PHYS_RAM_BASE
> >>>>>>>>> - added PHYS_RAM_BASE_FIXED config flag to allow usage of
> >>>>>>>>>     PHYS_RAM_BASE in non-XIP configurations if needed
> >>>>>>>>> - XIP_FIXUP macro rewritten with a tempoarary variable to avoid
> >>>>>>>>> side
> >>>>>>>>>     effects
> >>>>>>>>> - fixed crash for non-XIP kernels that don't use built-in DTB
> >>>>>>>>
> >>>>>>>> So v5 landed on for-next, which generally means it's best to avo=
id
> >>>>>>>> re-spinning the patch and instead send along fixups.  That said,
> >>>>>>>> the v5
> >>>>>>>> is causing some testing failures for me.
> >>>>>>>>
> >>>>>>>> I'm going to drop the v5 for now as I don't have time to test th=
is
> >>>>>>>> tonight.  I'll try and take a look soon, as it will conflict wit=
h
> >>>>>>>> Alex's
> >>>>>>>> patches.
> >>>>>>>
> >>>>>>> I can come up with the incremental patch instead pretty much
> >>>>>>> straight
> >>>>>>> away if that works better.
> >>>>>>>
> >>>>>>> ~Vitaly
> >>>>>>>
> >>>>>>>>>    arch/riscv/Kconfig                  |  49 ++++++++++-
> >>>>>>>>>    arch/riscv/Makefile                 |   8 +-
> >>>>>>>>>    arch/riscv/boot/Makefile            |  13 +++
> >>>>>>>>>    arch/riscv/include/asm/pgtable.h    |  65 ++++++++++++--
> >>>>>>>>>    arch/riscv/kernel/cpu_ops_sbi.c     |  11 ++-
> >>>>>>>>>    arch/riscv/kernel/head.S            |  49 ++++++++++-
> >>>>>>>>>    arch/riscv/kernel/head.h            |   3 +
> >>>>>>>>>    arch/riscv/kernel/setup.c           |   8 +-
> >>>>>>>>>    arch/riscv/kernel/vmlinux-xip.lds.S | 132
> >>>>>>>>> ++++++++++++++++++++++++++++
> >>>>>>>>>    arch/riscv/kernel/vmlinux.lds.S     |   6 ++
> >>>>>>>>>    arch/riscv/mm/init.c                | 100 ++++++++++++++++++=
+--
> >>>>>>>>>    11 files changed, 426 insertions(+), 18 deletions(-)
> >>>>>>>>>    create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>>>>>>> index 8ea60a0a19ae..bd6f82240c34 100644
> >>>>>>>>> --- a/arch/riscv/Kconfig
> >>>>>>>>> +++ b/arch/riscv/Kconfig
> >>>>>>>>> @@ -441,7 +441,7 @@ config EFI_STUB
> >>>>>>>>>
> >>>>>>>>>    config EFI
> >>>>>>>>>         bool "UEFI runtime support"
> >>>>>>>>> -     depends on OF
> >>>>>>>>> +     depends on OF && !XIP_KERNEL
> >>>>>>>>>         select LIBFDT
> >>>>>>>>>         select UCS2_STRING
> >>>>>>>>>         select EFI_PARAMS_FROM_FDT
> >>>>>>>>> @@ -465,11 +465,56 @@ config STACKPROTECTOR_PER_TASK
> >>>>>>>>>         def_bool y
> >>>>>>>>>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> >>>>>>>>>
> >>>>>>>>> +config PHYS_RAM_BASE_FIXED
> >>>>>>>>> +     bool "Explicitly specified physical RAM address"
> >>>>>>>>> +     default n
> >>>>>>>>> +
> >>>>>>>>> +config PHYS_RAM_BASE
> >>>>>>>>> +     hex "Platform Physical RAM address"
> >>>>>>>>> +     depends on PHYS_RAM_BASE_FIXED
> >>>>>>>>> +     default "0x80000000"
> >>>>>>>>> +     help
> >>>>>>>>> +       This is the physical address of RAM in the system. It h=
as
> >>>>>>>>> to be
> >>>>>>>>> +       explicitly specified to run early relocations of
> >>>>>>>>> read-write data
> >>>>>>>>> +       from flash to RAM.
> >>>>>>>>> +
> >>>>>>>>> +config XIP_KERNEL
> >>>>>>>>> +     bool "Kernel Execute-In-Place from ROM"
> >>>>>>>>> +     depends on MMU
> >>>>>>>>> +     select PHYS_RAM_BASE_FIXED
> >>>>>>>>> +     help
> >>>>>>>>> +       Execute-In-Place allows the kernel to run from
> >>>>>>>>> non-volatile storage
> >>>>>>>>> +       directly addressable by the CPU, such as NOR flash. Thi=
s
> >>>>>>>>> saves RAM
> >>>>>>>>> +       space since the text section of the kernel is not loade=
d
> >>>>>>>>> from flash
> >>>>>>>>> +       to RAM.  Read-write sections, such as the data section =
and
> >>>>>>>>> stack,
> >>>>>>>>> +       are still copied to RAM.  The XIP kernel is not compres=
sed
> >>>>>>>>> since
> >>>>>>>>> +       it has to run directly from flash, so it will take more
> >>>>>>>>> space to
> >>>>>>>>> +       store it.  The flash address used to link the kernel
> >>>>>>>>> object files,
> >>>>>>>>> +       and for storing it, is configuration dependent. Therefo=
re,
> >>>>>>>>> if you
> >>>>>>>>> +       say Y here, you must know the proper physical address
> >>>>>>>>> where to
> >>>>>>>>> +       store the kernel image depending on your own flash memo=
ry
> >>>>>>>>> usage.
> >>>>>>>>> +
> >>>>>>>>> +       Also note that the make target becomes "make xipImage"
> >>>>>>>>> rather than
> >>>>>>>>> +       "make zImage" or "make Image".  The final kernel binary=
 to
> >>>>>>>>> put in
> >>>>>>>>> +       ROM memory will be arch/riscv/boot/xipImage.
> >>>>>>>>> +
> >>>>>>>>> +       If unsure, say N.
> >>>>>>>>> +
> >>>>>>>>> +config XIP_PHYS_ADDR
> >>>>>>>>> +     hex "XIP Kernel Physical Location"
> >>>>>>>>> +     depends on XIP_KERNEL
> >>>>>>>>> +     default "0x21000000"
> >>>>>>>>> +     help
> >>>>>>>>> +       This is the physical address in your flash memory the
> >>>>>>>>> kernel will
> >>>>>>>>> +       be linked for and stored to.  This address is dependent=
 on
> >>>>>>>>> your
> >>>>>>>>> +       own flash usage.
> >>>>>>>>> +
> >>>>>>>>>    endmenu
> >>>>>>>>>
> >>>>>>>>>    config BUILTIN_DTB
> >>>>>>>>> -     def_bool n
> >>>>>>>>> +     bool
> >>>>>>>>>         depends on OF
> >>>>>>>>> +     default y if XIP_KERNEL
> >>>>>>>>>
> >>>>>>>>>    menu "Power management options"
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> >>>>>>>>> index 1368d943f1f3..8fcbec03974d 100644
> >>>>>>>>> --- a/arch/riscv/Makefile
> >>>>>>>>> +++ b/arch/riscv/Makefile
> >>>>>>>>> @@ -82,7 +82,11 @@ CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$=
(BITS)
> >>>>>>>>>
> >>>>>>>>>    # Default target when executing plain make
> >>>>>>>>>    boot         :=3D arch/riscv/boot
> >>>>>>>>> +ifeq ($(CONFIG_XIP_KERNEL),y)
> >>>>>>>>> +KBUILD_IMAGE :=3D $(boot)/xipImage
> >>>>>>>>> +else
> >>>>>>>>>    KBUILD_IMAGE :=3D $(boot)/Image.gz
> >>>>>>>>> +endif
> >>>>>>>>>
> >>>>>>>>>    head-y :=3D arch/riscv/kernel/head.o
> >>>>>>>>>
> >>>>>>>>> @@ -95,12 +99,14 @@ PHONY +=3D vdso_install
> >>>>>>>>>    vdso_install:
> >>>>>>>>>         $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> >>>>>>>>>
> >>>>>>>>> +ifneq ($(CONFIG_XIP_KERNEL),y)
> >>>>>>>>>    ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
> >>>>>>>>>    KBUILD_IMAGE :=3D $(boot)/loader.bin
> >>>>>>>>>    else
> >>>>>>>>>    KBUILD_IMAGE :=3D $(boot)/Image.gz
> >>>>>>>>>    endif
> >>>>>>>>> -BOOT_TARGETS :=3D Image Image.gz loader loader.bin
> >>>>>>>>> +endif
> >>>>>>>>> +BOOT_TARGETS :=3D Image Image.gz loader loader.bin xipImage
> >>>>>>>>>
> >>>>>>>>>    all: $(notdir $(KBUILD_IMAGE))
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefil=
e
> >>>>>>>>> index 03404c84f971..6bf299f70c27 100644
> >>>>>>>>> --- a/arch/riscv/boot/Makefile
> >>>>>>>>> +++ b/arch/riscv/boot/Makefile
> >>>>>>>>> @@ -17,8 +17,21 @@
> >>>>>>>>>    KCOV_INSTRUMENT :=3D n
> >>>>>>>>>
> >>>>>>>>>    OBJCOPYFLAGS_Image :=3D-O binary -R .note -R
> >>>>>>>>> .note.gnu.build-id -R
> >>>>>>>>> .comment -S
> >>>>>>>>> +OBJCOPYFLAGS_xipImage :=3D-O binary -R .note -R .note.gnu.buil=
d-id
> >>>>>>>>> -R .comment -S
> >>>>>>>>>
> >>>>>>>>>    targets :=3D Image Image.* loader loader.o loader.lds loader=
.bin
> >>>>>>>>> +targets :=3D Image Image.* loader loader.o loader.lds loader.b=
in
> >>>>>>>>> xipImage
> >>>>>>>>> +
> >>>>>>>>> +ifeq ($(CONFIG_XIP_KERNEL),y)
> >>>>>>>>> +
> >>>>>>>>> +quiet_cmd_mkxip =3D $(quiet_cmd_objcopy)
> >>>>>>>>> +cmd_mkxip =3D $(cmd_objcopy)
> >>>>>>>>> +
> >>>>>>>>> +$(obj)/xipImage: vmlinux FORCE
> >>>>>>>>> +     $(call if_changed,mkxip)
> >>>>>>>>> +     @$(kecho) '  Physical Address of xipImage:
> >>>>>>>>> $(CONFIG_XIP_PHYS_ADDR)'
> >>>>>>>>> +
> >>>>>>>>> +endif
> >>>>>>>>>
> >>>>>>>>>    $(obj)/Image: vmlinux FORCE
> >>>>>>>>>         $(call if_changed,objcopy)
> >>>>>>>>> diff --git a/arch/riscv/include/asm/pgtable.h
> >>>>>>>>> b/arch/riscv/include/asm/pgtable.h
> >>>>>>>>> index ebf817c1bdf4..21a9b2f8d1c7 100644
> >>>>>>>>> --- a/arch/riscv/include/asm/pgtable.h
> >>>>>>>>> +++ b/arch/riscv/include/asm/pgtable.h
> >>>>>>>>> @@ -11,6 +11,33 @@
> >>>>>>>>>
> >>>>>>>>>    #include <asm/pgtable-bits.h>
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_MMU
> >>>>>>>>> +
> >>>>>>>>> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> >>>>>>>>> +
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#define VMALLOC_SIZE     ((KERN_VIRT_SIZE >> 1) - SZ_16M)
> >>>>>>>>> +#define VMALLOC_END      (PAGE_OFFSET - SZ_16M - 1)
> >>>>>>>>> +
> >>>>>>>>> +#define XIP_OFFSET           SZ_8M
> >>>>>>>>> +#define XIP_MASK             (SZ_8M - 1)
> >>>>>>>>> +#define XIP_VIRT_ADDR(physaddr)      \
> >>>>>>>>> +     (PAGE_OFFSET - XIP_OFFSET + ((physaddr) & XIP_MASK))
> >>>>>>>>> +
> >>>>>>>>> +#else
> >>>>>>>>> +
> >>>>>>>>> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> >>>>>>>>> +#define VMALLOC_END      (PAGE_OFFSET - 1)
> >>>>>>>>> +
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>> +#else
> >>>>>>>>> +
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#define XIP_VIRT_ADDR(physaddr) (physaddr)
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +#endif /* CONFIG_MMU */
> >>>>>>>>> +
> >>>>>>>>>    #ifndef __ASSEMBLY__
> >>>>>>>>>
> >>>>>>>>>    /* Page Upper Directory not used in RISC-V */
> >>>>>>>>> @@ -21,9 +48,25 @@
> >>>>>>>>>
> >>>>>>>>>    #ifdef CONFIG_MMU
> >>>>>>>>>
> >>>>>>>>> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> >>>>>>>>> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> >>>>>>>>> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +/*
> >>>>>>>>> + * Since we use sections to map it, this macro replaces the
> >>>>>>>>> physical address
> >>>>>>>>> + * with its virtual address while keeping offset from the base
> >>>>>>>>> section.
> >>>>>>>>> + */
> >>>>>>>>> +#define XIP_PHYS_ADDR(va)     \
> >>>>>>>>> +     ((uintptr_t)(va) - PAGE_OFFSET + XIP_OFFSET +
> >>>>>>>>> CONFIG_XIP_PHYS_ADDR)
> >>>>>>>>> +
> >>>>>>>>> +#define XIP_VIRT_ADDR_START  XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADD=
R)
> >>>>>>>>> +
> >>>>>>>>> +#define XIP_FIXUP(addr)              ({ \
> >>>>>>>>> +     uintptr_t __a =3D (uintptr_t)(addr); \
> >>>>>>>>> +     (__a >=3D CONFIG_XIP_PHYS_ADDR && \
> >>>>>>>>> +      __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
> >>>>>>>>> +     __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE -
> >>>>>>>>> XIP_OFFSET : __a; \
> >>>>>>>>> +})
> >>>>>>>>> +#else
> >>>>>>>>> +#define XIP_FIXUP(addr)              (addr)
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>>
> >>>>>>>>>    #define BPF_JIT_REGION_SIZE  (SZ_128M)
> >>>>>>>>>    #define BPF_JIT_REGION_START (PAGE_OFFSET -
> >>>>>>>>> BPF_JIT_REGION_SIZE)
> >>>>>>>>> @@ -484,8 +527,20 @@ static inline int
> >>>>>>>>> ptep_clear_flush_young(struct vm_area_struct *vma,
> >>>>>>>>>
> >>>>>>>>>    #define kern_addr_valid(addr)   (1) /* FIXME */
> >>>>>>>>>
> >>>>>>>>> -extern void *dtb_early_va;
> >>>>>>>>> -extern uintptr_t dtb_early_pa;
> >>>>>>>>> +extern void *_dtb_early_va;
> >>>>>>>>> +extern uintptr_t _dtb_early_pa;
> >>>>>>>>> +#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
> >>>>>>>>> +
> >>>>>>>>> +#define dtb_early_va (*(void **)XIP_FIXUP(&_dtb_early_va))
> >>>>>>>>> +#define dtb_early_pa (*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
> >>>>>>>>> +
> >>>>>>>>> +#else
> >>>>>>>>> +
> >>>>>>>>> +#define dtb_early_va _dtb_early_va
> >>>>>>>>> +#define dtb_early_pa _dtb_early_pa
> >>>>>>>>> +
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>>    void setup_bootmem(void);
> >>>>>>>>>    void paging_init(void);
> >>>>>>>>>    void misc_mem_init(void);
> >>>>>>>>> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c
> >>>>>>>>> b/arch/riscv/kernel/cpu_ops_sbi.c
> >>>>>>>>> index 685fae72b7f5..2413c2997350 100644
> >>>>>>>>> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> >>>>>>>>> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> >>>>>>>>> @@ -53,10 +53,19 @@ static int sbi_hsm_hart_get_status(unsigned
> >>>>>>>>> long hartid)
> >>>>>>>>>    }
> >>>>>>>>>    #endif
> >>>>>>>>>
> >>>>>>>>> +static inline unsigned long get_secondary_start_phys(void)
> >>>>>>>>> +{
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     return XIP_PHYS_ADDR(secondary_start_sbi);
> >>>>>>>>> +#else
> >>>>>>>>> +     return __pa_symbol(secondary_start_sbi);
> >>>>>>>>> +#endif
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>    static int sbi_cpu_start(unsigned int cpuid, struct task_str=
uct
> >>>>>>>>> *tidle)
> >>>>>>>>>    {
> >>>>>>>>>         int rc;
> >>>>>>>>> -     unsigned long boot_addr =3D __pa_symbol(secondary_start_s=
bi);
> >>>>>>>>> +     unsigned long boot_addr =3D get_secondary_start_phys();
> >>>>>>>>>         int hartid =3D cpuid_to_hartid_map(cpuid);
> >>>>>>>>>
> >>>>>>>>>         cpu_update_secondary_bootdata(cpuid, tidle);
> >>>>>>>>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.=
S
> >>>>>>>>> index f5a9bad86e58..bbe74e37914f 100644
> >>>>>>>>> --- a/arch/riscv/kernel/head.S
> >>>>>>>>> +++ b/arch/riscv/kernel/head.S
> >>>>>>>>> @@ -9,11 +9,23 @@
> >>>>>>>>>    #include <linux/linkage.h>
> >>>>>>>>>    #include <asm/thread_info.h>
> >>>>>>>>>    #include <asm/page.h>
> >>>>>>>>> +#include <asm/pgtable.h>
> >>>>>>>>>    #include <asm/csr.h>
> >>>>>>>>>    #include <asm/hwcap.h>
> >>>>>>>>>    #include <asm/image.h>
> >>>>>>>>>    #include "efi-header.S"
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +.macro XIP_FIXUP_OFFSET reg
> >>>>>>>>> +     REG_L t0, _xip_fixup
> >>>>>>>>> +     add \reg, \reg, t0
> >>>>>>>>> +.endm
> >>>>>>>>> +_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR=
 -
> >>>>>>>>> XIP_OFFSET
> >>>>>>>>> +#else
> >>>>>>>>> +.macro XIP_FIXUP_OFFSET reg
> >>>>>>>>> +.endm
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>>    __HEAD
> >>>>>>>>>    ENTRY(_start)
> >>>>>>>>>         /*
> >>>>>>>>> @@ -69,7 +81,11 @@ pe_head_start:
> >>>>>>>>>    #ifdef CONFIG_MMU
> >>>>>>>>>    relocate:
> >>>>>>>>>         /* Relocate return address */
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     li a1, XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> >>>>>>>>> +#else
> >>>>>>>>>         li a1, PAGE_OFFSET
> >>>>>>>>> +#endif
> >>>>>>>>>         la a2, _start
> >>>>>>>>>         sub a1, a1, a2
> >>>>>>>>>         add ra, ra, a1
> >>>>>>>>> @@ -91,6 +107,7 @@ relocate:
> >>>>>>>>>          * to ensure the new translations are in use.
> >>>>>>>>>          */
> >>>>>>>>>         la a0, trampoline_pg_dir
> >>>>>>>>> +     XIP_FIXUP_OFFSET a0
> >>>>>>>>>         srl a0, a0, PAGE_SHIFT
> >>>>>>>>>         or a0, a0, a1
> >>>>>>>>>         sfence.vma
> >>>>>>>>> @@ -144,7 +161,9 @@ secondary_start_sbi:
> >>>>>>>>>
> >>>>>>>>>         slli a3, a0, LGREG
> >>>>>>>>>         la a4, __cpu_up_stack_pointer
> >>>>>>>>> +     XIP_FIXUP_OFFSET a4
> >>>>>>>>>         la a5, __cpu_up_task_pointer
> >>>>>>>>> +     XIP_FIXUP_OFFSET a5
> >>>>>>>>>         add a4, a3, a4
> >>>>>>>>>         add a5, a3, a5
> >>>>>>>>>         REG_L sp, (a4)
> >>>>>>>>> @@ -156,6 +175,7 @@ secondary_start_common:
> >>>>>>>>>    #ifdef CONFIG_MMU
> >>>>>>>>>         /* Enable virtual memory and relocate to virtual
> >>>>>>>>> address */
> >>>>>>>>>         la a0, swapper_pg_dir
> >>>>>>>>> +     XIP_FIXUP_OFFSET a0
> >>>>>>>>>         call relocate
> >>>>>>>>>    #endif
> >>>>>>>>>         call setup_trap_vector
> >>>>>>>>> @@ -236,12 +256,33 @@ pmp_done:
> >>>>>>>>>    .Lgood_cores:
> >>>>>>>>>    #endif
> >>>>>>>>>
> >>>>>>>>> +#ifndef CONFIG_XIP_KERNEL
> >>>>>>>>>         /* Pick one hart to run the main boot sequence */
> >>>>>>>>>         la a3, hart_lottery
> >>>>>>>>>         li a2, 1
> >>>>>>>>>         amoadd.w a3, a2, (a3)
> >>>>>>>>>         bnez a3, .Lsecondary_start
> >>>>>>>>>
> >>>>>>>>> +#else
> >>>>>>>>> +     /* hart_lottery in flash contains a magic number */
> >>>>>>>>> +     la a3, hart_lottery
> >>>>>>>>> +     mv a2, a3
> >>>>>>>>> +     XIP_FIXUP_OFFSET a2
> >>>>>>>>> +     lw t1, (a3)
> >>>>>>>>> +     amoswap.w t0, t1, (a2)
> >>>>>>>>> +     /* first time here if hart_lottery in RAM is not set */
> >>>>>>>>> +     beq t0, t1, .Lsecondary_start
> >>>>>>>>> +
> >>>>>>>>> +     la sp, _end + THREAD_SIZE
> >>>>>>>>> +     XIP_FIXUP_OFFSET sp
> >>>>>>>>> +     mv s0, a0
> >>>>>>>>> +     call __copy_data
> >>>>>>>>> +
> >>>>>>>>> +     /* Restore a0 copy */
> >>>>>>>>> +     mv a0, s0
> >>>>>>>>> +#endif
> >>>>>>>>> +
> >>>>>>>>> +#ifndef CONFIG_XIP_KERNEL
> >>>>>>>>>         /* Clear BSS for flat non-ELF images */
> >>>>>>>>>         la a3, __bss_start
> >>>>>>>>>         la a4, __bss_stop
> >>>>>>>>> @@ -251,15 +292,18 @@ clear_bss:
> >>>>>>>>>         add a3, a3, RISCV_SZPTR
> >>>>>>>>>         blt a3, a4, clear_bss
> >>>>>>>>>    clear_bss_done:
> >>>>>>>>> -
> >>>>>>>>> +#endif
> >>>>>>>>>         /* Save hart ID and DTB physical address */
> >>>>>>>>>         mv s0, a0
> >>>>>>>>>         mv s1, a1
> >>>>>>>>> +
> >>>>>>>>>         la a2, boot_cpu_hartid
> >>>>>>>>> +     XIP_FIXUP_OFFSET a2
> >>>>>>>>>         REG_S a0, (a2)
> >>>>>>>>>
> >>>>>>>>>         /* Initialize page tables and relocate to virtual
> >>>>>>>>> addresses */
> >>>>>>>>>         la sp, init_thread_union + THREAD_SIZE
> >>>>>>>>> +     XIP_FIXUP_OFFSET sp
> >>>>>>>>>    #ifdef CONFIG_BUILTIN_DTB
> >>>>>>>>>         la a0, __dtb_start
> >>>>>>>>>    #else
> >>>>>>>>> @@ -268,6 +312,7 @@ clear_bss_done:
> >>>>>>>>>         call setup_vm
> >>>>>>>>>    #ifdef CONFIG_MMU
> >>>>>>>>>         la a0, early_pg_dir
> >>>>>>>>> +     XIP_FIXUP_OFFSET a0
> >>>>>>>>>         call relocate
> >>>>>>>>>    #endif /* CONFIG_MMU */
> >>>>>>>>>
> >>>>>>>>> @@ -292,7 +337,9 @@ clear_bss_done:
> >>>>>>>>>
> >>>>>>>>>         slli a3, a0, LGREG
> >>>>>>>>>         la a1, __cpu_up_stack_pointer
> >>>>>>>>> +     XIP_FIXUP_OFFSET a1
> >>>>>>>>>         la a2, __cpu_up_task_pointer
> >>>>>>>>> +     XIP_FIXUP_OFFSET a2
> >>>>>>>>>         add a1, a3, a1
> >>>>>>>>>         add a2, a3, a2
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.=
h
> >>>>>>>>> index b48dda3d04f6..aabbc3ac3e48 100644
> >>>>>>>>> --- a/arch/riscv/kernel/head.h
> >>>>>>>>> +++ b/arch/riscv/kernel/head.h
> >>>>>>>>> @@ -12,6 +12,9 @@ extern atomic_t hart_lottery;
> >>>>>>>>>
> >>>>>>>>>    asmlinkage void do_page_fault(struct pt_regs *regs);
> >>>>>>>>>    asmlinkage void __init setup_vm(uintptr_t dtb_pa);
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +asmlinkage void __init __copy_data(void);
> >>>>>>>>> +#endif
> >>>>>>>>>
> >>>>>>>>>    extern void *__cpu_up_stack_pointer[];
> >>>>>>>>>    extern void *__cpu_up_task_pointer[];
> >>>>>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setu=
p.c
> >>>>>>>>> index e85bacff1b50..a0384c72c272 100644
> >>>>>>>>> --- a/arch/riscv/kernel/setup.c
> >>>>>>>>> +++ b/arch/riscv/kernel/setup.c
> >>>>>>>>> @@ -50,7 +50,11 @@ struct screen_info screen_info
> >>>>>>>>> __section(".data") =3D {
> >>>>>>>>>     * This is used before the kernel initializes the BSS so it
> >>>>>>>>> can't be in the
> >>>>>>>>>     * BSS.
> >>>>>>>>>     */
> >>>>>>>>> -atomic_t hart_lottery __section(".sdata");
> >>>>>>>>> +atomic_t hart_lottery __section(".sdata")
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +=3D ATOMIC_INIT(0xC001BEEF)
> >>>>>>>>> +#endif
> >>>>>>>>> +;
> >>>>>>>>>    unsigned long boot_cpu_hartid;
> >>>>>>>>>    static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >>>>>>>>>
> >>>>>>>>> @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
> >>>>>>>>>    #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >>>>>>>>>         unflatten_and_copy_device_tree();
> >>>>>>>>>    #else
> >>>>>>>>> -     if (early_init_dt_verify(__va(dtb_early_pa)))
> >>>>>>>>> +     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> >>>>>>>>>                 unflatten_device_tree();
> >>>>>>>>>         else
> >>>>>>>>>                 pr_err("No DTB found in kernel mappings\n");
> >>>>>>>>> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S
> >>>>>>>>> b/arch/riscv/kernel/vmlinux-xip.lds.S
> >>>>>>>>> new file mode 100644
> >>>>>>>>> index 000000000000..9f0f08c34cd3
> >>>>>>>>> --- /dev/null
> >>>>>>>>> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> >>>>>>>>> @@ -0,0 +1,132 @@
> >>>>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>>>>>>> +/*
> >>>>>>>>> + * Copyright (C) 2012 Regents of the University of California
> >>>>>>>>> + * Copyright (C) 2017 SiFive
> >>>>>>>>> + * Copyright (C) 2020 Vitaly Wool, Konsulko AB
> >>>>>>>>> + */
> >>>>>>>>> +
> >>>>>>>>> +#define LOAD_OFFSET XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> >>>>>>>>> +/* No __ro_after_init data in the .rodata section - which will
> >>>>>>>>> always be ro */
> >>>>>>>>> +#define RO_AFTER_INIT_DATA
> >>>>>>>>> +
> >>>>>>>>> +#include <asm/vmlinux.lds.h>
> >>>>>>>>> +#include <asm/page.h>
> >>>>>>>>> +#include <asm/pgtable.h>
> >>>>>>>>> +#include <asm/cache.h>
> >>>>>>>>> +#include <asm/thread_info.h>
> >>>>>>>>> +
> >>>>>>>>> +OUTPUT_ARCH(riscv)
> >>>>>>>>> +ENTRY(_start)
> >>>>>>>>> +
> >>>>>>>>> +jiffies =3D jiffies_64;
> >>>>>>>>> +
> >>>>>>>>> +SECTIONS
> >>>>>>>>> +{
> >>>>>>>>> +     /* Beginning of code and text segment */
> >>>>>>>>> +     . =3D XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> >>>>>>>>> +     _xiprom =3D .;
> >>>>>>>>> +     _start =3D .;
> >>>>>>>>> +     HEAD_TEXT_SECTION
> >>>>>>>>> +     INIT_TEXT_SECTION(PAGE_SIZE)
> >>>>>>>>> +     /* we have to discard exit text and such at runtime, not
> >>>>>>>>> link time */
> >>>>>>>>> +     .exit.text :
> >>>>>>>>> +     {
> >>>>>>>>> +             EXIT_TEXT
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     .text : {
> >>>>>>>>> +             _text =3D .;
> >>>>>>>>> +             _stext =3D .;
> >>>>>>>>> +             TEXT_TEXT
> >>>>>>>>> +             SCHED_TEXT
> >>>>>>>>> +             CPUIDLE_TEXT
> >>>>>>>>> +             LOCK_TEXT
> >>>>>>>>> +             KPROBES_TEXT
> >>>>>>>>> +             ENTRY_TEXT
> >>>>>>>>> +             IRQENTRY_TEXT
> >>>>>>>>> +             SOFTIRQENTRY_TEXT
> >>>>>>>>> +             *(.fixup)
> >>>>>>>>> +             _etext =3D .;
> >>>>>>>>> +     }
> >>>>>>>>> +     RO_DATA(L1_CACHE_BYTES)
> >>>>>>>>> +     .srodata : {
> >>>>>>>>> +             *(.srodata*)
> >>>>>>>>> +     }
> >>>>>>>>> +     .init.rodata : {
> >>>>>>>>> +             INIT_SETUP(16)
> >>>>>>>>> +             INIT_CALLS
> >>>>>>>>> +             CON_INITCALL
> >>>>>>>>> +             INIT_RAM_FS
> >>>>>>>>> +     }
> >>>>>>>>> +     _exiprom =3D .;                   /* End of XIP ROM area =
*/
> >>>>>>>>> +
> >>>>>>>>> +
> >>>>>>>>> +/*
> >>>>>>>>> + * From this point, stuff is considered writable and will be
> >>>>>>>>> copied to RAM
> >>>>>>>>> + */
> >>>>>>>>> +     __data_loc =3D ALIGN(16);         /* location in file */
> >>>>>>>>> +     . =3D PAGE_OFFSET;                /* location in memory *=
/
> >>>>>>>>> +
> >>>>>>>>> +     _sdata =3D .;                     /* Start of data sectio=
n */
> >>>>>>>>> +     _data =3D .;
> >>>>>>>>> +     RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> >>>>>>>>> +     _edata =3D .;
> >>>>>>>>> +     __start_ro_after_init =3D .;
> >>>>>>>>> +     .data.ro_after_init : AT(ADDR(.data.ro_after_init) -
> >>>>>>>>> LOAD_OFFSET) {
> >>>>>>>>> +             *(.data..ro_after_init)
> >>>>>>>>> +     }
> >>>>>>>>> +     __end_ro_after_init =3D .;
> >>>>>>>>> +
> >>>>>>>>> +     . =3D ALIGN(PAGE_SIZE);
> >>>>>>>>> +     __init_begin =3D .;
> >>>>>>>>> +     .init.data : {
> >>>>>>>>> +             INIT_DATA
> >>>>>>>>> +     }
> >>>>>>>>> +     .exit.data : {
> >>>>>>>>> +             EXIT_DATA
> >>>>>>>>> +     }
> >>>>>>>>> +     . =3D ALIGN(8);
> >>>>>>>>> +     __soc_early_init_table : {
> >>>>>>>>> +             __soc_early_init_table_start =3D .;
> >>>>>>>>> +             KEEP(*(__soc_early_init_table))
> >>>>>>>>> +             __soc_early_init_table_end =3D .;
> >>>>>>>>> +     }
> >>>>>>>>> +     __soc_builtin_dtb_table : {
> >>>>>>>>> +             __soc_builtin_dtb_table_start =3D .;
> >>>>>>>>> +             KEEP(*(__soc_builtin_dtb_table))
> >>>>>>>>> +             __soc_builtin_dtb_table_end =3D .;
> >>>>>>>>> +     }
> >>>>>>>>> +     PERCPU_SECTION(L1_CACHE_BYTES)
> >>>>>>>>> +
> >>>>>>>>> +     . =3D ALIGN(PAGE_SIZE);
> >>>>>>>>> +     __init_end =3D .;
> >>>>>>>>> +
> >>>>>>>>> +     .sdata : {
> >>>>>>>>> +             __global_pointer$ =3D . + 0x800;
> >>>>>>>>> +             *(.sdata*)
> >>>>>>>>> +             *(.sbss*)
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> >>>>>>>>> +     EXCEPTION_TABLE(0x10)
> >>>>>>>>> +
> >>>>>>>>> +     .rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
> >>>>>>>>> +             *(.rel.dyn*)
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     /*
> >>>>>>>>> +      * End of copied data. We need a dummy section to get its
> >>>>>>>>> LMA.
> >>>>>>>>> +      * Also located before final ALIGN() as trailing padding =
is
> >>>>>>>>> not stored
> >>>>>>>>> +      * in the resulting binary file and useless to copy.
> >>>>>>>>> +      */
> >>>>>>>>> +     .data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
> >>>>>>>>> +     _edata_loc =3D LOADADDR(.data.endmark);
> >>>>>>>>> +
> >>>>>>>>> +     . =3D ALIGN(PAGE_SIZE);
> >>>>>>>>> +     _end =3D .;
> >>>>>>>>> +
> >>>>>>>>> +     STABS_DEBUG
> >>>>>>>>> +     DWARF_DEBUG
> >>>>>>>>> +
> >>>>>>>>> +     DISCARDS
> >>>>>>>>> +}
> >>>>>>>>> diff --git a/arch/riscv/kernel/vmlinux.lds.S
> >>>>>>>>> b/arch/riscv/kernel/vmlinux.lds.S
> >>>>>>>>> index de03cb22d0e9..6745ec325930 100644
> >>>>>>>>> --- a/arch/riscv/kernel/vmlinux.lds.S
> >>>>>>>>> +++ b/arch/riscv/kernel/vmlinux.lds.S
> >>>>>>>>> @@ -4,7 +4,12 @@
> >>>>>>>>>     * Copyright (C) 2017 SiFive
> >>>>>>>>>     */
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#include "vmlinux-xip.lds.S"
> >>>>>>>>> +#else
> >>>>>>>>> +
> >>>>>>>>>    #define LOAD_OFFSET PAGE_OFFSET
> >>>>>>>>> +
> >>>>>>>>>    #include <asm/vmlinux.lds.h>
> >>>>>>>>>    #include <asm/page.h>
> >>>>>>>>>    #include <asm/cache.h>
> >>>>>>>>> @@ -132,3 +137,4 @@ SECTIONS
> >>>>>>>>>
> >>>>>>>>>         DISCARDS
> >>>>>>>>>    }
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >>>>>>>>> index 7f5036fbee8c..efe649d41f95 100644
> >>>>>>>>> --- a/arch/riscv/mm/init.c
> >>>>>>>>> +++ b/arch/riscv/mm/init.c
> >>>>>>>>> @@ -31,8 +31,8 @@ EXPORT_SYMBOL(empty_zero_page);
> >>>>>>>>>
> >>>>>>>>>    extern char _start[];
> >>>>>>>>>    #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> >>>>>>>>> -void *dtb_early_va __initdata;
> >>>>>>>>> -uintptr_t dtb_early_pa __initdata;
> >>>>>>>>> +void *_dtb_early_va __initdata;
> >>>>>>>>> +uintptr_t _dtb_early_pa __initdata;
> >>>>>>>>>
> >>>>>>>>>    struct pt_alloc_ops {
> >>>>>>>>>         pte_t *(*get_pte_virt)(phys_addr_t pa);
> >>>>>>>>> @@ -88,6 +88,10 @@ static void print_vm_layout(void)
> >>>>>>>>>                   (unsigned long)VMALLOC_END);
> >>>>>>>>>         print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
> >>>>>>>>>                   (unsigned long)high_memory);
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     print_mlm("xip", (unsigned long)XIP_VIRT_ADDR_START,
> >>>>>>>>> +               (unsigned long)XIP_VIRT_ADDR_START + SZ_16M);
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>>    }
> >>>>>>>>>    #else
> >>>>>>>>>    static void print_vm_layout(void) { }
> >>>>>>>>> @@ -113,6 +117,10 @@ void __init setup_bootmem(void)
> >>>>>>>>>         phys_addr_t dram_end =3D memblock_end_of_DRAM();
> >>>>>>>>>         phys_addr_t max_mapped_addr =3D __pa(~(ulong)0);
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     vmlinux_start =3D __pa_symbol(&_sdata);
> >>>>>>>>> +#endif
> >>>>>>>>> +
> >>>>>>>>>         /* The maximal physical memory size is -PAGE_OFFSET. */
> >>>>>>>>>         memblock_enforce_memory_limit(-PAGE_OFFSET);
> >>>>>>>>>
> >>>>>>>>> @@ -149,11 +157,27 @@ void __init setup_bootmem(void)
> >>>>>>>>>         memblock_allow_resize();
> >>>>>>>>>    }
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +
> >>>>>>>>> +extern char _xiprom[], _exiprom[];
> >>>>>>>>> +extern char _sdata[], _edata[];
> >>>>>>>>> +
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>>    #ifdef CONFIG_MMU
> >>>>>>>>> -static struct pt_alloc_ops pt_ops;
> >>>>>>>>> +static struct pt_alloc_ops _pt_ops;
> >>>>>>>>> +
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> >>>>>>>>> +#else
> >>>>>>>>> +#define pt_ops       _pt_ops
> >>>>>>>>> +#endif
> >>>>>>>>>
> >>>>>>>>>    unsigned long va_pa_offset;
> >>>>>>>>>    EXPORT_SYMBOL(va_pa_offset);
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#define va_pa_offset (*((unsigned long
> >>>>>>>>> *)XIP_FIXUP(&va_pa_offset)))
> >>>>>>>>> +#endif
> >>>>>>>>>    unsigned long pfn_base;
> >>>>>>>>>    EXPORT_SYMBOL(pfn_base);
> >>>>>>>>>
> >>>>>>>>> @@ -163,6 +187,12 @@ pte_t fixmap_pte[PTRS_PER_PTE]
> >>>>>>>>> __page_aligned_bss;
> >>>>>>>>>
> >>>>>>>>>    pgd_t early_pg_dir[PTRS_PER_PGD] __initdata
> >>>>>>>>> __aligned(PAGE_SIZE);
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +#define trampoline_pg_dir    ((pgd_t
> >>>>>>>>> *)XIP_FIXUP(trampoline_pg_dir))
> >>>>>>>>> +#define fixmap_pte           ((pte_t *)XIP_FIXUP(fixmap_pte))
> >>>>>>>>> +#define early_pg_dir         ((pgd_t *)XIP_FIXUP(early_pg_dir)=
)
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>>    void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys=
,
> >>>>>>>>> pgprot_t prot)
> >>>>>>>>>    {
> >>>>>>>>>         unsigned long addr =3D __fix_to_virt(idx);
> >>>>>>>>> @@ -238,6 +268,15 @@ pmd_t fixmap_pmd[PTRS_PER_PMD]
> >>>>>>>>> __page_aligned_bss;
> >>>>>>>>>    pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE=
);
> >>>>>>>>>    pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata
> >>>>>>>>> __aligned(PAGE_SIZE);
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +pmd_t xip_pmd[PTRS_PER_PMD] __page_aligned_bss;
> >>>>>>>>> +
> >>>>>>>>> +#define trampoline_pmd       ((pmd_t *)XIP_FIXUP(trampoline_pm=
d))
> >>>>>>>>> +#define fixmap_pmd   ((pmd_t *)XIP_FIXUP(fixmap_pmd))
> >>>>>>>>> +#define xip_pmd              ((pmd_t *)XIP_FIXUP(xip_pmd))
> >>>>>>>>> +#define early_pmd    ((pmd_t *)XIP_FIXUP(early_pmd))
> >>>>>>>>> +#endif /* CONFIG_XIP_KERNEL */
> >>>>>>>>> +
> >>>>>>>>>    static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> >>>>>>>>>    {
> >>>>>>>>>         /* Before MMU is enabled */
> >>>>>>>>> @@ -354,6 +393,19 @@ static uintptr_t __init
> >>>>>>>>> best_map_size(phys_addr_t base, phys_addr_t size)
> >>>>>>>>>         return PMD_SIZE;
> >>>>>>>>>    }
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +/* called from head.S with MMU off */
> >>>>>>>>> +asmlinkage void __init __copy_data(void)
> >>>>>>>>> +{
> >>>>>>>>> +     void *from =3D (void *)(&_sdata);
> >>>>>>>>> +     void *end =3D (void *)(&_end);
> >>>>>>>>> +     void *to =3D (void *)CONFIG_PHYS_RAM_BASE;
> >>>>>>>>> +     size_t sz =3D (size_t)(end - from);
> >>>>>>>>> +
> >>>>>>>>> +     memcpy(to, from, sz);
> >>>>>>>>> +}
> >>>>>>>>> +#endif
> >>>>>>>>> +
> >>>>>>>>>    /*
> >>>>>>>>>     * setup_vm() is called from head.S with MMU-off.
> >>>>>>>>>     *
> >>>>>>>>> @@ -374,7 +426,8 @@ static uintptr_t __init
> >>>>>>>>> best_map_size(phys_addr_t base, phys_addr_t size)
> >>>>>>>>>
> >>>>>>>>>    asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>>>>>>>>    {
> >>>>>>>>> -     uintptr_t va, pa, end_va;
> >>>>>>>>> +     uintptr_t va, end_va;
> >>>>>>>>> +     uintptr_t __maybe_unused pa;
> >>>>>>>>>         uintptr_t load_pa =3D (uintptr_t)(&_start);
> >>>>>>>>>         uintptr_t load_sz =3D (uintptr_t)(&_end) - load_pa;
> >>>>>>>>>         uintptr_t map_size;
> >>>>>>>>> @@ -382,6 +435,13 @@ asmlinkage void __init setup_vm(uintptr_t
> >>>>>>>>> dtb_pa)
> >>>>>>>>>         pmd_t fix_bmap_spmd, fix_bmap_epmd;
> >>>>>>>>>    #endif
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     uintptr_t xiprom =3D (uintptr_t)CONFIG_XIP_PHYS_ADDR;
> >>>>>>>>> +     uintptr_t xiprom_sz =3D (uintptr_t)(&_exiprom) -
> >>>>>>>>> (uintptr_t)(&_xiprom);
> >>>>>>>>> +
> >>>>>>>>> +     load_pa =3D (uintptr_t)CONFIG_PHYS_RAM_BASE;
> >>>>>>>>> +     load_sz =3D (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
> >>>>>>>>> +#endif
> >>>>>>>>>         va_pa_offset =3D PAGE_OFFSET - load_pa;
> >>>>>>
> >>>>>> I should have seen this before, I was too focused on having a XIP
> >>>>>> kernel
> >>>>>> boot. I already moved the kernel mapping in the vmalloc zone: the
> >>>>>> virtual to physical translations need to be handled differently
> >>>>>> now that
> >>>>>> the kernel mapping does not lie into linear mapping anymore, we ca=
n't
> >>>>>> use va_pa_offset defined above for both mappings.
> >>>>>>
> >>>>>> I was rebasing my patchset on the XIP patch but I believe that
> >>>>>> doing the
> >>>>>> other way around would greatly simplify the XIP patch as the kerne=
l
> >>>>>> mapping would already be moved outside the linear mapping, there
> >>>>>> would
> >>>>>> be no need to reserve a zone in vmalloc anymore (that simplifies
> >>>>>> pgtable.h quite a lot). And the XIP kernel mapping could be
> >>>>>> implemented
> >>>>>> in a new create_kernel_page_table (that would also simplify
> >>>>>> mm/init.c).
> >>>>>>
> >>>>>> I can help to do that but I don't think we should merge this patch
> >>>>>> as is
> >>>>>> now.
> >>>>>
> >>>>> I think that's the right way to go for now: it's a lot harder to te=
st
> >>>>> the XIP stuff, as it requires a bunch of harness changes.  So let's
> >>>>> take the page table refactoring in now and rebase this stuff on top=
 of
> >>>>> it. There's really no way to do both without making more work for
> >>>>> someone, it's just a headache on timing.
> >>>>>
> >>>>> Alex: if you want to sign up to spend some time there that'd be gre=
at,
> >>>>> otherwise I will.
> >>>>
> >>>> I can take care of that, no problem.
> >>>
> >>> Vitaly, can you try the branch int/alex/riscv_xip_kernel_rebase_v1 at
> >>> https://github.com/AlexGhiti/riscv-linux ? This boots fine using my
> >>> setup.
> >>>
> >>> I removed most of the pgtable.h stuff, the XIP kernel is now mapped l=
ike
> >>> any other kernel at the end of the address space, not in the vmalloc
> >>> zone as you proposed. And I fixed a few thigns along the way (pfn_bas=
e,
> >>> pfn_valid, copy_data and other stuff).
> >>>
> >>> Any comment is welcome !
> >>
> >> thanks for your efforts!
> >>
> >> I've just built your version. The build went well, but the image
> >> doesn't seem to boot for me.
> >
> > Too bad. Can you give me your config please ?
> >
>
> Apparently, as you can see below, your config works for me, at least it
> reaches userspace. Do you have traces or more info about what is wrong ?

Console output is just the same but it stops after the following line:
[    0.003208] Console: colour dummy device 80x25

I did some very simplistic debugging bisecting start_kernel()
execution and I could see that setup_per_cpu_pageset() was reached
while calibrate_delay() was not.

How (and whether) this might be related to XIP I don't know :)

Best regards,
   Vitaly

> Thanks!
>
> [    0.000000] Linux version 5.12.0-rc2 (alex@debian)
> (riscv64-buildroot-linux-gnu-gcc.br_real (Buildroot 2020.11.2) 9.3.0,
> GNU ld (GNU Binutils) 2.34) #322 SMP Sat Apr 3 05:50:18 EDT 2021
> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000bfffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000080000000-0x00000000bfffffff]
> [    0.000000] On node 0 totalpages: 262144
> [    0.000000]   DMA32 zone: 3584 pages used for memmap
> [    0.000000]   DMA32 zone: 0 pages reserved
> [    0.000000]   DMA32 zone: 262144 pages, LIFO batch:63
> [    0.000000] SBI specification v0.2 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x6
> [    0.000000] SBI v0.2 TIME extension detected
> [    0.000000] SBI v0.2 IPI extension detected
> [    0.000000] SBI v0.2 RFENCE extension detected
> [    0.000000] software IO TLB: mapped [mem
> 0x00000000b9e00000-0x00000000bde00000] (64MB)
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] riscv: ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 17 pages/cpu s29856 r8192 d31584 u69632
> [    0.000000] pcpu-alloc: s29856 r8192 d31584 u69632 alloc=3D17*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258=
560
> [    0.000000] Kernel command line: earlyprintk debug earlycon=3Dsbi
> console=3DttyS0,115200n8 root=3D/dev/ram0 init=3D/sbin/init
> [    0.000000] Dentry cache hash table entries: 131072 (order: 8,
> 1048576 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288
> bytes, linear)
> [    0.000000] Sorting __ex_table...
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 947732K/1048576K available (2999K kernel code,
> 692K rwdata, 953K rodata, 205K init, 247K bss, 100844K reserved, 0K
> cma-reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] riscv-intc: unable to find hart id for
> /cpus/cpu@0/interrupt-controller
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts
> with 4 handlers for 9 contexts.
> [    0.000000] random: get_random_bytes called from
> start_kernel+0x2fe/0x49c with crng_init=3D0
> [    0.000000] riscv_timer_init_dt: Registering clocksource cpuid [0]
> hartid [1]
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
> max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000146] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps
> every 2199023255500ns
> [    0.006056] Console: colour dummy device 80x25
> [    0.015242] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 2.00 BogoMIPS (lpj=3D4000)
> [    0.017130] pid_max: default: 32768 minimum: 301
> [    0.020115] Mount-cache hash table entries: 2048 (order: 2, 16384
> bytes, linear)
> [    0.021097] Mountpoint-cache hash table entries: 2048 (order: 2,
> 16384 bytes, linear)
> [    0.078755] ASID allocator using 16 bits (65536 entries)
> [    0.083669] rcu: Hierarchical SRCU implementation.
> [    0.093304] smp: Bringing up secondary CPUs ...
> [    1.149900] CPU1: failed to come online
> [    2.204183] CPU2: failed to come online
> [    3.256211] CPU3: failed to come online
> [    3.257043] smp: Brought up 1 node, 1 CPU
> [    3.269554] devtmpfs: initialized
> [    3.282015] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    3.283484] futex hash table entries: 1024 (order: 4, 65536 bytes,
> linear)
> [    3.381718] SCSI subsystem initialized
> [    3.385115] clocksource: Switched to clocksource riscv_clocksource
> [    3.602198] workingset: timestamp_bits=3D62 max_order=3D18 bucket_orde=
r=3D0
> [    3.624182] Block layer SCSI generic (bsg) driver version 0.4 loaded
> (major 253)
> [    3.625988] io scheduler mq-deadline registered
> [    3.626725] io scheduler kyber registered
> [    3.629047] start plist test
> [    3.641420] end plist test
> [    3.717639] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    3.752315] brd: module loaded
> [    3.790207] loop: module loaded
> [    3.793943] mousedev: PS/2 mouse device common for all mice
> [    3.810511] Warning: unable to open an initial console.
> [    3.811923] Freeing unused kernel memory: 88K
> [    3.812558] This architecture does not have kernel memory protection.
> [    3.814280] Run /init as init process
> [    3.814808]   with arguments:
> [    3.815227]     /init
> [    3.815539]   with environment:
> [    3.815924]     HOME=3D/
> [    3.816250]     TERM=3Dlinux
> [    4.398678] random: dd: uninitialized urandom read (512 bytes read)
>
>
> > Thanks,
> >
> > Alex
> >
> >> I'll take a look at the code later today.
> >>
> >> Best regards,
> >>     Vitaly
> >>
> >>> Thanks,
> >>>
> >>> Alex
> >>>
> >>>>
> >>>>> Either way, can you point me (either just indicate the old version =
is
> >>>>> OK or send a new one) to what you want me to look at WRT the page
> >>>>> table code?  IIRC it looked pretty much fine, but I'll take another
> >>>>> look ASAP so we can avoid serializing everything.
> >>>>
> >>>> The v3 is fine for me:
> >>>> https://patchwork.kernel.org/project/linux-riscv/list/?series=3D4476=
99
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>>>>         pfn_base =3D PFN_DOWN(load_pa);
> >>>>>>>>>
> >>>>>>>>> @@ -420,6 +480,21 @@ asmlinkage void __init setup_vm(uintptr_t
> >>>>>>>>> dtb_pa)
> >>>>>>>>>                            load_pa, PGDIR_SIZE, PAGE_KERNEL_EXE=
C);
> >>>>>>>>>    #endif
> >>>>>>>>>
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     create_pgd_mapping(trampoline_pg_dir, XIP_VIRT_ADDR_START=
,
> >>>>>>>>> +                        (uintptr_t)xip_pmd, PGDIR_SIZE,
> >>>>>>>>> PAGE_TABLE);
> >>>>>>>>> +     for (va =3D XIP_VIRT_ADDR_START;
> >>>>>>>>> +          va < XIP_VIRT_ADDR_START + xiprom_sz;
> >>>>>>>>> +          va +=3D PMD_SIZE) {
> >>>>>>>>> +             create_pmd_mapping(xip_pmd, va,
> >>>>>>>>> +                                xiprom + (va -
> >>>>>>>>> XIP_VIRT_ADDR_START),
> >>>>>>>>> +                                PMD_SIZE, PAGE_KERNEL_EXEC);
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     create_pgd_mapping(early_pg_dir, XIP_VIRT_ADDR_START,
> >>>>>>>>> +                        (uintptr_t)xip_pmd, PGDIR_SIZE,
> >>>>>>>>> PAGE_TABLE);
> >>>>>>>>> +#endif
> >>>>>>>>> +
> >>>>>>>>>         /*
> >>>>>>>>>          * Setup early PGD covering entire kernel which will
> >>>>>>>>> allows
> >>>>>>>>>          * us to reach paging_init(). We map all memory banks
> >>>>>>>>> later
> >>>>>>>>> @@ -444,7 +519,7 @@ asmlinkage void __init setup_vm(uintptr_t
> >>>>>>>>> dtb_pa)
> >>>>>>>>>                            pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL=
);
> >>>>>>>>>         dtb_early_va =3D (void *)DTB_EARLY_BASE_VA + (dtb_pa &
> >>>>>>>>> (PMD_SIZE - 1));
> >>>>>>>>>    #else /* CONFIG_BUILTIN_DTB */
> >>>>>>>>> -     dtb_early_va =3D __va(dtb_pa);
> >>>>>>>>> +     dtb_early_va =3D __va(XIP_FIXUP(dtb_pa));
> >>>>>>>>>    #endif /* CONFIG_BUILTIN_DTB */
> >>>>>>>>>    #else
> >>>>>>>>>    #ifndef CONFIG_BUILTIN_DTB
> >>>>>>>>> @@ -456,7 +531,7 @@ asmlinkage void __init setup_vm(uintptr_t
> >>>>>>>>> dtb_pa)
> >>>>>>>>>                            pa + PGDIR_SIZE, PGDIR_SIZE,
> >>>>>>>>> PAGE_KERNEL);
> >>>>>>>>>         dtb_early_va =3D (void *)DTB_EARLY_BASE_VA + (dtb_pa &
> >>>>>>>>> (PGDIR_SIZE - 1));
> >>>>>>>>>    #else /* CONFIG_BUILTIN_DTB */
> >>>>>>>>> -     dtb_early_va =3D __va(dtb_pa);
> >>>>>>>>> +     dtb_early_va =3D __va(XIP_FIXUP(dtb_pa));
> >>>>>>>>>    #endif /* CONFIG_BUILTIN_DTB */
> >>>>>>>>>    #endif
> >>>>>>>>>         dtb_early_pa =3D dtb_pa;
> >>>>>>>>> @@ -497,6 +572,9 @@ static void __init setup_vm_final(void)
> >>>>>>>>>         uintptr_t va, map_size;
> >>>>>>>>>         phys_addr_t pa, start, end;
> >>>>>>>>>         u64 i;
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     uintptr_t xiprom_sz =3D (uintptr_t)(&_exiprom) -
> >>>>>>>>> (uintptr_t)(&_xiprom);
> >>>>>>>>> +#endif
> >>>>>>>>>
> >>>>>>>>>         /**
> >>>>>>>>>          * MMU is enabled at this point. But page table setup i=
s
> >>>>>>>>> not complete yet.
> >>>>>>>>> @@ -528,6 +606,16 @@ static void __init setup_vm_final(void)
> >>>>>>>>>                                            map_size,
> >>>>>>>>> PAGE_KERNEL_EXEC);
> >>>>>>>>>                 }
> >>>>>>>>>         }
> >>>>>>>>> +#ifdef CONFIG_XIP_KERNEL
> >>>>>>>>> +     map_size =3D best_map_size(CONFIG_XIP_PHYS_ADDR, xiprom_s=
z);
> >>>>>>>>> +     for (va =3D XIP_VIRT_ADDR_START;
> >>>>>>>>> +          va < XIP_VIRT_ADDR_START + xiprom_sz;
> >>>>>>>>> +          va +=3D map_size)
> >>>>>>>>> +             create_pgd_mapping(swapper_pg_dir, va,
> >>>>>>>>> +                                CONFIG_XIP_PHYS_ADDR + (va -
> >>>>>>>>> XIP_VIRT_ADDR_START),
> >>>>>>>>> +                                map_size, PAGE_KERNEL_EXEC);
> >>>>>>>>> +
> >>>>>>>>> +#endif
> >>>>>>>>>
> >>>>>>>>>         /* Clear fixmap PTE and PMD mappings */
> >>>>>>>>>         clear_fixmap(FIX_PTE);
> >>>>>>>
> >>>>>>> _______________________________________________
> >>>>>>> linux-riscv mailing list
> >>>>>>> linux-riscv@lists.infradead.org
> >>>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> linux-riscv mailing list
> >>>>> linux-riscv@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>>
> >>>> _______________________________________________
> >>>> linux-riscv mailing list
> >>>> linux-riscv@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>
