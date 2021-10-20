Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753584349FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:29:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC613C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:27:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p21so18149835wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AklsK9+LMtL2zZX38Ceie+zGJ7WCnCZ1oClrdPbxi4=;
        b=w9VWvwKddci/py1jnUMvLafuRneR27szt5RGP+LrJZwedjYW86gCYIWjtbZYNu7sdL
         /wA3c5ot88XM2CixfqLreORum0+JpoCwrY38sp8RkFw2WX4hCLV17S22A4QQiMOGoNQw
         8EO7b1+K396TADKKX6glkFwzhhAvBtWGfK4X92VwFNPBrglBd2jnTMMvR491OVqOcYwx
         8+H2h1iaoIqf9uyMvW1GBC/eC27+ictr2CdwRku/QtQcGk+/ZEQb3cAvDwolYAm9Xq6M
         Uqwp0M2xsn+0eAjcauL4MihOAn2TWW/Ww1FF1RfB8r9OBYtehW4i3ZckuQwzNQ5hEuys
         yd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AklsK9+LMtL2zZX38Ceie+zGJ7WCnCZ1oClrdPbxi4=;
        b=loYjgbLMdeQvQ0uTSS6RrEMywYwdC8CC0HnF8YitUY1eqwGgHa5txANX6KPD04H8+i
         xGlL8FMpzInBKMJcdH3bkg+cn7RknThVbz9xjHERh2aLgIoVIkvx5G38LXhWZOcng76w
         spsnnYWm4rJ8aVCtP2QHKYEYXL5DrIohUT1t6t8DFe0Atuf69ePIk8i0rGz6oAUHPGrN
         oyDBhdg5TSUZmUyztEvh5za+V57C8R5TXaMikwdaIKnVVI7eTXfW7PAW7CRR2TdVE+CE
         z9nMsQ+aYCO3D4won4ddbr36VTrSTcfwDzV5n9lszwPnEo/gKGpXwaa511pXOPLxpi4c
         Mqvw==
X-Gm-Message-State: AOAM532HyfqAs3j8J7DsbIVT2OXZreapLwzGuIFMPmsdo2BmCqK2M6BT
        cHTUHPcZbTAXzPwmeyQXDimOf6AROTLNBiYaTjc1Uw==
X-Google-Smtp-Source: ABdhPJwQW/QqmolpZfOc8Kz+YzIDyEkVHrGRhiztf5HZNU7ntT1W7DjFz+IsntW//lduScMXZQ9CpBsTz9U1gh3/SIA=
X-Received: by 2002:a7b:c742:: with SMTP id w2mr13062017wmk.61.1634729244322;
 Wed, 20 Oct 2021 04:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 20 Oct 2021 16:57:12 +0530
Message-ID: <CAAhSdy22y3gWM0Y9x7m84CdmtHKo7VsDC4+ZDY7+mhkJ9HcYyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: T-HEAD CLINT
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bin Meng <bmeng.cn@gmail.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 3:06 PM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
> not support 64bit mmio access to the MTIMER device.
>
> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
> restriction and the "sifive,cling0" compatible string. An OpenSBI
> patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
> is generally used in the devicetree schema for such a condition.
>
> As the design is not SiFive based it is preferable to apply a compatible
> string identifying T-HEAD instead.
>
> Add a new yaml file describing the T-HEAD CLINT.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> @Palmer, @Anup
> I copied you as maintainers from sifive,clint.yaml. Please, indicate if
> this should be changed.
>
> For the prior discussion see:
> https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
> https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/
>
> A release candidate of the ACLINT specification is available at
> https://github.com/riscv/riscv-aclint/releases

T-HEAD supporting only 32bit accesses to MTIME and MTIMECMP
registers are totally allowed. The RISC-V privileged specification does
not enforce RV64 platforms to support 64bit accesses to MTIME and
MTIMECMP registers. Also, the ACLINT specification only states
that MTIME and MTIMECMP registers are 64-bit wide but it does
not enforce platforms to support 64-bit accesses.

Here are some discussions from tech-aia mailing list:
https://lists.riscv.org/g/tech-aia/message/115
https://lists.riscv.org/g/tech-aia/message/119
https://lists.riscv.org/g/tech-aia/message/120

In other words, the T-HEAD CLINT (MTIMER+MSWI) is compliant
with the RISC-V ACLINT specification.

I think we should add implementation specific compatible strings
for Allwinner D1 in the ACLINT MTIMER and ACLINT MSWI
DT bindings.

How about including the following two compatible strings in
ACLINT DT bindings ?
allwinner,sun20i-d1-aclint-mtimer
allwinner,sun20i-d1-aclint-mswi

Regards,
Anup

> ---
>  .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/thead,clint.yaml b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> new file mode 100644
> index 000000000000..02463fb2043a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/thead,clint.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Core Local Interruptor
> +
> +maintainers:
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  T-HEAD (and other RISC-V) SOCs include an implementation of the T-HEAD
> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> +  interrupts. It directly connects to the timer and inter-processor interrupt
> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> +  interrupt controller is the parent interrupt controller for CLINT device.
> +  The clock frequency of the CLINT is specified via "timebase-frequency" DT
> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const:
> +          - allwinner,sun20i-d1-clint
> +      - const:
> +          - thead,clint0
> +
> +    description:
> +      Should be "<vendor>,<chip>-clint" and "thead,clint<version>" for
> +      the T-HEAD derived CLINTs.
> +      Supported compatible strings are -
> +      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC
> +      and "thead,clint0" for the T-HEAD IP block with no chip
> +      integration tweaks.
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    timer@2000000 {
> +      compatible = "allwinner,sun20i-d1-clint", "thead,clint0";
> +      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> +                             &cpu2intc 3 &cpu2intc 7
> +                             &cpu3intc 3 &cpu3intc 7
> +                             &cpu4intc 3 &cpu4intc 7>;
> +       reg = <0x2000000 0x10000>;
> +    };
> +...
> --
> 2.32.0
>
