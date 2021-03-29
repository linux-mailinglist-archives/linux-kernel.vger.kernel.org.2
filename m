Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8187134D1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhC2NrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhC2NrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E34C061574;
        Mon, 29 Mar 2021 06:47:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so12910121wro.7;
        Mon, 29 Mar 2021 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LQo2IHbDrnsvLwx9E49b4vmdluvz5ztdZ0USfGdznpw=;
        b=hUH2tcrxar9RPvmx9tqIwFhRkLd9FYx4Q2uANYKC+xvb26EemiLSzxn08kH+GUKWcW
         9vyl3yVm8rAF2icwMClFF7/tHncCDp/MuSNXAdM0kHJYtO+AhrSSNJpmVYM6RlRuJr2a
         O7N4EqXkwFkLn8taYWfkLSRKBy/vS/v1DnlqULZJxrPr+8kKRQV6QeO4pf5Dm6DgEYuQ
         PZiTIX8+DB9xHxPFiUoTRmmcIWNIFqMiehQhVIyteOOUJs9/Xp2eKMiiEZP5D3b4DS/b
         JBEjIgzi0SXwDYua7diw0IGCh2zJ51u5gfb50O3+AcH49U2qgO1Lk5zpgp8yRsINOQBV
         L7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LQo2IHbDrnsvLwx9E49b4vmdluvz5ztdZ0USfGdznpw=;
        b=ak0TF18aL0N4us59/xm3i2VchaBk5K3fYhkRYx3ahrHMp85gikK8mt1RjlXBqzu3cd
         tiWBK3hN9YSVx7J5fg1FMTOwlkqzHOS13b7dGyVev3ZtPtOZeJJdr8A4E3ZYdf1Qv6oG
         FkfQRkNWfNyPKTo40dOG1uljQIrTnJlWtM6PxLRvZyr9P+gLW7zZK12BWEkFUfUbDCPN
         wyybR1jtnGXZKfrazQCPYzgk01hH+k+lQesw5CcK7vy9ei7khs5wdMa8evLQJWlDamfk
         HGFB8nN7hCzS5YWxHwedKGeGPexwpnYhnKkA8Tp42GNrqCYd34fcouM5hEHgFzgCw4B1
         qWDw==
X-Gm-Message-State: AOAM5331rifq+T9DNKD8sWB//ftIM/ENxe/WKdFFXsaOy4FCkQufDfvX
        XJEn/9C07OPHat+Zn6einm8EYJ0TaYoSJg==
X-Google-Smtp-Source: ABdhPJysDSrMY/1qPw5vBQij0RgaU13OWCnbwhhrcG2Ij3e9ZtM+LI2TTKmj3RKJAuKWx8X8klEhaA==
X-Received: by 2002:a5d:6542:: with SMTP id z2mr17102271wrv.205.1617025619676;
        Mon, 29 Mar 2021 06:46:59 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id b12sm31428854wrf.39.2021.03.29.06.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:46:59 -0700 (PDT)
Subject: Re: [PATCH v5 08/13] arm64: dts: mediatek: mt8516: harmonize node
 names and compatibles
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
 <20210316092232.9806-8-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ff4ab27b-5a76-0597-780c-7b101e1b0963@gmail.com>
Date:   Mon, 29 Mar 2021 15:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-8-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> This is used to fix dtbs_check warning:
>   harmonize node names and compatibles;
>   add property "usb-role-switch" for connector dependence.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts64

> ---
> v2~v5: no changes
> ---
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi         | 9 +++++----
>  arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index b80e95574bef..bbe5a1419eff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -480,7 +480,7 @@
>  		};
>  
>  		usb0: usb@11100000 {
> -			compatible = "mediatek,mtk-musb";
> +			compatible = "mediatek,mt8516-musb", "mediatek,mtk-musb";
>  			reg = <0 0x11100000 0 0x1000>;
>  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-names = "mc";
> @@ -493,7 +493,7 @@
>  		};
>  
>  		usb1: usb@11190000 {
> -			compatible = "mediatek,mtk-musb";
> +			compatible = "mediatek,mt8516-musb", "mediatek,mtk-musb";
>  			reg = <0 0x11190000 0 0x1000>;
>  			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-names = "mc";
> @@ -506,8 +506,9 @@
>  			status = "disabled";
>  		};
>  
> -		usb_phy: usb@11110000 {
> -			compatible = "mediatek,generic-tphy-v1";
> +		usb_phy: t-phy@11110000 {
> +			compatible = "mediatek,mt8516-tphy",
> +				     "mediatek,generic-tphy-v1";
>  			reg = <0 0x11110000 0 0x800>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index 63fd70086bb8..7d738f01cf8d 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -188,6 +188,7 @@
>  &usb0 {
>  	status = "okay";
>  	dr_mode = "peripheral";
> +	usb-role-switch;
>  
>  	usb_con: connector {
>  		compatible = "usb-c-connector";
> 
