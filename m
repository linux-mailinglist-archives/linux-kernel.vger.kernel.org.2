Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5A34D1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhC2NrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhC2Nql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:46:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC4C061574;
        Mon, 29 Mar 2021 06:46:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j9so11208446wrx.12;
        Mon, 29 Mar 2021 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fddk+qv8UJfczImeuAqflr8tlEyX+yc2b+zWaj55sgA=;
        b=BoJnjCr0tIsIlLAM3ga49aWB6PlgHKVLZXcWuCB+a9OWArIY71D1usPH0Wm+bsY8vA
         PhoMkAzBbRNkUgCLrrHXrX5Se4n89fqekjlAtvlfnvkalsY9NW9ACt0HnXl7qy4XEMnA
         KecK8uSXtYRu1nuFmYYQ4MyiW6N/atrqHebR0pBSBf8/4MCVHJp5rTvcF49eWrSirGgo
         5r8iWZcr4nqKqA/4epm5AqDAdzPFgWZwPLfPLWQy9aYj2FqA01H+XzWr32y7NYQlvR88
         SvYaoOhAtYU7qI2EGmRn/4a8Uk8pWRbRpbboYTlF1iGz481v74bBqrIO8ttrOpF8D/fx
         6hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fddk+qv8UJfczImeuAqflr8tlEyX+yc2b+zWaj55sgA=;
        b=EuwqPAOfwpPMKt9Nu+gWEjDp8tEy/6e47WdVxZlggX72DnKsFy4Trq6u2uIoFXXkpz
         nAHfL08E6+lQlAbmW7lPoawEqMCyvwZD0HdKeyOTRPn4IXZwB63JTo6OmidSp4Xz2lf4
         4ubUGMnJK3gpNWxgZw4g+wjTIarKN9h5grzfxAzWu+c3I+FRf8GKpI0Cc6npmwQR/dFz
         gC3eYtuHfbXQnvsQuHYqNz11VxyD4ux2X46A9aX0GBbscUb9wlUifLAl94k7xd27GnNx
         GTnsJ196M0dMcT0WVoINRPbIFsH7+oIgiRJyYUz0EUro/c3dyyWX7fkqv2K+2vkLcWI/
         FfZw==
X-Gm-Message-State: AOAM533fXZDU/+Ujzu80b3ck+Ls0uqsFTmqbQDL+AzemvvbNWdq9p6T9
        3e31M2SxvjUqxYMPzyuwRGhQH7PqHXyJ/w==
X-Google-Smtp-Source: ABdhPJzCNweHlfMu3tJ8ncNx1C9Tl3Kr3IlwwNZX3f4HHFLINKz4ouGVZzSu2PRZOBQs4iscfaMCXg==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr28666138wrr.49.1617025599382;
        Mon, 29 Mar 2021 06:46:39 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id 81sm25642323wmc.11.2021.03.29.06.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:46:38 -0700 (PDT)
Subject: Re: [PATCH v5 06/13] arm64: dts: mediatek: mt8173: fix dtbs_check
 warning
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
 <20210316092232.9806-6-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <56fdac32-b106-10fb-64ff-c04d67603537@gmail.com>
Date:   Mon, 29 Mar 2021 15:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-6-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> Harmonize nodes names, compatibles and remove unused property.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts64

> ---
> v2~v5: no changes
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 13 +++++++------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 6dffada2e66b..0ce81c4fe81e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -516,10 +516,8 @@
>  	extcon = <&extcon_usb>;
>  	dr_mode = "otg";
>  	wakeup-source;
> -	pinctrl-names = "default", "id_float", "id_ground";
> +	pinctrl-names = "default";
>  	pinctrl-0 = <&usb_id_pins_float>;
> -	pinctrl-1 = <&usb_id_pins_float>;
> -	pinctrl-2 = <&usb_id_pins_ground>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index ecb37a7e6870..003a5653c505 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -631,7 +631,7 @@
>  			#mbox-cells = <2>;
>  		};
>  
> -		mipi_tx0: mipi-dphy@10215000 {
> +		mipi_tx0: dsi-phy@10215000 {
>  			compatible = "mediatek,mt8173-mipi-tx";
>  			reg = <0 0x10215000 0 0x1000>;
>  			clocks = <&clk26m>;
> @@ -641,7 +641,7 @@
>  			status = "disabled";
>  		};
>  
> -		mipi_tx1: mipi-dphy@10216000 {
> +		mipi_tx1: dsi-phy@10216000 {
>  			compatible = "mediatek,mt8173-mipi-tx";
>  			reg = <0 0x10216000 0 0x1000>;
>  			clocks = <&clk26m>;
> @@ -926,7 +926,7 @@
>  		};
>  
>  		ssusb: usb@11271000 {
> -			compatible = "mediatek,mt8173-mtu3";
> +			compatible = "mediatek,mt8173-mtu3", "mediatek,mtu3";
>  			reg = <0 0x11271000 0 0x3000>,
>  			      <0 0x11280700 0 0x0100>;
>  			reg-names = "mac", "ippc";
> @@ -943,8 +943,9 @@
>  			ranges;
>  			status = "disabled";
>  
> -			usb_host: xhci@11270000 {
> -				compatible = "mediatek,mt8173-xhci";
> +			usb_host: usb@11270000 {
> +				compatible = "mediatek,mt8173-xhci",
> +					     "mediatek,mtk-xhci";
>  				reg = <0 0x11270000 0 0x1000>;
>  				reg-names = "mac";
>  				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
> @@ -955,7 +956,7 @@
>  			};
>  		};
>  
> -		u3phy: usb-phy@11290000 {
> +		u3phy: t-phy@11290000 {
>  			compatible = "mediatek,mt8173-u3phy";
>  			reg = <0 0x11290000 0 0x800>;
>  			#address-cells = <2>;
> 
