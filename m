Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E349232E484
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCEJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCEJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:15:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B6C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:15:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t9so1476551pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2s/6bosQnyMVVhGPfC4oLj+5tbM01J9t4bfvMd7vhE=;
        b=AaRPNLUShGL/WIkNjCI0BiUU3K2IHRYb3melResKabIt41oLMDOCBa5ds0aAxzFZSZ
         t2cd5JZ8xh0hphmXPCOe0xzIQJkSw2Db1V1OqJH5pS0etrD3XWxxjwSjXcqBg++A1h5f
         g1PAmYxHwOrcvMMeo2ZcIihES8695t8Gn1yGObjhXS/CZ9InFMrYdk/82/STX4MSmHU6
         UfgiiWlXhGOZAwpoql5BXkBvzAd4mb6tmO2rFhmvpY71qx7C5lMnCJErH2DahXH7Aqre
         HuJOjOC21AQ5xfBPqCp4UFKi/OzUqSiJ/d1dvY9+lpgQOKZN0NQCRJ/5ZfTIsXE6m/wt
         kPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2s/6bosQnyMVVhGPfC4oLj+5tbM01J9t4bfvMd7vhE=;
        b=RGwvDmMXjoXj4eL1XOxXW9leQ/R/23ce0jPSXjMgt0lZmm4ELoYgDN0Ii9fdcNFlDP
         IiuKAO2PZ9QUGVwJGzUfY9mFEb36x3sv2jbHlRPp4X6Ru/Ajt3C3XdugH7fXdKvDBV1d
         vMvTGWkksMSBQkpJ+kpzqK7V7vmh+gW86Yuh2E2u2A51/Z19ZKMMQ8elA2oQxDeJdFnu
         lzPv4II+BZzxSKehx5vk1cjWvTDx8SGYnFNqWIxuU0W5L3NZpe+h97x8u5csr+W6Wvsl
         dYeehQzrpKuzJ1gJLcxDUGbm3HVqy0+kafg7S97BzzcMdxMGoP2B9swW0DatH794Xadt
         Z9cw==
X-Gm-Message-State: AOAM531734/HDFPQrRzsWIjhF8RUjbaLF2MMDPGYIomNduSPQGiBX3l2
        aZmsTBazgpJKxl05EK0xA97FcVhoWT+YC0AAUaZ23A==
X-Google-Smtp-Source: ABdhPJy/Sfmg/zLpRI4ehD75EdGmKQ7AwXYkMBriEgMGBtafpi+vNhuCvcADyvNsVacmQIihmDdlrS1M9kGc3mjRNZo=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr9516532pjb.19.1614935758043;
 Fri, 05 Mar 2021 01:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20210304092133.21717-1-jagan@amarulasolutions.com>
In-Reply-To: <20210304092133.21717-1-jagan@amarulasolutions.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 5 Mar 2021 10:15:47 +0100
Message-ID: <CAG3jFysfspsKe6U9pxEjgDh9W4Lzs4f7G4cnwvjz0gYc4b5gzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: bridge: Add Chipone ICN6211 bindings
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jagan,

This looks good to me, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Thu, 4 Mar 2021 at 10:21, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> ICN6211 is MIPI-DSI to RGB Converter bridge from Chipone.
>
> It has a flexible configuration of MIPI DSI signal input and
> produces RGB565, RGB666, RGB888 output format.
>
> Add dt-bingings for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4:
> - fixed Laurent comments
> - added regulators
> - replace reset with EN
> - fixed warnings pointed by Robert
> Changes for v3:
> - updated to new dt-bindings style
>
>  .../display/bridge/chipone,icn6211.yaml       | 99 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> new file mode 100644
> index 000000000000..62c3bd4cb28d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +description: |
> +  ICN6211 is MIPI-DSI to RGB Converter bridge from chipone.
> +
> +  It has a flexible configuration of MIPI DSI signal input and
> +  produce RGB565, RGB666, RGB888 output format.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - chipone,icn6211
> +
> +  reg:
> +    maxItems: 1
> +    description: virtual channel number of a DSI peripheral
> +
> +  enable-gpios:
> +    description: Bridge EN pin, chip is reset when EN is low.
> +
> +  vdd1-supply:
> +    description: A 1.8V/2.5V/3.3V supply that power the MIPI RX.
> +
> +  vdd2-supply:
> +    description: A 1.8V/2.5V/3.3V supply that power the PLL.
> +
> +  vdd3-supply:
> +    description: A 1.8V/2.5V/3.3V supply that power the RGB output.
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
> +          Video port for MIPI DPI output (panel or connector).
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bridge@0 {
> +        compatible = "chipone,icn6211";
> +        reg = <0>;
> +        enable-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +
> +            bridge_in_dsi: endpoint {
> +              remote-endpoint = <&dsi_out_bridge>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +
> +            bridge_out_panel: endpoint {
> +              remote-endpoint = <&panel_out_bridge>;
> +            };
> +          };
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d241b832aae..065cbdc889d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5529,6 +5529,11 @@ S:       Maintained
>  F:     Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
>  F:     drivers/gpu/drm/panel/panel-boe-himax8279d.c
>
> +DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTER BRIDGE
> +M:     Jagan Teki <jagan@amarulasolutions.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> +
>  DRM DRIVER FOR FARADAY TVE200 TV ENCODER
>  M:     Linus Walleij <linus.walleij@linaro.org>
>  S:     Maintained
> --
> 2.25.1
>
