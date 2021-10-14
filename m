Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8543442E289
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhJNUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:19:03 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46727 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhJNUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:18:55 -0400
Received: by mail-ot1-f45.google.com with SMTP id 62-20020a9d0a44000000b00552a6f8b804so9223038otg.13;
        Thu, 14 Oct 2021 13:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLOZBbljlJk6fxRBXiALacjUjEX+53gXTaAVz3wg99U=;
        b=LUJ4ODNkz46zZnNI+Yx6vpzWkKAgPuwlYyK1H2wZ+TP7BnnKeB7NCBkv5rv8JY6VWB
         IyVEVuhu7ElGzgqImUMZirBXv0mIDqUnbZysoqjMzfLi0q5d6oj0j7m3eJQ8+umHmnBM
         E11wXEk+xsib3xj+YmYJKKqdT4VwJVUQ/Llw9Ljbj5xJuHtV6gyM8vaqdSRkMKyUhqhP
         5wEoizex/FLpajMfSn3tsUsValjOgf+u8ErrbdcsiaiV4a6eFT3mT2lCkYw572oSKf/1
         QBO8UF5+n1hH8uUipKL7zPpmqADFMS93x1khXiNpv792ccOW43mN8iaraZnAmVoVfYJ6
         xMVg==
X-Gm-Message-State: AOAM530MGlzRzXMsEO5OmckMwxt47vHzP6yQyCwSYhpWD1KtVAOzgp18
        fPOrCfvHB3AemHuqYMIp1g==
X-Google-Smtp-Source: ABdhPJzsUlG+d1iaT/mSTy2OK/mA2mBw4ASqaCFdzTmfCHcV6evnztjSEGS/un35IXxmlV95JeN2QA==
X-Received: by 2002:a9d:4684:: with SMTP id z4mr4445844ote.134.1634242610236;
        Thu, 14 Oct 2021 13:16:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j65sm780894oif.5.2021.10.14.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:16:49 -0700 (PDT)
Received: (nullmailer pid 3850196 invoked by uid 1000);
        Thu, 14 Oct 2021 20:16:48 -0000
Date:   Thu, 14 Oct 2021 15:16:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     a.hajda@samsung.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/bridge: tc358767: Convert to YAML
 binding
Message-ID: <YWiQMM0ugXFYCaD0@robh.at.kernel.org>
References: <20211006135204.505144-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006135204.505144-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:52:04PM +0200, AngeloGioacchino Del Regno wrote:
> Convert the Toshiba TC358767 txt documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/bridge/toshiba,tc358767.txt       |  54 --------
>  .../display/bridge/toshiba,tc358767.yaml      | 118 ++++++++++++++++++
>  2 files changed, 118 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt
> deleted file mode 100644
> index 583c5e9dbe6b..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -Toshiba TC358767 eDP bridge bindings
> -
> -Required properties:
> - - compatible: "toshiba,tc358767"
> - - reg: i2c address of the bridge, 0x68 or 0x0f, depending on bootstrap pins
> - - clock-names: should be "ref"
> - - clocks: OF device-tree clock specification for refclk input. The reference
> -   clock rate must be 13 MHz, 19.2 MHz, 26 MHz, or 38.4 MHz.
> -
> -Optional properties:
> - - shutdown-gpios: OF device-tree gpio specification for SD pin
> -                   (active high shutdown input)
> - - reset-gpios: OF device-tree gpio specification for RSTX pin
> -                (active low system reset)
> - - toshiba,hpd-pin: TC358767 GPIO pin number to which HPD is connected to (0 or 1)
> - - ports: the ports node can contain video interface port nodes to connect
> -   to a DPI/DSI source and to an eDP/DP sink according to [1][2]:
> -    - port@0: DSI input port
> -    - port@1: DPI input port
> -    - port@2: eDP/DP output port
> -
> -[1]: Documentation/devicetree/bindings/graph.txt
> -[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	edp-bridge@68 {
> -		compatible = "toshiba,tc358767";
> -		reg = <0x68>;
> -		shutdown-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
> -		clock-names = "ref";
> -		clocks = <&edp_refclk>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@1 {
> -				reg = <1>;
> -
> -				bridge_in: endpoint {
> -					remote-endpoint = <&dpi_out>;
> -				};
> -			};
> -
> -			port@2 {
> -				reg = <2>;
> -
> -				bridge_out: endpoint {
> -					remote-endpoint = <&panel_in>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
> new file mode 100644
> index 000000000000..8e27e6f0fc7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358767.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC358767 MIPI-DSI or MIPI-DPI to DP/eDP bridge
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - toshiba,tc358767
> +
> +  reg:
> +    description: I2C address of the bridge
> +    enum: [0x68, 0x0f]
> +
> +  clocks:
> +    description:
> +      Reference clock input. The reference clock rate must be 13MHz, 19.2MHz,
> +      26MHz, or 38.4MHz.
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ref
> +
> +  reset-gpios:
> +    description: GPIO connected to the RSTX signal.
> +    maxItems: 1
> +
> +  shutdown-gpios:
> +    description: GPIO connected to the SD signal.
> +    maxItems: 1
> +
> +  toshiba,hpd-pin:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: TC356767 GPIO pin number to which HPD is connected
> +    enum:
> +      - 0
> +      - 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for MIPI DSI input
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for MIPI DPI input
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for DP/eDP output (panel or connector).
> +
> +    oneOf:
> +      - required:
> +          - port@0
> +          - port@2
> +      - required:
> +          - port@1
> +          - port@2

You could move port@2 out to:

       required:
         - port@2

> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-names
> +  - clocks
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c1 {

i2c {

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bridge@68 {
> +        compatible = "toshiba,tc358767";
> +        reg = <0x68>;
> +        clock-names = "ref";
> +        clocks = <&edp_refclk>;
> +        reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
> +        shutdown-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@1 {
> +            reg = <1>;
> +            bridge_in: endpoint {
> +              remote-endpoint = <&dpi_out>;
> +            };
> +          };
> +
> +          port@2 {
> +            reg = <2>;
> +            bridge_out: endpoint {
> +              remote-endpoint = <&panel_in>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.33.0
> 
> 
