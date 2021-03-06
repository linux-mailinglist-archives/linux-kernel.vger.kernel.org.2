Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB73305D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCHCQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:16:00 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:44142 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCHCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:15:37 -0500
Received: by mail-io1-f52.google.com with SMTP id 81so8319693iou.11;
        Sun, 07 Mar 2021 18:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zUhMpHW1VVHowuwumAIjSibq4yrtfBm/0FQm+5qDnvo=;
        b=r64NK7knaXssnmTQXPbBeQeyxjNj5ctP3w+7UP9emCNrb/E3T7d9lcbLWPXEJ1zbF1
         fPKUMO6EFJkdPkgKEcQM3X9cYqZjGqNXGs5PAIAggcV0QYLbYt3SdSXNVqY23kGfouvC
         ont29slnYt3PWh9YP2GcqvrUjZGNfPbaitVT/BL/DBd5Fw+yr+Hn3HZoXVvqAVA853ch
         VO/C6s8gqbU//zDujnQQENIMZ+pF60p0kuDDY9Dcz+gHsLPCM1dBuuM4orAqDVaj226e
         KvMouA1+hs0S4ZLBxaSeQTX9VhTY2Tz4OUPzHGoB2QPzOX4rwjePBmIscp0GYNtEiSa/
         928g==
X-Gm-Message-State: AOAM533qQUKCXAIHOgOWKR+nNxtQuHQKBMC6Cmz/1ZiioP+8iuQKHq6i
        yGZOA+lyvqAtu4YgAgpakQ==
X-Google-Smtp-Source: ABdhPJyJ4+Xk5fu91tItzXJMFfQKHGOUGzBjfazjdZbIWp1LHEJoenrI8ZrmQ27FjmyvsTP16nOXmA==
X-Received: by 2002:a5d:9250:: with SMTP id e16mr17112049iol.27.1615169736731;
        Sun, 07 Mar 2021 18:15:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 74sm5340847iob.43.2021.03.07.18.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:15:35 -0800 (PST)
Received: (nullmailer pid 1282752 invoked by uid 1000);
        Sat, 06 Mar 2021 21:52:32 -0000
Date:   Sat, 6 Mar 2021 14:52:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] dt-bindings: phy: brcm,ns-usb2-phy: bind single CRU
 reg
Message-ID: <20210306215232.GA1238918@robh.at.kernel.org>
References: <20210226114501.31086-1-zajec5@gmail.com>
 <20210226114501.31086-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226114501.31086-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:45:00PM +0100, Rafał Miłecki wrote:
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
>  .../bindings/phy/brcm,ns-usb2-phy.yaml        | 46 +++++++++++++++----
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> index b8b683ce8fa9..8e056d4d205a 100644
> --- a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> @@ -16,11 +16,20 @@ properties:
>      const: brcm,ns-usb2-phy
>  
>    reg:
> -    maxItems: 1
> -    description: DMU (Device Management Unit) address range
> +    anyOf:
> +      - maxItems: 1
> +        description: PHY control register
> +      - maxItems: 1
> +        description: DMU (Device Management Unit) address range
> +        deprecated: true
>  
>    reg-names:
>      const: dmu
> +    deprecated: true
> +
> +  brcm,syscon-clkset:
> +    description: phandle to syscon for clkset register
> +    $ref: /schemas/types.yaml#/definitions/phandle

Don't really need this as it's just a compatible node of the parent 
node.

>  
>    clocks:
>      maxItems: 1
> @@ -34,22 +43,39 @@ properties:
>  
>  required:
>    - reg
> -  - reg-names
>    - clocks
>    - clock-names
>    - "#phy-cells"
>  
> +oneOf:
> +  - required:
> +      - brcm,syscon-clkset
> +  - required:
> +      - reg-names
> +
>  additionalProperties: false
>  
>  examples:
>    - |
>      #include <dt-bindings/clock/bcm-nsp.h>
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

A specific compatible is needed for this block.

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

Is this going to expand to 0x1a4/4 child nodes? The problem with one 
node per register is I don't know when it ends and you have to 
constantly update your DT.

Rob
