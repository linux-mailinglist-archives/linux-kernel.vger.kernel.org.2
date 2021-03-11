Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB9337F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCKUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCKUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:33:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C6C061574;
        Thu, 11 Mar 2021 12:33:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x4so35256430lfu.7;
        Thu, 11 Mar 2021 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDxi9l/65w1lS5MeVsfp0a2o3WqXobOac2jPACVvWIo=;
        b=gqFV3M8auXLT3svzUoytk0Umf1KAkOaqlfY5H56OjlaSjU/rs3MCe5DHuNs2D7OLl1
         dkhs9c+kSfLVsRRdcNO8Rihlpo7WJ6vkJsLOWUL1NQEN4mFx1Ne6KqzLZ8sbY1AW+dcg
         kK3Vko9qVktuM7AG0+Gjt5X384mMAEZv6vuPCmKS95aDuBMLtRCNRTetTPNK9spStG1R
         Ur6cHLNE1swoU03XUsY/IBHVvGOHNJQHbu1ftczt+HUArPHsGWlonCyVKYIKxxDHRpwr
         HgoxCqw/uQ+Vdo3Uw2dTcsYgl3wYeWCueFbsun+hObn4yj+4GVGcq03dhDxi4eF1O6DV
         YriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDxi9l/65w1lS5MeVsfp0a2o3WqXobOac2jPACVvWIo=;
        b=kDqId2dP54ZVw+q5PdS5u6b60ZpDq8GXU+BIkqSX4y7XWXH/luN7rHbrVlem5mz2Zr
         +3mXAyzIaXsGNMhUMoxN95BASUUPcInRvoJSzCBFGnFU69TOjL7uiAnSqnruPFP7eqkG
         ktp7N/B5MZXVqQAegfETS6D7018C4MAtjnkMbEQS4dFT3WKcZDPR2OeRiqWxhStCj+Dx
         FFjJUD5vYClRrQozpWbkLQFk9bxH6bOOD7F2Vvwt7ma9Ag6+dJIUt/8+eq/Swv+aGDre
         jvpq4DUiuKVt3xYexxb50p1eSEXoRZDirPKiDbYX49A85iJXewqs8QyQVmTF1hpjvXIc
         9ltw==
X-Gm-Message-State: AOAM532hrBwLr+UK2PBKgil5Hr0aYzyIv+GS9vIHLcCJTOzC/a5ZXfji
        nngeMQVSNz3QVTd98PJl0Lg=
X-Google-Smtp-Source: ABdhPJw8KFY3irIf8lesknRMh5e8ws2nSFDJJQ6gOTenIvdwRyo99g33LfCaISUTRtBG972zTlzRSQ==
X-Received: by 2002:a05:6512:4c4:: with SMTP id w4mr3281698lfq.91.1615494799457;
        Thu, 11 Mar 2021 12:33:19 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id u15sm1144658lff.262.2021.03.11.12.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 12:33:18 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb2-phy: convert to yaml
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org, Vivek Unune <npcomplete13@gmail.com>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <20201116074650.16070-2-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <411eafa9-70d6-0d46-66dd-ea03c5594e1a@gmail.com>
Date:   Thu, 11 Mar 2021 21:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201116074650.16070-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.2020 08:46, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Convert from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Document "#phy-cells"
> 4. Fix example node name (noticed by dt_binding_check)
> 5. Add #include to example (noticed by dt_binding_check)
> 6. Specify license
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I think this should go through linux-phy tree. Kishon, Vinod, can you
> take this patch?
> 
> This patch generates a false positive checkpatch.pl warning [0].
> Please ignore:
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> [0] https://lkml.org/lkml/2020/2/18/1084

Same thing here.

Kishon, Vinod: I sent this patch back in December, it was Reviewed-by
Rob, but never accepted.

Could you push this patch to the linux-phy.git?


> ---
>   .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
>   .../bindings/phy/bcm-ns-usb2-phy.yaml         | 59 +++++++++++++++++++
>   2 files changed, 59 insertions(+), 21 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> deleted file mode 100644
> index a7aee9ea8926..000000000000
> --- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Driver for Broadcom Northstar USB 2.0 PHY
> -
> -Required properties:
> -- compatible: brcm,ns-usb2-phy
> -- reg: iomem address range of DMU (Device Management Unit)
> -- reg-names: "dmu", the only needed & supported reg right now
> -- clocks: USB PHY reference clock
> -- clock-names: "phy-ref-clk", the only needed & supported clock right now
> -
> -To initialize USB 2.0 PHY driver needs to setup PLL correctly. To do this it
> -requires passing phandle to the USB PHY reference clock.
> -
> -Example:
> -	usb2-phy {
> -		compatible = "brcm,ns-usb2-phy";
> -		reg = <0x1800c000 0x1000>;
> -		reg-names = "dmu";
> -		#phy-cells = <0>;
> -		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
> -		clock-names = "phy-ref-clk";
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
> new file mode 100644
> index 000000000000..05b4dcd80019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/bcm-ns-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Northstar USB 2.0 PHY
> +
> +description: >
> +  To initialize USB 2.0 PHY driver needs to setup PLL correctly.
> +  To do this it requires passing phandle to the USB PHY reference clock.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    const: brcm,ns-usb2-phy
> +
> +  reg:
> +    items:
> +      - description: iomem address range of DMU (Device Management Unit)
> +
> +  reg-names:
> +    items:
> +      - const: dmu
> +
> +  clocks:
> +    items:
> +      - description: USB PHY reference clock
> +
> +  clock-names:
> +    items:
> +      - const: phy-ref-clk
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm-nsp.h>
> +    phy@1800c000 {
> +        compatible = "brcm,ns-usb2-phy";
> +        reg = <0x1800c000 0x1000>;
> +        reg-names = "dmu";
> +        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
> +        clock-names = "phy-ref-clk";
> +        #phy-cells = <0>;
> +    };
> 
