Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA134D1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhC2Nrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhC2NrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E63C061574;
        Mon, 29 Mar 2021 06:47:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso8571981wmq.1;
        Mon, 29 Mar 2021 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvzgiV2nSwBn6Q8dJPr/Ctf77sdhvnpJP3sNw2DTkQM=;
        b=i8QSVI0D3LEga2X5WIQ3W3/mZv3QboeegLFcBkjwjtp7EYuoVIWme1JwudklBmykEE
         nlJQxBXLOdXKNkZeztN2c+Xipn7JupOACYUvhfuLFRhHepeYT9Blt/KxmZSgfjrkr8G4
         Nu+cbfnjTqO6z9tc1lveJaU9tp24dTS62j+JSdMtvdjKcf3qPlc1dW/Gi0RIng2cLUmn
         ZqwlYXBDhEvsq2nEjg+YwhjgoyxYxVQswSAkETdh1Rc38zFtZ/s59gzS9gCsBOC5HxUx
         tjXTk8118zWLy9cMgbi50XAX/oiyEiyjgvH4YH0Oo2H1CqzMh3wUZH+PdS1CKX9Od2OI
         83vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvzgiV2nSwBn6Q8dJPr/Ctf77sdhvnpJP3sNw2DTkQM=;
        b=ilbVZ5Ue4UPpmqZtUax18C1galkvx5Gde4ptdIRApBzSyV1cLS/HpXZVP7suMd5mFH
         vxLiCUC8Uw8yQttSenxC+UMzzvhPU7684q3BoRSjsuoCsmkhk5f+PD1wKrWvqIEXA+U+
         DEf3SEr3CkMwTg6YR0z8gIj1VCN0qxt0ruBSGoghI+Gncaxeza0s1tQmgXU8bWHMQKAL
         tcGWgS73/Gnibj2XOaqjdLqcVfARSLe1gTKNnNTGfuZfpPCHEwyHJ0Hspauqxvb03tKJ
         qW4x7zE66glI7Z0IKWekDefytYyG/y57v9kFBxlUdS0NTHOF97vCOimo7/pJjoPHn9RF
         7QpQ==
X-Gm-Message-State: AOAM5334LCR6aBtQ2qedi+Gm+fppq8kqEtaZToNkytsyB9CcmQz9nXjZ
        Eaw2+jRkgfa9N5dMD8xDPAB6s0vCm8wePQ==
X-Google-Smtp-Source: ABdhPJyGvufcTPc2hzUFUUCpwwx6QBJ/M0LmHOUV1Yhmv35Zc+bNMvcSZk8TgVOu9KQY9NndjIFCGw==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr25371592wmi.84.1617025632328;
        Mon, 29 Mar 2021 06:47:12 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id z1sm29922043wru.95.2021.03.29.06.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:47:11 -0700 (PDT)
Subject: Re: [PATCH v5 10/13] arm64: dts: mediatek: mt8183: fix dtbs_check
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
 <20210316092232.9806-10-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a744a9ae-2687-39ec-332e-09ec5fdf6fb0@gmail.com>
Date:   Mon, 29 Mar 2021 15:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-10-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> Harmonize node names, compatibles and properties.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts64

> ---
> v4~v5: no changes
> v3: remove property clock-names suggested by CK
> v2: no changes
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 80519a145f13..8882d35ac6ab 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -880,7 +880,7 @@
>  			ranges;
>  			status = "disabled";
>  
> -			usb_host: xhci@11200000 {
> +			usb_host: usb@11200000 {
>  				compatible = "mediatek,mt8183-xhci",
>  					     "mediatek,mtk-xhci";
>  				reg = <0 0x11200000 0 0x1000>;
> @@ -923,11 +923,10 @@
>  			status = "disabled";
>  		};
>  
> -		mipi_tx0: mipi-dphy@11e50000 {
> +		mipi_tx0: dsi-phy@11e50000 {
>  			compatible = "mediatek,mt8183-mipi-tx";
>  			reg = <0 0x11e50000 0 0x1000>;
>  			clocks = <&apmixedsys CLK_APMIXED_MIPID0_26M>;
> -			clock-names = "ref_clk";
>  			#clock-cells = <0>;
>  			#phy-cells = <0>;
>  			clock-output-names = "mipi_tx0_pll";
> @@ -946,11 +945,10 @@
>  			};
>  		};
>  
> -		u3phy: usb-phy@11f40000 {
> +		u3phy: t-phy@11f40000 {
>  			compatible = "mediatek,mt8183-tphy",
>  				     "mediatek,generic-tphy-v2";
>  			#address-cells = <1>;
> -			#phy-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0 0x11f40000 0x1000>;
>  			status = "okay";
> 
