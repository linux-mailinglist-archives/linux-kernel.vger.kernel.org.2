Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15CC3B1A85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFWMzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:55:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F6C061574;
        Wed, 23 Jun 2021 05:53:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nd37so3892728ejc.3;
        Wed, 23 Jun 2021 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AoXX4SX7rV+WFRuHMMsSXZsHaxT12D2qXpCC8mveCBs=;
        b=bc+fJMq0Nexc4x+TzqlhSZ91XKaf2VqAOdF1oK+kLmTwkV6yJ6tip+JSiZOKXnewXq
         kv0xPhCnZa5Ysf83zcnmzM+14SEIpePLzNMVfqYLQ5GrCYe2Fo1x0EiOC/ryM3VCJT3x
         JR11HX8L23w9EW8/m37LWYCssXg0X3A05jan4LArGwaNZeeqbq4tLKWiZXBG00GREk/Z
         4JK8mtZ0O/VhirYb7MIPuiHQRLYJCpbcdp8hH9oDt/ks65hUztqi/kMF/bM97ktKdTen
         yqg6oSf+WtpkBkzSXzZr9RSHaFNQHJjennWtgZ42H0dup6ZQSSQnaeTTACo4TJFICMBl
         aK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoXX4SX7rV+WFRuHMMsSXZsHaxT12D2qXpCC8mveCBs=;
        b=b+y+SZmMwWER7CuxzlaSPI+J5Vht8hgDgurpXK6DmG04wHiStisCyhK5zGsWCu7Ejv
         Y2a/qNroc98gSmIV/+1JgLl0T9hhzaJNf8vUdwkEk/SrjldgE+bNBLxZLIBlUFF7N/SA
         b2jpe6Rr+Uh9kLQsxPiWtkAZszQZ+96Q1MatZKWnzFokZfjjqUua1gS9arOqmYGrQH4Y
         pD4tYH4GaQz0pegzijD7/iuP2pYUxWw1lo2rYxDfkdUbcSZ92v6vBp+N+ZVAnfdqFSe8
         iKezwkveaG1MB+bBtg3gNNSwcwmcW92pCyIpJUNeilmnmdIRtxgK5PS4UalIwrM4Frm7
         sSUg==
X-Gm-Message-State: AOAM533PI1OUxzvPNhGGe6L0XVUVdcMzg+lPkZJzooOmQ/OErKt0gfO0
        vOISYePD+iTSJQD1aKYzHdeWuzgS1jU6qw==
X-Google-Smtp-Source: ABdhPJx+iMhYgPNTj4qUhJF40jNYvuXqAcXmr1VTDM8EkTlVRQUuL1iTiitmPKM+lsoudUPfaH/kKw==
X-Received: by 2002:a17:906:841:: with SMTP id f1mr6680570ejd.308.1624452804700;
        Wed, 23 Jun 2021 05:53:24 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm13449981edx.4.2021.06.23.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:53:24 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210623120001.164920-1-knaerzche@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c30377a1-90aa-d79e-a60a-5bc1a8e18c44@gmail.com>
Date:   Wed, 23 Jun 2021 14:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623120001.164920-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

On 6/23/21 2:00 PM, Alex Bee wrote:
> RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
> boards have sdio wifi connected to it. In order to use it
> one would have to add the pinctrls from sdmmc0ext group which
> is done on board level.
> 
> While at that also add the reset controls for the other mmc
> controllers.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index da84be6f4715..c13fa2f3f4cd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -858,6 +858,8 @@ sdmmc: mmc@ff500000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_MMC0>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>  
> @@ -870,6 +872,8 @@ sdio: mmc@ff510000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_SDIO>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>  
> @@ -882,6 +886,8 @@ emmc: mmc@ff520000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_EMMC>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>  
> @@ -980,6 +986,20 @@ usb_host0_ohci: usb@ff5d0000 {
>  		status = "disabled";
>  	};
>  

> +	sdmmc_ext: dwmmc@ff5f0000 {

/arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: dwmmc@ff5f0000:
$nodename:0: 'dwmmc@ff5f0000' does not match '^mmc(@.*)?$'

> +		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
> +		reg = <0x0 0xff5f0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_SDMMC_EXT>, <&cru SCLK_SDMMC_EXT>,
> +			 <&cru SCLK_SDMMC_EXT_DRV>, <&cru SCLK_SDMMC_EXT_SAMPLE>;
> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +		fifo-depth = <0x100>;
> +		max-frequency = <150000000>;
> +		resets = <&cru SRST_SDMMCEXT>;
> +		reset-names = "reset";
> +		status = "disabled";
> +	};
> +
>  	usbdrd3: usb@ff600000 {
>  		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
>  		reg = <0x0 0xff600000 0x0 0x100000>;
> 
