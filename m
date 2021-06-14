Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC23A6804
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhFNNgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhFNNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:36:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F256C061574;
        Mon, 14 Jun 2021 06:34:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h15so15402521ybm.13;
        Mon, 14 Jun 2021 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqPPaC0AVXMJ3H5esYJa9y/dYjMnHXQGcgEzhU5z3t8=;
        b=UG/HrtRLM0fhcNimkNz1NG4ePk8jTvq2Wa4dDhbl5S9zOZVd45EM0N31w9tl+P63VU
         7TxbCribIVyMwIYckPAkxbIHcakglCox3IJH7RP13oY1Mkz412y2JVkhnasuUJTONVZA
         ETRYL0DgsH15hn+4KAmPp3ryTBpf3JZWlU8A1ZdbEsaFrLzO0HIV9boKMXRaRgmYF8Gu
         boN6a7XM/sKK5KUFirR47JNC6WKMNFXGY6UK+HB3qnIJPW0x053jP+ut0q9CcKyI1BDz
         bXi3urkhimgV9TQij97TQuv3U04fnzrsXvVRltN2M6l3gw2H5NXepNdP7Yjxisa9zQUn
         kJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqPPaC0AVXMJ3H5esYJa9y/dYjMnHXQGcgEzhU5z3t8=;
        b=nDgNefGqv+mhMoNV0IDRPJnlGoY3KCIZ5oWCaLjahmgyxVCrPrWGLsqn7YG0v8MS+r
         Hgt5qAE6U3EUR4e16LQtGD4XcfRXhv+qmVPaip6Q1kRx5AK5lw4TWOM1jEh1vxwVkhxp
         P7KzzUT8HCXUT21bhb57LXJmiXnBDRFTuOMOjni7SidYGN6jtMDB7GQ1IFwGMFRfnojO
         jaedeAwmDeOCHmQO9w32e7BRIvr9u8Hj7ZCr2EQyy3NdnLC+WRf/K+hcZu8tKRnqPtJY
         yUXYni+DSg+D+dqMqRhZTiwrRy5rAUsYc7oMlINPHUKIA6hvNX/jsIdPGDEcaRrxzBSN
         K5mQ==
X-Gm-Message-State: AOAM531b7L6IK97zSTaCU13bfFIn6ZV3Ug4cczvO3TLiTCjQxB99w66d
        xGDp3J4wH9A24ohObT2lO3TYaSnFB9ae/KJ2RMvP/CAC
X-Google-Smtp-Source: ABdhPJz3CmO4ZnGWstNHNNqRLhvlWMTKOp0WViJjbD4gJARSVgF3aZiCem4kIuPeaiVTACVQnZRB2c+FEk7jk60E/Ko=
X-Received: by 2002:a25:2e43:: with SMTP id b3mr24811303ybn.152.1623677664281;
 Mon, 14 Jun 2021 06:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-10-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-10-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:34:12 +0800
Message-ID: <CAEUhbmXyBZsLJk=cehz504j1funGwwORKxhbhf-WyVV1Su5ZJw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 09/10] dt-bindings: timer: Add ACLINT MSWI and SSWI bindings
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:08 AM Anup Patel <anup.patel@wdc.com> wrote:
>

The commit title should say "interrupt-controller" instead of "timer"

> We add DT bindings documentation for the ACLINT MSWI and SSWI
> devices found on RISC-V SOCs.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../riscv,aclint-swi.yaml                     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> new file mode 100644
> index 000000000000..bed15411c18f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V ACLINT Software Interrupt Devices
> +
> +maintainers:
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  RISC-V SOCs include an implementation of the M-level software interrupt
> +  (MSWI) device and the S-level software interrupt (SSWI) device defined
> +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
> +
> +  The ACLINT MSWI (and SSWI) devices are documented in the RISC-V ACLINT

nits: please remove the ( )

> +  specification located at
> +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> +
> +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
> +  S-level software interrupt lines of various HARTs (or CPUs) respectively
> +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
> +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - riscv,aclint-mswi
> +          - riscv,aclint-sswi
> +
> +    description:
> +      Should be "<vendor>,<chip>-aclint-mswi" and "riscv,aclint-mswi" OR
> +      "<vendor>,<chip>-aclint-sswi" and "riscv,aclint-sswi".
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  interrupts-extended:
> +    minItems: 1
> +
> +  interrupt-controller: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    // Example 1 (RISC-V MSWI device used by Linux RISC-V NoMMU kernel):
> +
> +    interrupt-controller@2000000 {
> +      compatible = "riscv,aclint-mswi";
> +      interrupts-extended = <&cpu1intc 3 &cpu2intc 3 &cpu3intc 3 &cpu4intc 3>;
> +      reg = <0x2000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +    };
> +
> +  - |
> +    // Example 2 (RISC-V SSWI device used by Linux RISC-V MMU kernel):
> +
> +    interrupt-controller@2100000 {
> +      compatible = "riscv,aclint-sswi";
> +      interrupts-extended = <&cpu1intc 1 &cpu2intc 1 &cpu3intc 1 &cpu4intc 1>;
> +      reg = <0x2100000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +    };
> +...

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
