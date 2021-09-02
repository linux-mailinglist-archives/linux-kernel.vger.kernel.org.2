Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B83FE6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbhIBAe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhIBAe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:34:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1024F61074;
        Thu,  2 Sep 2021 00:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630542841;
        bh=AULb94u8DPCVX3NAb7nJvJEiQNrMkPYbLeM6cmrGsVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R5howx/slD6zitOsueBZeXYbzp7F84HlafFu1dVLGq4uq281lmnC57T2+uWta3HJD
         S15CzUjxueIDPs5cAAlgANkTtsW7JqakZhw9Qf6EyJSNhvxwuzMN1s1BpdWoE9PHbj
         7loNUHXawi2/7w47UBDxKeQcF1I7HUZTfzJYVVQ4tbB5ibfvE5WSdTRg0KPpkBwe8m
         1O+1Oq2STduH+00FSfXRjziqFMs9YMITvOW50nNRS8+j3/PxnVA0BGZJY0lSSx2iYA
         jm7Zp55tIZ+0vsmllcsHJS4Ks84cokDhE0Yw+1xYi133y/3qv+7zFIzM1E+S0mWibh
         61uHJXKQS+AXw==
Received: by mail-ej1-f49.google.com with SMTP id h9so272871ejs.4;
        Wed, 01 Sep 2021 17:34:00 -0700 (PDT)
X-Gm-Message-State: AOAM533bys+by4mVh/vTWAOJ/ws/oUlNQPAqq84ZhxZQ1Cr3PpNiC4+g
        cBJGB/khtRsOY1//r0m4sMkq3sv8GlD1lDPugg==
X-Google-Smtp-Source: ABdhPJx7u5F8Nk4zeQKwACQmAUvSnPMJrvfvsim7Oy27vFJxP7EV+LC3aHBRTgoZs71PV9j+8DsQqnm0r5jmZOj1foQ=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr663241ejb.108.1630542839613;
 Wed, 01 Sep 2021 17:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-6-anup.patel@wdc.com>
 <YS7WTPRYJWnPu2ii@robh.at.kernel.org> <CAAhSdy1mttzt3_CnKc=xhpp5CKOEAasQVobTR-2L6Z26rstn+A@mail.gmail.com>
In-Reply-To: <CAAhSdy1mttzt3_CnKc=xhpp5CKOEAasQVobTR-2L6Z26rstn+A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Sep 2021 19:33:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLT3RgG0MHMWEs8BZPPtOUUcjRw27W+O4z=DNP9M=EKAw@mail.gmail.com>
Message-ID: <CAL_JsqLT3RgG0MHMWEs8BZPPtOUUcjRw27W+O4z=DNP9M=EKAw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/11] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
To:     Anup Patel <anup@brainfault.org>
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

On Wed, Sep 1, 2021 at 6:56 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Sep 1, 2021 at 6:54 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 30, 2021 at 09:47:23AM +0530, Anup Patel wrote:
> > > We add DT bindings documentation for the ACLINT MSWI and SSWI
> > > devices found on RISC-V SOCs.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >  .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > new file mode 100644
> > > index 000000000000..68563259ae24
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > @@ -0,0 +1,95 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V ACLINT Software Interrupt Devices
> > > +
> > > +maintainers:
> > > +  - Anup Patel <anup.patel@wdc.com>
> > > +
> > > +description:
> > > +  RISC-V SOCs include an implementation of the M-level software interrupt
> > > +  (MSWI) device and the S-level software interrupt (SSWI) device defined
> > > +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
> > > +
> > > +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
> > > +  specification located at
> > > +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> > > +
> > > +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
> > > +  S-level software interrupt lines of various HARTs (or CPUs) respectively
> > > +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
> > > +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +        - enum:
> > > +          - riscv,aclint-mswi
> > > +
> > > +      - items:
> > > +        - enum:
> > > +          - riscv,aclint-sswi
> >
> > All this can be just:
> >
> > enum:
> >   - riscv,aclint-mswi
> >   - riscv,aclint-sswi
> >
> > However...
> >
> > > +
> > > +    description:
> > > +      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
> > > +      "<vendor>,<chip>-aclint-mswi".
> > > +      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
> > > +      "<vendor>,<chip>-aclint-sswi".
> >
> > s/OR/AND/
> >
> > There must be a compatible for the implementation. Unless RiscV
> > implementations of specs are complete describing all clocks, power
> > domains, resets, etc. and are quirk free.
> >
> > But don't write free form constraints...
>
> It is possible that quite a few implementations (QEMU, FPGAs, and
> other simulators) will not require implementation specific compatible
> strings. Should we still mandate implementation specific compatible
> strings in DTS for such cases?

No, but the schema says you only have those cases. Are there not any
actual implementations?

Minimally make "<vendor>,<chip>-aclint-mswi" into a schema pattern for
the first entry and perhaps a note to replace with actual strings when
there are some. It's ultimately up to the RiscV maintainers to require
SoC specific compatibles here. Allowing a generic one alone makes that
harder because the schema can't enforce it.

Rob
