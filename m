Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9A32DD1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCDWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhCDWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:34:30 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EEBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 14:34:30 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id l17so74194vkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rajd7yQJWJDe7aYct9nFV0g6FXEt/vXGJuGQS9x6yXw=;
        b=oUka736fvVmqzp5RZlMPVQlOWSDNz4htaYj7uuL247K09QoorKATvBeitoXWE8gl+X
         r94pJWxWaxqv79liStuj+r+wOq9fKTa2NVLKprtxD75cZnVmt9BEMnKCn4Xd9zs4UWJ6
         CQ6jtxH67C/5rnyDzukP5k1FYOYfssSHIFSyNA7WdjiO/frwnnkVeZoO7o+Gc9I57FTo
         u/S0ZsgZwgdx5YNwzOLc4j3eZMAZpI2wZLGK5WsqjQgS6eiEvoJewqz2ADLgJI4oWCKz
         gj3GrX4nrKqtReA0fKuEEoPzn+FxbRqEKhIr5E0rCzeUqMUCAyfLv51punQn6wxGiPA0
         JyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rajd7yQJWJDe7aYct9nFV0g6FXEt/vXGJuGQS9x6yXw=;
        b=OkC/8Q98RfwPEVsrf8FtqL8aWUBeWJql7hxmnTXLGAvrBrRYxLcqjgEK+hgzRCapRL
         2VNtY+IkJEg8zSXyYeeOEA31rklV7pqpOIssdWfbm8XJzK6YqMsUAhIZWrPBEhSrl04e
         OHZPOrjaAqwFnJCLX5fs0J80B1+2hbROyIXvWzgSY58jADUefjBZEsEzHGytGHRTv4H7
         apftC35A5i6fjGHOvRlVluN74DIMFACbFzIZ3cTQDaASguJ9fWFUIVY7D2CnMSTm3GbD
         i3ezOXQ65O4eKBkpE07Z9d2wxzlVWS94sETUQtXon3rwMmHvXZFxABIAjacjiob0mKHb
         YoZg==
X-Gm-Message-State: AOAM532kdjU0su/y7IskYBYCpoS5F66lD65BM2JrnAhkOZY9mIRy9yIS
        9pX6l/DI7aBUvpUZq1DHIb/1xuq5nLIKOtOc7rqBRw==
X-Google-Smtp-Source: ABdhPJw9hVzk/M0ZP7TpOX5Yz4NgqYdBHM97WKO8NA9JuMXAIsUjqPbiWDl2C+auPNVj7KxAWJlH8sBOEJlhhiJycZs=
X-Received: by 2002:a1f:99c2:: with SMTP id b185mr4516009vke.3.1614897269361;
 Thu, 04 Mar 2021 14:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210304184544.2014171-1-samitolvanen@google.com>
 <87k0qmzq5u.wl-maz@kernel.org> <CABCJKufmjMT8+hGEnL3aJM7-OSwhYSHiJA=i8e7dHSGDWXYtsg@mail.gmail.com>
 <878s72sgwt.wl-maz@kernel.org>
In-Reply-To: <878s72sgwt.wl-maz@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 4 Mar 2021 14:34:18 -0800
Message-ID: <CABCJKud1EmXmmQj-YOUNCFhE3P1W6Uhqpwe1G0zcR5zw71ksJA@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 2:17 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 04 Mar 2021 21:25:41 +0000,
> Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Thu, Mar 4, 2021 at 11:15 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 04 Mar 2021 18:45:44 +0000,
> > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> > > > linker errors:
> > > >
> > > >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
> > >
> > > I assume this message is only an oddity, right? Because
> > > __guest_enter() is as far as you can imagine from irqbypass.c...
> >
> > I'm not sure what's up with the filename in the error message. Fangrui
> > or Nick probably have a better idea.
> >
> > > >   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
> > > >   [-1048576, 1048575]; references hyp_panic
> > > >   >>> defined in vmlinux.o
> > > >
> > > >   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
> > > >   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
> > > >   [-1048576, 1048575]; references hyp_panic
> > > >   >>> defined in vmlinux.o
> > > >
> > > > As LTO is not really necessary for the hypervisor code, disable it for
> > > > the hyp directory to fix the build.
> > >
> > > Can you shed some light on what the problem is exactly?
> >
> > I assume hyp_panic() ends up being placed too far from __guest_enter()
> > when the kernel is large enough. Possibly something to do with LLVM
> > always splitting functions into separate sections with LTO. I'm not
> > sure why the linker cannot shuffle things around to make everyone
> > happy in this case, but I confirmed that this patch also fixes the
> > build issue for me:
> >
> > diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> > index af8e940d0f03..128197b7c794 100644
> > --- a/arch/arm64/kvm/hyp/vhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> > @@ -214,7 +214,7 @@ static void __hyp_call_panic(u64 spsr, u64 elr, u64 par)
> >  }
> >  NOKPROBE_SYMBOL(__hyp_call_panic);
> >
> > -void __noreturn hyp_panic(void)
> > +void __noreturn hyp_panic(void) __section(".text")
> >  {
> >         u64 spsr = read_sysreg_el2(SYS_SPSR);
> >         u64 elr = read_sysreg_el2(SYS_ELR);
> >
>
> We're getting into black-magic territory here. Why wouldn't hyp_panic
> be in the .text section already?

It's not quite black magic. LLVM essentially flips on
-ffunction-sections with LTO and therefore, hyp_panic() will be in
.text.hyp_panic in vmlinux.o, while __guest_enter() will be in .text.
Everything ends up in .text when we link vmlinux, of course.

$ readelf --sections vmlinux.o | grep hyp_panic
  [3936] .text.hyp_panic   PROGBITS         0000000000000000  004b56e4

Sami
