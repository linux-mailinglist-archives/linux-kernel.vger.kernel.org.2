Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBC3433FF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCUSGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCUSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:06:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1973C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 11:06:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so17757658lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W3wjT16CHIMv+PNhc4CfMCEsKvxIs5MrY9/cNi4Cir8=;
        b=gkuGxGMGuMb0Pw7jnmInwCCI1OqucIm7WZLXiircYrrUGJvH5i46mHYk9NGdzLnc0J
         8/3p1MllhGsvG4nibz+tl1Zf5QqupNwZSjQl3o6YT/Vd6HmeklnhkNw+bU/hl4MkHPEq
         biCdZVbLIBGmbJAA2AdickFt6290g/QT2+xkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W3wjT16CHIMv+PNhc4CfMCEsKvxIs5MrY9/cNi4Cir8=;
        b=NfQrcKPz0SRI8PZveFby827KAK9YXeMB+LcgFaQ32IKPQi/nxHDGwtAfYcxdcMWFyv
         rnMXXFogtJrW4xYLWDTdKFLQ4sgxDxoCWYOx+DDV20n3m+InmD9wjc2abbokpg4s33DU
         r6uzz2nQIghhKL/RWBu5NAUyir9AeIm0qw53/6quI5F6n0FyQAHShwHFfMHBVfGQ6tu+
         La3H80a3X8i5jgngecgvGlJHX2is5cPZpDPs94KUhJU8mPLMtaJ/sRxx8NKp4vxgUZO5
         kWmpgZWknHvzqQpnAdn2LB7BeI5ho2vnbmuyQwxrMLZYT5CCtD8NMNAtyH0GTzRMEO86
         lGhg==
X-Gm-Message-State: AOAM531BMA6J3Fo3M0Eulkgt/DcmFhBslRzmEF8iNr+ewfmK9DsREl3N
        3haZFGdJhloNdc8dofhf+KpxVeflXd65h2SGjiJ+2WEOle75f5rm
X-Google-Smtp-Source: ABdhPJw+tdZTyyA/Nq2r9/KULEgjvwXQegjS6dSB65N7c/3wGCEopuXb0IQC0JGHpggcnkAjVVNkQHeAjRIAElYWG3M=
X-Received: by 2002:ac2:5687:: with SMTP id 7mr3294536lfr.407.1616349993663;
 Sun, 21 Mar 2021 11:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210310092234.10501-1-vitaly.wool@konsulko.com> <82a05081-5662-c787-44e4-d480774ce31c@ghiti.fr>
In-Reply-To: <82a05081-5662-c787-44e4-d480774ce31c@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 21 Mar 2021 19:06:22 +0100
Message-ID: <CAM4kBBKU_qq=3An-nCbT-+AqsfAJhA=J8eocwNckVu8se001YA@mail.gmail.com>
Subject: Re: [PATCH v5] RISC-V: enable XIP
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alex,

On Sun, Mar 21, 2021 at 4:11 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Vitaly,
>
> Le 3/10/21 =C3=A0 4:22 AM, Vitaly Wool a =C3=A9crit :
> > Introduce XIP (eXecute In Place) support for RISC-V platforms.
> > It allows code to be executed directly from non-volatile storage
> > directly addressable by the CPU, such as QSPI NOR flash which can
> > be found on many RISC-V platforms. This makes way for significant
> > optimization of RAM footprint. The XIP kernel is not compressed
> > since it has to run directly from flash, so it will occupy more
> > space on the non-volatile storage to The physical flash address
>
> There seems to be missing something here.


Hmmm... strange indeed. I'll come up with a respin shortly and will
double check.
>
>
> > used to link the kernel object files and for storing it has to
> > be known at compile time and is represented by a Kconfig option.
> >
> > XIP on RISC-V will currently only work on MMU-enabled kernels.
> >
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>
>
> This fails to boot on current for-next with the following panic.
> This is because dtb_early_va points to an address that is not mapped in
> swapper_pg_dir: using __va(dtb_early_pa) instead works fine.

Is it with CONFIG_BUILTIN_DTB or without?

>
> And as this likely needs another version, I'm going to add my comments
> below.
>
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Unable to handle kernel paging request at virtual address
> 0000000040000001
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc2 #155
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : fdt_check_header+0x0/0x1fc
> [    0.000000]  ra : early_init_dt_verify+0x16/0x6e
> [    0.000000] epc : ffffffe0002b955e ra : ffffffe00082100c sp :
> ffffffe001203f10
> [    0.000000]  gp : ffffffe0012e40b8 tp : ffffffe00120bd80 t0 :
> ffffffe23fdf7000
> [    0.000000]  t1 : 0000000000000000 t2 : 0000000000000000 s0 :
> ffffffe001203f30
> [    0.000000]  s1 : 0000000040000000 a0 : 0000000040000000 a1 :
> 00000002bfffffff
> [    0.000000]  a2 : ffffffe23fdf6f00 a3 : 0000000000000001 a4 :
> 0000000000000018
> [    0.000000]  a5 : ffffffe000a0b5e8 a6 : ffffffe23fdf6ef0 a7 :
> 0000000000000018
> [    0.000000]  s2 : 0000000080000200 s3 : 0000000000000fff s4 :
> ffffffe000a0a958
> [    0.000000]  s5 : 0000000000000005 s6 : 0000000000000140 s7 :
> ffffffe23fdf6ec0
> [    0.000000]  s8 : 0000000081000200 s9 : 0000000080000200 s10:
> ffffffe000a01000
> [    0.000000]  s11: 0000000000000fff t3 : ffffffffbfff7000 t4 :
> ffffffffffffffff
> [    0.000000]  t5 : 0000000080e00000 t6 : 0000000080202000
> [    0.000000] status: 0000000000000100 badaddr: 0000000040000001 cause:
> 000000000000000d
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffe0002b955e>] fdt_check_header+0x0/0x1fc
> [    0.000000] [<ffffffe000802af2>] setup_arch+0x3a6/0x412
> [    0.000000] [<ffffffe0008006ea>] start_kernel+0x7e/0x580
> [    0.000000] random: get_random_bytes called from
> print_oops_end_marker+0x22/0x44 with crng_init=3D0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> >
> > ---
> > Changes in v2:
> > - dedicated macro for XIP address fixup when MMU is not enabled yet
> >    o both for 32-bit and 64-bit RISC-V
> > - SP is explicitly set to a safe place in RAM before __copy_data call
> > - removed redundant alignment requirements in vmlinux-xip.lds.S
> > - changed long -> uintptr_t typecast in __XIP_FIXUP macro.
> > Changes in v3:
> > - rebased against latest for-next
> > - XIP address fixup macro now takes an argument
> > - SMP related fixes
> > Changes in v4:
> > - rebased against the current for-next
> > - less #ifdef's in C/ASM code
> > - dedicated XIP_FIXUP_OFFSET assembler macro in head.S
> > - C-specific definitions moved into #ifndef __ASSEMBLY__
> > - Fixed multi-core boot
> > Changes in v5:
> > - fixed build error for non-XIP kernels
> >
> >   arch/riscv/Kconfig                  |  44 +++++++++-
> >   arch/riscv/Makefile                 |   8 +-
> >   arch/riscv/boot/Makefile            |  13 +++
> >   arch/riscv/include/asm/pgtable.h    |  65 ++++++++++++--
> >   arch/riscv/kernel/cpu_ops_sbi.c     |  12 ++-
> >   arch/riscv/kernel/head.S            |  59 ++++++++++++-
> >   arch/riscv/kernel/head.h            |   3 +
> >   arch/riscv/kernel/setup.c           |   8 +-
> >   arch/riscv/kernel/vmlinux-xip.lds.S | 132 +++++++++++++++++++++++++++=
+
> >   arch/riscv/kernel/vmlinux.lds.S     |   6 ++
> >   arch/riscv/mm/init.c                | 100 +++++++++++++++++++--
> >   11 files changed, 432 insertions(+), 18 deletions(-)
> >   create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 85d626b8ce5e..59fb945a900e 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -438,7 +438,7 @@ config EFI_STUB
> >
> >   config EFI
> >       bool "UEFI runtime support"
> > -     depends on OF
> > +     depends on OF && !XIP_KERNEL
> >       select LIBFDT
> >       select UCS2_STRING
> >       select EFI_PARAMS_FROM_FDT
> > @@ -462,11 +462,51 @@ config STACKPROTECTOR_PER_TASK
> >       def_bool y
> >       depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> >
> > +config XIP_KERNEL
> > +     bool "Kernel Execute-In-Place from ROM"
> > +     depends on MMU
> > +     help
> > +       Execute-In-Place allows the kernel to run from non-volatile sto=
rage
> > +       directly addressable by the CPU, such as NOR flash. This saves =
RAM
> > +       space since the text section of the kernel is not loaded from f=
lash
> > +       to RAM.  Read-write sections, such as the data section and stac=
k,
> > +       are still copied to RAM.  The XIP kernel is not compressed sinc=
e
> > +       it has to run directly from flash, so it will take more space t=
o
> > +       store it.  The flash address used to link the kernel object fil=
es,
> > +       and for storing it, is configuration dependent. Therefore, if y=
ou
> > +       say Y here, you must know the proper physical address where to
> > +       store the kernel image depending on your own flash memory usage=
.
> > +
> > +       Also note that the make target becomes "make xipImage" rather t=
han
> > +       "make zImage" or "make Image".  The final kernel binary to put =
in
> > +       ROM memory will be arch/riscv/boot/xipImage.
> > +
> > +       If unsure, say N.
> > +
> > +config XIP_PHYS_ADDR
> > +     hex "XIP Kernel Physical Location"
> > +     depends on XIP_KERNEL
> > +     default "0x21000000"
> > +     help
> > +       This is the physical address in your flash memory the kernel wi=
ll
> > +       be linked for and stored to.  This address is dependent on your
> > +       own flash usage.
> > +
> > +config XIP_PHYS_RAM_BASE
> > +     hex "Platform Physical RAM address"
> > +     depends on XIP_KERNEL
> > +     default "0x80000000"
> > +     help
> > +       This is the physical address of RAM in the system. It has to be
> > +       explicitly specified to run early relocations of read-write dat=
a
> > +       from flash to RAM.
>
> This is not XIP specific and this is something I considered to add in
> order to map the linear mapping with hugepages, maybe simply rename this
> without XIP_ prefix.

Sure, let's just go with PHYS_RAM_BASE. I was reluctant to add yet
another constant at first but having to derive it in runtime led to
overly complicated calculations which could not be compile time
optimized, so here it came.

> > +
> >   endmenu
> >
> >   config BUILTIN_DTB
> > -     def_bool n
> > +     bool
> >       depends on OF
> > +     default y if XIP_KERNEL
> >
> >   menu "Power management options"
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 1368d943f1f3..8fcbec03974d 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -82,7 +82,11 @@ CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$(BITS)
> >
> >   # Default target when executing plain make
> >   boot                :=3D arch/riscv/boot
> > +ifeq ($(CONFIG_XIP_KERNEL),y)
> > +KBUILD_IMAGE :=3D $(boot)/xipImage
> > +else
> >   KBUILD_IMAGE        :=3D $(boot)/Image.gz
> > +endif
> >
> >   head-y :=3D arch/riscv/kernel/head.o
> >
> > @@ -95,12 +99,14 @@ PHONY +=3D vdso_install
> >   vdso_install:
> >       $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> >
> > +ifneq ($(CONFIG_XIP_KERNEL),y)
> >   ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
> >   KBUILD_IMAGE :=3D $(boot)/loader.bin
> >   else
> >   KBUILD_IMAGE :=3D $(boot)/Image.gz
> >   endif
> > -BOOT_TARGETS :=3D Image Image.gz loader loader.bin
> > +endif
> > +BOOT_TARGETS :=3D Image Image.gz loader loader.bin xipImage
> >
> >   all:        $(notdir $(KBUILD_IMAGE))
> >
> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> > index 03404c84f971..6bf299f70c27 100644
> > --- a/arch/riscv/boot/Makefile
> > +++ b/arch/riscv/boot/Makefile
> > @@ -17,8 +17,21 @@
> >   KCOV_INSTRUMENT :=3D n
> >
> >   OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .c=
omment -S
> > +OBJCOPYFLAGS_xipImage :=3D-O binary -R .note -R .note.gnu.build-id -R =
.comment -S
> >
> >   targets :=3D Image Image.* loader loader.o loader.lds loader.bin
> > +targets :=3D Image Image.* loader loader.o loader.lds loader.bin xipIm=
age
> > +
> > +ifeq ($(CONFIG_XIP_KERNEL),y)
> > +
> > +quiet_cmd_mkxip =3D $(quiet_cmd_objcopy)
> > +cmd_mkxip =3D $(cmd_objcopy)
> > +
> > +$(obj)/xipImage: vmlinux FORCE
> > +     $(call if_changed,mkxip)
> > +     @$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR=
)'
> > +
> > +endif
> >
> >   $(obj)/Image: vmlinux FORCE
> >       $(call if_changed,objcopy)
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index ebf817c1bdf4..4c2e6902f2b8 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -11,6 +11,33 @@
> >
> >   #include <asm/pgtable-bits.h>
> >
> > +#ifdef CONFIG_MMU
> > +
> > +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> > +
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define VMALLOC_SIZE     ((KERN_VIRT_SIZE >> 1) - SZ_16M)
> > +#define VMALLOC_END      (PAGE_OFFSET - SZ_16M - 1)
> > +
> > +#define XIP_OFFSET           SZ_8M
> > +#define XIP_MASK             (SZ_8M - 1)
> > +#define XIP_VIRT_ADDR(physaddr)      \
> > +     (PAGE_OFFSET - XIP_OFFSET + ((physaddr) & XIP_MASK))
> > +
> > +#else
> > +
> > +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> > +#define VMALLOC_END      (PAGE_OFFSET - 1)
> > +
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> > +#else
> > +
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define XIP_VIRT_ADDR(physaddr) (physaddr)
> > +#endif /* CONFIG_XIP_KERNEL */
> > +#endif /* CONFIG_MMU */
> > +
> >   #ifndef __ASSEMBLY__
> >
> >   /* Page Upper Directory not used in RISC-V */
> > @@ -21,9 +48,25 @@
> >
> >   #ifdef CONFIG_MMU
> >
> > -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> > -#define VMALLOC_END      (PAGE_OFFSET - 1)
> > -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> > +#ifdef CONFIG_XIP_KERNEL
> > +/*
> > + * Since we use sections to map it, this macro replaces the physical a=
ddress
> > + * with its virtual address while keeping offset from the base section=
.
>
> It seems the comment should be the other way around: "this macro
> replaces the *virtual* address...etc".
>
> > + */
> > +#define XIP_PHYS_ADDR(va)     \
> > +     ((uintptr_t)(va) - PAGE_OFFSET + XIP_OFFSET + CONFIG_XIP_PHYS_ADD=
R)
> > +
> > +#define XIP_VIRT_ADDR_START  XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> > +#define __PHRAM_BASE         CONFIG_XIP_PHYS_RAM_BASE
>
> I don't think that it is necessary to define this intermediate
> __PHRAM_BASE.

That was for the sake of keeping shorter lines. :)

> > +
> > +#define XIP_FIXUP(addr)              \
> > +     (((uintptr_t)(addr) >=3D CONFIG_XIP_PHYS_ADDR && \
> > +       (uintptr_t)(addr) <=3D CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
>
> That should be < CONFIG_XIP_PHYS_ADDR + SZ_16M, not <=3D.

Thanks, will fix.

> > +     (uintptr_t)(addr) - CONFIG_XIP_PHYS_ADDR + __PHRAM_BASE - XIP_OFF=
SET : \
> > +     (uintptr_t)(addr))
>
> There are possible side-effects in this macro definition, consider using
> a temporary variable for addr.

This is an internal definition so I didn't care much but FWIW it's
better to change it as you suggest, thanks.

> > +#else
> > +#define XIP_FIXUP(addr)              (addr)
> > +#endif /* CONFIG_XIP_KERNEL */
> >
> >   #define BPF_JIT_REGION_SIZE (SZ_128M)
> >   #define BPF_JIT_REGION_START        (PAGE_OFFSET - BPF_JIT_REGION_SIZ=
E)
> > @@ -484,8 +527,20 @@ static inline int ptep_clear_flush_young(struct vm=
_area_struct *vma,
> >
> >   #define kern_addr_valid(addr)   (1) /* FIXME */
> >
> > -extern void *dtb_early_va;
> > -extern uintptr_t dtb_early_pa;
> > +extern void *_dtb_early_va;
> > +extern uintptr_t _dtb_early_pa;
> > +#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
>
> CONFIG_XIP_KERNEL already depends on CONFIG_MMU. And maybe we could
> handle XIP_KERNEL and !XIP_KERNEL in XIP_FIXUP to avoid those ifdefs ?

This is a temporary dependence, we are working on the non-MMU case too
so I would not like to go that path.

> > +
> > +#define dtb_early_va (*(void **)XIP_FIXUP(&_dtb_early_va))
> > +#define dtb_early_pa (*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
> > +
> > +#else
> > +
> > +#define dtb_early_va _dtb_early_va
> > +#define dtb_early_pa _dtb_early_pa
> > +
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> >   void setup_bootmem(void);
> >   void paging_init(void);
> >   void misc_mem_init(void);
> > diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_op=
s_sbi.c
> > index 685fae72b7f5..7d368bc656ff 100644
> > --- a/arch/riscv/kernel/cpu_ops_sbi.c
> > +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> > @@ -53,10 +53,20 @@ static int sbi_hsm_hart_get_status(unsigned long ha=
rtid)
> >   }
> >   #endif
> >
> > +static inline unsigned long get_secondary_start_phys(void)
> > +{
> > +#ifdef CONFIG_XIP_KERNEL
> > +     return XIP_PHYS_ADDR(secondary_start_sbi);
> > +#else
> > +     return __pa_symbol(secondary_start_sbi);
> > +#endif
> > +}
> > +
> > +
>
> There are 2 newlines here.
>
> >   static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidl=
e)
> >   {
> >       int rc;
> > -     unsigned long boot_addr =3D __pa_symbol(secondary_start_sbi);
> > +     unsigned long boot_addr =3D get_secondary_start_phys();
> >       int hartid =3D cpuid_to_hartid_map(cpuid);
> >
> >       cpu_update_secondary_bootdata(cpuid, tidle);
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index f5a9bad86e58..17ecf6095209 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -9,11 +9,33 @@
> >   #include <linux/linkage.h>
> >   #include <asm/thread_info.h>
> >   #include <asm/page.h>
> > +#include <asm/pgtable.h>
> >   #include <asm/csr.h>
> >   #include <asm/hwcap.h>
> >   #include <asm/image.h>
> >   #include "efi-header.S"
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +.macro XIP_FIXUP_OFFSET reg
> > +#ifdef CONFIG_64BIT
> > +             ld t0, _xip_fixup
> > +#else
> > +             lw t0, _xip_fixup
> > +#endif
>
> Use REG_L here.

Will do, thanks.

> > +             add \reg, \reg, t0
> > +.endm
> > +
> > +_xip_fixup:
> > +#ifdef CONFIG_64BIT
> > +     .dword CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFS=
ET
> > +#else
> > +     .word CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSE=
T
> > +#endif
> > +#else
> > +.macro XIP_FIXUP_OFFSET reg
> > +.endm
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> >   __HEAD
> >   ENTRY(_start)
> >       /*
> > @@ -69,7 +91,11 @@ pe_head_start:
> >   #ifdef CONFIG_MMU
> >   relocate:
> >       /* Relocate return address */
> > +#ifdef CONFIG_XIP_KERNEL
> > +     li a1, XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> > +#else
> >       li a1, PAGE_OFFSET
> > +#endif
> >       la a2, _start
> >       sub a1, a1, a2
> >       add ra, ra, a1
> > @@ -91,6 +117,7 @@ relocate:
> >        * to ensure the new translations are in use.
> >        */
> >       la a0, trampoline_pg_dir
> > +     XIP_FIXUP_OFFSET a0
>
>
> For all those pairs of la aX...; XIP_FIXUP_OFFSET aX...; maybe introduce
> a macro that does both ?

I can do that but wouldn't it obscure the operations too much?

> >       srl a0, a0, PAGE_SHIFT
> >       or a0, a0, a1
> >       sfence.vma
> > @@ -144,7 +171,9 @@ secondary_start_sbi:
> >
> >       slli a3, a0, LGREG
> >       la a4, __cpu_up_stack_pointer
> > +     XIP_FIXUP_OFFSET a4
> >       la a5, __cpu_up_task_pointer
> > +     XIP_FIXUP_OFFSET a5
> >       add a4, a3, a4
> >       add a5, a3, a5
> >       REG_L sp, (a4)
> > @@ -156,6 +185,7 @@ secondary_start_common:
> >   #ifdef CONFIG_MMU
> >       /* Enable virtual memory and relocate to virtual address */
> >       la a0, swapper_pg_dir
> > +     XIP_FIXUP_OFFSET a0
> >       call relocate
> >   #endif
> >       call setup_trap_vector
> > @@ -236,12 +266,33 @@ pmp_done:
> >   .Lgood_cores:
> >   #endif
> >
> > +#ifndef CONFIG_XIP_KERNEL
> >       /* Pick one hart to run the main boot sequence */
> >       la a3, hart_lottery
> >       li a2, 1
> >       amoadd.w a3, a2, (a3)
> >       bnez a3, .Lsecondary_start
> >
> > +#else
> > +     /* hart_lottery in flash contains a magic number */
> > +     la a3, hart_lottery
> > +     mv a2, a3
> > +     XIP_FIXUP_OFFSET a2
> > +     lw t1, (a3)
> > +     amoswap.w t0, t1, (a2)
> > +     /* first time here if hart_lottery in RAM is not set */
> > +     beq t0, t1, .Lsecondary_start
> > +
> > +     la sp, _end + THREAD_SIZE
> > +     XIP_FIXUP_OFFSET sp
> > +     mv s0, a0
> > +     call __copy_data
> > +
> > +     /* Restore a0 copy */
> > +     mv a0, s0
> > +#endif
> > +
> > +#ifndef CONFIG_XIP_KERNEL
> >       /* Clear BSS for flat non-ELF images */
> >       la a3, __bss_start
> >       la a4, __bss_stop
> > @@ -251,15 +302,18 @@ clear_bss:
> >       add a3, a3, RISCV_SZPTR
> >       blt a3, a4, clear_bss
> >   clear_bss_done:
> > -
> > +#endif
> >       /* Save hart ID and DTB physical address */
> >       mv s0, a0
> >       mv s1, a1
> > +
> >       la a2, boot_cpu_hartid
> > +     XIP_FIXUP_OFFSET a2
> >       REG_S a0, (a2)
> >
> >       /* Initialize page tables and relocate to virtual addresses */
> >       la sp, init_thread_union + THREAD_SIZE
> > +     XIP_FIXUP_OFFSET sp
> >   #ifdef CONFIG_BUILTIN_DTB
> >       la a0, __dtb_start
> >   #else
> > @@ -268,6 +322,7 @@ clear_bss_done:
> >       call setup_vm
> >   #ifdef CONFIG_MMU
> >       la a0, early_pg_dir
> > +     XIP_FIXUP_OFFSET a0
> >       call relocate
> >   #endif /* CONFIG_MMU */
> >
> > @@ -292,7 +347,9 @@ clear_bss_done:
> >
> >       slli a3, a0, LGREG
> >       la a1, __cpu_up_stack_pointer
> > +     XIP_FIXUP_OFFSET a1
> >       la a2, __cpu_up_task_pointer
> > +     XIP_FIXUP_OFFSET a2
> >       add a1, a3, a1
> >       add a2, a3, a2
> >
> > diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
> > index b48dda3d04f6..aabbc3ac3e48 100644
> > --- a/arch/riscv/kernel/head.h
> > +++ b/arch/riscv/kernel/head.h
> > @@ -12,6 +12,9 @@ extern atomic_t hart_lottery;
> >
> >   asmlinkage void do_page_fault(struct pt_regs *regs);
> >   asmlinkage void __init setup_vm(uintptr_t dtb_pa);
> > +#ifdef CONFIG_XIP_KERNEL
> > +asmlinkage void __init __copy_data(void);
> > +#endif
> >
> >   extern void *__cpu_up_stack_pointer[];
> >   extern void *__cpu_up_task_pointer[];
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index e85bacff1b50..29956c41a9cc 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") =
=3D {
> >    * This is used before the kernel initializes the BSS so it can't be =
in the
> >    * BSS.
> >    */
> > -atomic_t hart_lottery __section(".sdata");
> > +atomic_t hart_lottery __section(".sdata")
> > +#ifdef CONFIG_XIP_KERNEL
> > +=3D ATOMIC_INIT(0xC001BEEF)
> > +#endif
> > +;
> >   unsigned long boot_cpu_hartid;
> >   static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >
> > @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
> >   #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >       unflatten_and_copy_device_tree();
> >   #else
> > -     if (early_init_dt_verify(__va(dtb_early_pa)))
> > +     if (early_init_dt_verify(dtb_early_va))
> >               unflatten_device_tree();
> >       else
> >               pr_err("No DTB found in kernel mappings\n");
> > diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vm=
linux-xip.lds.S
> > new file mode 100644
> > index 000000000000..9f0f08c34cd3
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> > @@ -0,0 +1,132 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2012 Regents of the University of California
> > + * Copyright (C) 2017 SiFive
> > + * Copyright (C) 2020 Vitaly Wool, Konsulko AB
> > + */
> > +
> > +#define LOAD_OFFSET XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> > +/* No __ro_after_init data in the .rodata section - which will always =
be ro */
> > +#define RO_AFTER_INIT_DATA
> > +
> > +#include <asm/vmlinux.lds.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/cache.h>
> > +#include <asm/thread_info.h>
> > +
> > +OUTPUT_ARCH(riscv)
> > +ENTRY(_start)
> > +
> > +jiffies =3D jiffies_64;
> > +
> > +SECTIONS
> > +{
> > +     /* Beginning of code and text segment */
> > +     . =3D XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> > +     _xiprom =3D .;
> > +     _start =3D .;
> > +     HEAD_TEXT_SECTION
> > +     INIT_TEXT_SECTION(PAGE_SIZE)
> > +     /* we have to discard exit text and such at runtime, not link tim=
e */
> > +     .exit.text :
> > +     {
> > +             EXIT_TEXT
> > +     }
> > +
> > +     .text : {
> > +             _text =3D .;
> > +             _stext =3D .;
> > +             TEXT_TEXT
> > +             SCHED_TEXT
> > +             CPUIDLE_TEXT
> > +             LOCK_TEXT
> > +             KPROBES_TEXT
> > +             ENTRY_TEXT
> > +             IRQENTRY_TEXT
> > +             SOFTIRQENTRY_TEXT
> > +             *(.fixup)
> > +             _etext =3D .;
> > +     }
> > +     RO_DATA(L1_CACHE_BYTES)
> > +     .srodata : {
> > +             *(.srodata*)
> > +     }
> > +     .init.rodata : {
> > +             INIT_SETUP(16)
> > +             INIT_CALLS
> > +             CON_INITCALL
> > +             INIT_RAM_FS
> > +     }
> > +     _exiprom =3D .;                   /* End of XIP ROM area */
> > +
> > +
> > +/*
> > + * From this point, stuff is considered writable and will be copied to=
 RAM
> > + */
> > +     __data_loc =3D ALIGN(16);         /* location in file */
> > +     . =3D PAGE_OFFSET;                /* location in memory */
> > +
> > +     _sdata =3D .;                     /* Start of data section */
> > +     _data =3D .;
> > +     RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> > +     _edata =3D .;
> > +     __start_ro_after_init =3D .;
> > +     .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET)=
 {
> > +             *(.data..ro_after_init)
> > +     }
> > +     __end_ro_after_init =3D .;
> > +
> > +     . =3D ALIGN(PAGE_SIZE);
> > +     __init_begin =3D .;
> > +     .init.data : {
> > +             INIT_DATA
> > +     }
> > +     .exit.data : {
> > +             EXIT_DATA
> > +     }
> > +     . =3D ALIGN(8);
> > +     __soc_early_init_table : {
> > +             __soc_early_init_table_start =3D .;
> > +             KEEP(*(__soc_early_init_table))
> > +             __soc_early_init_table_end =3D .;
> > +     }
> > +     __soc_builtin_dtb_table : {
> > +             __soc_builtin_dtb_table_start =3D .;
> > +             KEEP(*(__soc_builtin_dtb_table))
> > +             __soc_builtin_dtb_table_end =3D .;
> > +     }
> > +     PERCPU_SECTION(L1_CACHE_BYTES)
> > +
> > +     . =3D ALIGN(PAGE_SIZE);
> > +     __init_end =3D .;
> > +
> > +     .sdata : {
> > +             __global_pointer$ =3D . + 0x800;
> > +             *(.sdata*)
> > +             *(.sbss*)
> > +     }
> > +
> > +     BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> > +     EXCEPTION_TABLE(0x10)
> > +
> > +     .rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
> > +             *(.rel.dyn*)
> > +     }
> > +
> > +     /*
> > +      * End of copied data. We need a dummy section to get its LMA.
> > +      * Also located before final ALIGN() as trailing padding is not s=
tored
> > +      * in the resulting binary file and useless to copy.
> > +      */
> > +     .data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
> > +     _edata_loc =3D LOADADDR(.data.endmark);
> > +
> > +     . =3D ALIGN(PAGE_SIZE);
> > +     _end =3D .;
> > +
> > +     STABS_DEBUG
> > +     DWARF_DEBUG
> > +
> > +     DISCARDS
> > +}
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinu=
x.lds.S
> > index de03cb22d0e9..6745ec325930 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -4,7 +4,12 @@
> >    * Copyright (C) 2017 SiFive
> >    */
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +#include "vmlinux-xip.lds.S"
> > +#else
> > +
> >   #define LOAD_OFFSET PAGE_OFFSET
> > +
> >   #include <asm/vmlinux.lds.h>
> >   #include <asm/page.h>
> >   #include <asm/cache.h>
> > @@ -132,3 +137,4 @@ SECTIONS
> >
> >       DISCARDS
> >   }
> > +#endif /* CONFIG_XIP_KERNEL */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 067583ab1bd7..b5ac455cb159 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -31,8 +31,8 @@ EXPORT_SYMBOL(empty_zero_page);
> >
> >   extern char _start[];
> >   #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> > -void *dtb_early_va __initdata;
> > -uintptr_t dtb_early_pa __initdata;
> > +void *_dtb_early_va __initdata;
> > +uintptr_t _dtb_early_pa __initdata;
> >
> >   struct pt_alloc_ops {
> >       pte_t *(*get_pte_virt)(phys_addr_t pa);
> > @@ -88,6 +88,10 @@ static void print_vm_layout(void)
> >                 (unsigned long)VMALLOC_END);
> >       print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
> >                 (unsigned long)high_memory);
> > +#ifdef CONFIG_XIP_KERNEL
> > +     print_mlm("xip", (unsigned long)XIP_VIRT_ADDR_START,
> > +               (unsigned long)XIP_VIRT_ADDR_START + SZ_16M);
> > +#endif /* CONFIG_XIP_KERNEL */
> >   }
> >   #else
> >   static void print_vm_layout(void) { }
> > @@ -113,6 +117,10 @@ void __init setup_bootmem(void)
> >       phys_addr_t dram_end =3D memblock_end_of_DRAM();
> >       phys_addr_t max_mapped_addr =3D __pa(~(ulong)0);
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +     vmlinux_start =3D __pa_symbol(&_sdata);
> > +#endif
>
> Nit: I would use IS_ENABLED(CONFIG_XIP_KERNEL) to avoid double
> assignment in case CONFIG_XIP_KERNEL is set.
>
> > +
> >       /* The maximal physical memory size is -PAGE_OFFSET. */
> >       memblock_enforce_memory_limit(-PAGE_OFFSET);
> >
> > @@ -148,11 +156,27 @@ void __init setup_bootmem(void)
> >       memblock_allow_resize();
> >   }
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +
> > +extern char _xiprom[], _exiprom[];
> > +extern char _sdata[], _edata[];
> > +
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> >   #ifdef CONFIG_MMU
> > -static struct pt_alloc_ops pt_ops;
> > +static struct pt_alloc_ops _pt_ops;
> > +
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> > +#else
> > +#define pt_ops       _pt_ops
> > +#endif
> >
> >   unsigned long va_pa_offset;
> >   EXPORT_SYMBOL(va_pa_offset);
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define va_pa_offset (*((unsigned long *)XIP_FIXUP(&va_pa_offset)))
> > +#endif
> >   unsigned long pfn_base;
> >   EXPORT_SYMBOL(pfn_base);
> >
> > @@ -162,6 +186,12 @@ pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> >
> >   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define trampoline_pg_dir    ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> > +#define fixmap_pte           ((pte_t *)XIP_FIXUP(fixmap_pte))
> > +#define early_pg_dir         ((pgd_t *)XIP_FIXUP(early_pg_dir))
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> >   void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_=
t prot)
> >   {
> >       unsigned long addr =3D __fix_to_virt(idx);
> > @@ -237,6 +267,15 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> >   pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> >   pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +pmd_t xip_pmd[PTRS_PER_PMD] __page_aligned_bss;
> > +
> > +#define trampoline_pmd       ((pmd_t *)XIP_FIXUP(trampoline_pmd))
> > +#define fixmap_pmd   ((pmd_t *)XIP_FIXUP(fixmap_pmd))
> > +#define xip_pmd              ((pmd_t *)XIP_FIXUP(xip_pmd))
> > +#define early_pmd    ((pmd_t *)XIP_FIXUP(early_pmd))
> > +#endif /* CONFIG_XIP_KERNEL */
> > +
> >   static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> >   {
> >       /* Before MMU is enabled */
> > @@ -353,6 +392,19 @@ static uintptr_t __init best_map_size(phys_addr_t =
base, phys_addr_t size)
> >       return PMD_SIZE;
> >   }
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +/* called from head.S with MMU off */
> > +asmlinkage void __init __copy_data(void)
> > +{
> > +     void *from =3D (void *)(&_sdata);
> > +     void *end =3D (void *)(&_end);
> > +     void *to =3D (void *)CONFIG_XIP_PHYS_RAM_BASE;
> > +     size_t sz =3D (size_t)(end - from);
> > +
> > +     memcpy(to, from, sz);
> > +}
> > +#endif
> > +
> >   /*
> >    * setup_vm() is called from head.S with MMU-off.
> >    *
> > @@ -373,7 +425,8 @@ static uintptr_t __init best_map_size(phys_addr_t b=
ase, phys_addr_t size)
> >
> >   asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >   {
> > -     uintptr_t va, pa, end_va;
> > +     uintptr_t va, end_va;
> > +     uintptr_t __maybe_unused pa;
> >       uintptr_t load_pa =3D (uintptr_t)(&_start);
> >       uintptr_t load_sz =3D (uintptr_t)(&_end) - load_pa;
> >       uintptr_t map_size;
> > @@ -381,6 +434,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       pmd_t fix_bmap_spmd, fix_bmap_epmd;
> >   #endif
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +     uintptr_t xiprom =3D (uintptr_t)CONFIG_XIP_PHYS_ADDR;
> > +     uintptr_t xiprom_sz =3D (uintptr_t)(&_exiprom) - (uintptr_t)(&_xi=
prom);
> > +
> > +     load_pa =3D (uintptr_t)CONFIG_XIP_PHYS_RAM_BASE;
> > +     load_sz =3D (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
> > +#endif
> >       va_pa_offset =3D PAGE_OFFSET - load_pa;
> >       pfn_base =3D PFN_DOWN(load_pa);
> >
> > @@ -419,6 +479,21 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >                          load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
> >   #endif
> >
> > +#ifdef CONFIG_XIP_KERNEL
> > +     create_pgd_mapping(trampoline_pg_dir, XIP_VIRT_ADDR_START,
> > +                        (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
> > +     for (va =3D XIP_VIRT_ADDR_START;
> > +          va < XIP_VIRT_ADDR_START + xiprom_sz;
> > +          va +=3D PMD_SIZE) {
> > +             create_pmd_mapping(xip_pmd, va,
> > +                                xiprom + (va - XIP_VIRT_ADDR_START),
> > +                                PMD_SIZE, PAGE_KERNEL_EXEC);
> > +     }
> > +
> > +     create_pgd_mapping(early_pg_dir, XIP_VIRT_ADDR_START,
> > +                        (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
> > +#endif
> > +
> >       /*
> >        * Setup early PGD covering entire kernel which will allows
> >        * us to reach paging_init(). We map all memory banks later
> > @@ -443,7 +518,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >                          pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
> >       dtb_early_va =3D (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE =
- 1));
> >   #else /* CONFIG_BUILTIN_DTB */
> > -     dtb_early_va =3D __va(dtb_pa);
> > +     dtb_early_va =3D __va(XIP_FIXUP(dtb_pa));
> >   #endif /* CONFIG_BUILTIN_DTB */
> >   #else
> >   #ifndef CONFIG_BUILTIN_DTB
> > @@ -455,7 +530,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >                          pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
> >       dtb_early_va =3D (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZ=
E - 1));
> >   #else /* CONFIG_BUILTIN_DTB */
> > -     dtb_early_va =3D __va(dtb_pa);
> > +     dtb_early_va =3D __va(XIP_FIXUP(dtb_pa));
> >   #endif /* CONFIG_BUILTIN_DTB */
> >   #endif
> >       dtb_early_pa =3D dtb_pa;
> > @@ -496,6 +571,9 @@ static void __init setup_vm_final(void)
> >       uintptr_t va, map_size;
> >       phys_addr_t pa, start, end;
> >       u64 i;
> > +#ifdef CONFIG_XIP_KERNEL
> > +     uintptr_t xiprom_sz =3D (uintptr_t)(&_exiprom) - (uintptr_t)(&_xi=
prom);
> > +#endif
> >
> >       /**
> >        * MMU is enabled at this point. But page table setup is not comp=
lete yet.
> > @@ -527,6 +605,16 @@ static void __init setup_vm_final(void)
> >                                          map_size, PAGE_KERNEL_EXEC);
> >               }
> >       }
> > +#ifdef CONFIG_XIP_KERNEL
> > +     map_size =3D best_map_size(CONFIG_XIP_PHYS_ADDR, xiprom_sz);
> > +     for (va =3D XIP_VIRT_ADDR_START;
> > +          va < XIP_VIRT_ADDR_START + xiprom_sz;
> > +          va +=3D map_size)
> > +             create_pgd_mapping(swapper_pg_dir, va,
> > +                                CONFIG_XIP_PHYS_ADDR + (va - XIP_VIRT_=
ADDR_START),
> > +                                map_size, PAGE_KERNEL_EXEC);
> > +
> > +#endif
> >
> >       /* Clear fixmap PTE and PMD mappings */
> >       clear_fixmap(FIX_PTE);
> >
>
> And I'm not sure I understand which variables are required to be fixup,
> can you explain it a bit more please ?

On a high level, all the RW sections are copied to RAM but while the
MMU is not enabled, we are dealing with the addresses in the NOR flash
all the way. To read and modify the RAM versions of variables we do
this XIP_FIXUP thing.

Please come back if this explanation is not clear enough.

> And finally, how can we try XIP_KERNEL on qemu ?

It works with Polarfire Icicle emulation. I'm using the folllowing
command line for testing it:
qemu-system-riscv64 -M microchip-icicle-kit -bios
work/hart-software-services/hss.bin -smp 5 -drive
if=3Dsd,format=3Draw,file=3Dsd1.img -nic user,model=3Dcadence_gem -display
none -serial null -chardev
socket,id=3Dserial1,path=3D/tmp/serial1.sock,server -serial
chardev:serial1 -device loader,addr=3D0x21000000,file=3DxipImage -D
qemu.log -monitor stdio

Thanks a lot for the review,

Best regards,
   Vitaly
