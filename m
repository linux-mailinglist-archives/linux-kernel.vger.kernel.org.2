Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77206386EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbhERBGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:06:00 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38713 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbhERBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:05:59 -0400
Received: by mail-oi1-f176.google.com with SMTP id z3so8211763oib.5;
        Mon, 17 May 2021 18:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SxHwQbAd9PyYMHvbV2F26fHPcBALRSGxTgLDpMOWzQQ=;
        b=aKGiL43z+Fn7bRbpCFhQLgrN0EGf+kZVJCJSyRxFdkMwh4ad3dYrhxIUiYwD4tuXUs
         hTkMo4NGmo3GLe+izEROBFTUw4C99/LhvCt9efLoBokfbs0WiIQJ/oe6wnfe4hJNCd+d
         EX+F1BWFn9f5nLOElvsgiPt8BPn1Ce44OU/FvbuG7yzZYYipxcfydnkXZoWrFbtBfEtz
         Yc/BlJH8/++W1U46EuecW0zxCehmkpGxaqqDlNhcKJJehVRJOAENgp79JfRIs//FuBg/
         fxNkg/D2vXoa9NrOUu0EPdC1zyXeujteicc4+z8Cx33Toge1nI/WXXr4nG/L1GQOFupB
         LiLQ==
X-Gm-Message-State: AOAM531zE3IZns8bS5d3fP30CZOteMXintUzjuZjeJe9VuIFbzU488Es
        mURZC+roBrANKizlfaEcHQ==
X-Google-Smtp-Source: ABdhPJyf0pyW0S41fWKZ804dgH5cblGefnR1aOV1tvOb/H1KFlgu8LzH9jN6ZmU22hvwZ66FGvTi/A==
X-Received: by 2002:aca:2417:: with SMTP id n23mr1411208oic.111.1621299880509;
        Mon, 17 May 2021 18:04:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm3398791oog.25.2021.05.17.18.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:04:39 -0700 (PDT)
Received: (nullmailer pid 3562405 invoked by uid 1000);
        Tue, 18 May 2021 01:04:38 -0000
Date:   Mon, 17 May 2021 20:04:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linus.walleij@linaro.org, kishon@ti.com,
        vkoul@kernel.org, jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: phy: convert rockchip-usb-phy.txt to
 YAML
Message-ID: <20210518010438.GA3548693@robh.at.kernel.org>
References: <20210512122346.9463-1-jbx6244@gmail.com>
 <20210512122346.9463-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512122346.9463-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:23:43PM +0200, Johan Jonker wrote:
> Current dts files with Rockchip 'usbphy' nodes are manually verified.
> In order to automate this process rockchip-usb-phy.txt has to be
> converted to YAML.
> 
> Add "#phy-cells", because it is a required property
> by phy-provider.yaml

Maybe we should relax that. Or changing the node name would solve it. 

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/phy/rockchip-usb-phy.txt   | 52 -------------
>  .../devicetree/bindings/phy/rockchip-usb-phy.yaml  | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> deleted file mode 100644
> index 4ed569046..000000000
> --- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -ROCKCHIP USB2 PHY
> -
> -Required properties:
> - - compatible: matching the soc type, one of
> -     "rockchip,rk3066a-usb-phy"
> -     "rockchip,rk3188-usb-phy"
> -     "rockchip,rk3288-usb-phy"
> - - #address-cells: should be 1
> - - #size-cells: should be 0
> -
> -Deprecated properties:
> - - rockchip,grf : phandle to the syscon managing the "general
> -   register files" - phy should be a child of the GRF instead
> -
> -Sub-nodes:
> -Each PHY should be represented as a sub-node.
> -
> -Sub-nodes
> -required properties:
> -- #phy-cells: should be 0
> -- reg: PHY configure reg address offset in GRF
> -		"0x320" - for PHY attach to OTG controller
> -		"0x334" - for PHY attach to HOST0 controller
> -		"0x348" - for PHY attach to HOST1 controller
> -
> -Optional Properties:
> -- clocks : phandle + clock specifier for the phy clocks
> -- clock-names: string, clock name, must be "phyclk"
> -- #clock-cells: for users of the phy-pll, should be 0
> -- reset-names: Only allow the following entries:
> - - phy-reset
> -- resets: Must contain an entry for each entry in reset-names.
> -- vbus-supply: power-supply phandle for vbus power source
> -
> -Example:
> -
> -grf: syscon@ff770000 {
> -	compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
> -
> -...
> -
> -	usbphy: phy {
> -		compatible = "rockchip,rk3288-usb-phy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usbphy0: usb-phy0 {
> -			#phy-cells = <0>;
> -			reg = <0x320>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> new file mode 100644
> index 000000000..3b6b39da0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip USB2.0 phy
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,rk3288-usb-phy
> +      - items:
> +          - enum:
> +              - rockchip,rk3066a-usb-phy
> +              - rockchip,rk3188-usb-phy
> +          - const: rockchip,rk3288-usb-phy
> +
> +  "#phy-cells":
> +    const: 0

If we did add this, we'd want it to be 1 so we could identify which phy.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "usb-phy@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      "#phy-cells":
> +        const: 0
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: phyclk
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      resets:
> +        maxItems: 1
> +
> +      reset-names:
> +        const: phy-reset
> +
> +      vbus-supply:
> +        description: phandle for vbus power source
> +
> +    required:
> +      - reg
> +      - "#phy-cells"
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    usbphy: usbphy {
> +      compatible = "rockchip,rk3288-usb-phy";
> +      #phy-cells = <0>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      usbphy0: usb-phy@320 {
> +        reg = <0x320>;
> +        #phy-cells = <0>;
> +      };
> +    };
> -- 
> 2.11.0
> 
