Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61C3D5CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhGZOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGZOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:42:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:22:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so11558186wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avDShFOnRifoiKTiQKCeIkAP138nxzPrnp0tkIoBLys=;
        b=LG0MkcBw3Z8/VwJ4qdyP2VQUN3bST3lAmhEB7ChPfdR1gEwwIuYBgiN/RXIjg2IypI
         JZDI6pM94yYdb1m7jGnbk6OK7ppwXgVaqF/AuCaSXl/V69s/EC3aevtYsFPQ8DCWHhbJ
         BDHi2MYfoFNrbPwhrvKoLCDgNAXqXIZUQQiZMoNwUmOOPaUsa2liD2V59LICIMvMzkHV
         WC1XX9f/bx5A6PU0H7krRq+N/59uSo18rJuCA5QO1oaObAt2braN1ZHR3n/c80akk5vN
         elUrX0N53yel+hJ+nLwZZFsXE1M7kQiaLEs6O8SYeKxPpxIEv/qOSHM4+dKv7BXK9niZ
         3c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avDShFOnRifoiKTiQKCeIkAP138nxzPrnp0tkIoBLys=;
        b=dbULJNqNIno17VDPvON+lAtbmhgxwTKFVlwUZuoQ+nOtrNscpqBsWeSPaVGapUn7ip
         tlzhC8D/zBNzDKEOq1YeMizdO23UFWMkXWTCjh/0nEj0sRfa08fnznAfSjmE/qx4Ygc+
         Q4wLzHLsmUiNaE1iOPe3Dvgj59sMkLBX9XTRcNWj7CMNcRgMvHubChjzASBkEsH9A51p
         E40/ucrJ8/iVI4VrU9s2Wp8+gv6sUfmktir31r8xcsgsXvT3H47v0IrmbvrHdG/mkGVN
         cf6QMKGckQ359AyfrJ5Pw1UsUi4DHuZCvx4rdJBTS5Tro30XtPth5A/MPHeZ6Z6Ppcjc
         Ui9A==
X-Gm-Message-State: AOAM530sBWjbohz/Ha/FKDbCoU5ua3Vwkk+uw2sZ+D8fFgRjfHeCPU2n
        JFxgJohgFbEN/I9YmqjWh8SYDTAOiX4gxDLodMJgOw==
X-Google-Smtp-Source: ABdhPJxS1dRI/OSfH5W9DS2t09aCkQ4v/mCbJyOLuy5wMIvH2nM9dj7G3bhhBdXNRi0ux2I+OSdKyT7lKWDbq822IjU=
X-Received: by 2002:a5d:424d:: with SMTP id s13mr10302527wrr.356.1627312954415;
 Mon, 26 Jul 2021 08:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123851.1344518-1-anup.patel@wdc.com> <20210618123851.1344518-3-anup.patel@wdc.com>
 <87lf5tdw9z.wl-maz@kernel.org>
In-Reply-To: <87lf5tdw9z.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 26 Jul 2021 20:52:23 +0530
Message-ID: <CAAhSdy3tLNPsdLEW2zSqFSUS5iuoVCLrcmwQkcw4w75DPHXUyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] RISC-V: Use common print prefix in smp.c
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:14 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 18 Jun 2021 13:38:42 +0100,
> Anup Patel <anup.patel@wdc.com> wrote:
> >
> > We add "#define pr_fmt()" in smp.c to use "riscv:" as common
> > print prefix for all pr_xyz() statements in this file.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  arch/riscv/kernel/smp.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 547dc508f7d1..eea0c9d11d9f 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -8,6 +8,7 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >
> > +#define pr_fmt(fmt) "riscv: " fmt
> >  #include <linux/cpu.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/interrupt.h>
> > @@ -114,7 +115,7 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
> >       if (ipi_ops && ipi_ops->ipi_inject)
> >               ipi_ops->ipi_inject(mask);
> >       else
> > -             pr_warn("SMP: IPI inject method not available\n");
> > +             pr_warn("IPI inject method not available\n");
> >  }
> >
> >  static void send_ipi_single(int cpu, enum ipi_message_type op)
> > @@ -126,7 +127,7 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
> >       if (ipi_ops && ipi_ops->ipi_inject)
> >               ipi_ops->ipi_inject(cpumask_of(cpu));
> >       else
> > -             pr_warn("SMP: IPI inject method not available\n");
> > +             pr_warn("IPI inject method not available\n");
>
> "SMP:" made a lot more sense. I assume that the user knows that they
> are using a RISC-V machine. On the other hand, seeing a "SMP:" prefix
> for a message indicates the provenance of the message.
>
> I honestly don't see the point in this change.

The intention was to distinguish arch specific prints from
generic kernel prints at boot-time because "SMP: " prefix
was not making it obvious that these are arch specific prints.

I am certainly fine dropping this patch as well.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
