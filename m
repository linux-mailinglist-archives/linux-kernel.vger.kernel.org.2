Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D493A6788
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhFNNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:16:57 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36465 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhFNNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:16:55 -0400
Received: by mail-wr1-f45.google.com with SMTP id n7so8342025wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XaqFjDhdi9dIScXFDsKNQBeWGz1HwBH0TF+QCGhEDg4=;
        b=HwYvbf7w8uywUzYEqLUcnCZiAoF1NoeXpwx56KYax2Bqehbxafzv0waHhZPevrg34z
         nMVIV1K2SC/msQ0BkfdJVwOnqO7JGAR3knwH8dySAyCL6llJHF/ZBeBexlWz9Rj1w6ME
         /qsPwb9mSuOs1YXOWxV6d8fSl67TpC0S6DAu1duEPhbxAYsXpUCUufv180Y56LA+2UA2
         7I28bWDD3lZPoygb9Mue5oUHuN2FeGyqZyD+Vg3QeMdAYFkhGqQ0om3jqjWlhXIcRStK
         cmxS9cTwwQWja5rRwcthhKqHsu/h3SifiTTuP5aWrznboqD4461X5ez91LokOV7+f/vd
         X/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XaqFjDhdi9dIScXFDsKNQBeWGz1HwBH0TF+QCGhEDg4=;
        b=lxBBKWwSZYN6R88cvYx7yw0xMa/LuK6o5aap9Mm7tsYizaLnnA9Z7SEj0UnMdK4nFz
         +AXaflQq1Lrd6R34tfzdIn5lbnRJoe8YVfU/a4ZXe0AzuH0NvKno6iTjKslE5ocG66lm
         FmpoB4KIAoaZ5rsI5wOxN6iPiO4oiU/Avd4zJifPo0MevVED9Q7Fw7CjOTwUgiWvrYCn
         cva1O146MGO79cZIZsMFf1hj5Nb1lVZ6kmt7dooQP45Jl/SJZKSpDfcYZWqOFfZddJDC
         VROOWfaq/EVyAlGiAKDUQUJPSItUWDfPrpffiCHjYjxl4Lubf7x33ftXQbkPHJ9PC8Z7
         lpPA==
X-Gm-Message-State: AOAM533XR3/xaBJCebFBlPcauKwTt0IPeQa0CSscGHT+TeJ3LgtvzJVJ
        ZyUQEHft4J3gfuaxzqLDOFoc4G0wk6ezuJ1ZhKhuHA==
X-Google-Smtp-Source: ABdhPJwaIml99G0JVblKb/bJU6ZJxhC4NnG3pECobXr6p0v0dm5rhMCSciB3jhJPIU6+0Ueq2o9rrQ5zrI4HAOZY5mY=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr18528505wrx.144.1623676416729;
 Mon, 14 Jun 2021 06:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-6-anup.patel@wdc.com>
 <878s3et831.wl-maz@kernel.org> <CAAhSdy2e9BsgtTL3ETRC-dvHW9hgKmgRi87Gsk+vUT-kMsJ4NQ@mail.gmail.com>
 <87a6nsrdkm.wl-maz@kernel.org>
In-Reply-To: <87a6nsrdkm.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 14 Jun 2021 18:43:25 +0530
Message-ID: <CAAhSdy0jZTqZ+zTazpQLeCnbAHr99t40vEa-_GD0_UjBZsXWzg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/10] irqchip: Add ACLINT software interrupt driver
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

On Mon, Jun 14, 2021 at 3:08 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 13 Jun 2021 13:25:40 +0100,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sun, Jun 13, 2021 at 3:11 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > I'm sorry, but this really isn't an irqchip driver. This is a piece of
> > > arch-specific code that uses *none* of the irq subsystem abstractions
> > > apart from the IRQCHIP_DECLARE() macro.
> >
> > Yes, I was not sure we can call it IRQCHIP hence the RFC PATCH.
> >
> > Both ACLINT MSWI and SSWI are special devices providing only IPI
> > support so I will re-think how to fit this.
>
> It depends on how you think of IPIs in your architecture.
>
> arm64 (and even now 32bit) have been moved to a mode where IPIs are
> normal interrupts, as it helps with other things such as our pseudo
> NMIs, and reduces code duplication. MIPS has done the same for a long
> time (they don't have dedicated HW for that).

RISC-V is also moving in a similar direction with the RISC-V advanced
interrupt architecture (AIA) specification which aims at defining an
interrupt controller having MSI support, virtualization support and
scalable for a large number of CPUs. The RISC-V AIA treats IPIs as
normal interrupts.

The RISC-V ACLINT based IPI support is for RISC-V systems which
only need a simple interrupt controller without MSI support and
virtualization support. These systems will not implement RISC-V AIA.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
