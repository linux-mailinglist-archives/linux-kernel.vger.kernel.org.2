Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6263A584E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhFMMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:32:02 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40561 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhFMMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:32:01 -0400
Received: by mail-wm1-f47.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so11195390wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFw5V6rcIrPE+2HCF52bPq6yFSTBGQP95PAhiE4OJDM=;
        b=hRzQ0f+uIAiruqZ6/UeXM9i+Qa0s+aGsy/nypdMQWkpcSjkvdKrsSHPYv4mlB/ZCI6
         Y4l4Oyw+87+XCTxQ2o3Y40Q9jfAWQUhLeuPYedBsrPwhtaFR1E/BEGcq7ub2yxv2l9xA
         2VIWUeqeizWjSq2cq2obkiMj1IuntZsXOeGy3rlfSHq60wHoHxyEpe6Fxh/zlNRat0Tq
         3etlBxe8kGgQR5wPXSCXxVVKqfXC8aNpjNIzd3lQSXvCTakLIkaU4GMwU9jkx+y1wIFg
         oGIkRcgoKezfZKFOu4Q75CdXRVJlnjPcCUF6+X6m7U8bryEa8VrmodzmJ80aFVfkLtOv
         xhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFw5V6rcIrPE+2HCF52bPq6yFSTBGQP95PAhiE4OJDM=;
        b=GbJNbKh1uzTXS2CdYCB1ZBNbur9lIFH8OiJ43m2LUEojd2/AL80PH4EZgcMU5MJN+e
         OPnPxJQVOQbNeDNYtQqY5xUE5TOrBvwlCrNpxIjhAM/xf4ZkNveItsx51vw99jv+2hul
         3N4i2Ebh4oXCINpoHT52ZoNC3FhfG7OUJK8bfx92Wx6c4Lcu4EgpPdGOzkFy2h9UOMDd
         S3PwpSA86vbXVR/LdYvh/HyTCiEJgsgbVGNPb1AcBhELljFFUavmhSQvR7UYHJhFXYJn
         D+aMrnEYoBq8T+FLluAHvmxZJ5Y+YPNjr9yzfFCCu3NP+htvzzZQHgzrhVRem5vYiO+k
         eZVg==
X-Gm-Message-State: AOAM532F48C0Jjcvqc9/B1xvyleA527HoMxjrfUMSIyJ0UopeS9z02eF
        1oWmHWG8TWANTCsGgtL3ZBQMYG8DdM20YqGqLYMlNA==
X-Google-Smtp-Source: ABdhPJwEQO4Mjls0s+EY5auqfFyOv+/X1rhrcKbVkmx5yPV4XoADVdTjZkrOoOg0ZYmeEwvrgAlMsk8rzjAouUfGo20=
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr12077157wmj.134.1623587330548;
 Sun, 13 Jun 2021 05:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-5-anup.patel@wdc.com>
 <87a6nut8h9.wl-maz@kernel.org>
In-Reply-To: <87a6nut8h9.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 13 Jun 2021 17:58:39 +0530
Message-ID: <CAAhSdy1-VbEwmWbYzB4KmCK3HjDXzi5-3S+9BS-D3o6q0iOY9g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/10] RISC-V: Use IPIs for remote TLB flush when possible
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
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 3:03 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 12 Jun 2021 17:04:16 +0100,
> Anup Patel <anup.patel@wdc.com> wrote:
> >
> > If IPI calls are injected using SBI IPI calls then remote TLB flush
> > using SBI RFENCE calls is much faster because using IPIs for remote
> > TLB flush would still endup as SBI IPI calls with extra processing
> > on kernel side.
> >
> > It is now possible to have specialized hardware (such as RISC-V AIA)
> > which allows S-mode software to directly inject IPIs without any
> > assistance from M-mode runtime firmware.
> >
> > This patch extends remote TLB flush functions to use IPIs whenever
> > underlying IPI operations are suitable for remote FENCEs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/mm/tlbflush.c | 62 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 720b443c4528..009c56fa102d 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -1,39 +1,73 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TLB flush implementation.
> > + *
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
>
> I find this a bit odd. You don't mention this addition in the commit
> message, and a quick look at the commits touching tlbflush.[ch]
> doesn't make the copyright assignment obvious (most commits originate
> from either SiFive or Christoph).
>
> In any way, please keep this kind of changes out of this series if
> possible, and have a separate discussion on who gets to brag about
> this code.

I agree it's unrelated change.

The commit history suggest mm/tlbflush.c was added by Christoph
and other commits after that are from Atish (Western Digital).

I will sort this out separately.

Regards,
Anup

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
