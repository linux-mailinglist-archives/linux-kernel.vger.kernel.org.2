Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D763C34D1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhC2NsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhC2Nrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32CC061574;
        Mon, 29 Mar 2021 06:47:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v4so12899193wrp.13;
        Mon, 29 Mar 2021 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDEzUvKkjAIAvpEGtHLesvgMticNcLTXLAP3FMyOp20=;
        b=QgMv/ynDdRRfWLLD1H+6oPildJRa0NtXPSoikSLeCdIBE9YYdG9IhWa3D0NHkYueHe
         8chQPBQz5nGPtY9fgNvn9APGFCv6tmTskaHuxDYLAJmQQ9a8TDj+H/Mds222JcgNMPdn
         UH2Jvu2nq9lc8DlHoRfJveHMdC8kgU/2tB7M65tY41CEth45jvkrap7CtyHshYRJ3VBx
         aDhyqbRUyg7O/cZBPJsVP7uLx3UMHWekrJOYgJhUIk93zpV+YhvS3Ky0ydwFcirY0E6p
         Zf7IN+mNu9Sf9MUFmyPW/CWXNWJWotMApizLID1AuUkyC5hb4QK1H++JUgU1QdLJKel2
         rFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDEzUvKkjAIAvpEGtHLesvgMticNcLTXLAP3FMyOp20=;
        b=Gw7agG7ejgAYb4JEpUGJlIA7SFmfvPPhfTiUTW6eHkhpCHKyEZ03Y294/WtclBmR65
         3PjjSHhc0jAkznw+LerjMUvYtTru1msGTqaEH9MyPfNzn/PCON4zxP+OaeEdLrFKPynQ
         vVqE+nS+cWIUfoWbxg4ISSdgvGcIn79XZPNvccVIMxk4iHc55RQjTA3Rc5idZ72asnJp
         M2HkFCL7ZxQ0KvUECDs079jzkSHKj1DsS2NYOJQitzu3UTo3JI07Zrh1djyLpDuSnsGz
         lIB7ZFq7VKPRWKE0iQX5sD+Qx9u9FOv6KG3VTUVU4IdNQ/ZRSt2NsrTcHjAxBAmizb7k
         ijbQ==
X-Gm-Message-State: AOAM531GhMOMRBkm1G7/i6hAmTtjMgxnqGIWX14Hun7YNbOXbwDxADex
        bUVuIQeqZBwiF2qCK0fY1uMmDzSdWa/YcQ==
X-Google-Smtp-Source: ABdhPJyzByzyqLM6tlsL+vq+denDIyXkVf9F+7u6Otbf7WudUQp4OKErhkmujtGBPS5iAhA+nISOvg==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr29064992wrs.229.1617025662200;
        Mon, 29 Mar 2021 06:47:42 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id y205sm30561793wmc.18.2021.03.29.06.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:47:41 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] arm: dts: mt2701: harmonize node names and
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
 <20210316092232.9806-13-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b6e523bb-8991-b5e8-576d-55190e7fc49f@gmail.com>
Date:   Mon, 29 Mar 2021 15:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-13-chunfeng.yun@mediatek.com>
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
>  arch/arm/boot/dts/mt2701.dtsi | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index fade14284017..4776f85d6d5b 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -607,7 +607,7 @@
>  	};
>  
>  	usb0: usb@1a1c0000 {
> -		compatible = "mediatek,mt8173-xhci";
> +		compatible = "mediatek,mt2701-xhci", "mediatek,mtk-xhci";
>  		reg = <0 0x1a1c0000 0 0x1000>,
>  		      <0 0x1a1c4700 0 0x0100>;
>  		reg-names = "mac", "ippc";
> @@ -620,8 +620,9 @@
>  		status = "disabled";
>  	};
>  
> -	u3phy0: usb-phy@1a1c4000 {
> -		compatible = "mediatek,mt2701-u3phy";
> +	u3phy0: t-phy@1a1c4000 {
> +		compatible = "mediatek,mt2701-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a1c4000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -646,7 +647,7 @@
>  	};
>  
>  	usb1: usb@1a240000 {
> -		compatible = "mediatek,mt8173-xhci";
> +		compatible = "mediatek,mt2701-xhci", "mediatek,mtk-xhci";
>  		reg = <0 0x1a240000 0 0x1000>,
>  		      <0 0x1a244700 0 0x0100>;
>  		reg-names = "mac", "ippc";
> @@ -659,8 +660,9 @@
>  		status = "disabled";
>  	};
>  
> -	u3phy1: usb-phy@1a244000 {
> -		compatible = "mediatek,mt2701-u3phy";
> +	u3phy1: t-phy@1a244000 {
> +		compatible = "mediatek,mt2701-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a244000 0 0x0700>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -700,8 +702,9 @@
>  		status = "disabled";
>  	};
>  
> -	u2phy0: usb-phy@11210000 {
> -		compatible = "mediatek,generic-tphy-v1";
> +	u2phy0: t-phy@11210000 {
> +		compatible = "mediatek,mt2701-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x11210000 0 0x0800>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> 
