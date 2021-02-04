Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE3030F9F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhBDRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:42:01 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45485 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhBDRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:41:20 -0500
Received: by mail-oi1-f181.google.com with SMTP id m7so4504587oiw.12;
        Thu, 04 Feb 2021 09:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppFNAnwz/O2d3fmUTcOou1FwVZxpBcox4zp0+9mjbI0=;
        b=O78orqmvTwrEOs7ZHGwoIQl2PrVvCEHDeNP7rieH4kcKwMTamRDmB4VMMBvuE6j/n8
         93xsfODX/QS0nUVBwRKgCpTrituU35FOqqO9JeYUs8VP63e0mDL3zHtq5Bpmg8LFcY6Y
         32vhSbGTR9O0PpiaydF3jjTDaDgtV7P1IoLvV5yUCYPa+onhb/HVvAkxfbHBRjyvsck9
         OpL9QKAAzlfgsyspXIKL2UD67ctIvkUqgz9PFaNTUpmTCPibvIA+nyWDXsroGAUqs2OW
         LNZbCT9ac5nQ1U2FEYDJ8Ri3mwZsHOEcaHtj/bIOnLj+Ev/fo0doweldDlQ1aeFONfhw
         N50A==
X-Gm-Message-State: AOAM532CcB66+fR4UJ7BN9yeswIqcYmkrvbVRD1qu9G8ck4fkZwYZv58
        FeFryvtoIKVfnJbig6t+2A==
X-Google-Smtp-Source: ABdhPJwyQZK/KLQa58IT9c/ne8vaoP5CTOrMYyKDPUl4t2Upj/dzcMYl4KNRnM0QPe8DsbgWaulQrw==
X-Received: by 2002:a05:6808:145:: with SMTP id h5mr406403oie.87.1612460439336;
        Thu, 04 Feb 2021 09:40:39 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a63sm1233750otc.75.2021.02.04.09.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 09:40:38 -0800 (PST)
Received: (nullmailer pid 702724 invoked by uid 1000);
        Thu, 04 Feb 2021 17:40:37 -0000
Date:   Thu, 4 Feb 2021 11:40:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add documentation
 for SN65DSI84
Message-ID: <20210204174037.GA690342@robh.at.kernel.org>
References: <20210203071256.42050-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203071256.42050-1-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:42:55PM +0530, Jagan Teki wrote:
> SN65DSI84 is a Single Channel DSI to Dual-link LVDS bridge from
> Texas Instruments.
> 
> SN65DSI83, SN65DSI85 are variants of the same family of bridge
> controllers.
> 
> Right now the bridge driver is supporting a single link, dual-link
> support requires to initiate I2C Channel B registers, so dt-bindings
> documented with single link LVDS.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - none
> 
>  .../bindings/display/bridge/ti,sn65dsi84.yaml | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
> new file mode 100644
> index 000000000000..891382a76c1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ti,sn65dsi84.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI SN65DSI84 MIPI DSI to LVDS bridge bindings
> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +description: |
> +  The SN65DSI84 DSI to FlatLink bridge features a single channel MIPI D-PHY receiver
> +  front-end configuration with 4 lanes per channel operating at 1 Gbps per lanes.
> +  The bridge decodes MIPI DSI 18bpp RGB666 and 240bpp RG888 packets and converts
> +  the formatted video data stream to a FlatLink compatible LVDS output operating
> +  at pixel clocks operating from 25 MHx to 154 MHz, offering a Dual-Link LVDS,
> +  Single-Link LVDS interface with four data lanes per link.
> +
> +  https://www.ti.com/product/SN65DSI84
> +
> +properties:
> +  compatible:
> +    const: ti,sn65dsi84
> +
> +  reg:
> +    maxItems: 1
> +    description: i2c address of the bridge, 0x2c

Just 'const: 0x2c' if that's the only valid address.

> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for bridge enable pin (active high).
> +
> +  ports:
> +    type: object
> +    description:
> +      A node containing input and output port nodes with endpoint definitions
> +      as documented in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description: |
> +          DSI Input. The remote endpoint phandle should be a
> +          reference to a valid mipi_dsi_host device node.
> +
> +      port@1:
> +        type: object
> +        description: |
> +          Video port for LVDS output (panel or connector).

This needs to use the graph.yaml schema. See the ones in drm-misc-next 
that are already converted.

> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       ports {
> +           #address-cells = <1>;
> +           #size-cells = <0>;
> +
> +           port@0 {
> +               reg = <0>;
> +               dsi_in: endpoint {
> +                   remote-endpoint = <&ltdc_ep0_out>;
> +               };
> +           };
> +
> +           port@1 {
> +               reg = <1>;
> +               dsi_out: endpoint {
> +                   remote-endpoint = <&bridge_in>;
> +                   data-lanes = <0 1>;
> +               };
> +           };
> +       };
> +    };
> +
> +    i2c6 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       bridge@2c {
> +           compatible = "ti,sn65dsi84";
> +           reg = <0x2c>;
> +           enable-gpios = <&gpiof 15 GPIO_ACTIVE_HIGH>;
> +
> +           ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               port@0 {
> +                   reg = <0>;
> +                   bridge_in: endpoint {
> +                        remote-endpoint = <&dsi_out>;
> +                   };
> +               };
> +
> +               port@1 {
> +                   reg = <1>;
> +                   bridge_out: endpoint {
> +                        remote-endpoint = <&panel_in_lvds>;
> +                   };
> +               };
> +           };
> +       };
> +    };
> -- 
> 2.25.1
> 
