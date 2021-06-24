Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64003B371A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhFXTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:40:02 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:39525 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:40:00 -0400
Received: by mail-il1-f169.google.com with SMTP id o10so2594832ils.6;
        Thu, 24 Jun 2021 12:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWhye/6S8g9hGkNXlGHIocDBMqgPBs5Mtuh6KXd+3tY=;
        b=jxrJI4r7OcGQPSZXSl1K+tW26yjcwk95SAIafUljIHcXa+n9Zp9ofGGO9JSNd7dmtL
         kQ4k9OmcmAd3+caHoiYYVB2rqkT2D/k+IJgzrO2+fBFzZPKAjOogINah6te/YsqzXEVM
         j0E9jSyeCGBIYFycqF5HBzULWnWHcEheHdXPE0Fb8XUtHeedRRPXwSTN9bvUXXkwi4K/
         DvgBS0jNphwVW6AgUBIdN9Dmh5e6ny+7LQSwx9DVyIyGqymlGXKX6vx8QYvgfZekXNmD
         Ad0ZFq1peQJKQZ2X+arUZQ1becNF+29CKcvGfCAWsMZ27CVnCrsqtPeoCCGaxpRe4P2l
         wEdg==
X-Gm-Message-State: AOAM53085Y6B7JSQDib5tb5k2iPmhp59T/wGaUiR0MN/m9WSxL3Ohp/8
        YFIEkSoMzCyveTvGM2bmEA==
X-Google-Smtp-Source: ABdhPJwSd8/oiajVe2YqxqKTvKQy/jjMa32+1wKg7yUUaZPVJEVf6zw3457IUh+MYcOR6C1/0RkKgA==
X-Received: by 2002:a92:c686:: with SMTP id o6mr4676515ilg.278.1624563460923;
        Thu, 24 Jun 2021 12:37:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d194sm1544999iof.37.2021.06.24.12.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:37:39 -0700 (PDT)
Received: (nullmailer pid 1861539 invoked by uid 1000);
        Thu, 24 Jun 2021 19:37:35 -0000
Date:   Thu, 24 Jun 2021 13:37:35 -0600
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
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v1 09/10] dt-bindings: timer: Add ACLINT MSWI and
 SSWI bindings
Message-ID: <20210624193735.GA1847423@robh.at.kernel.org>
References: <20210612160422.330705-1-anup.patel@wdc.com>
 <20210612160422.330705-10-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612160422.330705-10-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 09:34:21PM +0530, Anup Patel wrote:
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

Don't write descriptions that should be schemas.

Is there no vendor or specific implementation yet?

You can write "pattern: '.*,.*-aclint-sswi$' as an entry with a comment 
to add specific compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  interrupts-extended:
> +    minItems: 1

maxItems? 

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

format as: <&cpu1intc 3>, <&cpu2intc 3>, <&cpu3intc 3>, <&cpu4intc 3>

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
> -- 
> 2.25.1
> 
> 
