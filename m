Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0273FE8D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhIBFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhIBFjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:39:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D6C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 22:38:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so879733wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 22:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWV9bLG/2yXnxhGxXYYM9ItVns0zZK7AGnCy4qIXCSc=;
        b=wS+RIKCKV2QUWDiVvVyaN+rSuO+rDjBROwlgxCzHSX8Hm6YowtBE3WZ08yT1eb0H4t
         mJX1/cwHzNdSy7jYHD4Dj18Ze4ssMXzv3GXqfhX4YguDQVLWenVhw60tFGGUVWvEEaMe
         rv/faXMpuPuWn1gdVcuFnWSXZ4wSxHKlMGtA8i9QW3VXnB8msMu7Kn3HFp5CstDFD0p5
         00r+yUn+g2rK3WzH69ou9SxBzsHAS82CNBDLxTeOHEDLEfkaAP/HG0kptP8elqeACAKV
         7CqEm9rQlYjjIZto5gJVQUUG0vfHY5iS0Nb5pYVzYsiQ9VxnutHX0DcM9BN2ZWfDjD/d
         gzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWV9bLG/2yXnxhGxXYYM9ItVns0zZK7AGnCy4qIXCSc=;
        b=n8xPU+NqGa7mk0T7d91nASFD8Com9nXFJNNyIsBTO1VuUsoOfDqgmXOrjLx3zyzVh8
         1sR2x3I5NVPjNKZxR/92HPCbVzSzwxtfo8l8zwbzS1WzNhXYoWSosq2jHVh1e98hwLhW
         ngka6FgDMdvtxUhJqSGhdoA0dNw60RuKpS0X9PYyjWS7ZajwWDEoPvCdu/LRWsL5CN5+
         /flesiXJ2cBTpscN+9lgYXvfrd/fGvYBBi/U2EX4lb0T6qw2xPX7upAURkAj3z94oCsZ
         OLo/lAnaOzbkH1RKxmBH05J0wgmkv6CRI6uhNL4nnUyLyQEBBQBZVlbRysQUp8vqINrg
         zyJA==
X-Gm-Message-State: AOAM5335jNe1kLslNP7ejp6TA8CD2jamyBFWsS2YHyOIX24N0jbTJfrs
        eywAHUD9C3EgCMD2N4SDCKLNdBFV2gzmSgttwMegkg==
X-Google-Smtp-Source: ABdhPJwOM1D55l6+NkGI52QGARqgqsCy0uArZ5990xPenEDFN+7yWV8AdcF3BU+g5/6zok2iR7fN9N5Pq54RtuA6e1U=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr1517203wrw.390.1630561080772;
 Wed, 01 Sep 2021 22:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-7-anup.patel@wdc.com>
 <YS7Xk/Np2yc1/wrb@robh.at.kernel.org> <CAAhSdy2e8bPXkTodpbtNeEVX-iCxVeyNLYBkL0aCQBZ7wbSCzw@mail.gmail.com>
 <CAL_JsqJ_Uc5UqCFojUYioXYJycbcBCF-nGryJiTMkhkN5MJhpw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ_Uc5UqCFojUYioXYJycbcBCF-nGryJiTMkhkN5MJhpw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 2 Sep 2021 11:07:49 +0530
Message-ID: <CAAhSdy1A-2oPVfWioqc7JDsRTHEgwMNR5zuVg-O-X0K86-7Exg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/11] dt-bindings: timer: Update SiFive CLINT
 bindings for IPI support
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 5:48 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 1, 2021 at 7:00 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Sep 1, 2021 at 6:59 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Aug 30, 2021 at 09:47:24AM +0530, Anup Patel wrote:
> > > > The Linux RISC-V now treats IPIs as regular per-CPU IRQs. This means
> > > > we have to create a IPI interrupt domain to use CLINT IPI functionality
> > > > hence requiring a "interrupt-controller" and "#interrupt-cells" DT
> > > > property in CLINT DT nodes.
> > > >
> > > > Impact of this CLINT DT bindings change only affects Linux RISC-V
> > > > NoMMU kernel and has no effect of existing M-mode runtime firmwares
> > > > (i.e. OpenSBI).
> > >
> > > It appears to me you should fix Linux to not need these 2 useless
> > > properties. I say useless because #interrupt-cells being 0 is pretty
> > > useless.
> >
> > Linux IRQCHIP framework only probes IRQCHIP DT nodes which
> > have "interrupt-controller" DT property.
>
> Right, I believe I wrote that... So what would it look like to fix
> that? The simplest thing is just drop the check for
> 'interrupt-controller'. That's just a sanity check and we have other
> ways to do that now (schemas). Do you need this early? You can always
> implement your own initcall.

Okay, let me first try to fix this in the driver itself. Most likely,
we will not
require changes in this DT binding.

>
>
> > The "interrupt-cells" DT property
> > can be removed because as an interrupt controller SiFive CLINT
> > will only provide IPIs to arch code.
>
> The schema will disagree.

Okay.

>
> Rob

Regards,
Anup
