Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94BE32DFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCECib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:38:30 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:38:30 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id c44so258559uad.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QS2dc4BRJJgr8umUp9EpdfHdtGHxUWTC0395zWXgRQ0=;
        b=LSH6iwuk+SlxyAgzUKOCThatNBJjTF63wj9pl7/rv3WvWASJdjJ5g08bUmf4+LU4nr
         hUsYKepzYVnbq2ahvA2yinYFF1yOI+u7nlH+XozKJBVt/hGCDT0EI6B51/JnJ4hrDbXI
         lcFb/vEF3ijhC35zMtJnWQNY1R0xMoIaRGfErQzQSiAN3iNmMjUjLN14hzICPK81xQCI
         Pb9/lKaEvaWgRm3xCbQqMpivxmjtVOCDebEA+INWDAkDqUPrMMxty/lQQDEK2+Db3xdC
         CwiHANsN8spPAlFQkX7yqbhlTWfSY1RcjoyC/niyBpki7rRNL3tK4aZU20flB8KcWp5R
         C83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QS2dc4BRJJgr8umUp9EpdfHdtGHxUWTC0395zWXgRQ0=;
        b=OND6Tmm8zkoxZoFvy4vpgUzGxZNS2m4xLpP6aqqZdu3QTykfmtv+FyCeSo0Cs5WUZC
         n6bQj9Xihm3AG468RVVMV6ztuv4oiXHprisTh57XzjqQl38Hd3r6KD+Hcek+kNgBJvTj
         GnDCp5+xrhVJMiMJwZ++cLxZuhAVZ2bz/wQ/hKi4Bxj8TVKQpCR6U+ZSHRW1XCmuIYNT
         kJwv3GhMvKs4F6y7Gt0igYxEiMRZ+TsihjdLnIR0v3m484pLYJOSPo/FjRZoNpYn1+WZ
         PsgeFPxa88WLWzD92XNpi9P2YpkqbyJbiGEs/Hoo5ixJMK0w03q3It/S8/4AO4QmvRAn
         cKUw==
X-Gm-Message-State: AOAM533x/1XyVsq3ahQWuScl1PewuFK/W2qEAsiep7jPkYp/NIyV7oyO
        YyeSfucEKESIdPFGtbu26DJe802Em46aAys/VViiQw==
X-Google-Smtp-Source: ABdhPJxMZd/afyVrbW4edXEQyCei1a86gfA8o3+MYDlHubXJYjQzSdCnAYOppQlxL7/Vjn59qH+xxqJciQKFnen8Po0=
X-Received: by 2002:a9f:374d:: with SMTP id a13mr4660885uae.122.1614911909135;
 Thu, 04 Mar 2021 18:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20210304184544.2014171-1-samitolvanen@google.com>
 <87k0qmzq5u.wl-maz@kernel.org> <CABCJKufmjMT8+hGEnL3aJM7-OSwhYSHiJA=i8e7dHSGDWXYtsg@mail.gmail.com>
 <878s72sgwt.wl-maz@kernel.org> <CABCJKud1EmXmmQj-YOUNCFhE3P1W6Uhqpwe1G0zcR5zw71ksJA@mail.gmail.com>
In-Reply-To: <CABCJKud1EmXmmQj-YOUNCFhE3P1W6Uhqpwe1G0zcR5zw71ksJA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 4 Mar 2021 18:38:17 -0800
Message-ID: <CABCJKudvzBggE7AZQERto5Wo_LoL0G2sNee7_1R7h2TnGhjq8A@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Disable LTO in hyp
To:     Marc Zyngier <maz@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 2:34 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Thu, Mar 4, 2021 at 2:17 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 04 Mar 2021 21:25:41 +0000,
> > Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > On Thu, Mar 4, 2021 at 11:15 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Thu, 04 Mar 2021 18:45:44 +0000,
> > > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > > > >
> > > > > allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> > > > > linker errors:
> > > > >
> > > > >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
> > > >
> > > > I assume this message is only an oddity, right? Because
> > > > __guest_enter() is as far as you can imagine from irqbypass.c...
> > >
> > > I'm not sure what's up with the filename in the error message. Fangrui
> > > or Nick probably have a better idea.
> > >
> > > > >   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
> > > > >   [-1048576, 1048575]; references hyp_panic
> > > > >   >>> defined in vmlinux.o
> > > > >
> > > > >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
> > > > >   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
> > > > >   [-1048576, 1048575]; references hyp_panic
> > > > >   >>> defined in vmlinux.o
> > > > >
> > > > > As LTO is not really necessary for the hypervisor code, disable it for
> > > > > the hyp directory to fix the build.
> > > >
> > > > Can you shed some light on what the problem is exactly?
> > >
> > > I assume hyp_panic() ends up being placed too far from __guest_enter()
> > > when the kernel is large enough. Possibly something to do with LLVM
> > > always splitting functions into separate sections with LTO. I'm not
> > > sure why the linker cannot shuffle things around to make everyone
> > > happy in this case, but I confirmed that this patch also fixes the
> > > build issue for me:
> > >
> > > diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> > > index af8e940d0f03..128197b7c794 100644
> > > --- a/arch/arm64/kvm/hyp/vhe/switch.c
> > > +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> > > @@ -214,7 +214,7 @@ static void __hyp_call_panic(u64 spsr, u64 elr, u64 par)
> > >  }
> > >  NOKPROBE_SYMBOL(__hyp_call_panic);
> > >
> > > -void __noreturn hyp_panic(void)
> > > +void __noreturn hyp_panic(void) __section(".text")
> > >  {
> > >         u64 spsr = read_sysreg_el2(SYS_SPSR);
> > >         u64 elr = read_sysreg_el2(SYS_ELR);
> > >
> >
> > We're getting into black-magic territory here. Why wouldn't hyp_panic
> > be in the .text section already?
>
> It's not quite black magic. LLVM essentially flips on
> -ffunction-sections with LTO and therefore, hyp_panic() will be in
> .text.hyp_panic in vmlinux.o, while __guest_enter() will be in .text.
> Everything ends up in .text when we link vmlinux, of course.
>
> $ readelf --sections vmlinux.o | grep hyp_panic
>   [3936] .text.hyp_panic   PROGBITS         0000000000000000  004b56e4

Note that disabling LTO here has essentially the same effect as using
__section(".text"). It stops the compiler from splitting these
functions into .text.* sections and makes it less likely that
hyp_panic() ends up too far away from __guest_enter().

If neither of these workarounds sound appealing, I suppose we could
alternatively change hyp/entry.S to use adr_l for hyp_panic. Thoughts?

Sami
