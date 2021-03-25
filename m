Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FED34974E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCYQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:49:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:49:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4349994pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaZNs/slFbXR+His3djbKPWrwZ4lvzuSmzWHKektuFM=;
        b=Vlr0woIKSnzYqOorKJVFFq+dl4PWdwBStgUJVK/JTCgUghS+QDp1JjuyjXUdzyhPQO
         sYgRWBVWGjHTDHgijhGcL8U51jUGgF04DOENDTJBSpZ+Y3AIjkixor/uLErRjaiGvKhQ
         QTN8H3gF0kdJjdW8/k1+tcrRV4sUdJhuBROtS0jST6XkauacxKx/L5blCWUyweWotaa7
         ucRuxOhGc6gyqusUXi1Jl3pBUk4gfJGoNM1YlQ3lbUyewRyX61OEq8uJb19CjNELD34L
         GEV22TMIh2sxveAwHdjWicFS24NNMLKI1GBXPLEF5AvC6Q0nwVfmqtq2AQyoJXpC59rm
         b9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaZNs/slFbXR+His3djbKPWrwZ4lvzuSmzWHKektuFM=;
        b=CFlM3Bkqql5c5SK8H01ZmhFNSIjC2VMmO3Ed/fNr11U+iy117ZcEZ4GRRsv0u69QxD
         BI0EJAMQGIQoXlG9ISp/RQMxcnZXzfGSfapaQ5DQxLmaoBgOKkTWO2+MVmB3GaepvmE0
         FPYDWOeNYAyctQLZAtIbUu1hAzBFu1It738bN9xrQ4KoZXqYPQ178sxtAjqMeUtIbO2o
         TNEclqe3s5EbxcByQ4zQrarxegK9SSQXixSkBvrhN8TmeREFyrWte5rOetsECrAel2I2
         xY5x1KRY+wnqh6rD5jh8l6FHprbbNKQGo7vduKTB/SF8pIGZlEdshsyN/05bSM4E8JpC
         /MrA==
X-Gm-Message-State: AOAM5319YAYt0QCg8OckrTbDlg0aleRltfc3Z9DBSM/xWXusd8qoaxkV
        Gq8NvzoPKUUDLhRY0EiijFlinKEPUFsj9FiFqptzUg==
X-Google-Smtp-Source: ABdhPJx7d0yaG5nL06/Z/qmgArm+E/1zz6/PdivRj7LNIGAYNsSqEjhkh4JiFkM9WhYO6fEUA/XeRv0i5aSyAMHJZZM=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr9930336pjh.19.1616690989004;
 Thu, 25 Mar 2021 09:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210322103328.66442-1-jagan@amarulasolutions.com>
In-Reply-To: <20210322103328.66442-1-jagan@amarulasolutions.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 25 Mar 2021 17:49:38 +0100
Message-ID: <CAG3jFyt1pztRM=pHmE3VWK0aXKivQJ=7qz8QsryhEtL35LVXKg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: bridge: Add Chipone ICN6211 bindings
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
        <devicetree@vger.kernel.org>, linux-amarula@amarulasolutions.com,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a42e37db23b88120aea9fa31f9c0952accb39296

On Mon, 22 Mar 2021 at 11:33, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> ICN6211 is MIPI-DSI to RGB Converter bridge from Chipone.
>
> It has a flexible configuration of MIPI DSI signal input and
> produces RGB565, RGB666, RGB888 output format.
>
> Add dt-bingings for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v5:
> - rebase drm-misc-next
> - collect Rob, Robert review tags
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
> index 4b705ba51c54..b9d11101d060 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5568,6 +5568,11 @@ S:       Maintained
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
