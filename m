Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E93FD914
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbhIAL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbhIAL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:57:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EAC061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 04:56:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so4139674wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0azurFEdIj3ZC2ZbeqfiGR0BlWdPTBZ0eY7HkyWHa2Y=;
        b=ycqYpYprwv+8Vnwh7DpeornOkThIjfcXQU00tbtCKFpCHePBxPbNfxsWxS9+X/heuV
         0+M9LzyIXjixhFh+xNYeHX4rJ2kn6sngjiL1rWYJPrqlFyAFMcCtMRsp/8UrBiSs/eys
         x037ok1Hsh5ZoGocgpzEaOYXRCha8jvevbd7j+rToaPxjHC0axNKU8QGBvYlJeHROyLq
         8uMJTirpZ7uo8zhWmAroylNa6158dtdBkcyWFfo3QyPnuitMd+2mFw1B67ItQC5Ksncv
         vGpEOcCQ3o3ssY6fhd1bvaYu0c2D0EssflfbhkakAFm8UxPAWbRa+hOpBJSD8RCbVpZz
         /w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0azurFEdIj3ZC2ZbeqfiGR0BlWdPTBZ0eY7HkyWHa2Y=;
        b=bqQk/RJLA6ALi8D50hGMLevnXohY8CaSZrKUB6aOfxd5dxnVfUKMGSC1JyURMWMVHr
         y+cjFvdLzCdmvDAlUdQDZIvMHk8dQd1FDclc9lbO83eslPoJRJjxp4qOdHkMenMHz43S
         EHPpnpN2WtorZavzexczRWBTO1ieKD4bkaMAJg0Pg/OYIPC3REvrJMYx/9sFKk0SskMW
         WCH6i+XMLHF3dxw2dKnzL2rBhrNsAMRCBtx3+BuD/eFlGqrpkzu9APLqZUpaX5fTSh42
         0AqsvYX4qOrUH2TeuH0SUWkMgkIFd84Fk0rmYsaJ2qSHQeMbZwC8vKMuWAKMzj5PPWyt
         vcqg==
X-Gm-Message-State: AOAM531xqAfVMaqwvbtmoK8/OoRjtMYr0TGY6bFJU0xuU9/jdYNgZm06
        xfV79spaQsjPEvTJZgpSro/G+43JUE+yKIy9u1QppQ==
X-Google-Smtp-Source: ABdhPJzRxVML9moiMgg+a03C/rFPY4kkvpXCjDbBd+shBLGf/JF/Hax8hkKGtVV6C2PckIB2I5y4IK/5UM0VeTmLVho=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr38038230wrw.390.1630497387244;
 Wed, 01 Sep 2021 04:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-6-anup.patel@wdc.com>
 <YS7WTPRYJWnPu2ii@robh.at.kernel.org>
In-Reply-To: <YS7WTPRYJWnPu2ii@robh.at.kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 Sep 2021 17:26:16 +0530
Message-ID: <CAAhSdy1mttzt3_CnKc=xhpp5CKOEAasQVobTR-2L6Z26rstn+A@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 6:54 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 30, 2021 at 09:47:23AM +0530, Anup Patel wrote:
> > We add DT bindings documentation for the ACLINT MSWI and SSWI
> > devices found on RISC-V SOCs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > new file mode 100644
> > index 000000000000..68563259ae24
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V ACLINT Software Interrupt Devices
> > +
> > +maintainers:
> > +  - Anup Patel <anup.patel@wdc.com>
> > +
> > +description:
> > +  RISC-V SOCs include an implementation of the M-level software interrupt
> > +  (MSWI) device and the S-level software interrupt (SSWI) device defined
> > +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
> > +
> > +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
> > +  specification located at
> > +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> > +
> > +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
> > +  S-level software interrupt lines of various HARTs (or CPUs) respectively
> > +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
> > +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - riscv,aclint-mswi
> > +
> > +      - items:
> > +        - enum:
> > +          - riscv,aclint-sswi
>
> All this can be just:
>
> enum:
>   - riscv,aclint-mswi
>   - riscv,aclint-sswi
>
> However...
>
> > +
> > +    description:
> > +      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
> > +      "<vendor>,<chip>-aclint-mswi".
> > +      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
> > +      "<vendor>,<chip>-aclint-sswi".
>
> s/OR/AND/
>
> There must be a compatible for the implementation. Unless RiscV
> implementations of specs are complete describing all clocks, power
> domains, resets, etc. and are quirk free.
>
> But don't write free form constraints...

It is possible that quite a few implementations (QEMU, FPGAs, and
other simulators) will not require implementation specific compatible
strings. Should we still mandate implementation specific compatible
strings in DTS for such cases?

I was not sure so I used "OR".

Regards,
Anup

>
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#interrupt-cells":
> > +    const: 0
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 4095
> > +
> > +  interrupt-controller: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts-extended
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +
> > +examples:
> > +  - |
> > +    // Example 1 (RISC-V MSWI device used by Linux RISC-V NoMMU kernel):
> > +
> > +    interrupt-controller@2000000 {
> > +      compatible = "riscv,aclint-mswi";
> > +      interrupts-extended = <&cpu1intc 3>,
> > +                            <&cpu2intc 3>,
> > +                            <&cpu3intc 3>,
> > +                            <&cpu4intc 3>;
> > +      reg = <0x2000000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +    };
> > +
> > +  - |
> > +    // Example 2 (RISC-V SSWI device used by Linux RISC-V MMU kernel):
> > +
> > +    interrupt-controller@2100000 {
> > +      compatible = "riscv,aclint-sswi";
> > +      interrupts-extended = <&cpu1intc 1>,
> > +                            <&cpu2intc 1>,
> > +                            <&cpu3intc 1>,
> > +                            <&cpu4intc 1>;
> > +      reg = <0x2100000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +    };
> > +...
> > --
> > 2.25.1
> >
> >
