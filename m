Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07C4390B74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhEYV3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:29:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46483 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEYV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:29:13 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7FA91FF802;
        Tue, 25 May 2021 21:27:40 +0000 (UTC)
Date:   Tue, 25 May 2021 23:27:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: rtc: nxp,pcf8563: Convert to DT schema
Message-ID: <YK1rzHSXC7rNpCpC@piout.net>
References: <20210518232858.1535403-1-robh@kernel.org>
 <20210518232858.1535403-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518232858.1535403-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 18/05/2021 18:28:54-0500, Rob Herring wrote:
> Convert the Philips PCF8563/Epson RTC8564 binding to DT schema format.
> 
> Add 'interrupts' as this device has an interrupt which was not
> documented, but in use.
> 

It also supports start-year from rtc.yaml.

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 50 +++++++++++++++++++
>  .../devicetree/bindings/rtc/pcf8563.txt       | 29 -----------
>  2 files changed, 50 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> new file mode 100644
> index 000000000000..15e67be0ef95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,pcf8563.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Philips PCF8563/Epson RTC8564 Real Time Clock
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - epson,rtc8564
> +      - microcrystal,rv8564
> +      - nxp,pcf8563
> +      - nxp,pca8565
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@51 {
> +            compatible = "nxp,pcf8563";
> +            reg = <0x51>;
> +            #clock-cells = <0>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
> deleted file mode 100644
> index 0a900f7c8977..000000000000
> --- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -* Philips PCF8563/Epson RTC8564 Real Time Clock
> -
> -Philips PCF8563/Epson RTC8564 Real Time Clock
> -
> -Required properties:
> -- compatible: Should contain "nxp,pcf8563",
> -	"epson,rtc8564" or
> -	"microcrystal,rv8564" or
> -	"nxp,pca8565"
> -- reg: I2C address for chip.
> -
> -Optional property:
> -- #clock-cells: Should be 0.
> -- clock-output-names:
> -  overwrite the default clock name "pcf8563-clkout"
> -
> -Example:
> -
> -pcf8563: pcf8563@51 {
> -	compatible = "nxp,pcf8563";
> -	reg = <0x51>;
> -	#clock-cells = <0>;
> -};
> -
> -device {
> -...
> -	clocks = <&pcf8563>;
> -...
> -};
> -- 
> 2.27.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
