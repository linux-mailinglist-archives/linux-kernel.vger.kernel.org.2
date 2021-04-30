Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6837016E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhD3Tpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:45:32 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38731 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhD3Tp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:45:28 -0400
Received: by mail-oi1-f180.google.com with SMTP id d25so33574900oij.5;
        Fri, 30 Apr 2021 12:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbQQRQSYYNb4Hamcnl+TDiVyJMNuMwmcGfDu3YBv0tk=;
        b=Tcl3T5PIgbfGm+6oS6KINgpRwAnCRVLVUXOmNMi/JHozQMacqE97mWXiBJC6i0v1cp
         Yzstsrf4cM8l8NdL0pIRg+b5woqlasWgBB5o09+BFd+fiUkMTdRhhIY3BP0b0oogAoPh
         BLcpefcqS+FNNmQGa0iSY7W7pNjscGr8HPaFCpuL2xhq3sG2O5K2N4xGfjQXe/TKYgwS
         eSl6j78Tov3bhMxbPHEwkdzWyE6lFX6U/A0t6BjVI+gh6wbXY5hQOTkpPfHgzP/6Ck+3
         Kw0RiFcWHX5XqrgUHK8+7eKrzcWaAL9S8obYq4mk4k1OthtnIBMo5rVo5TlnfIp9T8xy
         U0aA==
X-Gm-Message-State: AOAM531kdp/cvUo6paFNBlhKuu6BG/uODB2dNJf2in+16LC77uV0yWI8
        xJQg62r7ky/CylqF48RCeg==
X-Google-Smtp-Source: ABdhPJztGli5TC5CkRdcCKaCbKgQsTL2TMovEyN2HfCyxTWUrWMsfyYqhHiiL7Jcxz9/GHnxaHjYLA==
X-Received: by 2002:aca:c68a:: with SMTP id w132mr12284029oif.130.1619811879354;
        Fri, 30 Apr 2021 12:44:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm904031oii.58.2021.04.30.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:44:38 -0700 (PDT)
Received: (nullmailer pid 3759998 invoked by uid 1000);
        Fri, 30 Apr 2021 19:44:37 -0000
Date:   Fri, 30 Apr 2021 14:44:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3
 glue
Message-ID: <20210430194437.GA3755541@robh.at.kernel.org>
References: <20210430031912.42252-1-samuel@sholland.org>
 <20210430031912.42252-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430031912.42252-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:19:11PM -0500, Samuel Holland wrote:
> The RST_BUS_XHCI reset line in the H6 affects both the DWC3 core and the
> USB3 PHY. This suggests the reset line controls the USB3 IP as a whole.
> Represent this by attaching the reset line to a glue layer device.

Does that really mean anything more than a shared reset? Doesn't the 
reset code support shared resets?

> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
> new file mode 100644
> index 000000000000..936b5c74043f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/allwinner,sun50i-h6-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner H6 DWC3 USB controller
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun50i-h6-dwc3
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  ranges: true
> +
> +  resets:
> +    maxItems: 1
> +
> +# Required child node:
> +
> +patternProperties:
> +  "^phy@[0-9a-f]+$":
> +    $ref: ../phy/allwinner,sun50i-h6-usb3-phy.yaml#
> +
> +  "^usb@[0-9a-f]+$":
> +    $ref: snps,dwc3.yaml#
> +
> +required:
> +  - compatible
> +  - ranges
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sun50i-h6-ccu.h>
> +    #include <dt-bindings/reset/sun50i-h6-ccu.h>
> +
> +    usb3: usb@5200000 {
> +        compatible = "allwinner,sun50i-h6-dwc3";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        resets = <&ccu RST_BUS_XHCI>;
> +
> +        dwc3: usb@5200000 {
> +            compatible = "snps,dwc3";
> +            reg = <0x05200000 0x10000>;
> +            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&ccu CLK_BUS_XHCI>,
> +                     <&ccu CLK_BUS_XHCI>,
> +                     <&rtc 0>;
> +            clock-names = "ref", "bus_early", "suspend";
> +            dr_mode = "host";
> +            phys = <&usb3phy>;
> +            phy-names = "usb3-phy";
> +        };
> +
> +        usb3phy: phy@5210000 {
> +            compatible = "allwinner,sun50i-h6-usb3-phy";
> +            reg = <0x5210000 0x10000>;
> +            clocks = <&ccu CLK_USB_PHY1>;
> +            resets = <&ccu RST_USB_PHY1>;
> +            #phy-cells = <0>;
> +        };
> +    };
> -- 
> 2.26.3
> 
