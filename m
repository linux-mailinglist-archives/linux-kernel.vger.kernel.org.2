Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E785D31734F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBJW1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:27:45 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44339 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:27:41 -0500
Received: by mail-oi1-f178.google.com with SMTP id r75so3896215oie.11;
        Wed, 10 Feb 2021 14:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9TC4esxc+xfZ+c0X7hu9IPnSeq6h5D3GimauTtA6CI=;
        b=eE1JpQ9rpRTBhqDLlBvc8MFFUClqnf8RzyBsp2E+zuZGgPj0nLlfUvq/b3Gn7lsPjc
         /R85nzzNjqtEqkjVXRWWoTWT0QgbOFI45fkIovfh5axF/Q8WYKy9odYE5mtOIfSJ0Gx6
         Bstl9967+7suTNCv829gmlar5SnX04yC1WRYwo2tXi3Id7g4qZGX22iqiD6tD1CDk/4k
         F1Qi9HztWRmEIYdZPpGf7OUZJ1UmtunFaNRi8JXFAIDuFiY7yQHPSU+31jVKUPPJj0eW
         8OOjQpTCR/ggURlUXCie+m+LCKyQWawoGWrKJhN642QrjBKjXsSZwLzMmBp7XF7W+sFY
         5C3A==
X-Gm-Message-State: AOAM533biR3xuKQYqXNjvtSwbfnHZsiGrvhIm2vpB+dzg9xb4qEMyoYr
        ZjPFwqFfqFw2R0oaFC0PIQ==
X-Google-Smtp-Source: ABdhPJyhbITafpylWo59tDvDK8qPhE9mMpcG59cDZyK9lB/d60Ay75Fxuyb+WkQU2JX3kHrTnrZrBQ==
X-Received: by 2002:a05:6808:649:: with SMTP id z9mr836073oih.154.1612996019876;
        Wed, 10 Feb 2021 14:26:59 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 203sm752187oie.14.2021.02.10.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:26:58 -0800 (PST)
Received: (nullmailer pid 2918770 invoked by uid 1000);
        Wed, 10 Feb 2021 22:26:57 -0000
Date:   Wed, 10 Feb 2021 16:26:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net, devicetree@vger.kernel.org
Subject: Re: [RFC/PATCH v2 01/16] dt-bindings: soc: bcm: bcm2835-pm: Convert
 bindings to DT schema
Message-ID: <20210210222657.GA2911555@robh.at.kernel.org>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
 <20210209125912.3398-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209125912.3398-2-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:58:57PM +0100, Nicolas Saenz Julienne wrote:
> This converts the brcm,bcm2835-pm bindings from text to proper schema.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 -----------
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> deleted file mode 100644
> index 72ff033565e5..000000000000
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -BCM2835 PM (Power domains, watchdog)
> -
> -The PM block controls power domains and some reset lines, and includes
> -a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
> -binding which covered some of PM's register range and functionality.
> -
> -Required properties:
> -
> -- compatible:		Should be "brcm,bcm2835-pm"
> -- reg:			Specifies base physical address and size of the two
> -			  register ranges ("PM" and "ASYNC_BRIDGE" in that
> -			  order)
> -- clocks:		a) v3d: The V3D clock from CPRMAN
> -			b) peri_image: The PERI_IMAGE clock from CPRMAN
> -			c) h264: The H264 clock from CPRMAN
> -			d) isp: The ISP clock from CPRMAN
> -- #reset-cells: 	Should be 1.  This property follows the reset controller
> -			  bindings[1].
> -- #power-domain-cells:	Should be 1.  This property follows the power domain
> -			  bindings[2].
> -
> -Optional properties:
> -
> -- timeout-sec:		Contains the watchdog timeout in seconds
> -- system-power-controller: Whether the watchdog is controlling the
> -    system power.  This node follows the power controller bindings[3].
> -
> -[1] Documentation/devicetree/bindings/reset/reset.txt
> -[2] Documentation/devicetree/bindings/power/power-domain.yaml
> -[3] Documentation/devicetree/bindings/power/power-controller.txt
> -
> -Example:
> -
> -pm {
> -	compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
> -	#power-domain-cells = <1>;
> -	#reset-cells = <1>;
> -	reg = <0x7e100000 0x114>,
> -	      <0x7e00a000 0x24>;
> -	clocks = <&clocks BCM2835_CLOCK_V3D>,
> -		 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
> -		 <&clocks BCM2835_CLOCK_H264>,
> -		 <&clocks BCM2835_CLOCK_ISP>;
> -	clock-names = "v3d", "peri_image", "h264", "isp";
> -	system-power-controller;
> -};
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> new file mode 100644
> index 000000000000..8bc65e5f62a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-pm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: BCM2835 PM (Power domains, watchdog)
> +
> +description: |
> +  The PM block controls power domains and some reset lines, and includes a
> +  watchdog timer.
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> +
> +allOf:
> +  - $ref: ../../watchdog/watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm2835-pm
> +      - const: brcm,bcm2835-pm-wdt

Odd...

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: Specifies base physical address and size of the two register
> +                 ranges, "PM" and "ASYNC_BRIDGE" in that order.

The number, what they are and order are captured with:

items:
  - description: PM registers
  - description: ASYNC_BRIDGE registers

'Specifies base physical address and size' is every 'reg'.

> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: v3d
> +      - const: peri_image
> +      - const: h264
> +      - const: isp
> +
> +  system-power-controller:
> +    type: boolean
> +
> +  timeout-sec: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - "#reset-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +
> +    watchdog@7e100000 {
> +        compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
> +        #power-domain-cells = <1>;
> +        #reset-cells = <1>;
> +        reg = <0x7e100000 0x114>,
> +              <0x7e00a000 0x24>;
> +        clocks = <&clocks BCM2835_CLOCK_V3D>,
> +        	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
> +        	 <&clocks BCM2835_CLOCK_H264>,
> +        	 <&clocks BCM2835_CLOCK_ISP>;
> +        clock-names = "v3d", "peri_image", "h264", "isp";
> +        system-power-controller;
> +    };
> -- 
> 2.30.0
> 
