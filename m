Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFC35E5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhDMSJy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Apr 2021 14:09:54 -0400
Received: from aposti.net ([89.234.176.197]:58612 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhDMSJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:09:53 -0400
Date:   Tue, 13 Apr 2021 19:09:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: bridge: add it66121 bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, devicetree@vger.kernel.org,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>
Message-Id: <H3LIRQ.7IT4EUNNTEBX1@crapouillou.net>
In-Reply-To: <20210412154648.3719153-2-narmstrong@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
        <20210412154648.3719153-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Le lun. 12 avril 2021 à 17:46, Neil Armstrong 
<narmstrong@baylibre.com> a écrit :
> From: Phong LE <ple@baylibre.com>
> 
> Add the ITE bridge HDMI it66121 bindings.
> 
> Signed-off-by: Phong LE <ple@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/bridge/ite,it66121.yaml  | 123 
> ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> 
> diff --git 
> a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml 
> b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> new file mode 100644
> index 000000000000..61ed6dc7740b
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it66121.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE it66121 HDMI bridge Device Tree Bindings
> +
> +maintainers:
> +  - Phong LE <ple@baylibre.com>
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The IT66121 is a high-performance and low-power single channel HDMI
> +  transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward 
> compatible
> +  to DVI 1.0 specifications.
> +
> +properties:
> +  compatible:
> +    const: ite,it66121
> +
> +  reg:
> +    maxItems: 1
> +    description: base I2C address of the device
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active low reset
> +
> +  vrf12-supply:
> +    description: Regulator for 1.2V analog core power.
> +
> +  vcn33-supply:
> +    description: Regulator for 3.3V digital core power.
> +
> +  vcn18-supply:
> +    description: Regulator for 1.8V IO core power.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: DPI input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-width:
> +                description:
> +                  Endpoint bus width.
> +                enum:
> +                  - 12  # 12 data lines connected and dual-edge mode
> +                  - 24  # 24 data lines connected and single-edge 
> mode
> +                default: 24
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: HDMI Connector port.
> +
> +    required:
> +      - port@0
> +      - port@1

Should port@1 really be required? Since the chip itself handles the 
hotplug detection and stuff like DCC, I'm not sure what to connect here.

Cheers,
-Paul

> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vrf12-supply
> +  - vcn33-supply
> +  - vcn18-supply
> +  - interrupts
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      it66121hdmitx: it66121hdmitx@4c {
> +        compatible = "ite,it66121";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&ite_pins_default>;
> +        vcn33-supply = <&mt6358_vcn33_wifi_reg>;
> +        vcn18-supply = <&mt6358_vcn18_reg>;
> +        vrf12-supply = <&mt6358_vrf12_reg>;
> +        reset-gpios = <&pio 160 1 /* GPIO_ACTIVE_LOW */>;
> +        interrupt-parent = <&pio>;
> +        interrupts = <4 8 /* IRQ_TYPE_LEVEL_LOW */>;
> +        reg = <0x4c>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            it66121_in: endpoint {
> +              bus-width = <12>;
> +              remote-endpoint = <&display_out>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            hdmi_conn_out: endpoint {
> +              remote-endpoint = <&hdmi_conn_in>;
> +            };
> +          };
> +        };
> +      };
> +    };
> --
> 2.25.1
> 


