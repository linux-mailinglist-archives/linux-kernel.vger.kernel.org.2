Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40D43C095
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhJ0DQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:16:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41894 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhJ0DQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:16:25 -0400
Received: by mail-ot1-f45.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so1663369ote.8;
        Tue, 26 Oct 2021 20:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZsgutcYXburh6Om3gxFfVkZQgm5rcUqHCp1VMGBB+c=;
        b=DD85eIA19kt/W1rYc1LnhNG4e71DeR4hgZYzzyIX1U5IfToP+paDESEVJZXluTs3wE
         Btdhco5IhmoLtSr9yFZ91J9Gems8iY0jtyHFEyEa4og7vh3v0lTdjrcwED82z/U8YfCh
         auClgKkap7sHuOhYLYvG1tptpJB00hk+JjRuVgGCLvxINexsUMcLybVbR3pKW0SWaBc9
         IkFhmOTqVst1ymeR9oTq4pBpFoq5M4/uIgLnKyO6vLxSi8IgBLQpmAWU6PjyLKRCEb/w
         c+oKMjMv1QnPvDmAl8aTxgd1A8og99xB6r9FvK1n/Du7OChKo8e3TGWwNF5QPag7hZ+p
         OSKw==
X-Gm-Message-State: AOAM530PqF3CVv6ts4JAvOtgsocT/o15Dqhhe3DpVO2GdvZH9EymdVFy
        l9AQWyeFVMwrGEY0zKf5dQ==
X-Google-Smtp-Source: ABdhPJwsYa2fg2xp4ZMiq9mRoWd9HVle2S+Y17/gYBC7E9sJazBCcIUaMe9RAMjnpV09dzXgvdCOfA==
X-Received: by 2002:a05:6830:30a1:: with SMTP id g1mr22610662ots.54.1635304440594;
        Tue, 26 Oct 2021 20:14:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r131sm1199208oib.27.2021.10.26.20.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:13:59 -0700 (PDT)
Received: (nullmailer pid 3948938 invoked by uid 1000);
        Wed, 27 Oct 2021 03:13:58 -0000
Date:   Tue, 26 Oct 2021 22:13:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: lan966x phy reset driver bindings
Message-ID: <YXjD9o8ws5KWlafb@robh.at.kernel.org>
References: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
 <20211019115205.1516311-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019115205.1516311-2-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:52:04PM +0200, Horatiu Vultur wrote:
> Document the lan966x phy reset device driving bindings.
> It is using register access for the internal PHYs and toggles
> GPIO for external PHYs.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../bindings/reset/lan966x-phy,rst.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> new file mode 100644
> index 000000000000..35a32458cafe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/lan966x-phy,rst.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip Lan966x PHY Reset
> +
> +maintainers:
> +  - Horatiu Vultur <horatiu.vultur@microchip.com>
> +
> +description: |
> +  The Microchip Lan966x Switch provides 2 internal PHY which needs to be
> +  released from reset before they can be accessed. Also it might have external
> +  PHYs which requires to toggle a GPIO before the access to the PHYs.
> +
> +properties:
> +  $nodename:
> +    pattern: "^phy-reset@[0-9a-f]+$"

^reset-controller@[0-9a-f]+$

> +
> +  compatible:
> +    const: microchip,lan966x-phy-reset
> +
> +  reg:
> +    items:
> +      - description: internal phy reset registers

Just: maxItems: 1

> +
> +  reg-names:
> +    const: phy

Not all that useful with only 1 entry.

> +
> +  "#reset-cells":
> +    const: 1
> +
> +  external-phy-reset-gpios:
> +    description: used for release of reset of the external PHY
> +    maxItems: 1

This belongs in the external PHY's node.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy_reset: phy-reset@e2010010 {
> +        compatible = "microchip,lan966x-phy-reset";
> +        reg = <0xe2010010 0x14>;
> +        reg-names = "phy";
> +        #reset-cells = <1>;
> +    };
> -- 
> 2.33.0
> 
> 
