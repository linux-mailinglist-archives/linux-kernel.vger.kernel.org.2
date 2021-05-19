Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E632E38845F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhESBWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhESBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:22:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4194C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 18:21:10 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r8so15838848ybb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OvP6C5u3es07lieekWZCHmsvTzfV4S8Srcbhv371jMA=;
        b=vYAUByKH56C6E8+Ulqe5d0IvuL+D8d4ZvGoi9bVIt9UR/uTxiimyOfuNDH05F8VDd/
         uLXOlxOWJ8Hy0jf5i9gwaKNU5GIzYpvxwQF1Mg93gAL6wCCcaWaKE91/jfFRAdq4hSko
         RmSyUok6sLrdi6EgLJ9wJHJh55W2RBq7Pv1auDMRwgHhl/z/4neLd2pZtZtYj+uqvoaT
         qDXAjQtwwE/H+jub8+bEwv3cPaW9tUJX9DK+JyHlX+2f+rWPO1id4Bmr6bw/57cDxPcF
         R+vGjs9WKcXnn7Pv8z1+4BQlUjPIuvG07NZ9kqIlTg4US5aodYLSvd2YDOPH+vTO50f9
         ZzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OvP6C5u3es07lieekWZCHmsvTzfV4S8Srcbhv371jMA=;
        b=gKBunfwuKn/h3u0kytSMzkxCYSo0S+x6gI1YjSdDs7U7hib6iXkYnheF3Xa/SyRCqh
         xhraLrvy+aHbr6ncMTCTgad+qeMvfr/OMkOiFDu7GcU2UNKq7tJRO80/QdOwBTyhibum
         /iBZ81PlZiWiGmiv3ao3ENSfhUuPx7aN1eeGQ2zPCXKxChzbrzRbOyWHDHhzYlX1RxPw
         Sjqqy7C1U38OvzVMFcvs61rNPKfjS+EwJB0UY5NQvoV6aWVLtSnPJPx272PBGKmcnFHu
         B5Nx3xqc5SGrjDFGUGJttHSum7qJp5lp6VQLI5dZxxPeHFmiOmxtXFVYHY9S9Bw08+rV
         Qqbg==
X-Gm-Message-State: AOAM533fcMof4UE5OGSjKD436L1JjhyQYlFlCeXUdy0MxCBdXSEWM0v8
        Cs4lXY8SoYuCKOtANQTfdvn5stOfe/7T4sU+r/8rzzZ/JWs=
X-Google-Smtp-Source: ABdhPJxnY+/S3J2IYeK1sXB5g2pZk/QbdpHYhsqwQP12KHrtA2zp9X6jF2w/jRPhnT6OhWZuOiNSQOE7q4aQ57HlUlQ=
X-Received: by 2002:a25:addc:: with SMTP id d28mr11853584ybe.448.1621387269819;
 Tue, 18 May 2021 18:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <97588756-5c12-2913-05a7-938eb7a510c8@intel.com> <20210519011712.1334416-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210519011712.1334416-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Tue, 18 May 2021 18:20:58 -0700
Message-ID: <CAC41dw9oni+E3CVu0R-4dqCD2suXeuxSa6BPYm3LQ4M7_C-33g@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Wire up KVM hypercalls
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I have missed to include a change log.

* Removed tdx-kvm.c and implemented tdx_kvm_hypercall*() functions in tdx.h
* Exported __tdx_hypercall_vendor_kvm() symbol for kvm.ko.
* Fixed commit log as per Dave's suggestion.
* Added Reviewed-by from Dave
* Added FRAME_BEGIN/FRAME_END for __tdx_hypercall_vendor_kvm() to fix
compiler warnings.

On Tue, May 18, 2021 at 6:17 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> KVM hypercalls use the "vmcall" or "vmmcall" instructions.
> Although the ABI is similar, those instructions no longer
> function for TDX guests. Make vendor-specific TDVMCALLs
> instead of VMCALL. This enables TDX guests to run with KVM
> acting as the hypervisor. TDX guests running under other
> hypervisors will continue to use those hypervisors'
> hypercalls.
>
> Since KVM driver can be built as a kernel module, export
> tdx_kvm_hypercall*() to make the symbols visible to kvm.ko.
>
> [Isaku Yamahata: proposed KVM VENDOR string]
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  arch/x86/Kconfig                |  5 +++
>  arch/x86/include/asm/kvm_para.h | 21 ++++++++++
>  arch/x86/include/asm/tdx.h      | 68 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/tdcall.S        | 26 +++++++++++++
>  4 files changed, 120 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9e0e0ff76bab..15e66a99dd41 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -886,6 +886,11 @@ config INTEL_TDX_GUEST
>           run in a CPU mode that protects the confidentiality of TD memor=
y
>           contents and the TD=E2=80=99s CPU state from other software, in=
cluding VMM.
>
> +# This option enables KVM specific hypercalls in TDX guest.
> +config INTEL_TDX_GUEST_KVM
> +       def_bool y
> +       depends on KVM_GUEST && INTEL_TDX_GUEST
> +
>  endif #HYPERVISOR_GUEST
>
>  source "arch/x86/Kconfig.cpu"
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_p=
ara.h
> index 338119852512..2fa85481520b 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -6,6 +6,7 @@
>  #include <asm/alternative.h>
>  #include <linux/interrupt.h>
>  #include <uapi/asm/kvm_para.h>
> +#include <asm/tdx.h>
>
>  extern void kvmclock_init(void);
>
> @@ -34,6 +35,10 @@ static inline bool kvm_check_and_clear_guest_paused(vo=
id)
>  static inline long kvm_hypercall0(unsigned int nr)
>  {
>         long ret;
> +
> +       if (is_tdx_guest())
> +               return tdx_kvm_hypercall0(nr);
> +
>         asm volatile(KVM_HYPERCALL
>                      : "=3Da"(ret)
>                      : "a"(nr)
> @@ -44,6 +49,10 @@ static inline long kvm_hypercall0(unsigned int nr)
>  static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
>  {
>         long ret;
> +
> +       if (is_tdx_guest())
> +               return tdx_kvm_hypercall1(nr, p1);
> +
>         asm volatile(KVM_HYPERCALL
>                      : "=3Da"(ret)
>                      : "a"(nr), "b"(p1)
> @@ -55,6 +64,10 @@ static inline long kvm_hypercall2(unsigned int nr, uns=
igned long p1,
>                                   unsigned long p2)
>  {
>         long ret;
> +
> +       if (is_tdx_guest())
> +               return tdx_kvm_hypercall2(nr, p1, p2);
> +
>         asm volatile(KVM_HYPERCALL
>                      : "=3Da"(ret)
>                      : "a"(nr), "b"(p1), "c"(p2)
> @@ -66,6 +79,10 @@ static inline long kvm_hypercall3(unsigned int nr, uns=
igned long p1,
>                                   unsigned long p2, unsigned long p3)
>  {
>         long ret;
> +
> +       if (is_tdx_guest())
> +               return tdx_kvm_hypercall3(nr, p1, p2, p3);
> +
>         asm volatile(KVM_HYPERCALL
>                      : "=3Da"(ret)
>                      : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
> @@ -78,6 +95,10 @@ static inline long kvm_hypercall4(unsigned int nr, uns=
igned long p1,
>                                   unsigned long p4)
>  {
>         long ret;
> +
> +       if (is_tdx_guest())
> +               return tdx_kvm_hypercall4(nr, p1, p2, p3, p4);
> +
>         asm volatile(KVM_HYPERCALL
>                      : "=3Da"(ret)
>                      : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 8ab4067afefc..3d8d977e52f0 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -73,4 +73,72 @@ static inline void tdx_early_init(void) { };
>
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>
> +#ifdef CONFIG_INTEL_TDX_GUEST_KVM
> +u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
> +                              u64 r15, struct tdx_hypercall_output *out)=
;
> +
> +/* Used by kvm_hypercall0() to trigger hypercall in TDX guest */
> +static inline long tdx_kvm_hypercall0(unsigned int nr)
> +{
> +       return __tdx_hypercall_vendor_kvm(nr, 0, 0, 0, 0, NULL);
> +}
> +
> +/* Used by kvm_hypercall1() to trigger hypercall in TDX guest */
> +static inline long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
> +{
> +       return __tdx_hypercall_vendor_kvm(nr, p1, 0, 0, 0, NULL);
> +}
> +
> +/* Used by kvm_hypercall2() to trigger hypercall in TDX guest */
> +static inline long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2)
> +{
> +       return __tdx_hypercall_vendor_kvm(nr, p1, p2, 0, 0, NULL);
> +}
> +
> +/* Used by kvm_hypercall3() to trigger hypercall in TDX guest */
> +static inline long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2, unsigned long p3)
> +{
> +       return __tdx_hypercall_vendor_kvm(nr, p1, p2, p3, 0, NULL);
> +}
> +
> +/* Used by kvm_hypercall4() to trigger hypercall in TDX guest */
> +static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2, unsigned long p3,
> +                                     unsigned long p4)
> +{
> +       return __tdx_hypercall_vendor_kvm(nr, p1, p2, p3, p4, NULL);
> +}
> +#else
> +static inline long tdx_kvm_hypercall0(unsigned int nr)
> +{
> +       return -ENODEV;
> +}
> +
> +static inline long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
> +{
> +       return -ENODEV;
> +}
> +
> +static inline long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2)
> +{
> +       return -ENODEV;
> +}
> +
> +static inline long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2, unsigned long p3)
> +{
> +       return -ENODEV;
> +}
> +
> +static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
> +                                     unsigned long p2, unsigned long p3,
> +                                     unsigned long p4)
> +{
> +       return -ENODEV;
> +}
> +#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
> +
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> index 2dfecdae38bb..27355fb80aeb 100644
> --- a/arch/x86/kernel/tdcall.S
> +++ b/arch/x86/kernel/tdcall.S
> @@ -3,6 +3,7 @@
>  #include <asm/asm.h>
>  #include <asm/frame.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/export.h>
>
>  #include <linux/linkage.h>
>  #include <linux/bits.h>
> @@ -25,6 +26,8 @@
>                                           TDG_R12 | TDG_R13 | \
>                                           TDG_R14 | TDG_R15 )
>
> +#define TDVMCALL_VENDOR_KVM            0x4d564b2e584454 /* "TDX.KVM" */
> +
>  /*
>   * TDX guests use the TDCALL instruction to make requests to the
>   * TDX module and hypercalls to the VMM. It is supported in
> @@ -212,3 +215,26 @@ SYM_FUNC_START(__tdx_hypercall)
>         FRAME_END
>         retq
>  SYM_FUNC_END(__tdx_hypercall)
> +
> +#ifdef CONFIG_INTEL_TDX_GUEST_KVM
> +
> +/*
> + * Helper function for KVM vendor TDVMCALLs. This assembly wrapper
> + * lets us reuse do_tdvmcall() for KVM-specific hypercalls (
> + * TDVMCALL_VENDOR_KVM).
> + */
> +SYM_FUNC_START(__tdx_hypercall_vendor_kvm)
> +       FRAME_BEGIN
> +       /*
> +        * R10 is not part of the function call ABI, but it is a part
> +        * of the TDVMCALL ABI. So set it before making call to the
> +        * do_tdx_hypercall().
> +        */
> +       movq $TDVMCALL_VENDOR_KVM, %r10
> +       call do_tdx_hypercall
> +       FRAME_END
> +       retq
> +SYM_FUNC_END(__tdx_hypercall_vendor_kvm)
> +
> +EXPORT_SYMBOL(__tdx_hypercall_vendor_kvm);
> +#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
> --
> 2.25.1
>


--=20
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
