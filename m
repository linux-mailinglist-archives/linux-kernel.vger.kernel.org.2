Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2834D1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhC2Nrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhC2Nr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1ABC061574;
        Mon, 29 Mar 2021 06:47:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x13so12920401wrs.9;
        Mon, 29 Mar 2021 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FK45Q4UevMt4C1ovIeZMlV1i3u3GKa0Tu00QKkrxNG0=;
        b=DamKu1sw/d6YP4J90Cj2Cn8C7Af1GXV9idjHNa+dQ5eLBfy7twFECt3SIxHWPdC1OD
         zKLvJjaiAhp0Q1TBfTHnYPWWLl3WM/wO6s2D7hffQbTLyjuMJXfMyS6okI2t7mkYOlZ+
         Gog2AIzdp33f/L19H1zus/SzRUQOkt18vCRtxtMwXVxLgRo0avaNuMjkTO0xTAVLQ44T
         Tah4xSiq7QkD97+SJmDuO+GUW+W432TsUvfiA4Y6AskUURuxFw+rqPwrZ7tXMUNqPrve
         RN/AAgfVwYXZVCBY4I7OalgdmZ3O1D9w80IBJMHfuvxEnfkEYhQh8m2uMN/HqCl+TJbU
         wM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FK45Q4UevMt4C1ovIeZMlV1i3u3GKa0Tu00QKkrxNG0=;
        b=Eh6lYGI/53HAfS9n807r2lsLxkfZFbcXKb4oNA8ixrhAhMOAOFnjnj7rrGkqXmt7Ch
         TbciAzsgsWpzM+WjLDsIB1Pl+FRU0vW1xB9vQqSbcbR4IMRVkonrKJV2TUcYvz+Dn7tB
         XHzxP7yA6ydr+cOmzowQvVlqOull+2trii8aMgz+R2ajehZie9sL9auCi/tdC26IcvBp
         va/fli4nNH/hJlJ20UeUNZlwof2N5wXBMe/2y5vCb0YV8Oi9oSUVQqvrpjaOwB+9nIEI
         xRRxmt8tKvq/quml8JXAoTHBoUHyQ1lRH3qjx3jEAQW/1Bofyz2nIOW8ICIiKu0eGEHr
         cogg==
X-Gm-Message-State: AOAM532TGtpiG5zFc97ERxbXSeVWsGXsRoW5u75vx2D0oFcL6zbgE4Km
        s6jHNewsLt6MUnh0DeOT08FFTIAR+gJD2w==
X-Google-Smtp-Source: ABdhPJwMsREL7zHuATNR2GnBeA2/RuGUZ0DDadqnklrQuaoy06/CcvgFgav5KVcwSP2TiD1bV+A+fg==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr28076521wrw.289.1617025647683;
        Mon, 29 Mar 2021 06:47:27 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id m17sm30886347wrx.92.2021.03.29.06.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:47:27 -0700 (PDT)
Subject: Re: [PATCH v5 11/13] arm: dts: mt7629: harmonize node names and
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
 <20210316092232.9806-11-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c40af3a0-e28c-00e4-e2e0-e29d5166215a@gmail.com>
Date:   Mon, 29 Mar 2021 15:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-11-chunfeng.yun@mediatek.com>
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
>  arch/arm/boot/dts/mt7629.dtsi | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
> index 5cbb3d244c75..874043f0490d 100644
> --- a/arch/arm/boot/dts/mt7629.dtsi
> +++ b/arch/arm/boot/dts/mt7629.dtsi
> @@ -329,8 +329,9 @@
>  			status = "disabled";
>  		};
>  
> -		u3phy0: usb-phy@1a0c4000 {
> -			compatible = "mediatek,generic-tphy-v2";
> +		u3phy0: t-phy@1a0c4000 {
> +			compatible = "mediatek,mt7629-tphy",
> +				     "mediatek,generic-tphy-v2";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0x1a0c4000 0xe00>;
> @@ -413,14 +414,15 @@
>  			};
>  		};
>  
> -		pciephy1: pcie-phy@1a14a000 {
> -			compatible = "mediatek,generic-tphy-v2";
> +		pciephy1: t-phy@1a14a000 {
> +			compatible = "mediatek,mt7629-tphy",
> +				     "mediatek,generic-tphy-v2";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0x1a14a000 0x1000>;
>  			status = "disabled";
>  
> -			pcieport1: port1phy@0 {
> +			pcieport1: pcie-phy@0 {
>  				reg = <0 0x1000>;
>  				clocks = <&clk20m>;
>  				clock-names = "ref";
> 
