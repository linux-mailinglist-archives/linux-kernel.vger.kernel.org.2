Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7C32F582
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCEVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:48:06 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9AC06175F;
        Fri,  5 Mar 2021 13:48:05 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id q14so4657832ljp.4;
        Fri, 05 Mar 2021 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AxfzahttmJmyaaNO341zI4FxIQ9ySpNB5/9C/f+vk4U=;
        b=LDt6DG5EYiFvYSPj+yxTP/l91WhtxnepHQU/EPtg63Ny/bJjTaZN/A5kcC0RasBtzp
         LCbFvZJdFSqOV7fRxzrZg53K/H5JCOtEUnWzHeHWoZx1yqc7swTkKgBVaCEtVxIZ3YVn
         ErsM0vcPw/lIDi1GVjh50aSdo0vZSFrd2ZjX3JlG2phwKfDML/JwdDS/B95AYwSys8s8
         IhznNc5DIneJByLjGUxqDqyJN9qiK53nJXzEy2nvZNJGucNrOVgKdPysHIYWR5hl4sGP
         IWBseD+RKmI8FACLJUqaAbYQgAVTDpoJCd4N2u6LhuLmVAKYs3nJdjZ05oDrvRo3IWZ1
         BqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AxfzahttmJmyaaNO341zI4FxIQ9ySpNB5/9C/f+vk4U=;
        b=JGwkeSn6GxtYhGiTjckyaUq0Y3iaMVl2AAKb1saoMTiAIlxrFuGQHOnAqlV/TWXmU7
         NcBd7G87zsdfKeyElZ8s5tQOvy7HyUt8x9kxi+3LKRIAUUli8mVVX9RnW3/GW42+tcSF
         BfubofdNjfEdEO660+ZmxglA7NyQthl1haK27fCR8lv4eAy+r3h0Gd1qBJ3kDIjRkFqx
         /EvdIt7l6nSPI1IfrCU13mdsm5VQDPQV6JuhH7Qne9HiTA80h3jIPKqu74qWwNajmkbT
         WlUL3eveyigJLtueQ4GiqbY+ls4qTht+WwEkQ4qg1OFwZRTIXJuLfuVQxJ8TAAWTH2LO
         RIYQ==
X-Gm-Message-State: AOAM532S764wIcDAkh6Be6PRIe4zC0CzlWFkX3lgQUIBexVuZy0yclcU
        gJUNrIOGbhVPNi6Xxcgmn9E=
X-Google-Smtp-Source: ABdhPJybuT/DSeY60eU+wfU6jbpY0AEscf1GLffztX4byv6PHBvlctCDKMBpcc8rz19jofO7TpP5OA==
X-Received: by 2002:a2e:86d0:: with SMTP id n16mr6599564ljj.288.1614980884339;
        Fri, 05 Mar 2021 13:48:04 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id k1sm448346lfe.208.2021.03.05.13.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 13:48:03 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: phy: convert Broadcom NS USB 2.0 to the
 json-schema
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org
References: <20210226114501.31086-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <b17965ce-20c4-b697-b21e-09e76e113ef1@gmail.com>
Date:   Fri, 5 Mar 2021 22:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210226114501.31086-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc linux-phy@ again (after fixing recipients limit)

On 26.02.2021 12:44, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Minor example fixes:
> 1. Include bcm-nsp.h
> 2. Add address to the node name
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This has been verified using dt_binding_check
> ---
>   .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
>   .../bindings/phy/brcm,ns-usb2-phy.yaml        | 55 +++++++++++++++++++
>   2 files changed, 55 insertions(+), 21 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
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
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> new file mode 100644
> index 000000000000..b8b683ce8fa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/brcm,ns-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Northstar USB 2.0 PHY
> +
> +description: Broadcom's USB 2.0 PHY integrated into Northstar family SoCs
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    const: brcm,ns-usb2-phy
> +
> +  reg:
> +    maxItems: 1
> +    description: DMU (Device Management Unit) address range
> +
> +  reg-names:
> +    const: dmu
> +
> +  clocks:
> +    maxItems: 1
> +    description: USB PHY reference clock
> +
> +  clock-names:
> +    const: phy-ref-clk
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
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
> +
> +    usb2-phy@1800c000 {
> +        compatible = "brcm,ns-usb2-phy";
> +        reg = <0x1800c000 0x1000>;
> +        reg-names = "dmu";
> +        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
> +        clock-names = "phy-ref-clk";
> +        #phy-cells = <0>;
> +    };
> 
