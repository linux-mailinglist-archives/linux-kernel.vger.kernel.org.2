Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE33D9D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhG2Fg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhG2Fg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:36:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:36:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n21so2882268wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpDxw18ZLgwbipCgFlvxBIciXYiO7op8Q9ue2Xjmcbs=;
        b=o5LPvTsq0l4OsscTvgnH9/wsTpbspVXBABAj+Su9kHFVq/CL44Jmz6o0g5ft97e04J
         D7Jx2Eax8EVYIKEy4x+ZkpC4U4hKhy9asV4BQ1keSuYEH5Lodxh5YYIzyhk+z6xjrOH4
         QSTFm07Z6vkDPCRLj7xlYUq5zvbgjHs9Y8xxp4KCj0iWpLM6DiLpt4eRULG1fCYQaTl5
         bUefvaDOTu8ShXl7Z3PiIqcN1FLE3EJHS/ilt5gjhuk1V+HRoBT4CeXBibinqQ41u2Vs
         rAaoiTovSa2bfo7nr43JTrvIPjQC7//hm3OeTOxpsL0yzufJvnpy7XDx2kxKN7zcMp1Y
         0MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpDxw18ZLgwbipCgFlvxBIciXYiO7op8Q9ue2Xjmcbs=;
        b=orw+GUv6FRsP/P4FoCUwbCyLhYrarjEEurguc9xuD3TtbbqmHuEGOl7B2bKAqH6EoI
         OSzxHXo8mCF/gpLX9y4iyPGn3HK3r6lbEwbPjyuE459ey8szLR9h4Ge3wF8TvaDheRBe
         KdMB8t6x3p3oQbippUguomnBzFmRQmrVDZbRwiLKh1whLzNiKnKw8q99fvbuWEmrFGtj
         VoWC5PI1Mfa/H5H9+9mZZClKHaw7BQFtvSCv7m9uNQT5lGuutdIz+t2T7mOY/HVqL8VY
         LwO4hkJIdG2HM0d8M2Sq9pR1IFYI9T5WOOytLpOBxMQGw9FQMnNcWem9xxDFPfum9ozY
         ok4w==
X-Gm-Message-State: AOAM5321DrPZCs4/HaE9zi6dOBq2KGclVemi06GeK41PpQfeio8lsz1M
        D8w1vJwVubzUYnbmCZsgRa1PjuqlcGS9V3Lql5vR9w==
X-Google-Smtp-Source: ABdhPJzOvSnOGPnXDXFEka6cyWxMLn749krCndUWIJPgiasluAR2vVfZSUTqyg1/vHq3tJ1n0K1u11AP1Zg7H9Mq2Zg=
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr12740398wmd.152.1627536982888;
 Wed, 28 Jul 2021 22:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy1rA9e2iCJWeVEQwKTRfTZZaRZVcMe1o8wMnFiWOOGW3w@mail.gmail.com>
 <mhng-7fd3d454-cd80-4ede-baed-08003d66b3a4@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7fd3d454-cd80-4ede-baed-08003d66b3a4@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Jul 2021 11:06:11 +0530
Message-ID: <CAAhSdy0T0_Gfa1eFA=rwQ+6NGT99FTo7wo3gcBQWkdj8OEvMWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Linux RISC-V ACLINT Support
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:00 AM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> On Mon, 26 Jul 2021 06:01:01 PDT (-0700), anup@brainfault.org wrote:
> > Hi Marc,
> >
> > On Mon, Jul 26, 2021 at 8:02 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Mon, 26 Jul 2021 13:45:20 +0100,
> >> Anup Patel <anup@brainfault.org> wrote:
> >> >
> >> > Hi Marc,
> >> >
> >> > I have taken the approach of IPI domains (like you suggested) in this series.
> >> >
> >> > What do you think ?
> >>
> >> I have commented on the irqchip driver.
> >>
> >> As for the RISC-V specific code, I'll let the architecture maintainers
> >> look into it. I guess the elephant in the room is that this spec seems
> >> to be evolving, and that there is no HW implementation (how this
> >> driver maps on SF's CLINT is anybody's guess).
>
> There's a long history of interrupt controller efforts from the RISC-V
> foundation, and we've yet to have any of them result in hardware.
>
> > The SiFive CLINT is a more convoluted device and provides M-level
> > timer functionality and M-level IPI functionality in one MMIO device.
> >
> > The RISC-V ACLINT specification is more modular and backward
> > compatible with the SiFive CLINT. In fact, a SiFive CLINT device
> > can be viewed as a ACLINT MSWI device + ACLINT MTIMER device.
> > This means existing RISC-V boards having SiFive CLINT will be
> > automatically compliant to the RISC-V ACLINT specification.
>
> So is there any hardware that this new specification enables?  It seems
> to be a more convoluted way to describe the same mess we're already in.
> I'm not really inclined to take a bunch of code that just does the same
> thing via a more complicated specification.
>
> > Here's the RISC-V ACLINT spec:
> > https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> >
> > The RISC-V ACLINT spec is quite stable and we are not seeing any
> > further changes hence I sent out RFC PATCHes to get feedback. The
> > RISC-V ACLINT spec will be frozen before 2021 end (i.e. before next
> > RISC-V summit).
>
> Have you talked to the other ISA folks about that?
>
> As far as I can tell this new spec allows for multiple MTIME registers,
> which seems to be in direct contradiction to the single -MTIME register

The RISC-V ISA spec only mandates a single view of MTIME registers
for all the HARTs

The RISC-V ISA spec does not mandate a single physical MTIME register.

In fact, multi-socket and multi-die systems will end-up having multiple
physical MTIME registers so on such systems these physical MTIME
registers need to be synchronized with hardware assistance. Please
refer to the MTIME synchronization section of ACLINT specification.

> as defined in the ISA manual.  It also seems to be vaguely incompatible
> WRT the definition of SSIP, but I'm not sure that one really matters all
> that much as it's not like old software can write the new registers.

Please loot at the ACLINT SSWI spec again. The SSIP bit definition
is to be modified where mip.SSIP bit is logical OR of software writable
bit and external SSIP signal. This way older software which uses
SBI call based IPI injection will work fine. In fact, this aspect of SSIP
bit is tested on QEMU RISC-V as well.

>
> I just talked to Krste and Andrew, they say they haven't heard of any of
> this.  I don't know what's going on over there, but it's very hard to
> review anything when I can't even tell where the ISA is defined.

Like mentioned in other thread, please first to talk to the actual
spec owners first. There are lot of working groups and activities
going on in RVI.

Regards,
Anup

>
> > The Linux NoMMU kernel (M-level) will use an ACLINT MSWI device
> > for IPI support whereas the regular Linux MMU kernel (S-level) will
> > use an ACLINT SSWI device for IPI support.
> >
> > The ACLINT SWI driver is a common IPI driver for both ACLINT
> > MSWI (Linux NoMMU) and ACLINT SSWI (Linux MMU). In fact,
> > the ACLINT SWI also works for IPI part (i.e. MSWI) of SiFive CLINT.
> >
> > Regards,
> > Anup
> >
> >>
> >>         M.
> >>
> >> --
> >> Without deviation from the norm, progress is not possible.
