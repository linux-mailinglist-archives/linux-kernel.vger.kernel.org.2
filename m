Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4231C311A63
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBFDni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhBFCq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:46:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED4D165000
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612568534;
        bh=3r3ZBoxDTpjMeOzTmP90xlm68adFxTpvNrw762pTrG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g2HHtkagsm6dZWsJvUy8gqdApDxc/QvdLkb6Hx+sUJS6gZhAmtfAsxjIkEJxLmoCr
         seLzrcTs5H123ufV8SAK8ufUz7uu7C34kUeKKFjO/32MsGzGd8KcLIfcgoA4s+/xed
         9KNzwLAQy8smdapG4lov4CBEcbr18UiHf0YztqnmzHyK/4JyXbKG4Eumsl/Tix1vEM
         5nrFUKwbeb1A5TJ3xE/7es/eu1GUQoYeA54rqrmz5joy6BxtAwfHbLwptO5sYFtCcd
         aBU2QNlbLHzOafblymeEHcZLlCbcLVnks13bCr94iEblCC3GfTTVSk8OsK7h1eq4+V
         mpVf3AbjwbrVw==
Received: by mail-ej1-f52.google.com with SMTP id i8so14806292ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:42:13 -0800 (PST)
X-Gm-Message-State: AOAM532rySov3o1Dyg4pZlFWdWxj02obuxdMEFuW0gpGux3MRXOC+gT+
        vD8CTrsYosbAkLM1ZeWHLX/vz65dFCKHX4luHnbxOA==
X-Google-Smtp-Source: ABdhPJzWWcT8nlp9IyAdrXwQ09Pjki4w4uGM7Crt4KvjRVGgERX26kKDkw8zbWc43JWEvVexPY4IvHSFKqBlpxWKyXU=
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr6335198ejn.214.1612568532360;
 Fri, 05 Feb 2021 15:42:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com> <e45fcb584cd9fd67e6585ad8a904659a8b2ff9a5.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e45fcb584cd9fd67e6585ad8a904659a8b2ff9a5.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Feb 2021 15:42:01 -0800
X-Gmail-Original-Message-ID: <CALCETrW3+mzHaCUcWC1YUSwiuHkDWo=S4xnavk0CMcBiZd17+Q@mail.gmail.com>
Message-ID: <CALCETrW3+mzHaCUcWC1YUSwiuHkDWo=S4xnavk0CMcBiZd17+Q@mail.gmail.com>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> TDX has three classes of CPUID leaves: some CPUID leaves
> are always handled by the CPU, others are handled by the TDX module,
> and some others are handled by the VMM. Since the VMM cannot directly
> intercept the instruction these are reflected with a #VE exception
> to the guest, which then converts it into a TDCALL to the VMM,
> or handled directly.
>
> The TDX module EAS has a full list of CPUID leaves which are handled
> natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by
> the #VE method. In practice this typically only applies to the
> hypervisor specific CPUIDs unknown to the native CPU.
>
> Therefore there is no risk of causing this in early CPUID code which
> runs before the #VE handler is set up because it will never access
> those exotic CPUID leaves.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/kernel/tdx.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 5d961263601e..e98058c048b5 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -172,6 +172,35 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
>         return ret || r10 ? -EIO : 0;
>  }
>
> +static void tdx_handle_cpuid(struct pt_regs *regs)
> +{
> +       register long r10 asm("r10") = TDVMCALL_STANDARD;
> +       register long r11 asm("r11") = EXIT_REASON_CPUID;
> +       register long r12 asm("r12") = regs->ax;
> +       register long r13 asm("r13") = regs->cx;
> +       register long r14 asm("r14");
> +       register long r15 asm("r15");
> +       register long rcx asm("rcx");
> +       long ret;
> +
> +       /* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
> +       rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
> +
> +       asm volatile(TDCALL
> +                       : "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
> +                         "=r"(r14), "=r"(r15)
> +                       : "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
> +                         "r"(r13)
> +                       : );

Some "+" constraints would make this simpler.  But I think you should
factor the TDCALL helper out into its own function.
