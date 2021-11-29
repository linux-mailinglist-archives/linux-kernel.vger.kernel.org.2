Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B364460C42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376817AbhK2Bcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:32:43 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44977 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhK2Bam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:30:42 -0500
Received: by mail-ot1-f45.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso23255768otj.11;
        Sun, 28 Nov 2021 17:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/CrGecYUeDdR6r8+yA6oPN9sOdPcqSzyh2oQnkTLSY=;
        b=uEMJkfwYndC//ME2UkvJdAU74efgXNv48Y94FZYU4UNSpXxA+IEvNcN+qNFN1skwbE
         FvLFYx+0YiA83o8W0upQEP8knx+tWuP9Sgjym+BsohkjhmhluWCORHBvx75Ckw6lY57n
         N3XFyI/IKd+HkdGaiVvQEQyrE67iwVoEky6wkpJCfHM01zg28E66jaikKiQokR29pZx0
         8Q0c8FpnIJm5Ln6VuzwbCXxGgQQcrTf9hLI0+WfdmOowc92cGNfwnFVA1szQgFwZkVUL
         PHH0TRflYgk860I+RdWlX0efdJsO2etja17pXn7fUSsQfz2WLr06IQflVrbSC563D+Oy
         byYw==
X-Gm-Message-State: AOAM5316l+XKyLMcQHjkq5mQK71P9LpEd+8YDMgBD3zArW9JBCRLQxUs
        rvmZoYViXYkedmLWWYStVQ==
X-Google-Smtp-Source: ABdhPJxtuA+XfiWbawu7ZYKFsEv0Yo/JLTV8PehfvEcgdrBvReHgoIMJZMl5z7pxb0xzUVz0dkYoPA==
X-Received: by 2002:a9d:75d7:: with SMTP id c23mr43552829otl.181.1638149244994;
        Sun, 28 Nov 2021 17:27:24 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id bi20sm2734070oib.29.2021.11.28.17.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:27:24 -0800 (PST)
Received: (nullmailer pid 2973705 invoked by uid 1000);
        Mon, 29 Nov 2021 01:27:20 -0000
Date:   Sun, 28 Nov 2021 19:27:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add Apple dwc3 bindings
Message-ID: <YaQseO5kF71vABji@robh.at.kernel.org>
References: <20211108170946.49689-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108170946.49689-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 06:09:45PM +0100, Sven Peter wrote:
> Apple Silicon SoCs such as the M1 have multiple USB controllers based on
> the Synopsys DesignWare USB3 controller.
> References to the ATC PHY required for SuperSpeed are left out for now
> until support has been upstreamed as well.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>  - added apple,dwc3 bindings instead of a property for the reset quirk
>    as requested by robh
> 
> I think I have to use GPL-2.0 for this binding since it's based
> on and references snps,dwc3.yaml which is also only GPL-2.0.
> Otherwise I'd be fine with the usual GPL/BSD dual license as well.
> 
>  .../devicetree/bindings/usb/apple,dwc3.yaml   | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/apple,dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
> new file mode 100644
> index 000000000000..fb3b3489e6b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Silicon DWC3 USB controller
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description:
> +  On Apple Silicon SoCs such as the M1 each Type-C port has a corresponding
> +  USB controller based on the Synopsys DesignWare USB3 controller.
> +
> +  The common content of this binding is defined in snps,dwc3.yaml.
> +
> +allOf:
> +  - $ref: snps,dwc3.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: apple,dwc3

This needs to list all possible compatibles except snps,dwc3 so the 
schema is applied for any incorrect mixture of compatibles.

> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-dwc3
> +          - apple,t6000-dwc3
> +      - const: apple,dwc3
> +      - const: snps,dwc3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    usb@82280000 {
> +      compatible = "apple,t8103-dwc3", "apple,dwc3", "snps,dwc3";
> +      reg = <0x82280000 0x10000>;
> +      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      dr_mode = "otg";
> +      usb-role-switch;
> +      role-switch-default-mode = "host";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd441dde..03e7cc48877a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1724,6 +1724,7 @@ T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
> -- 
> 2.25.1
> 
> 
