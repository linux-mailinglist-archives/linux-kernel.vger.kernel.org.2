Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4333167A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCHSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:46:10 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:40552 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCHSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:46:00 -0500
Received: by mail-io1-f47.google.com with SMTP id i8so11063296iog.7;
        Mon, 08 Mar 2021 10:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfN5Nej69V/evaH4omPvCJozqJ9O6z93Ztcf2j8ULsI=;
        b=PPVV1i1ozxeHPC4GhaHw5N7vq54JxcY6DdBxneSh4KazRqm0ip9r3Re4fJdWe7V0e7
         FyRMZS8mlvN3FLNp8fjvElBPqxNcYielW96FP2y1DFYorckb0a/OqiZ/UJBqUdaulYE6
         IipdDGk7B3jlPZ/ht+b5dBirV9/41sdsqr9z0pFtYxuv0+FJeb04UrdUA/CDSRvNf8gG
         9GmBzIXri/xJ69XP4Xcj5cV0f/p4rSWli440AjhN5q+kVNJZOQP2BEOHRBNspnIEP56/
         jA22VlUzTSpwKd+xHdbkQ8A4NsOiCYBgDbTJjdQ1Ft0tuXjYCRcZZitYqaSBaxpCZlyU
         mu/w==
X-Gm-Message-State: AOAM532NcguSwlZsLMPAYzRTdt00pCgTDuCvsbxQoADixHgkCFaX/hP+
        YI1Afh25pDUM89nvB9W+eQ==
X-Google-Smtp-Source: ABdhPJyNM4ptLtRG6sZBwmYG4Kd5v3RNbnKIqIvBMtZLDZ7DZtcfjwttUS2uXhxKILLlZEV5+4uJAA==
X-Received: by 2002:a02:817:: with SMTP id 23mr24482608jac.23.1615229159689;
        Mon, 08 Mar 2021 10:45:59 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y11sm6330111ilv.64.2021.03.08.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:45:59 -0800 (PST)
Received: (nullmailer pid 2770740 invoked by uid 1000);
        Mon, 08 Mar 2021 18:45:57 -0000
Date:   Mon, 8 Mar 2021 11:45:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: mchp-eic: add bindings
Message-ID: <20210308184557.GA2768020@robh.at.kernel.org>
References: <20210302102846.619980-1-claudiu.beznea@microchip.com>
 <20210302102846.619980-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302102846.619980-2-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:28:45PM +0200, Claudiu Beznea wrote:
> Add DT bindings for Microchip External Interrupt Controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../interrupt-controller/mchp,eic.yaml        | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml
> new file mode 100644
> index 000000000000..5a927817aa7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mchp,eic.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/mchp,eic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip External Interrupt Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  This interrupt controller is found in Microchip SoCs (SAMA7G5) and provides
> +  support for handling up to 2 external interrupt lines.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sama7g5-eic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 3
> +    description:
> +      The first cell is the input IRQ number (between 0 and 1), the second cell
> +      is the trigger type as defined in interrupt.txt present in this directory
> +      and the third cell is the glitch filter (1, 2, 4, 8) in clock cycles
> +
> +  'interrupts':

Don't need quotes here.

> +    description: |
> +      Contains the GIC SPI IRQs mapped to the external interrupt lines. They
> +      should be specified sequentially from output 0 to output 1.
> +    minItems: 2
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - 'interrupts'

Or here.

> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    eic: eic@e1628000 {

interrupt-controller@...

> +      compatible = "microchip,sama7g5-eic";
> +      reg = <0xe1628000 0x100>;
> +      interrupt-parent = <&gic>;
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
> +      clock-names = "pclk";
> +    };
> +
> +...
> -- 
> 2.25.1
> 
