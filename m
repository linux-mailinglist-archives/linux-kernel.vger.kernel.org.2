Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC53D9CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhG2E4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhG2E4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:56:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C988EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:56:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c16so5133024wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgZ2ekjB2w4IATMge4zN6op9t2Z495TinwaLO8sLH0U=;
        b=cFFqioRADT538UWHbhbK/gKFUBiIb2E+GS9adDnd+Y5FNNDFj8UksFsBUAjkbdXtd6
         J/Q1lDxPGLM+Vg6I5wjdZwA5dcL8B5hNASh4M9zm0cWY/2ZVnctawbtYTlJxDgxADE9u
         qrvw/n7Y9VFbYLrL0gCliCt8Li/MSsWyiQo2Ylgc9Nw9lFxpoRmd0xOenpI8bHO+VrxK
         2U0sSdPlKvaxnAenqBccDx1sSZJoNZfohV7MvWjaAWPjKxRb3JoymN6LqHKgOAvReiMn
         mOD0tsfs11KfI/1UCrGPVRNdy2XfmTwl8pLrqTsv8OxQbUhXz9tkRoOX7F6ok2u2xKQs
         QYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgZ2ekjB2w4IATMge4zN6op9t2Z495TinwaLO8sLH0U=;
        b=SI4Va241D8fXb9J0dXe1bePuzKJ7vm94nOavzpAMoHXzZngpp9vO9HLDYP1k1nZJPt
         d80kopoMlFCxAD1KTCE7Zp8OKCCUMcHFSe0zisKePEaKsYR/wpCujG/meUTe3yJbsxEF
         uKcUKZXA+paQyh3czewxis1f2iu3yXCDuECDgl0/wfLXJTPegh7zdGGkIpNEQWIz4Zyr
         SDynw+JaNdWky66S2s5njRLNPBf45p5fIEc5jLSXGFs6oWoyMG8uCeabcciE3PsKm8Kr
         /xZFjUq8/TpiUX+Kl7dtsFUC8slME8pUGiU990kWJd7PnHEl4iJlVThxhcT5Q+XmdsR+
         GX8Q==
X-Gm-Message-State: AOAM533FOwYLRHxztP+ZVVh+qPNNXhjrMOYap37ZQrxgTesJkzl0IoTb
        ZlW3WGJ4Ng4jyxYsB3Vkmg26XfpKMw3qrIoGqlQgYQ==
X-Google-Smtp-Source: ABdhPJy9zG4CjAQR/J6R19gfFDkrsm7e4WOPkyQ/kcxBrA8tFfhtF7n/4/gG7NkhctFeNwvdbA425f129B53LpKUKAE=
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr2525748wry.128.1627534609273;
 Wed, 28 Jul 2021 21:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy1rA9e2iCJWeVEQwKTRfTZZaRZVcMe1o8wMnFiWOOGW3w@mail.gmail.com>
 <mhng-7fd3d454-cd80-4ede-baed-08003d66b3a4@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7fd3d454-cd80-4ede-baed-08003d66b3a4@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Jul 2021 10:26:38 +0530
Message-ID: <CAAhSdy0PsbAJdA=CX7fh=J8jaEh2XniXveQV8rhQWNzW=PBBwQ@mail.gmail.com>
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

The RISC-V AIA group was formed last year. Can you point me to which
interrupt controller efforts you are referring to.

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

Nope, it is much cleaner and modular compared to SiFive CLINT and
it is also backward compatible to SiFive CLINT.

Can you elaborate what part of the code you are not okay with ?

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

This spec is being developed by the RISC-V AIA group based on the
feedback from ISA folks and HW architects.

>
> As far as I can tell this new spec allows for multiple MTIME registers,
> which seems to be in direct contradiction to the single -MTIME register
> as defined in the ISA manual.  It also seems to be vaguely incompatible
> WRT the definition of SSIP, but I'm not sure that one really matters all
> that much as it's not like old software can write the new registers.

The ACLINT spec clearly defines that if we have multiple MTIME registers
then these registers must be synchronized to meet the architecture
requirements. The spec also defines a software mechanism for MTIME
synchronization. It is also possible for multiple MTIMER devices to share
same MTIME register. Please refer to the latest ACLINT spec.

>
> I just talked to Krste and Andrew, they say they haven't heard of any of
> this.  I don't know what's going on over there, but it's very hard to
> review anything when I can't even tell where the ISA is defined.

I am surprised by the respone you got because the ACLINT spec is
being developed by a working group of RISC-V International. In fact,
it is hosted on the RISC-V International GitHub. How can we host it on
RISC-V GitHub if it is not an official spec being developed by RVI.

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
