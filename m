Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD643FD0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbhIABZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:25:27 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41482 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhIABZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:25:26 -0400
Received: by mail-oi1-f179.google.com with SMTP id 6so1701136oiy.8;
        Tue, 31 Aug 2021 18:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJN6Yn8anNyePkxZIH0sbBuDiAsFTMzSe4iTlv6qQOw=;
        b=UcF5h2S4wQ2ehCmS+UrKDubR6LFS2AlMwO11VYeTvh6xJ+o46bQj5yTTauQk/puFaF
         jpi6xe8iEWIkx+YsqhNNPIUE3Pmu4flbLNbz/51QaJRZeHw5UQopR9cKO4zo+Y6huDzz
         dkBlSbwMDWIlrQk+Ei4NGTfSREiVvyyOmIznDAboLxl3P8e5w5mQY5QbxoBSgLRRLuTQ
         JlCbQQ0J9L1knB7dv8lrsUd7W1WW4hDX+Tqsmx2Z0MtRtER+fVlAOl3rZC54+dp/XYTw
         dW1gKII0Ff+MdX16lS/0YNjGB5eCV48hUe27FFYzCh8kP5sOvUPOce4F02aK8Z9+9DO7
         RAwQ==
X-Gm-Message-State: AOAM5305g5o7fPtG40+FNRxtRmtlrrxN9FyDaM2coVEIKqhL8MKmQHRi
        V0C11F7Iqo5LdFqZcUCdGQ==
X-Google-Smtp-Source: ABdhPJyvzKX814iG5ZL8LMATnBzH0VmFI/oubUGGa/PHFQpVoPJj+dYVcpNcvUnZWp34KIDDfP1J1w==
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr5361611oig.152.1630459469893;
        Tue, 31 Aug 2021 18:24:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k23sm4055216ood.12.2021.08.31.18.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:24:29 -0700 (PDT)
Received: (nullmailer pid 990302 invoked by uid 1000);
        Wed, 01 Sep 2021 01:24:28 -0000
Date:   Tue, 31 Aug 2021 20:24:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [RFC PATCH v3 05/11] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
Message-ID: <YS7WTPRYJWnPu2ii@robh.at.kernel.org>
References: <20210830041729.237252-1-anup.patel@wdc.com>
 <20210830041729.237252-6-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830041729.237252-6-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 09:47:23AM +0530, Anup Patel wrote:
> We add DT bindings documentation for the ACLINT MSWI and SSWI
> devices found on RISC-V SOCs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> new file mode 100644
> index 000000000000..68563259ae24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> @@ -0,0 +1,95 @@
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
> +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
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
> +    oneOf:
> +      - items:
> +        - enum:
> +          - riscv,aclint-mswi
> +
> +      - items:
> +        - enum:
> +          - riscv,aclint-sswi

All this can be just:

enum:
  - riscv,aclint-mswi
  - riscv,aclint-sswi

However...

> +
> +    description:
> +      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
> +      "<vendor>,<chip>-aclint-mswi".
> +      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
> +      "<vendor>,<chip>-aclint-sswi".

s/OR/AND/

There must be a compatible for the implementation. Unless RiscV 
implementations of specs are complete describing all clocks, power 
domains, resets, etc. and are quirk free.

But don't write free form constraints...


> +
> +  reg:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4095
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
> +      interrupts-extended = <&cpu1intc 3>,
> +                            <&cpu2intc 3>,
> +                            <&cpu3intc 3>,
> +                            <&cpu4intc 3>;
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
> +      interrupts-extended = <&cpu1intc 1>,
> +                            <&cpu2intc 1>,
> +                            <&cpu3intc 1>,
> +                            <&cpu4intc 1>;
> +      reg = <0x2100000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
