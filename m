Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820173FFE52
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbhICKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbhICKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:41:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0610C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:40:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3247064wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQwd8S30SMMSUoUfiujLV3m0uDIvIxN2gb+ceJ/Cjqc=;
        b=hoIfoySMft4uXS5Emu+pqPpJ4ycBAvbSH05oi2TGL/pME7DAJrclBEuM41TOlIlDp3
         kC0BlpbbkUAU4vOU4N797gU7Qq1joD17ZGLZZeVQjO/7NoXeHaE2tJDyzQqNrC7ZhC5W
         gK5IJAzTWF4x1ajN7aPgpbAQD5sJdNf/ZefuAXWqPIHJu77Iu1npF+7UaxjGt26KtKr+
         Tr/qGz04mpwlbFm8KZjB/fvu+ADWARhxSGOiHC3MwcI0bfyMYFOB4AKnWHi/b/Ystd3C
         Ei7uG0Em8AWrYeAOupxp1IDXLcBIlcqMLmB2rpNqaZrP1ghZgUket6NCIgVEMN9mdrzd
         DmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQwd8S30SMMSUoUfiujLV3m0uDIvIxN2gb+ceJ/Cjqc=;
        b=SYL0VfleOhtR4UJ9qpRLLMnjm5EWCubfvW2gnfYhzW2Y711LWcCHfkeqdnmD3wJhNN
         Opwsj/0l3R1YPrrBySmqsJYtTeW8DXTi8nSjOkyVzHnFZ2yfI2N9MuPZK8W0g1EPf36j
         NgHgxqj7hpH88+APwNU+/kCrLR5DXY0dj9+L1dAz3jsKqvuauiKMqC7Umrx91TD9XJpo
         iMzJaJAMNBuKUxYWSfi4yVXakfojhf6z8ET/xw54WrA6K+VODsyOfAmcbdLeEU3MhbIX
         lHIAFff25DXhLtJHH/mBoddiQkoo+eqLtCPf2rQd5du1MhgKRNjdulnJ+RHdOtQ2aOkv
         HI7g==
X-Gm-Message-State: AOAM532uQ0K42tCn0YWRyCw36QBN7v+Li1U8FhX6PfUQvVYXV9VHW8VA
        gkjqZOC9S/+EpJKxdJv5PPb7wHvIIsH7q3TS5ZMk4g==
X-Google-Smtp-Source: ABdhPJyyTSOea4UvObuNECW9zeYgA6pqjw7cAM6LYRDFNTT1e35OUfvPkO3D9m+EbH2nXHT7Jh7UdULa9shSAeYWdMI=
X-Received: by 2002:a1c:1d87:: with SMTP id d129mr7753647wmd.185.1630665621006;
 Fri, 03 Sep 2021 03:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-6-anup.patel@wdc.com>
 <YS7WTPRYJWnPu2ii@robh.at.kernel.org> <CAAhSdy1mttzt3_CnKc=xhpp5CKOEAasQVobTR-2L6Z26rstn+A@mail.gmail.com>
 <CAL_JsqLT3RgG0MHMWEs8BZPPtOUUcjRw27W+O4z=DNP9M=EKAw@mail.gmail.com>
In-Reply-To: <CAL_JsqLT3RgG0MHMWEs8BZPPtOUUcjRw27W+O4z=DNP9M=EKAw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 3 Sep 2021 16:10:09 +0530
Message-ID: <CAAhSdy1NBNTQ5F=4MjjwLb4k_kGgB9j5iFxJ6qoGSCuGkn=66g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/11] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
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
        DTML <devicetree@vger.kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 6:04 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 1, 2021 at 6:56 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Sep 1, 2021 at 6:54 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Aug 30, 2021 at 09:47:23AM +0530, Anup Patel wrote:
> > > > We add DT bindings documentation for the ACLINT MSWI and SSWI
> > > > devices found on RISC-V SOCs.
> > > >
> > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > ---
> > > >  .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
> > > >  1 file changed, 95 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > > new file mode 100644
> > > > index 000000000000..68563259ae24
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > > @@ -0,0 +1,95 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RISC-V ACLINT Software Interrupt Devices
> > > > +
> > > > +maintainers:
> > > > +  - Anup Patel <anup.patel@wdc.com>
> > > > +
> > > > +description:
> > > > +  RISC-V SOCs include an implementation of the M-level software interrupt
> > > > +  (MSWI) device and the S-level software interrupt (SSWI) device defined
> > > > +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
> > > > +
> > > > +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
> > > > +  specification located at
> > > > +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> > > > +
> > > > +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
> > > > +  S-level software interrupt lines of various HARTs (or CPUs) respectively
> > > > +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
> > > > +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +        - enum:
> > > > +          - riscv,aclint-mswi
> > > > +
> > > > +      - items:
> > > > +        - enum:
> > > > +          - riscv,aclint-sswi
> > >
> > > All this can be just:
> > >
> > > enum:
> > >   - riscv,aclint-mswi
> > >   - riscv,aclint-sswi
> > >
> > > However...
> > >
> > > > +
> > > > +    description:
> > > > +      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
> > > > +      "<vendor>,<chip>-aclint-mswi".
> > > > +      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
> > > > +      "<vendor>,<chip>-aclint-sswi".
> > >
> > > s/OR/AND/
> > >
> > > There must be a compatible for the implementation. Unless RiscV
> > > implementations of specs are complete describing all clocks, power
> > > domains, resets, etc. and are quirk free.
> > >
> > > But don't write free form constraints...
> >
> > It is possible that quite a few implementations (QEMU, FPGAs, and
> > other simulators) will not require implementation specific compatible
> > strings. Should we still mandate implementation specific compatible
> > strings in DTS for such cases?
>
> No, but the schema says you only have those cases. Are there not any
> actual implementations?

All existing RISC-V boards have SiFive CLINT and ACLINT is backward
compatible with SiFive CLINT so we do have actual implementations.

None of the existing RISC-V boards have special clocks, power domain,
resets etc for these devices.

>
> Minimally make "<vendor>,<chip>-aclint-mswi" into a schema pattern for
> the first entry and perhaps a note to replace with actual strings when
> there are some. It's ultimately up to the RiscV maintainers to require
> SoC specific compatibles here. Allowing a generic one alone makes that
> harder because the schema can't enforce it.

Can we have a common compatible string for QEMU, FPGAs, etc ?

For example,
compatible = "riscv,generic-aclint-mswi", "riscv,aclint-mswi";

Regards,
Anup

>
> Rob
