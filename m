Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19AA435001
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJTQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJTQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:21:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:18:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso11492007wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RpDaphKaULN4/89C8L4bD1DcIqBybhRsQBUxIBBeNZg=;
        b=kUprcAR2htHrBKfjlDZ75+0TfgTGJ7mUB2W2QoT1ebBXuZD6CgaBOHQ0sskcNqyspB
         Ce+zCkoQFhHtOwwsxQ/jWh91yCUs2nHQfdFUsX54h+heArdNsQ1Wi1ldGyoC3/L0IHpb
         /GwAowqyK7TbukDad86HgttnmD+4wS91cVvUsf9gplFAeUCzC0Yom30tl6QRAX6wGULq
         0O/SjmaEXWNmktVuNeSyXNmT5n4QuKYGlIgjY+F5Qqm7YJA0W1Z4xBwXdQjXdB7fSCRR
         ZdAl8702GCr07s39QjoOwUmNmHduGyLNBH7hD9GF4YzhvkS3imn038m5AeEXmW3ZWLeH
         b7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RpDaphKaULN4/89C8L4bD1DcIqBybhRsQBUxIBBeNZg=;
        b=0+dUBjQFsW5dpBNx7QS0DvQm8MX7I9T032I+GzgAeEWriF9RSAKHf4iNsEN8w3KieI
         E0tl+gie+LpVBorZjVkQHImMAfq7oQPCm9j+ly7a1YQT7CfmJcdVGhfFGyzKyUEmTn7v
         9LKFic6pgGl0tk1qONZ23J2D6cRBGrShJVlliexxY029cn6604j12vLV5F1Jf7CKgEJh
         RRAo/obEzWHy3USufdj3R2mo95O6PiRVYJH1YA19KkDgHlA7sg+K9PMDcFV7bI2cep8a
         mG0HpdH7mr3uM00brl5FzdKweWWR3GPqxp64uKGOupB6/O18kX2VTMJSGG0BO8Qn+xM5
         AVkw==
X-Gm-Message-State: AOAM530tgRxUqN7ddJe9CMPiHHnRs986nv4Y+98lrqve2BOLDa2CwrLd
        El01Ihd/UH07QzybUM20mBc2v+3gkK4JkPxKmtlcng==
X-Google-Smtp-Source: ABdhPJwLBRyQtWG7x7CWXuH1W3s6K3jBd6D+Z46Mv0MN16GIwgS2GF3/OsPoN2Fr1EXpMi48GJkBydY5lP97XUbFXC0=
X-Received: by 2002:a5d:5849:: with SMTP id i9mr167911wrf.331.1634746728173;
 Wed, 20 Oct 2021 09:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org> <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
 <YXAu7OS82G1k28bZ@bruce.bluespec.com>
In-Reply-To: <YXAu7OS82G1k28bZ@bruce.bluespec.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 20 Oct 2021 21:48:36 +0530
Message-ID: <CAAhSdy1FS+rTO8JWfqKVMLPBUOzmy0d5D1s=psfxbm4s6QrBCA@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Guo Ren <guoren@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
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

On Wed, Oct 20, 2021 at 8:29 PM Darius Rad <darius@bluespec.com> wrote:
>
> On Wed, Oct 20, 2021 at 10:19:06PM +0800, Guo Ren wrote:
> > On Wed, Oct 20, 2021 at 9:34 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 19 Oct 2021 14:27:02 +0100,
> > > Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > > > in a separate bit, then you need to track this by yourself in the
> > > > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > > > breaks
> > > > > > > the HW interrupt state or not.
> > > > > > The problem is when enable bit is 0 for that irq_number,
> > > > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > > > the hw state machine. Then this irq would enter in ack state and no
> > > > > > continues irqs could come in.
> > > > >
> > > > > Really? This means that you cannot mask an interrupt while it is being
> > > > > handled? How great...
> > > > If the completion ID does not match an interrupt source that is
> > > > currently enabled for the target, the completion is silently ignored.
> > > > So, C9xx completion depends on enable-bit.
> > >
> > > Is that what the PLIC spec says? Or what your implementation does? I
> > > can understand that one implementation would be broken, but if the
> > > PLIC architecture itself is broken, that's far more concerning.
> >
> > Here is the description of Interrupt Completion in PLIC spec [1]:
> >
> > The PLIC signals it has completed executing an interrupt handler by
> > writing the interrupt ID it received from the claim to the claim/complete
> > register. The PLIC does not check whether the completion ID is the same
> > as the last claim ID for that target. If the completion ID does not match
> > an interrupt source that is currently enabled for the target, the
> >                                       ^^ ^^^^^^^^^ ^^^^^^^
> > completion is silently ignored.
> >
> > [1] https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
> >
> > Did we misunderstand the PLIC spec?
> >
>
> That clause sounds to me like it is due to the SiFive implementation, which
> the RISC-V PLIC specification is based on.  Since the PLIC spec is still a
> draft I would expect it to change before release.

The SiFive PLIC has been adopted by various RISC-V platforms (including
SiFive themselves). Almost all existing RISC-V boards have PLIC as the
interrupt controller.

Considering the wide usage of PLIC across existing platforms, the RISC-V
International has adopted it as an official RISC-V non-ISA spec. Of course,
the RISC-V PLIC spec needs to follow the process for RISC-V non-ISA spec
but changing the RISC-V PLIC spec now would mean all existing RISC-V
platforms will become non-compliant.

The RISC-V AIA spec is intended to replace the RISC-V PLIC spec as the
new interrupt controller spec for future RISC-V platforms.

Regards,
Anup
