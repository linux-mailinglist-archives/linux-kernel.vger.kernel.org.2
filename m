Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1031B889
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBOL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhBOL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:58:59 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:58:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d13so3625720plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STe5WvrkatZVjS+sJ4Z+wGsil/9GokGdjFMxGOL/bOc=;
        b=rOy7yc79FkXAeqXnzqAOUPdOnDZamQGVPBA3hpVjZCIQU/goE5UEQfXd5mUXQao5UK
         m/DJbTklI8pDUuwioaLXSTNLUlDP3Nckrp8NInNDSueIPnE5pKxgjeLKa6aIFQZFwT9Z
         0dovhEJUhwovJVGEJotPI6D8SdsVCI1eCxCU2s4Xi6ggw5jZv3AkjXAjTM1s90QEhQRk
         vAkJQcvh/MBgkmAOwoDqPewoTjYiMgnTAeMNa0mx2lFJWiJCoeBvd+CZ1O6w3Ikjh9vc
         WzoRoJXkiATMuEVpISR7/1ELUjlmCJbExQk60m1SgfTjVIEhTi7yRf7nFeys00egz/nD
         e9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STe5WvrkatZVjS+sJ4Z+wGsil/9GokGdjFMxGOL/bOc=;
        b=DNzxETKarNX/Iov4rMv/97MShzwg0WjJYhVcEpf3wh2FhMENlGxtMRdutyTV0xChl5
         09+MO94PzDk2iJwNISos/h7LuIbZIWgUOBJYGsSBydd2MPV0GKsIF1rSDDPb3ICJ/Vix
         77xMuP9ju2TZlgdyublrFVCSuSzR+47Hwo/l3tRL0ey/0t3FT6p6jF8y3chtG0m0LrQG
         T2lgFHR7lJ8+QU/SRfOEaFSil5pu8kwru5Gujg4w7pJgsVq9P4b9InBAC9eF4kRgGPQw
         fB1vfZdLB13JJBn5zYq9bRlo4ZynGiBIO04j8fCd9JI176yqfEa3p+CacfqICn0Vfe/j
         C5Lw==
X-Gm-Message-State: AOAM532S9j/PUz9GtcBtZ3JkmnvdLTtMB+Oabr6KSWs3haYbaO8ZYYGf
        Y+U6z8H8jJynPxwZU38fTVtg3mHtIeu4HAbWaE7G7h8LOCeT0g==
X-Google-Smtp-Source: ABdhPJzjaKl4tw8H7uvDqKaROVYcze200koH64YBlRr2JiPQ8jGf9Eev6HGBZKF5irx2c5L89qBvK4Hn3stNj2Ilz8k=
X-Received: by 2002:a17:90a:70c1:: with SMTP id a1mr592704pjm.19.1613390298541;
 Mon, 15 Feb 2021 03:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
In-Reply-To: <20210214175211.105107-1-jagan@amarulasolutions.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 15 Feb 2021 12:58:07 +0100
Message-ID: <CAG3jFysAq0rSVRgjDSu6gF4kHcqOGAZt+b0Rz_reHgQr3Scy6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
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

Thanks for submitting this.

checkpatch.pl threw some typ-o warnings, and I listed them below. I
think either spelling is correct, but 'spelling.txt' does list this as
a typ-o explicitly, so I would suggest conforming to that just to
silence the checkpatch warning.

This patch also passes 'dt_binding_check' and 'dtbs_check', but I
think I'd like to defer to Rob Herring for an actual r-b.

On Sun, 14 Feb 2021 at 18:55, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
>
> It has a flexible configuration of MIPI DSI signal input and
> produce RGB565, RGB666, RGB888 output format.
>
> Add dt-bingings for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - updated to new dt-bindings style
>
>  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> new file mode 100644
> index 000000000000..13764f13fe46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge

$ scripts/checkpatch.pl --git HEAD~0
WARNING: 'Convertor' may be misspelled - perhaps 'Converter'?
#7:
ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
                           ^^^^^^^^^

> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +description: |
> +  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.

WARNING: 'Convertor' may be misspelled - perhaps 'Converter'?
#38: FILE: Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml:13:
+  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
                              ^^^^^^^^^


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
> +  reset-gpios:
> +    description: GPIO connected for the reset pin
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
> +  - reset-gpios
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
> +        reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          bridge_in: port@0 {
> +            reg = <0>;
> +
> +            bridge_out_dsi: endpoint {
> +              remote-endpoint = <&dsi_out_bridge>;
> +            };
> +          };
> +
> +          bridge_out: port@1 {
> +            reg = <1>;
> +
> +            bridge_out_panel: endpoint {
> +              remote-endpoint = <&panel_out_bridge>;
> +            };
> +          };
> +        };
> +      };
> +    };
> --
> 2.25.1
>
