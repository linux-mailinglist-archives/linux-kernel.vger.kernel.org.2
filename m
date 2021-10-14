Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0511E42E2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJNU2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:28:15 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38854 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:28:14 -0400
Received: by mail-oi1-f171.google.com with SMTP id t4so10023184oie.5;
        Thu, 14 Oct 2021 13:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aHKQKohGHGpk/MatBTbP6XDKQvJpmcSe7qNkG6DZok=;
        b=1Y3I6kxTdDgWwvJNfZF7ZO05/wn8QD23aPNvYbpQHYmvW+WkZtk+EJzwy8ybOV4WhF
         JcHPfRRj6bsEPLeCLsj5sOT3TpC0gw8KbT51QbUArNccVcLEtHrBNGyz3Y5tnkkiApJE
         Y2VUO028cUC6kHrvumJ0sZkRYCl43+jS1jtaWO65ACjBIbCxGzbm29xDVFH2YI4rfHGr
         lI1azKR9qg3K/WtAS6W0V1Z+83sH+RWTSzLkAJ2cnyWy1MRlIi8329E+g40s4BUAhAqF
         AK0s6cVg+hptnE8aUjpo9K0NsxVc48Z+s0jkeUmxdC2DZ8wy9epumENYLh/i9HI68obI
         kV4A==
X-Gm-Message-State: AOAM533SaTlQLMmr5FxbrTWyW4HNP1rERqPtC4nKhYYXB4cm89USkOmg
        aHqAdLeqcF2rgbSMShXC+Q==
X-Google-Smtp-Source: ABdhPJyBnYn5MvMsqkDKvnQ+/dsmTWdLCTaCpyxg7n8mfq03mFhSP0BRc10xrt6YOtOsmaoGoZzj8Q==
X-Received: by 2002:aca:eb42:: with SMTP id j63mr5636680oih.11.1634243168469;
        Thu, 14 Oct 2021 13:26:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f10sm741874otl.57.2021.10.14.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:26:07 -0700 (PDT)
Received: (nullmailer pid 3864570 invoked by uid 1000);
        Thu, 14 Oct 2021 20:26:07 -0000
Date:   Thu, 14 Oct 2021 15:26:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display/bridge: sil,sii8620: Convert to
 YAML binding
Message-ID: <YWiSX+wQbBOzW+nK@robh.at.kernel.org>
References: <20211006150459.584875-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006150459.584875-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:04:59PM +0200, AngeloGioacchino Del Regno wrote:
> Convert the Silicon Image SiI8620 HDMI/MHL bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/display/bridge/sil,sii8620.yaml  | 93 +++++++++++++++++++
>  .../bindings/display/bridge/sil-sii8620.txt   | 33 -------
>  2 files changed, 93 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> new file mode 100644
> index 000000000000..5a38595b6687
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/sil,sii8620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Image SiI8620 HDMI/MHL bridge
> +
> +maintainers:
> +  - Andrzej Hajda <a.hajda@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: sil,sii8620
> +
> +  reg:
> +    description: I2C address of the bridge
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xtal
> +
> +  cvcc10-supply:
> +    description: Digital Core Supply Voltage, 1.0V
> +
> +  iovcc18-supply:
> +    description: I/O voltage supply, 1.8V
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO connected to the reset pin.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for HDMI input

No need for 'ports' with only one port. However, this *should* have an 
output port for a connector, so I'm okay with this change. However, 
don't add that now. Just note the addition of 'ports' in the commit msg.

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - cvcc10-supply
> +  - iovcc18-supply
> +  - interrupts
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c1 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bridge@39 {
> +        compatible = "sil,sii8620";
> +        reg = <0x39>;
> +        cvcc10-supply = <&ldo36_reg>;
> +        iovcc18-supply = <&ldo34_reg>;
> +        interrupt-parent = <&gpf0>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        reset-gpios = <&gpv7 0 GPIO_ACTIVE_HIGH>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            mhl_to_hdmi: endpoint {
> +              remote-endpoint = <&hdmi_to_mhl>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> deleted file mode 100644
> index b05052f7d62f..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Silicon Image SiI8620 HDMI/MHL bridge bindings
> -
> -Required properties:
> -	- compatible: "sil,sii8620"
> -	- reg: i2c address of the bridge
> -	- cvcc10-supply: Digital Core Supply Voltage (1.0V)
> -	- iovcc18-supply: I/O Supply Voltage (1.8V)
> -	- interrupts: interrupt specifier of INT pin
> -	- reset-gpios: gpio specifier of RESET pin
> -	- clocks, clock-names: specification and name of "xtal" clock
> -	- video interfaces: Device node can contain video interface port
> -			    node for HDMI encoder according to [1].
> -
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	sii8620@39 {
> -		reg = <0x39>;
> -		compatible = "sil,sii8620";
> -		cvcc10-supply = <&ldo36_reg>;
> -		iovcc18-supply = <&ldo34_reg>;
> -		interrupt-parent = <&gpf0>;
> -		interrupts = <2 0>;
> -		reset-gpio = <&gpv7 0 0>;
> -		clocks = <&pmu_system_controller 0>;
> -		clock-names = "xtal";
> -
> -		port {
> -			mhl_to_hdmi: endpoint {
> -				remote-endpoint = <&hdmi_to_mhl>;
> -			};
> -		};
> -	};
> -- 
> 2.33.0
> 
> 
