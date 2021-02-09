Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD2315C33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhBJB1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:27:07 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33981 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhBIXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:08:59 -0500
Received: by mail-ot1-f41.google.com with SMTP id y11so116589otq.1;
        Tue, 09 Feb 2021 15:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flen+Q6BhqZvu5yUFGM567078RbssUkrmoOHzn1oN0E=;
        b=QN+qnROo6+hpHjnHK3QRCYoMDXDGYhJkCpWx8n8rZT21XMdK0LBl27wprmc0cmDlzN
         1aZrQeEzgVjVM9PfzmHHUW320qqpwc7HLqiLwY3UgS8fh7GHHU1F8shtHPBKoUwhO6wB
         l90ujsBEOFNf5n/498JfPwbHQJoOUy9OjCT7Wi+q+n1OlzdYeTG/S01OSXhS1vrkiZLa
         HC5nrPETWFfzK/W4kvgezVOL4jL0tnAt03msMPiCA1+gHqkruIuxqVMz4qc7fpnkEs3i
         vLaP/sJFWfrH5eOSKPw+mvzJgHXkeYm7jSiH1dLtFtSh4vtHggGFq/WRjcSgx3HPitWm
         ed4g==
X-Gm-Message-State: AOAM532uxxPgnwt7mpiFw0m8muRhhOYtJRiLeXw/rkfo62JVq3RnRlJG
        39qCTNBiWQIKRPBoY6n/Lmu28tygqw==
X-Google-Smtp-Source: ABdhPJwxZgOwm8lVG9U+3qOA69ztcXYK2Xdl9Kak65G3myAMYyBpwcpvQOGW8ZWCWZU9eSatBKyzZg==
X-Received: by 2002:a9d:61d1:: with SMTP id h17mr6253otk.113.1612912056647;
        Tue, 09 Feb 2021 15:07:36 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g66sm2454otg.54.2021.02.09.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:07:35 -0800 (PST)
Received: (nullmailer pid 398853 invoked by uid 1000);
        Tue, 09 Feb 2021 23:07:34 -0000
Date:   Tue, 9 Feb 2021 17:07:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 14/18] dt-bindings: interrupt-controller: Add DT bindings
 for apple-aic
Message-ID: <20210209230734.GA387609@robh.at.kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-15-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204203951.52105-15-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:47AM +0900, Hector Martin wrote:
> AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
> the M1.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../interrupt-controller/AAPL,aic.yaml        | 88 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  .../interrupt-controller/apple-aic.h          | 14 +++
>  3 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
>  create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
> new file mode 100644
> index 000000000000..7e119614275a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/AAPL,aic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Interrupt Controller
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  The Apple Interrupt Controller is a simple interrupt controller present on
> +  Apple ARM SoC platforms, including various iPhone and iPad devices and the
> +  "Apple Silicon" M1 Macs.
> +
> +  It provides the following features:
> +
> +  - Level-triggered hardware IRQs wired to SoC blocks
> +    - Single mask bit per IRQ
> +    - Per-IRQ affinity setting
> +    - Automatic masking on event delivery (auto-ack)
> +    - Software triggering (ORed with hw line)
> +  - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable
> +    if not symmetric)
> +  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
> +    higher priority)
> +  - Automatic masking on ack
> +  - Default "this CPU" register view and explicit per-CPU views
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - AAPL,aic
> +        - AAPL,m1-aic

Instead of 'contains', this should be:

items:
  - const: AAPL,m1-aic
  - const: AAPL,aic

With 'apple' instead...

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 3
> +    description: |
> +      The 1st cell contains the interrupt type:
> +        - 0: Hardware IRQ
> +        - 1: FIQ
> +        - 2: IPI
> +
> +      The 2nd cell contains the interrupt number.
> +        - HW IRQs: interrupt number
> +        - FIQs:
> +          - 0: physical timer
> +          - 1: virtual timer
> +        - IPIs:
> +          - 0: normal/"other" IPI (used interanlly for virtual IPIs)
> +          - 1: self IPI (normally unused)
> +
> +      The 3rd cell contains the interrupt flags. This is normally
> +      IRQ_TYPE_LEVEL_HIGH (4).
> +
> +  reg:
> +    description: |
> +      Specifies base physical address and size of the AIC registers.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - reg
> +
> +unevaluatedProperties: false

additionalProperties: false

(stricter and actually has support implemented)

> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        aic: interrupt-controller@23b100000 {
> +            compatible = "AAPL,m1-aic", "AAPL,aic";
> +            #interrupt-cells = <3>;
> +            interrupt-controller;
> +            reg = <0x2 0x3b100000 0x0 0x8000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91a7b33834ac..f3d4661731c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1634,6 +1634,8 @@ B:	https://github.com/AsahiLinux/linux/issues
>  C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/AAPL.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
> +F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  
>  ARM/ARTPEC MACHINE SUPPORT
>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
> new file mode 100644
> index 000000000000..f54dc0cd6e9a
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/apple-aic.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#define AIC_IRQ 0
> +#define AIC_FIQ 1
> +#define AIC_IPI 2
> +
> +#define AIC_TMR_PHYS 0
> +#define AIC_TMR_VIRT 1
> +
> +#endif
> -- 
> 2.30.0
> 
