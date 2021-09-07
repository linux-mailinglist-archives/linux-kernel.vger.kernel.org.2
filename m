Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34879402A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbhIGNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234990AbhIGNtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:49:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28DA161107;
        Tue,  7 Sep 2021 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631022498;
        bh=ArpxA6KfyIfvsZ8d82ObTY6A8wEvx7a+tmGvpZbu1u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kjFgQpGggoy8m98tICr9x1g/hjx8Ox1hcrlhLrM57ioC/90iFja0mnBM3BeeeXra7
         JphW+wIgU5CgTBCD7TCnN2d829H8+hK/9F04EvWUG7EcgiBWoqEX0x/1Cp4BxXbO00
         g1m9dO0al8adpXdoAQvlQtk2A/X+AWihwQ96o6nGRto6rP0BtE5+5BZv9lBD1b28v3
         04A3PskMinulB06flbwsREV2MJDtiWNWN9ZAkcLRSCruam2qU+0eUq9wbxclMYk0OP
         Kwq4TUZaSuQfrMGbUJ3lXBVPDJM8hJndeyPZaB2avbVoEpLx3QWOSIgkcb0aGchnUH
         7v+Tt6cPGmMTQ==
Received: by mail-ej1-f41.google.com with SMTP id x11so19893301ejv.0;
        Tue, 07 Sep 2021 06:48:18 -0700 (PDT)
X-Gm-Message-State: AOAM531bb2gU7iE8TaGvmexPLocomyScWc2Wo7H5Mlh374VteA4wlxgw
        gGPS7YjojeAHtffEuuRa2OHpk3yqjmzR6MbFrQ==
X-Google-Smtp-Source: ABdhPJwiAjWbUjHP2uyVj2Z+vPdtXWFsSipWwKu5pprpfvFabFFsaLXHejznbz/SkeiF6IcWA3068Sgq+uoQxj6jDr4=
X-Received: by 2002:a17:906:9a4e:: with SMTP id aj14mr18654434ejc.84.1631022496627;
 Tue, 07 Sep 2021 06:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-6-anup.patel@wdc.com>
 <YS7WTPRYJWnPu2ii@robh.at.kernel.org> <CAAhSdy1mttzt3_CnKc=xhpp5CKOEAasQVobTR-2L6Z26rstn+A@mail.gmail.com>
 <CAL_JsqLT3RgG0MHMWEs8BZPPtOUUcjRw27W+O4z=DNP9M=EKAw@mail.gmail.com> <CAAhSdy1NBNTQ5F=4MjjwLb4k_kGgB9j5iFxJ6qoGSCuGkn=66g@mail.gmail.com>
In-Reply-To: <CAAhSdy1NBNTQ5F=4MjjwLb4k_kGgB9j5iFxJ6qoGSCuGkn=66g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Sep 2021 08:48:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXnYAGY5yqVkazeVdUgOtbbOZ2DMCU0_O892suYA4d-w@mail.gmail.com>
Message-ID: <CAL_JsqLXnYAGY5yqVkazeVdUgOtbbOZ2DMCU0_O892suYA4d-w@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 5:40 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Sep 2, 2021 at 6:04 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Sep 1, 2021 at 6:56 AM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Wed, Sep 1, 2021 at 6:54 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 30, 2021 at 09:47:23AM +0530, Anup Patel wrote:
> > > > > We add DT bindings documentation for the ACLINT MSWI and SSWI
> > > > > devices found on RISC-V SOCs.
> > > > >
> > > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > ---
> > > > >  .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..68563259ae24
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > > > > @@ -0,0 +1,95 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: RISC-V ACLINT Software Interrupt Devices
> > > > > +
> > > > > +maintainers:
> > > > > +  - Anup Patel <anup.patel@wdc.com>
> > > > > +
> > > > > +description:
> > > > > +  RISC-V SOCs include an implementation of the M-level software interrupt
> > > > > +  (MSWI) device and the S-level software interrupt (SSWI) device defined
> > > > > +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
> > > > > +
> > > > > +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
> > > > > +  specification located at
> > > > > +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> > > > > +
> > > > > +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
> > > > > +  S-level software interrupt lines of various HARTs (or CPUs) respectively
> > > > > +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
> > > > > +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +        - enum:
> > > > > +          - riscv,aclint-mswi
> > > > > +
> > > > > +      - items:
> > > > > +        - enum:
> > > > > +          - riscv,aclint-sswi
> > > >
> > > > All this can be just:
> > > >
> > > > enum:
> > > >   - riscv,aclint-mswi
> > > >   - riscv,aclint-sswi
> > > >
> > > > However...
> > > >
> > > > > +
> > > > > +    description:
> > > > > +      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
> > > > > +      "<vendor>,<chip>-aclint-mswi".
> > > > > +      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
> > > > > +      "<vendor>,<chip>-aclint-sswi".
> > > >
> > > > s/OR/AND/
> > > >
> > > > There must be a compatible for the implementation. Unless RiscV
> > > > implementations of specs are complete describing all clocks, power
> > > > domains, resets, etc. and are quirk free.
> > > >
> > > > But don't write free form constraints...
> > >
> > > It is possible that quite a few implementations (QEMU, FPGAs, and
> > > other simulators) will not require implementation specific compatible
> > > strings. Should we still mandate implementation specific compatible
> > > strings in DTS for such cases?
> >
> > No, but the schema says you only have those cases. Are there not any
> > actual implementations?
>
> All existing RISC-V boards have SiFive CLINT and ACLINT is backward
> compatible with SiFive CLINT so we do have actual implementations.

So there's a SiFive compatible you can add here?

> None of the existing RISC-V boards have special clocks, power domain,
> resets etc for these devices.
>
> >
> > Minimally make "<vendor>,<chip>-aclint-mswi" into a schema pattern for
> > the first entry and perhaps a note to replace with actual strings when
> > there are some. It's ultimately up to the RiscV maintainers to require
> > SoC specific compatibles here. Allowing a generic one alone makes that
> > harder because the schema can't enforce it.
>
> Can we have a common compatible string for QEMU, FPGAs, etc ?
>
> For example,
> compatible = "riscv,generic-aclint-mswi", "riscv,aclint-mswi";

This is not any better than just allowing "riscv,aclint-mswi" by
itself as someone could just use the above strings on their new
implementation to avoid warnings.

You could just not worry about the QEMU and FPGA cases. FPGAs are
probably not upstream and if they are, don't they need specific
compatibles tied to versions of FPGA images? QEMU generating its own
DT doesn't run schema validation though that could change. I'm looking
at enabling schema validation at runtime for purposes of firmware
testing and with that QEMU generated DT may be something we test.

Rob
