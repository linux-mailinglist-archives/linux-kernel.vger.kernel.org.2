Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547F634D1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhC2Nru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhC2Nrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378FC061574;
        Mon, 29 Mar 2021 06:47:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x16so12927042wrn.4;
        Mon, 29 Mar 2021 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W351MbtZPqv7qJ77tVXfGqMA3tn9hsjpLQoPGH58vV8=;
        b=kv9ZybA80zOhmjIBaoGreSnFdPukXvit1IprLD7Pj8qvKyCG8ihu/NxhFgwvitOqHi
         dq5d8RnhSkjLBM6wEqSPE+4KSOApPXXvgleqU5k69B9rqOa+b/ZBstCyRoYLN7ZS4/OU
         cFUedqJrQK+OlhQE9E6P2IE2AxlqGOtmiKbHKwSX7tPBvSz9t1wSloGR2LFkvzu34gIP
         X8GhRbpV4w2bRsfwXl7OYzwDP0GSSVLZBrXJ0e+1b7GswWv9eGPWvPQyC5dLilbfPse1
         DUYCohPbFZHsJUb82fcaosrC7kGPWquSYV+otG/sqeaRAYLMW42ngT6QMoDepk5K5PKL
         rDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W351MbtZPqv7qJ77tVXfGqMA3tn9hsjpLQoPGH58vV8=;
        b=ialkakzskpngyZas7BpWTlga4gHkMIODShwShtnU/q+Saa2C928iOnSyj2HzpDKazy
         pURzvnZbcIOh3JC8v8JmaDMYdIkPgsNirb66ZgaCk27fNJ4AqQAYw2ZtZDknYwGvckbR
         /9SZij1xTZ9uE1F7GJHgJfTwmCXyTMkSEokD06WiKhu088sPvuzJu0bmvyGpGtsJvJ9o
         zlxloY8Pjqmy7bnAFz3shS4qxoerp7M63r8QysU+tyjQEk26WSbY7wzhiq2AZrefJbwm
         x9gGO0Ipv8iSQYLqx3/jMUjf5SuOlSlGlzLpBhwWFlbErOXbSd6/yWTKHwIorPgewn40
         YmLA==
X-Gm-Message-State: AOAM530jBARqdLyyWJWu7YQEWXIs+2D6djIA2zL+dl31rMqDExXfAr/q
        N3AqoCnI29O8pavugew/klHrGdEDANXosQ==
X-Google-Smtp-Source: ABdhPJxXGO9R/wMWd+TlB3G9feBlnxdBno7a47GaOgQqdLwM1OVa5hsBBhlZM+crSXpVxfzoxa6z2w==
X-Received: by 2002:adf:c10a:: with SMTP id r10mr29868077wre.40.1617025655240;
        Mon, 29 Mar 2021 06:47:35 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id x25sm28790150wmj.14.2021.03.29.06.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:47:34 -0700 (PDT)
Subject: Re: [PATCH v5 12/13] arm: dts: mt7623: harmonize node names and
 compatibles
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
 <20210316092232.9806-12-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a262f3aa-4a79-da90-81e4-6a3b2a9c7828@gmail.com>
Date:   Mon, 29 Mar 2021 15:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-12-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> This is used to fix dtbs_check warning
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts32

> ---
> v2~v5: no changes
> ---
>  arch/arm/boot/dts/mt7623.dtsi  | 26 ++++++++++++++------------
>  arch/arm/boot/dts/mt7623n.dtsi |  4 ++--
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index aea6809500d7..3c11f7cfcc40 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -787,8 +787,9 @@
>  		};
>  	};
>  
> -	pcie0_phy: pcie-phy@1a149000 {
> -		compatible = "mediatek,generic-tphy-v1";
> +	pcie0_phy: t-phy@1a149000 {
> +		compatible = "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a149000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -804,8 +805,9 @@
>  		};
>  	};
>  
> -	pcie1_phy: pcie-phy@1a14a000 {
> -		compatible = "mediatek,generic-tphy-v1";
> +	pcie1_phy: t-phy@1a14a000 {
> +		compatible = "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a14a000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -823,7 +825,7 @@
>  
>  	usb1: usb@1a1c0000 {
>  		compatible = "mediatek,mt7623-xhci",
> -			     "mediatek,mt8173-xhci";
> +			     "mediatek,mtk-xhci";
>  		reg = <0 0x1a1c0000 0 0x1000>,
>  		      <0 0x1a1c4700 0 0x0100>;
>  		reg-names = "mac", "ippc";
> @@ -836,9 +838,9 @@
>  		status = "disabled";
>  	};
>  
> -	u3phy1: usb-phy@1a1c4000 {
> -		compatible = "mediatek,mt7623-u3phy",
> -			     "mediatek,mt2701-u3phy";
> +	u3phy1: t-phy@1a1c4000 {
> +		compatible = "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a1c4000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -864,7 +866,7 @@
>  
>  	usb2: usb@1a240000 {
>  		compatible = "mediatek,mt7623-xhci",
> -			     "mediatek,mt8173-xhci";
> +			     "mediatek,mtk-xhci";
>  		reg = <0 0x1a240000 0 0x1000>,
>  		      <0 0x1a244700 0 0x0100>;
>  		reg-names = "mac", "ippc";
> @@ -877,9 +879,9 @@
>  		status = "disabled";
>  	};
>  
> -	u3phy2: usb-phy@1a244000 {
> -		compatible = "mediatek,mt7623-u3phy",
> -			     "mediatek,mt2701-u3phy";
> +	u3phy2: t-phy@1a244000 {
> +		compatible = "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a244000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
> index 1880ac9e32cf..bcb0846e29fd 100644
> --- a/arch/arm/boot/dts/mt7623n.dtsi
> +++ b/arch/arm/boot/dts/mt7623n.dtsi
> @@ -246,7 +246,7 @@
>  		status = "disabled";
>  	};
>  
> -	mipi_tx0: mipi-dphy@10010000 {
> +	mipi_tx0: dsi-phy@10010000 {
>  		compatible = "mediatek,mt7623-mipi-tx",
>  			     "mediatek,mt2701-mipi-tx";
>  		reg = <0 0x10010000 0 0x90>;
> @@ -265,7 +265,7 @@
>  		status = "disabled";
>  	};
>  
> -	hdmi_phy: phy@10209100 {
> +	hdmi_phy: hdmi-phy@10209100 {
>  		compatible = "mediatek,mt7623-hdmi-phy",
>  			     "mediatek,mt2701-hdmi-phy";
>  		reg = <0 0x10209100 0 0x24>;
> 
