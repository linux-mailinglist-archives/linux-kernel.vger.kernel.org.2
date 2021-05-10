Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE13B37997B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhEJV7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhEJV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:58:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:57:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a4so26787859ejk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xe8yto7Y1Sx6cNdcH9rP2VDkSTGfkrxa/0QAzyXUKSY=;
        b=ZLd/jApWQwqsWlO9GBUWBWi5K2acrKig/e/6zSWqYeeS7ho4ktv7bPcwmj7Tv0uPi7
         vH7C/ftF5LbhwN2gHSv3xg9XrEPJZlehmc6hv/aLMCMp5uQ33b/0LRx99aqJNa8QjFj6
         8ZL7/vUXnHUtB9HuWqsDE90nmL6YwpjiIkU6UjtwWSqDfQ1B4fXPuHActWhWig+O5cJt
         sXmXv+dQnY4sB7dPkGfKt9SY5Xt4xieTwasKFZnctush+hSiPGP7EoxVxVWoCHibaNdC
         NpK8eL6NAtdZs3+D+mjEzOoM8kbps9/XIQRbHfxxjld2csUdamb80/vMq/xaVJZO6bGP
         cVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xe8yto7Y1Sx6cNdcH9rP2VDkSTGfkrxa/0QAzyXUKSY=;
        b=n/rYnhEm0xLEc3U4LBPZBighYj0aoxAyLGXKaLTm59UjPKso345dlNAyxRuUlCYA8H
         TpIwAufOhuli+Dnm7tS5Lx72kKwr184qDIeG6lWfodslcB09QJbgXDCXaUvuJRjB77NY
         LUnrpxZ2SFIuejAtrAXwACuuTdXDq7uKK7aJHQIu/HasvcKoSERaOF2cVAdTLwV/nJq2
         OmkFflSaS3RrH8I3UgqpC19pQiSjNU2D+LIqJFBgJVQzW0uD6nvD1pLkrFP2rmgrqUBA
         FbKEO1rL6zRUOe1/Z8mB7J7tig/snLO4pZJPT9GEX+pblYxheSie2m64h9bjcV8vCfnJ
         dBLA==
X-Gm-Message-State: AOAM532dRda2fxxddqm3BOccc64r6ou3TTtxbF1DWMT2rJbsKPcAmvbC
        UCLU5WPHqk2vFFAUllxTa9E+neJMf1ecybXFrvaIZg==
X-Google-Smtp-Source: ABdhPJxjLQDQZY7giBP6n51kWegUQCkVNKORaegvu26NAYWxpipRrSpJwd/nXVrHNbKBqH/XerOuGq4wZ7ksJ0D6X2g=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr28268505ejy.323.1620683872270;
 Mon, 10 May 2021 14:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com> <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 14:57:40 -0700
Message-ID: <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:02 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

While I do not expect that a patch in the middle of a series needs the
full introduction of all concepts, the high expectations of  the
reader's context in this changelog make the patch actively painful to
read.

Some connective tissue commentary to list assumptions and pointers to
definitions is needed to make this patch stand alone when a future
bisect lands on it and someone wonders where to get started debugging
it.

> Unroll string operations and handle port I/O through TDVMCALLs.
> Also handle #VE due to I/O operations with the same TDVMCALLs.

There is a mix of direct-TDVMCALL usage and handling #VE when and why
is either approached used?

> Decompression code uses port IO for earlyprintk. We must use
> paravirt calls there too if we want to allow earlyprintk.

What is the tradeoff between teaching the decompression code to handle
#VE (the implied assumption) vs teaching it to avoid #VE with direct
TDVMCALLs (the chosen direction)?

Rewrite without "we":

"Given the need to support earlyprintk for protected guests, deploy
paravirt calls for the io*() and out*() usage in the decompress code."

This raises the question of why the cover letter switched from
explicitly saying TDVMCALL to "paravirt" where it could be confused
with the typical paravirt helpers?

>
> Decompresion code cannot deal with alternatives: use branches

s/Decompresion/Decompression/

> instead to implement inX() and outX() helpers.
>
> Since we use call instruction in place of in/out instruction,
> the argument passed to call instruction has to be in a
> register, it cannot be an immediate value like in/out
> instruction. So change constraint flag from "Nd" to "d"

Rewrite without "we":

With the approach to use a "call" instruction as an alternative for an
"in/out" instruction it is no longer the case that the argument can be
an immediate value. Change the asm constraint flag from "Nd" to "d" to
accomodate.

>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/boot/compressed/Makefile |   1 +
>  arch/x86/boot/compressed/tdcall.S |   9 ++
>  arch/x86/include/asm/io.h         |   5 +-
>  arch/x86/include/asm/tdx.h        |  46 ++++++++-
>  arch/x86/kernel/tdcall.S          | 154 ++++++++++++++++++++++++++++++

Why is this named "tdcall" when it is implementing tdvmcalls? I must
say those names don't really help me understand what they do. Can we
have Linux names that don't mandate keeping the spec terminology in my
brain's translation cache?

>  arch/x86/kernel/tdx.c             |  33 +++++++
>  6 files changed, 245 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/tdcall.S
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index a2554621cefe..a944a2038797 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -97,6 +97,7 @@ endif
>
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
> +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdcall.o
>
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
> new file mode 100644
> index 000000000000..5ebb80d45ad8
> --- /dev/null
> +++ b/arch/x86/boot/compressed/tdcall.S
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm/export.h>
> +
> +/* Do not export symbols in decompression code */
> +#undef EXPORT_SYMBOL
> +#define EXPORT_SYMBOL(sym)

What's wrong with the existing:

KBUILD_CFLAGS += -D__DISABLE_EXPORTS

...in arch/x86/boot/compressed/Makefile?

> +
> +#include "../../kernel/tdcall.S"
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index ef7a686a55a9..30a3b30395ad 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -43,6 +43,7 @@
>  #include <asm/page.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable_types.h>
> +#include <asm/tdx.h>
>
>  #define build_mmio_read(name, size, type, reg, barrier) \
>  static inline type name(const volatile void __iomem *addr) \
> @@ -309,7 +310,7 @@ static inline unsigned type in##bwl##_p(int port)                   \
>                                                                         \
>  static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>  {                                                                      \
> -       if (sev_key_active()) {                                         \
> +       if (sev_key_active() || is_tdx_guest()) {                       \

Is there a unified Linux name these can be given to stop the
proliferation of poor vendor names for similar concepts?

That routine

>                 unsigned type *value = (unsigned type *)addr;           \
>                 while (count) {                                         \
>                         out##bwl(*value, port);                         \
> @@ -325,7 +326,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>                                                                         \
>  static inline void ins##bwl(int port, void *addr, unsigned long count) \
>  {                                                                      \
> -       if (sev_key_active()) {                                         \
> +       if (sev_key_active() || is_tdx_guest()) {                       \
>                 unsigned type *value = (unsigned type *)addr;           \
>                 while (count) {                                         \
>                         *value = in##bwl(port);                         \
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index e0b3ed9e262c..b972c6531a53 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -5,6 +5,8 @@
>
>  #define TDX_CPUID_LEAF_ID      0x21
>
> +#ifndef __ASSEMBLY__
> +
>  #ifdef CONFIG_INTEL_TDX_GUEST
>
>  #include <asm/cpufeature.h>
> @@ -67,6 +69,48 @@ long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
>  long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
>                 unsigned long p3, unsigned long p4);
>
> +/* Decompression code doesn't know how to handle alternatives */

Does it also not know how to handle #VE to keep it aligned with the
runtime code?

> +#ifdef BOOT_COMPRESSED_MISC_H
> +#define __out(bwl, bw)                                                 \
> +do {                                                                   \
> +       if (is_tdx_guest()) {                                           \
> +               asm volatile("call tdg_out" #bwl : :                    \
> +                               "a"(value), "d"(port));                 \
> +       } else {                                                        \
> +               asm volatile("out" #bwl " %" #bw "0, %w1" : :           \
> +                               "a"(value), "Nd"(port));                \
> +       }                                                               \
> +} while (0)
> +#define __in(bwl, bw)                                                  \
> +do {                                                                   \
> +       if (is_tdx_guest()) {                                           \
> +               asm volatile("call tdg_in" #bwl :                       \
> +                               "=a"(value) : "d"(port));               \
> +       } else {                                                        \
> +               asm volatile("in" #bwl " %w1, %" #bw "0" :              \
> +                               "=a"(value) : "Nd"(port));              \
> +       }                                                               \
> +} while (0)
> +#else
> +#define __out(bwl, bw)                                                 \
> +       alternative_input("out" #bwl " %" #bw "1, %w2",                 \
> +                       "call tdg_out" #bwl, X86_FEATURE_TDX_GUEST,     \
> +                       "a"(value), "d"(port))
> +
> +#define __in(bwl, bw)                                                  \
> +       alternative_io("in" #bwl " %w2, %" #bw "0",                     \
> +                       "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,      \
> +                       "=a"(value), "d"(port))

Outside the boot decompression code isn't this branch of the "ifdef
BOOT_COMPRESSED_MISC_H"  handled by #VE? I also don't see any usage of
__{in,out}() in this patch.

> +#endif
> +
> +void tdg_outb(unsigned char value, unsigned short port);
> +void tdg_outw(unsigned short value, unsigned short port);
> +void tdg_outl(unsigned int value, unsigned short port);
> +
> +unsigned char tdg_inb(unsigned short port);
> +unsigned short tdg_inw(unsigned short port);
> +unsigned int tdg_inl(unsigned short port);
> +
>  #else // !CONFIG_INTEL_TDX_GUEST
>
>  static inline bool is_tdx_guest(void)
> @@ -106,5 +150,5 @@ static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
>  }
>
>  #endif /* CONFIG_INTEL_TDX_GUEST */
> -
> +#endif /* __ASSEMBLY__ */
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> index 964bfd7fc682..df4159bb5103 100644
> --- a/arch/x86/kernel/tdcall.S
> +++ b/arch/x86/kernel/tdcall.S
> @@ -3,6 +3,7 @@
>  #include <asm/asm.h>
>  #include <asm/frame.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/export.h>
>
>  #include <linux/linkage.h>
>
> @@ -12,6 +13,12 @@
>   */
>  #define TDVMCALL_EXPOSE_REGS_MASK      0xfc00
>  #define TDVMCALL_VENDOR_KVM            0x4d564b2e584454 /* "TDX.KVM" */
> +#define EXIT_REASON_IO_INSTRUCTION     30
> +/*
> + * Current size of struct tdvmcall_output is 40 bytes,
> + * but allocate double to account future changes.

What future changes? Why could they not be handled as future code changes?

> + */
> +#define TDVMCALL_OUTPUT_SIZE           80

Perhaps "PAYLOAD_SIZE" since it is used for both input and output?

If the ABI does not include the size of the payload then how would
code detect if even 80 bytes was violated in the future?

>
>  /*
>   * TDX guests use the TDCALL instruction to make
> @@ -205,3 +212,150 @@ SYM_FUNC_START(__tdvmcall_vendor_kvm)
>         call do_tdvmcall
>         retq
>  SYM_FUNC_END(__tdvmcall_vendor_kvm)
> +
> +.macro io_save_registers
> +       push %rbp
> +       push %rbx
> +       push %rcx
> +       push %rdx
> +       push %rdi
> +       push %rsi
> +       push %r8
> +       push %r9
> +       push %r10
> +       push %r11
> +       push %r12
> +       push %r13
> +       push %r14
> +       push %r15

Surely there's an existing macro for this pattern? Would
PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
would eliminate clearing of %r8.

> +.endm
> +.macro io_restore_registers
> +       pop %r15
> +       pop %r14
> +       pop %r13
> +       pop %r12
> +       pop %r11
> +       pop %r10
> +       pop %r9
> +       pop %r8
> +       pop %rsi
> +       pop %rdi
> +       pop %rdx
> +       pop %rcx
> +       pop %rbx
> +       pop %rbp
> +.endm
> +
> +/*
> + * tdg_out{b,w,l}()  - Write given data to the specified port.
> + *
> + * @arg1 (RAX)       - Value to be written (passed via R8 to do_tdvmcall()).
> + * @arg2 (RDX)       - Port id (passed via RCX to do_tdvmcall()).
> + *
> + */
> +SYM_FUNC_START(tdg_outb)
> +       io_save_registers
> +       xor %r8, %r8
> +       /* Move data to R8 register */
> +       mov %al, %r8b
> +       /* Set data width to 1 byte */
> +       mov $1, %rsi
> +       jmp 1f
> +
> +SYM_FUNC_START(tdg_outw)
> +       io_save_registers
> +       xor %r8, %r8
> +       /* Move data to R8 register */
> +       mov %ax, %r8w
> +       /* Set data width to 2 bytes */
> +       mov $2, %rsi
> +       jmp 1f
> +
> +SYM_FUNC_START(tdg_outl)
> +       io_save_registers
> +       xor %r8, %r8
> +       /* Move data to R8 register */
> +       mov %eax, %r8d
> +       /* Set data width to 4 bytes */
> +       mov $4, %rsi
> +1:
> +       /*
> +        * Since io_save_registers does not save rax
> +        * state, save it here so that we can preserve
> +        * the caller register state.
> +        */
> +       push %rax
> +
> +       mov %rdx, %rcx
> +       /* Set 1 in RDX to select out operation */
> +       mov $1, %rdx
> +       /* Set TDVMCALL function id in RDI */
> +       mov $EXIT_REASON_IO_INSTRUCTION, %rdi
> +       /* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
> +       xor %r10, %r10
> +       /* Since we don't use tdvmcall output, set it to NULL */
> +       xor %r9, %r9
> +
> +       call do_tdvmcall
> +
> +       pop %rax
> +       io_restore_registers
> +       ret
> +SYM_FUNC_END(tdg_outb)
> +SYM_FUNC_END(tdg_outw)
> +SYM_FUNC_END(tdg_outl)
> +EXPORT_SYMBOL(tdg_outb)
> +EXPORT_SYMBOL(tdg_outw)
> +EXPORT_SYMBOL(tdg_outl)
> +
> +/*
> + * tdg_in{b,w,l}()   - Read data to the specified port.
> + *
> + * @arg1 (RDX)       - Port id (passed via RCX to do_tdvmcall()).
> + *
> + * Returns data read via RAX register.
> + *
> + */
> +SYM_FUNC_START(tdg_inb)
> +       io_save_registers
> +       /* Set data width to 1 byte */
> +       mov $1, %rsi
> +       jmp 1f
> +
> +SYM_FUNC_START(tdg_inw)
> +       io_save_registers
> +       /* Set data width to 2 bytes */
> +       mov $2, %rsi
> +       jmp 1f
> +
> +SYM_FUNC_START(tdg_inl)
> +       io_save_registers
> +       /* Set data width to 4 bytes */
> +       mov $4, %rsi
> +1:
> +       mov %rdx, %rcx
> +       /* Set 0 in RDX to select in operation */
> +       mov $0, %rdx
> +       /* Set TDVMCALL function id in RDI */
> +       mov $EXIT_REASON_IO_INSTRUCTION, %rdi
> +       /* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
> +       xor %r10, %r10
> +       /* Allocate memory in stack for Output */
> +       subq $TDVMCALL_OUTPUT_SIZE, %rsp

Why is this leaf function responsibility? I would expect the core
do_tdvmcall (or whatever it is renamed to) helper to hide output
buffer payload handling. tdg_in* only wants 1, 2, or 4 bytes, not 40
bytes of payload to handle.

> +       /* Move tdvmcall_output pointer to R9 */
> +       movq %rsp, %r9
> +
> +       call do_tdvmcall
> +
> +       /* Move data read from port to RAX */
> +       mov TDVMCALL_r11(%r9), %eax

"TDVMCALL_r11" is unreadable, what is that doing?

Shouldn't failed in* calls signal failure with an all ones result?

> +       /* Free allocated memory */
> +       addq $TDVMCALL_OUTPUT_SIZE, %rsp
> +       io_restore_registers
> +       ret
> +SYM_FUNC_END(tdg_inb)
> +SYM_FUNC_END(tdg_inw)
> +SYM_FUNC_END(tdg_inl)
> +EXPORT_SYMBOL(tdg_inb)
> +EXPORT_SYMBOL(tdg_inw)
> +EXPORT_SYMBOL(tdg_inl)
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index e42e260df245..ec61f2f06c98 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -189,6 +189,36 @@ static void tdg_handle_cpuid(struct pt_regs *regs)
>         regs->dx = out.r15;
>  }
>
> +static void tdg_out(int size, int port, unsigned int value)
> +{
> +       tdvmcall(EXIT_REASON_IO_INSTRUCTION, size, 1, port, value);
> +}
> +
> +static unsigned int tdg_in(int size, int port)
> +{
> +       return tdvmcall_out_r11(EXIT_REASON_IO_INSTRUCTION, size, 0, port, 0);
> +}
> +
> +static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +       bool string = exit_qual & 16;
> +       int out, size, port;
> +
> +       /* I/O strings ops are unrolled at build time. */
> +       BUG_ON(string);
> +
> +       out = (exit_qual & 8) ? 0 : 1;
> +       size = (exit_qual & 7) + 1;
> +       port = exit_qual >> 16;

This seems to be begging for exit_qual helpers to put symbolic names
on these operations.

> +
> +       if (out) {
> +               tdg_out(size, port, regs->ax);
> +       } else {
> +               regs->ax &= ~GENMASK(8 * size, 0);
> +               regs->ax |= tdg_in(size, port) & GENMASK(8 * size, 0);
> +       }
> +}
> +
>  unsigned long tdg_get_ve_info(struct ve_info *ve)
>  {
>         u64 ret;
> @@ -238,6 +268,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>         case EXIT_REASON_CPUID:
>                 tdg_handle_cpuid(regs);
>                 break;
> +       case EXIT_REASON_IO_INSTRUCTION:
> +               tdg_handle_io(regs, ve->exit_qual);
> +               break;
>         default:
>                 pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>                 return -EFAULT;
> --
> 2.25.1
>
