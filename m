Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E739CB21
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFEVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 17:11:22 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36586 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 17:11:20 -0400
Received: by mail-pj1-f49.google.com with SMTP id d5-20020a17090ab305b02901675357c371so9129373pjr.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dudXczIM0n5b9xhwHuG4Xckp/1A176e1zSr4y54qLag=;
        b=nKul2Nk9v2TEuU8KlSQeZBrSZ+1QNz3EbEVGJ8DkBuIaF+1qEuAGI39Oq5CraD9j1P
         f3jOTyNjSHo8v2wQK7uPloBsshROxETCYWb6e8/M0WItaVcaa56rXzg+ldvRlgSTLfB3
         /10hcZWkT0IQKqSd7ePp20aSIfLF/nRpGdK6ncbVUbrorYHOrk30LaBlbMjJ+FxcHkCH
         FfXLIWXWUtUYYGW2i6iESTEKO/bZpugEyId1cbc7VHF9UNufdfol4BT8uil3SJp8BLb1
         GQSmq3/+inEN/p+9noq/stXPphv8au2Yqw/NEpdNGYalRcr6JvYfo0zyXoOH0Ay9VJV0
         ic9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dudXczIM0n5b9xhwHuG4Xckp/1A176e1zSr4y54qLag=;
        b=GFkBYd/zu4sD5fJFXhrQuSkqHY0zakvOp30VvFi4UGnqkK/t3rPvZZZfT87ylZ5mni
         zI/N268ySF85cEZG6kby8D+SF4QXC36/kn64Zqc5gnllup6aqOUyza86NRvGbcOSNkN1
         mu/2+rfm02/t/pWUFE90x91y/8sN77VXxrMjLYcSRFTon43OPReUcVzsxqy2Icugg+QV
         WvFbemTs2BQDaTBQq8k5j0azfZPF7ttR4+S2WSGWgCtCGa5i3RmWmGwxpbbgbxjEXyMj
         96yZSrI2p0K51ll1xbBhpGJV7PqJ9bDMmlJFTOrq4W40tevjHNgolDElvj/ECtoKrb1d
         XJ2Q==
X-Gm-Message-State: AOAM531LbyXs2Q3ER5IBQTC5OqSxIvijBYjZqgfEEccDiwKMr1ck5E3f
        J8fkHYx/cUJTib4wP4e5XYxhdomJu8+9biSmkfMBG8BfJJg=
X-Google-Smtp-Source: ABdhPJxhz3r5YIRQmhaAiCVIaMy14vAVoI/p73ZTFxbeJchFfiVM9ZUDngEnNw3lYtlOmjlIollvu74TiStDMEDOHM0=
X-Received: by 2002:a17:902:820a:b029:10c:a12b:e524 with SMTP id
 x10-20020a170902820ab029010ca12be524mr10336721pln.79.1622927312131; Sat, 05
 Jun 2021 14:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com> <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
In-Reply-To: <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Jun 2021 14:08:21 -0700
Message-ID: <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
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

On Sat, Jun 5, 2021 at 1:08 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 6/5/21 11:52 AM, Dan Williams wrote:
> > On Wed, May 26, 2021 at 9:24 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >>
> >> TDX hypervisors cannot emulate instructions directly. This
> >> includes port IO which is normally emulated in the hypervisor.
> >> All port IO instructions inside TDX trigger the #VE exception
> >> in the guest and would be normally emulated there.
> >>
> >> For the really early code in the decompressor, #VE cannot be
> >> used because the IDT needed for handling the exception is not
> >> set-up, and some other infrastructure needed by the handler
> >> is missing. So to support port IO in decompressor code, add
> >> support for paravirt based I/O port virtualization.
> >>
> >> Also string I/O is not supported in TDX guest. So, unroll the
> >> string I/O operation into a loop operating on one element at
> >> a time. This method is similar to AMD SEV, so just extend the
> >> support for TDX guest platform.
> >
> > Given early port IO is broken out in its own previous I think it makes
> > sense to break out the decompressor port IO enabling from final
> > runtime port IO support.
>
> Patch titled "x86/tdx: Handle early IO operations" mainly adds
> IO #VE support in early exception handler. Decompression code IO
> support does not have dependency on it. You still think it is
> better to move it that patch?
>

No, I was suggesting three patches instead of 2:

early
decompressor
final-runtime

> >
> > The argument in the previous patch about using #VE emulation in the
> > early code was collisions with trace and printk support in the "fully
> > featured" #VE handler later in the series. My interpretation of that
> > collision was due to the possibility of the #VE handler going into
> > infinite recursion if a printk in the handler triggered port IO. It
>
> No. AFAIK, It has nothing to do with infinite recursion. We are just
> highlighting the fact that when kernel uses early exception handler
> support, we cannot use code path that enables tracing support. So we
> use simplest way to trigger IO hypercalls.

Ok, then how does this approach handle printk from the #VE handler if
printk issues port IO?

>
> if (early #VE exception path)
>      handle_io_ve()
>          __tdx_hypercall
>
> if (normal #VE path)
>      handle_io_ve()
>          __tdx_hypercall (current version)
>         // Later on when adding tracing support, we will replace it
>         // with trace hypercalls.
>         __trace_tdx_hypercall
>
> As you can see in above design flow, later on when adding tracing
> support we will have split the early #IO handling code from
> normal IO handling code. So instead of using common code now and
> refactor it later on, we just use different code path for both
> of them.

Could you put that in the changelog, it was non-obvious to me.

> > seems I do not have the right picture of the constraints. Given the
> > runtime kernel can direct replace in/out macros I would expect a
> > statement of the tradeoff with #VE emulation and why the post
> > decompressor code is still using emulation.
>
> Currently decompression code cannot use #VE based IO emulation. It does
> not know how to handle #VE exceptions. Also, It is much easier to replace
> IO calls with TDX hypercalls in decompression code when compared with
> teaching how to handle #VE exceptions in decompression code.

Ok, but that does not answer the background behind the decision to use
emulation rather than direct replacement of port IO instructions in
the final kernel runtime image.

This patch mixes those 2 concerns and I think it deserves to be broken
out and explained.

>
> >
> >>
> >> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >> ---
> >>   arch/x86/boot/compressed/Makefile |  1 +
> >>   arch/x86/boot/compressed/tdcall.S |  3 ++
> >>   arch/x86/boot/compressed/tdx.c    | 28 ++++++++++++++++++
> >>   arch/x86/include/asm/io.h         |  7 +++--
> >>   arch/x86/include/asm/tdx.h        | 47 ++++++++++++++++++++++++++++++-
> >>   arch/x86/kernel/tdx.c             | 39 +++++++++++++++++++++++++
> >>   6 files changed, 122 insertions(+), 3 deletions(-)
> >>   create mode 100644 arch/x86/boot/compressed/tdcall.S
> >>
> >> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >> index a2554621cefe..a944a2038797 100644
> >> --- a/arch/x86/boot/compressed/Makefile
> >> +++ b/arch/x86/boot/compressed/Makefile
> >> @@ -97,6 +97,7 @@ endif
> >>
>
> >>   static int __ro_after_init tdx_guest = -1;
> >>
> >> @@ -30,3 +32,29 @@ bool is_tdx_guest(void)
> >>          return !!tdx_guest;
> >>   }
> >>
> >> +/*
> >> + * Helper function used for making hypercall for "out"
> >> + * instruction. It will be called from __out IO
> >> + * macro (in tdx.h).
> >> + */
> >> +void tdg_out(int size, int port, unsigned int value)
> >> +{
> >> +       __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 1,
> >> +                       port, value, NULL);
> >> +}
> >> +
> >> +/*
> >> + * Helper function used for making hypercall for "in"
> >> + * instruction. It will be called from __in IO macro
> >> + * (in tdx.h). If IO is failed, it will return all 1s.
> >> + */
> >> +unsigned int tdg_in(int size, int port)
> >> +{
> >> +       struct tdx_hypercall_output out = {0};
> >> +       int err;
> >> +
> >> +       err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
> >> +                             port, 0, &out);
> >> +
> >> +       return err ? UINT_MAX : out.r11;
> >> +}
> >
> > The previous patch open coded tdg_{in,out} and this one provides
> > helpers. I think at a minimum they should be consistent and pick one
> > style.
>
> As I have mentioned above, early IO #VE handler is a special case. we
> don't want to complicate its code path with debug or tracing support.
> So it is not a good comparison target.

This patch and the last do the same thing in 2 different ways. One of
them should match the other even if the helpers are not directly
reused.

> In this case, the reason for adding helper function is to make it easier
> for calling it from tdx.h.
> >
> >> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> >> index ef7a686a55a9..daa75c8eef5d 100644
> >> --- a/arch/x86/include/asm/io.h
> >> +++ b/arch/x86/include/asm/io.h
> >> @@ -40,6 +40,7 @@
> >>
>
> snip
>
> >> +
> >> +/* Helper function for converting {b,w,l} to byte size */
> >> +static inline int tdx_get_iosize(char *str)
> >> +{
> >> +       if (str[0] == 'w')
> >> +               return 2;
> >> +       else if (str[0] == 'l')
> >> +               return 4;
> >> +
> >> +       return 1;
> >> +}
> >
> > This seems like an unnecessary novelty. The BUILDIO() macro in
> > arch/x86/include/asm/io.h takes a type argument, why can't the size be
> > explicitly specified rather than inferred from string parsing?
>
> I don't want to make changes to generic macros in io.h if it can be
> avoided. It follows similar argument/type in all arch/* code. Also, it
> is easier to handle TDX as a special case here.
>

What changes are you talking about to the generic macros? The BUILDIO
macro passes in a size parameter explicitly rather than inferring the
size from the string name of an argument. BUILDIO does not need to
change, it's backend just needs to do the right thing in the TDX case.

Otherwise, "I don't want to" is not a sufficient justification for
avoiding needlessly new design patterns.
