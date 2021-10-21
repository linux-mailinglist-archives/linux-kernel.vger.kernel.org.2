Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BA435D49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhJUIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJUItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:49:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D4C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:47:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so2259486wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=paZl2g6HHY69VKf6Y8X+ghPjPvGR1ETeK09s2XBFvzg=;
        b=AciGL0quv1VLtQW8hKxFL4HSl9/34w7CeQuR12Hl+p34yqNCMk9z84Cib3F9Q5c0xW
         sg9QrDE1X+4YdwHQqqNTlVITcKZ4BB3y2q2KvkHdYbcIBIJg+BLniONjI4JhKzhMzDwj
         XWT1bpjrr0fdmoyXtlwuCTYCmNpgw9HJcdiZDxJt26jTTtKl2AP7/daU9pu1uOXJ7+AU
         NpfSyWY9OmMBiEavA3XKZoUmp8UnpazdrWMrF6B5cW+xSC3bIuYZVuiO8OtrHZg+fgnM
         V8f4Fygp9ncNaa/oeZaFeNjjS/Nay3kBDMUSsT2u1XVXxP3t/kfO/GS7SWarZVrhzFIg
         TF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=paZl2g6HHY69VKf6Y8X+ghPjPvGR1ETeK09s2XBFvzg=;
        b=8J7azOjGD3lajQdueaa2Vth77aV2sE50F/tArQ48G6XJhy+oY0IXHtfUvQT7tKnNH6
         12z49QyfjnE7uqJVykpuuIpHfFbI2AgzWNS06BId3zyM3ENql/xxT6U4TAdseL0K4oe8
         IRX0BEdj3/sjrNxO6374e4x5GIu0/q//s/tjsESnV44rECf0PUnFoRUfP2OaKKrycFzm
         EfGscKZZkGLfOcO/a4bwls9G1GdLbFibzWy8mZ4DiwtfE85ZeF/pmzDNSpRWMcK/mCVW
         BZY09rdHaWSTihBP9zH//XXyOhsNzZwThzo8RgYw8d/yd83zrtJADfR2o4G51e9JYjeu
         nknA==
X-Gm-Message-State: AOAM533ytu4BOIH4fjWJhXVdwI4yL2p3cq/+1L7w9gVCacl7pZIgZu/l
        5RTmQa4vP0tilS1iAKT397Jc/tFvpwFfflBgPsiYnw==
X-Google-Smtp-Source: ABdhPJyWK2AbuighiygWHPrsWyJw2Y9IobM9qXRytPdIIPHY4IxfMYmXnY9s2QCAxyVM0AeaP1ZHum6tGnKdWRnMxHk=
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr19602240wmi.59.1634806037719;
 Thu, 21 Oct 2021 01:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-2-guoren@kernel.org> <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
 <f850af365f2ac77af79ec59f92e6434a@kernel.org> <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org> <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
 <YXAu7OS82G1k28bZ@bruce.bluespec.com> <CAAhSdy1FS+rTO8JWfqKVMLPBUOzmy0d5D1s=psfxbm4s6QrBCA@mail.gmail.com>
 <YXBZlrz2ythccKp0@bruce.bluespec.com>
In-Reply-To: <YXBZlrz2ythccKp0@bruce.bluespec.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 21 Oct 2021 14:17:05 +0530
Message-ID: <CAAhSdy29uw75n1nCJB9Zxs667Nx-Er3EFeGTja2SGuU1S7s57A@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:32 PM Darius Rad <darius@bluespec.com> wrote:
>
> On Wed, Oct 20, 2021 at 09:48:36PM +0530, Anup Patel wrote:
> > On Wed, Oct 20, 2021 at 8:29 PM Darius Rad <darius@bluespec.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 10:19:06PM +0800, Guo Ren wrote:
> > > > On Wed, Oct 20, 2021 at 9:34 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 19 Oct 2021 14:27:02 +0100,
> > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > > > >
> > > > > > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > > > > > in a separate bit, then you need to track this by yourself in the
> > > > > > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > > > > > breaks
> > > > > > > > > the HW interrupt state or not.
> > > > > > > > The problem is when enable bit is 0 for that irq_number,
> > > > > > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > > > > > the hw state machine. Then this irq would enter in ack state and no
> > > > > > > > continues irqs could come in.
> > > > > > >
> > > > > > > Really? This means that you cannot mask an interrupt while it is being
> > > > > > > handled? How great...
> > > > > > If the completion ID does not match an interrupt source that is
> > > > > > currently enabled for the target, the completion is silently ignored.
> > > > > > So, C9xx completion depends on enable-bit.
> > > > >
> > > > > Is that what the PLIC spec says? Or what your implementation does? I
> > > > > can understand that one implementation would be broken, but if the
> > > > > PLIC architecture itself is broken, that's far more concerning.
> > > >
> > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > >
> > > > The PLIC signals it has completed executing an interrupt handler by
> > > > writing the interrupt ID it received from the claim to the claim/complete
> > > > register. The PLIC does not check whether the completion ID is the same
> > > > as the last claim ID for that target. If the completion ID does not match
> > > > an interrupt source that is currently enabled for the target, the
> > > >                                       ^^ ^^^^^^^^^ ^^^^^^^
> > > > completion is silently ignored.
> > > >
> > > > [1] https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
> > > >
> > > > Did we misunderstand the PLIC spec?
> > > >
> > >
> > > That clause sounds to me like it is due to the SiFive implementation, which
> > > the RISC-V PLIC specification is based on.  Since the PLIC spec is still a
> > > draft I would expect it to change before release.
> >
> > The SiFive PLIC has been adopted by various RISC-V platforms (including
> > SiFive themselves). Almost all existing RISC-V boards have PLIC as the
> > interrupt controller.
> >
> > Considering the wide usage of PLIC across existing platforms, the RISC-V
> > International has adopted it as an official RISC-V non-ISA spec. ...
>
> You mean is in the process of adopting it, right?

Yes, it in the process.

>
> > ... Of course,
> > the RISC-V PLIC spec needs to follow the process for RISC-V non-ISA spec
> > but changing the RISC-V PLIC spec now would mean all existing RISC-V
> > platforms will become non-compliant.
> >
>
> I would expect the review process to produce a proper specification, rather
> than a verbatim copy of the SiFive datasheet, and clarify some ambgiuous
> and implementation specific language.  Clarifying the specification does
> not necessarily make all existing implementations non-compliant, as this
> has been done numerous times with other RISC-V specifications.

Yes, clarification can be definitely done.

Regards,
Anup

>
> > The RISC-V AIA spec is intended to replace the RISC-V PLIC spec as the
> > new interrupt controller spec for future RISC-V platforms.
> >
> > Regards,
> > Anup
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
