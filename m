Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B432F0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCERHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhCERH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:27 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBEE46508B;
        Fri,  5 Mar 2021 17:07:26 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lIDvA-00HXB9-HO; Fri, 05 Mar 2021 17:07:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Mar 2021 17:07:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: arm64: Disable LTO in hyp
In-Reply-To: <CABCJKud2eSr8ZfPxwa3XVTaJvAfYgydsWUu-AKo2gtNStQshFQ@mail.gmail.com>
References: <20210304184544.2014171-1-samitolvanen@google.com>
 <87k0qmzq5u.wl-maz@kernel.org>
 <CABCJKufmjMT8+hGEnL3aJM7-OSwhYSHiJA=i8e7dHSGDWXYtsg@mail.gmail.com>
 <878s72sgwt.wl-maz@kernel.org>
 <CABCJKud1EmXmmQj-YOUNCFhE3P1W6Uhqpwe1G0zcR5zw71ksJA@mail.gmail.com>
 <CABCJKudvzBggE7AZQERto5Wo_LoL0G2sNee7_1R7h2TnGhjq8A@mail.gmail.com>
 <87im65zvb9.wl-maz@kernel.org>
 <CAMj1kXEg2cwyJ4BnPq9nWKkG0rcBJhUZasTLThba4Fnt+3e9Vw@mail.gmail.com>
 <CABCJKud2eSr8ZfPxwa3XVTaJvAfYgydsWUu-AKo2gtNStQshFQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <fc8359f03d939e6aaa9b81e4c29138ba@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samitolvanen@google.com, ardb@kernel.org, maskray@google.com, ndesaulniers@google.com, james.morse@arm.com, nathan@kernel.org, keescook@chromium.org, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-05 16:55, Sami Tolvanen wrote:
> On Fri, Mar 5, 2021 at 6:22 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>> 
>> On Fri, 5 Mar 2021 at 12:38, Marc Zyngier <maz@kernel.org> wrote:
>> >
>> > On Fri, 05 Mar 2021 02:38:17 +0000,
>> > Sami Tolvanen <samitolvanen@google.com> wrote:
>> > >
>> > > On Thu, Mar 4, 2021 at 2:34 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>> > > >
>> > > > On Thu, Mar 4, 2021 at 2:17 PM Marc Zyngier <maz@kernel.org> wrote:
>> > > > >
>> > > > > On Thu, 04 Mar 2021 21:25:41 +0000,
>> > > > > Sami Tolvanen <samitolvanen@google.com> wrote:
>> >
>> > [...]
>> >
>> > > > > > I assume hyp_panic() ends up being placed too far from __guest_enter()
>> > > > > > when the kernel is large enough. Possibly something to do with LLVM
>> > > > > > always splitting functions into separate sections with LTO. I'm not
>> > > > > > sure why the linker cannot shuffle things around to make everyone
>> > > > > > happy in this case, but I confirmed that this patch also fixes the
>> > > > > > build issue for me:
>> > > > > >
>> > > > > > diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
>> > > > > > index af8e940d0f03..128197b7c794 100644
>> > > > > > --- a/arch/arm64/kvm/hyp/vhe/switch.c
>> > > > > > +++ b/arch/arm64/kvm/hyp/vhe/switch.c
>> > > > > > @@ -214,7 +214,7 @@ static void __hyp_call_panic(u64 spsr, u64 elr, u64 par)
>> > > > > >  }
>> > > > > >  NOKPROBE_SYMBOL(__hyp_call_panic);
>> > > > > >
>> > > > > > -void __noreturn hyp_panic(void)
>> > > > > > +void __noreturn hyp_panic(void) __section(".text")
>> > > > > >  {
>> > > > > >         u64 spsr = read_sysreg_el2(SYS_SPSR);
>> > > > > >         u64 elr = read_sysreg_el2(SYS_ELR);
>> > > > > >
>> > > > >
>> > > > > We're getting into black-magic territory here. Why wouldn't hyp_panic
>> > > > > be in the .text section already?
>> > > >
>> > > > It's not quite black magic. LLVM essentially flips on
>> > > > -ffunction-sections with LTO and therefore, hyp_panic() will be in
>> > > > .text.hyp_panic in vmlinux.o, while __guest_enter() will be in .text.
>> > > > Everything ends up in .text when we link vmlinux, of course.
>> > > >
>> > > > $ readelf --sections vmlinux.o | grep hyp_panic
>> > > >   [3936] .text.hyp_panic   PROGBITS         0000000000000000  004b56e4
>> > >
>> > > Note that disabling LTO here has essentially the same effect as using
>> > > __section(".text"). It stops the compiler from splitting these
>> > > functions into .text.* sections and makes it less likely that
>> > > hyp_panic() ends up too far away from __guest_enter().
>> > >
>> > > If neither of these workarounds sound appealing, I suppose we could
>> > > alternatively change hyp/entry.S to use adr_l for hyp_panic. Thoughts?
>> >
>> > That would be an actual fix instead of a workaround, as it would
>> > remove existing assumptions about the relative locations of the two
>> > objects. I guess you need to fix both instances with something such
>> > as:
>> >
>> > diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
>> > index b0afad7a99c6..a43e1f7ee354 100644
>> > --- a/arch/arm64/kvm/hyp/entry.S
>> > +++ b/arch/arm64/kvm/hyp/entry.S
>> > @@ -85,8 +85,10 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
>> >
>> >         // If the hyp context is loaded, go straight to hyp_panic
>> >         get_loaded_vcpu x0, x1
>> > -       cbz     x0, hyp_panic
>> > -
>> > +       cbnz    x0, 1f
>> > +       adr_l   x0, hyp_panic
>> > +       br      x0
>> > +1:
>> 
>> Agree with replacing the conditional branches that refer to external
>> symbols: the compiler never emits those, for the reason we are seeing
>> here, i.e., the range is simply insufficient.
>> 
>> But let's just use 'b hyp_panic' instead, no?
> 
> Alright, this seems to work for me:
> 
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index b0afad7a99c6..c62265951467 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -85,8 +85,10 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
> 
>         // If the hyp context is loaded, go straight to hyp_panic
>         get_loaded_vcpu x0, x1
> -       cbz     x0, hyp_panic
> +       cbnz    x0, 1f
> +       b       hyp_panic
> 
> +1:
>         // The hyp context is saved so make sure it is restored to 
> allow
>         // hyp_panic to run at hyp and, subsequently, panic to run in 
> the host.
>         // This makes use of __guest_exit to avoid duplication but sets 
> the
> @@ -94,7 +96,7 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
>         // current state is saved to the guest context but it will only 
> be
>         // accurate if the guest had been completely restored.
>         adr_this_cpu x0, kvm_hyp_ctxt, x1
> -       adr     x1, hyp_panic
> +       adr_l   x1, hyp_panic
>         str     x1, [x0, #CPU_XREG_OFFSET(30)]
> 
>         get_vcpu_ptr    x1, x0
> 
> But when I say work, I mean this fixes the allmodconfig build with
> LTO, and my kernel boots at EL2. I don't actually have a way to
> properly test KVM on arm64. If nobody sees obvious issues here, I can
> send a proper patch a bit later.

Please do, it is "obviously correct"! ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
