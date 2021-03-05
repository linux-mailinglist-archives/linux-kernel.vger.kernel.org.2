Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B192C32F118
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCERZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCERYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:24:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEADC061574;
        Fri,  5 Mar 2021 09:24:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z11so4865456lfb.9;
        Fri, 05 Mar 2021 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Wb7nGBp/ajWcDGb8UZSvbZL0I86y447bFDckQp9JzQ=;
        b=d5y9bIifMQExQQ9vY5l5w294XJdbHQZ5fNjkF+pN4hSaqcsX7aLsnWymwq7YuyQkXw
         vrbRfVS3xqPo1qh3KO0m9pGx1MGNtzEp4LV5+P8PwkqulAUnBIrgBQTIMKR+71jgYjH2
         PTMEhwWIvFqNWzgN6ydcHfopxCDygAoAI/0h/gJXq9EFcwSaZaYJEwuw8P3ERdT/KCJE
         bwsaVu7N8QwqfD8OGf6xGSuy/ZmJI+DLpIpOJNGzxReXnmxD0oztvMk9GYb8G9dVoPd4
         FkFaBfMsIQuDbdck5RZLwm6+4DcFbNTzyskfS1cu4JtHxuVSnwTwHY8KJ3r7zeGzcNJZ
         awAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Wb7nGBp/ajWcDGb8UZSvbZL0I86y447bFDckQp9JzQ=;
        b=TqZJvBLjd9g4tlcr+jyBfODuVwNIKr7g22nwDUEldUYf0Fq1dbqqrdKcJI0R+69x0a
         c0HALhDwfFFxumUZuejzV5NnZbYoXDA3wOvigFCjuX5hqZIUV2tOE2sgKOO9erk4qiq2
         mKlTi5O10TV2ScY5sW69hdeOWgYL4KJnayrHwPmTaqPrqB0yhX+RKiNwUlbIZS0wRanI
         QWkoiIx8yOYJGojNplQrfkyia23m/Mxjwgiml4uEFBYfWHourOC1Z8+2D4Pto3esTXOv
         uH7Gy638wsNzOqDS/5M3GhLqqy2FCbZSlq78rJGJ1baPVkkK+8rSOv2/SHwlkHog+W19
         2ykQ==
X-Gm-Message-State: AOAM532xljyOuRA7ddD2tl36xeXOsLlUVvLce1BEwM5e8cuCmb+UJbFw
        8UiM+/RbL7Jc9hB6N+WqDFc=
X-Google-Smtp-Source: ABdhPJxoGDw7q4dycejJ3c0mponDT/TQOdfyAW2yR4717cKQja4y8MOSwx5yjX9lEGtLIvzlOEqHkQ==
X-Received: by 2002:ac2:465c:: with SMTP id s28mr6126868lfo.135.1614965092213;
        Fri, 05 Mar 2021 09:24:52 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h3sm375821ljc.67.2021.03.05.09.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:24:51 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: phy: brcm,ns-usb2-phy: bind single CRU
 reg
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org
References: <20210226114501.31086-1-zajec5@gmail.com>
 <20210226114501.31086-2-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <26f8af0e-b0fc-d66d-69a3-ee5ad9f27dbe@gmail.com>
Date:   Fri, 5 Mar 2021 18:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210226114501.31086-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc linux-phy@

On 26.02.2021 12:45, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> The old binding was using whole DMU space. It was an overkill. DMU is a
> big block which contains e.g. CRU which contains e.g. PLLs, PHY, pinctrl
> and thermal blocks.
> 
> Rework the binding to directly use a single CRU register that controls
> USB 2.0 PHY. It's still required to reference CRU generic clkset
> register so add a syscon for that.
> 
> For a full DMU & CRU description see arch/arm/boot/dts/bcm5301x.dtsi .
> 
> The old binding is deprecated now.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This has been verified using dt_binding_check
> 
> I'd really like to get Rob's ack to make sure I don't do anything stupid
> 
> It's a reworked version of my abonded 2019 patch:
> [PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use CRU syscon
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20190108123907.19816-1-zajec5@gmail.com/
> ---
>   .../bindings/phy/brcm,ns-usb2-phy.yaml        | 46 +++++++++++++++----
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> index b8b683ce8fa9..8e056d4d205a 100644
> --- a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> @@ -16,11 +16,20 @@ properties:
>       const: brcm,ns-usb2-phy
>   
>     reg:
> -    maxItems: 1
> -    description: DMU (Device Management Unit) address range
> +    anyOf:
> +      - maxItems: 1
> +        description: PHY control register
> +      - maxItems: 1
> +        description: DMU (Device Management Unit) address range
> +        deprecated: true
>   
>     reg-names:
>       const: dmu
> +    deprecated: true
> +
> +  brcm,syscon-clkset:
> +    description: phandle to syscon for clkset register
> +    $ref: /schemas/types.yaml#/definitions/phandle
>   
>     clocks:
>       maxItems: 1
> @@ -34,22 +43,39 @@ properties:
>   
>   required:
>     - reg
> -  - reg-names
>     - clocks
>     - clock-names
>     - "#phy-cells"
>   
> +oneOf:
> +  - required:
> +      - brcm,syscon-clkset
> +  - required:
> +      - reg-names
> +
>   additionalProperties: false
>   
>   examples:
>     - |
>       #include <dt-bindings/clock/bcm-nsp.h>
>   
> -    usb2-phy@1800c000 {
> -        compatible = "brcm,ns-usb2-phy";
> -        reg = <0x1800c000 0x1000>;
> -        reg-names = "dmu";
> -        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
> -        clock-names = "phy-ref-clk";
> -        #phy-cells = <0>;
> +    cru-bus@1800c100 {
> +        compatible = "simple-bus";
> +        ranges = <0 0x1800c100 0x1a4>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        usb2-phy@64 {
> +            compatible = "brcm,ns-usb2-phy";
> +            reg = <0x64 0x4>;
> +            brcm,syscon-clkset = <&clkset>;
> +            clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
> +            clock-names = "phy-ref-clk";
> +            #phy-cells = <0>;
> +        };
> +
> +        clkset: syscon@80 {
> +            compatible = "brcm,cru-clkset", "syscon";
> +            reg = <0x80 0x4>;
> +        };
>       };
> 
