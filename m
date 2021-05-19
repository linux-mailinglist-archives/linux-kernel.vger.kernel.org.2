Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D342B388465
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhESBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:25:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33248 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:25:14 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BB8345E;
        Wed, 19 May 2021 03:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621387434;
        bh=HljQChIhkVo4pe3W9ud6GlqIPtBeP9G9bRZDvmIfjgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDQDxMNRiwA9H3B/7NHwAuM9AsqiIBkRx+nWxEUj1qfdqvcUwgJiwICPWmzmbGKIX
         ZOHQDuvbEugkcRk2Eq2djm96PbMIF+ssJXGqMejf7hdOCYeCbD1lh21Ru+00f4nxQZ
         qGHHQ8H5eXrZ4TGKxtskjCDAseq5MPYzYb+SysQI=
Date:   Wed, 19 May 2021 04:23:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: i2c: i2c-mux-pca954x: Convert to DT
 schema
Message-ID: <YKRoqaQaz9QSMVqg@pendragon.ideasonboard.com>
References: <20210518232858.1535403-1-robh@kernel.org>
 <20210518232858.1535403-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518232858.1535403-6-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Tue, May 18, 2021 at 06:28:57PM -0500, Rob Herring wrote:
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/i2c/i2c-mux-pca954x.txt          |  74 ------------
>  .../bindings/i2c/i2c-mux-pca954x.yaml         | 106 ++++++++++++++++++
>  2 files changed, 106 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> deleted file mode 100644
> index 9f3f3eb67e87..000000000000
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -* NXP PCA954x I2C bus switch
> -
> -The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> -
> -Required Properties:
> -
> -  - compatible: Must contain one of the following.
> -    "nxp,pca9540",
> -    "nxp,pca9542",
> -    "nxp,pca9543",
> -    "nxp,pca9544",
> -    "nxp,pca9545",
> -    "nxp,pca9546", "nxp,pca9846",
> -    "nxp,pca9547", "nxp,pca9847",
> -    "nxp,pca9548", "nxp,pca9848",
> -    "nxp,pca9849"
> -
> -  - reg: The I2C address of the device.
> -
> -  The following required properties are defined externally:
> -
> -  - Standard I2C mux properties. See i2c-mux.txt in this directory.
> -  - I2C child bus nodes. See i2c-mux.txt in this directory.
> -
> -Optional Properties:
> -
> -  - reset-gpios: Reference to the GPIO connected to the reset input.
> -  - idle-state: if present, overrides i2c-mux-idle-disconnect,
> -    Please refer to Documentation/devicetree/bindings/mux/mux-controller.yaml
> -  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
> -    children in idle state. This is necessary for example, if there are several
> -    multiplexers on the bus and the devices behind them use same I2C addresses.
> -  - interrupts: Interrupt mapping for IRQ.
> -  - interrupt-controller: Marks the device node as an interrupt controller.
> -  - #interrupt-cells : Should be two.
> -    - first cell is the pin number
> -    - second cell is used to specify flags.
> -    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -Example:
> -
> -	i2c-switch@74 {
> -		compatible = "nxp,pca9548";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0x74>;
> -
> -		interrupt-parent = <&ipic>;
> -		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -
> -		i2c@2 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <2>;
> -
> -			eeprom@54 {
> -				compatible = "atmel,24c08";
> -				reg = <0x54>;
> -			};
> -		};
> -
> -		i2c@4 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <4>;
> -
> -			rtc@51 {
> -				compatible = "nxp,pcf8563";
> -				reg = <0x51>;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> new file mode 100644
> index 000000000000..82d9101098c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PCA954x I2C bus switch
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +description:
> +  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-mux.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pca9540
> +      - nxp,pca9542
> +      - nxp,pca9543
> +      - nxp,pca9544
> +      - nxp,pca9545
> +      - nxp,pca9546
> +      - nxp,pca9547
> +      - nxp,pca9548
> +      - nxp,pca9849

I'd put this entry last to keep them alphabetically sorted.

While at it, could you add nxp,pca9646 as the driver supports it ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +      - nxp,pca9846
> +      - nxp,pca9847
> +      - nxp,pca9848
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  i2c-mux-idle-disconnect:
> +    type: boolean
> +    description: Forces mux to disconnect all children in idle state. This is
> +      necessary for example, if there are several multiplexers on the bus and
> +      the devices behind them use same I2C addresses.
> +
> +  idle-state:
> +    description: if present, overrides i2c-mux-idle-disconnect
> +    $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        i2c-mux@74 {
> +            compatible = "nxp,pca9548";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x74>;
> +
> +            interrupt-parent = <&ipic>;
> +            interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            i2c@2 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <2>;
> +
> +                eeprom@54 {
> +                    compatible = "atmel,24c08";
> +                    reg = <0x54>;
> +                };
> +            };
> +
> +            i2c@4 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <4>;
> +
> +                rtc@51 {
> +                    compatible = "nxp,pcf8563";
> +                    reg = <0x51>;
> +                };
> +            };
> +        };
> +    };
> +...

-- 
Regards,

Laurent Pinchart
