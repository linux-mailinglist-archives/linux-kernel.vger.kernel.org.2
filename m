Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A750D43809C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJVX2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:28:05 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:35542 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:28:04 -0400
Received: by mail-oi1-f179.google.com with SMTP id r6so6967804oiw.2;
        Fri, 22 Oct 2021 16:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJIKzHbNa5Q6Kgv4zcjqMqYyRHFLYKoh+406+sN2Wpk=;
        b=44ZqDGhkmPiY1GLxdwv9P2Qo8UBNLkzISHoq9Mzwq5bd4kQDheTQrydR8hWw7M/VbV
         kcfwU0yjYjelIcS0UqeCiwZ99M2WV1lPMlbGGeawxtncYjhvdxQjljMAV5+5t71D+cd4
         oIBL5kvDUwU4D3pMXHV0FCa+FdPuMEYG50fLhw7l0IM5Fg6BCRFo2sKc0rgL3oLB12ev
         jGxwQmFnYvANUQ1weecIVNh30kvTXuk/PTQ0FZjSa3AubDgQ1+DjRgX2bHWA6+p6/AC1
         Zjv181c2jkYPGKYlCGHPdWvJbhZPhjWwZIw0/MpiokGw/WABtW4KBbb7Opa7FQoubBYS
         AykA==
X-Gm-Message-State: AOAM531neAi0cjvSrvwSJLg+q/qwZXthM3J/fNldlTOvYQwfjjKISoWV
        L2o3g3RPhlWgNUeBrURQ7G4KLDgnCw==
X-Google-Smtp-Source: ABdhPJwvDusrDJl16j2C08MQxaNkm2tLDMN9BUSRqSnOKvG6XCsPMqo4liaFJL4zjqs6rm4ABdCdFg==
X-Received: by 2002:a05:6808:138d:: with SMTP id c13mr12549319oiw.60.1634945145948;
        Fri, 22 Oct 2021 16:25:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c24sm499654oih.41.2021.10.22.16.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 16:25:45 -0700 (PDT)
Received: (nullmailer pid 3365511 invoked by uid 1000);
        Fri, 22 Oct 2021 23:25:44 -0000
Date:   Fri, 22 Oct 2021 18:25:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     qinjian <qinjian@cqplus1.com>
Cc:     tglx@linutronix.de, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: interrupt-controller: Add bindings for
 SP7021 interrupt controller
Message-ID: <YXNIeDB8NdEmb41o@robh.at.kernel.org>
References: <20211022060737.281116-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022060737.281116-1-qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:07:37PM +0800, qinjian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>  .../sunplus,sp7021-intc.yaml                  | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  .../interrupt-controller/sp7021-intc.h        | 24 +++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
>  create mode 100644 include/dt-bindings/interrupt-controller/sp7021-intc.h
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> new file mode 100644
> index 000000000..73719f65b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sunplus,sp7021-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sunplus,sp7021-intc
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2

Looks like cell 1 is more than just 0-N hw irq numbers, so please 
describe the format of the cell.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupts references to primary interrupt controller

How many?

> +
> +  ext0-mask:
> +    description:
> +      cpu affinity of EXT_INT0.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 16
> +
> +  ext1-mask:
> +    description:
> +      cpu affinity of EXT_INT1.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 16

These need a vendor prefix.

This assumes the DT cpu numbering is 0-N which isn't the case on all 
architectures (Arm specifically).

> +
> +required:
> +  - compatible
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    intc: interrupt-controller@9c000780 {
> +        compatible = "sunplus,sp7021-intc";
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        reg = <0x9c000780 0x80>, <0x9c000a80 0x80>;
> +        interrupt-parent = <&gic>;
> +        interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>, /* EXT_INT0 */
> +                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>; /* EXT_INT1 */
> +        ext0-mask = <0xf>; /* core0-3 */
> +        ext1-mask = <0xe>; /* core1-3 */
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a78b1bbe..065da0846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2660,6 +2660,8 @@ M:	Qin Jian <qinjian@cqplus1.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> +F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
>  
>  ARM/Synaptics SoC support
>  M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> diff --git a/include/dt-bindings/interrupt-controller/sp7021-intc.h b/include/dt-bindings/interrupt-controller/sp7021-intc.h
> new file mode 100644
> index 000000000..8f36e262e
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/sp7021-intc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + *
> + *
> + * This header provides constants for the SP7021 INTC
> + */
> +
> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_SP7021_INTC_H
> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_SP7021_INTC_H
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/*
> + * Interrupt specifier cell 1.
> + * The flags in irq.h are valid, plus those below.
> + */
> +#define SP_INTC_EXT_INT0		0x00000
> +#define SP_INTC_EXT_INT1		0x01000
> +#define SP_INTC_EXT_INT_MASK	0xff000
> +#define SP_INTC_EXT_INT_SHFIT	12
> +
> +#endif
> -- 
> 2.33.1
> 
> 
