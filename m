Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5289433181C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCHUHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:07:53 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:45479 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCHUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:07:48 -0500
Received: by mail-il1-f176.google.com with SMTP id s1so9984718ilh.12;
        Mon, 08 Mar 2021 12:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hb9MlUCruG+kWO1lKH57/wKc+G9ftT/gzGlYNA3L+cY=;
        b=JkJ/VNkRafUxVKCF0seLnBDooS6tEx29CKQ0VzGsekx+BS9ySnbP0CoIKjxeSssH4Y
         xX3QLTeqZmaB00kDOizCifPOb6/0hxvQnvrrOrHWOtGsQI3oDCgjydlME8lF6GfpuRKn
         LdbHkiw8+PDOVv7Y94KKYZW0smtrnSg4OSi8YOuP0+kyR1y2HmjLTB+HW/9IfuLR2lMp
         AK8s/wD0w9pPcky1uv6RGBADSugwephBE74e7TIdPYvXE+X96++6gYmeR2c+ZFygQery
         LtDEz7arQ5wk/A3jVXs089x1D4HFzVjg47pkodcTVW3RUhDwMn/JAr6+RCfxVgUH9Giy
         yLyA==
X-Gm-Message-State: AOAM532Tw3Vht8fbGjixG3BBaCMmF+6PNbbh2nGncaJ0NXNg5aeoIPm5
        AA4VhwLMj8uMVBOHZD94hw==
X-Google-Smtp-Source: ABdhPJxJSPHeVH4KC5FKA9esv3cMQl9/CgiicCpLVF3hxcpaQHUSFrOy1AD0/tRq282E/iRzM+XXBw==
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr20569869ilv.145.1615234068215;
        Mon, 08 Mar 2021 12:07:48 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b20sm6421949iod.22.2021.03.08.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:07:47 -0800 (PST)
Received: (nullmailer pid 2877901 invoked by uid 1000);
        Mon, 08 Mar 2021 20:07:46 -0000
Date:   Mon, 8 Mar 2021 13:07:46 -0700
From:   Rob Herring <robh@kernel.org>
To:     Vic Wu <vic.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mediatek - remove obsolete documentation
Message-ID: <20210308200746.GA2870408@robh.at.kernel.org>
References: <20210303093950.20309-1-vic.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303093950.20309-1-vic.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:39:50PM +0800, Vic Wu wrote:
> The crypto mediatek driver has been replaced by the inside-secure driver now.
> Remove DT bindings documentation and update crypto engine nodes to the mt7623.dtsi files.

Wrap lines.

> 
> Signed-off-by: Vic Wu <vic.wu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/crypto/mediatek-crypto.txt       | 25 -------------------
>  arch/arm/boot/dts/mt7623.dtsi                 |  8 +++---
>  2 files changed, 3 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt b/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> deleted file mode 100644
> index 450da3661cad..000000000000
> --- a/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -MediaTek cryptographic accelerators
> -
> -Required properties:
> -- compatible: Should be "mediatek,eip97-crypto"
> -- reg: Address and length of the register set for the device
> -- interrupts: Should contain the five crypto engines interrupts in numeric
> -	order. These are global system and four descriptor rings.
> -- clocks: the clock used by the core
> -- clock-names: Must contain "cryp".
> -- power-domains: Must contain a reference to the PM domain.
> -
> -
> -Example:
> -	crypto: crypto@1b240000 {
> -		compatible = "mediatek,eip97-crypto";
> -		reg = <0 0x1b240000 0 0x20000>;
> -		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&ethsys CLK_ETHSYS_CRYPTO>;
> -		clock-names = "cryp";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
> -	};
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index aea6809500d7..25e3f3b04123 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -949,16 +949,14 @@
>  	};
>  
>  	crypto: crypto@1b240000 {
> -		compatible = "mediatek,eip97-crypto";
> +		compatible = "inside-secure,safexcel-eip97";

Please read what the new binding says about this compatible string.

>  		reg = <0 0x1b240000 0 0x20000>;
>  		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
> +			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;

Where did the extra interrupt go?

> +		interrupt-names = "ring0", "ring1", "ring2", "ring3";
>  		clocks = <&ethsys CLK_ETHSYS_CRYPTO>;
> -		clock-names = "cryp";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;

Suddenly the h/w is not in a power domain?

Seems to me 'mediatek,eip97-crypto' should be added to the common driver 
without having a dts change.

Rob
