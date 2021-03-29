Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADC34D1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhC2NrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhC2Nqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:46:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849EBC061574;
        Mon, 29 Mar 2021 06:46:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o16so12986863wrn.0;
        Mon, 29 Mar 2021 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VSdiOrRt5A5A6ik3jTpUtYldOZfvz8Pi38YucpFr6l8=;
        b=MCxyXVvcvdvVoXMVp3fxHBlxeNbm0IApsEt53rYdfT2KvWP0Fy3id135pTc+dZdIDX
         6QFBnBke6LhWl4locC7ajLCVbNeUazqfvD9XrUawL/6kzf1V6XNjNAFSALC3tSpoX+kR
         KaR/AMntZT04YpyR7jX3BQ1+YuPpe+yebmmeIaZ9UsI67dSoXTQLk37WTCDQnhOYrN4d
         evwlIxgxwKu25DZsI2jtFL5GI4oUY/L0SEqeAs6Lk7ItE8f3sZt+MfZsD4ZAHomL6tPs
         H9y5KR/OkI47MRN93bfq3yW2kfx4kzR6usGKGrwuCtHV4Ss9EFHrsRBzPBhpM0xPNpX1
         +VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSdiOrRt5A5A6ik3jTpUtYldOZfvz8Pi38YucpFr6l8=;
        b=lO9aZWqm4Cxg3orzrZGD35Su+AtZuMgLBe0YEOvvThfx/X6PIxMI26Hg6X53rttPgo
         kobV/crmlJfeZR4D0SdIlFkLg1sY9pZ51sWF+/kx/r+SNE7aMqnkKCWFwTfJgOzRiKKY
         amAiRwAiRUoAZVFM04KqbkR2fzO/7/TuaipruubMPWaLXNyPK3R/t3VJS5lTTZ3E/Bkp
         TEi+N7KM8j13HaKspUhvCgmV7g9IorStVmkJ+/qN09m0Irw4r72WJkyfdQEm4lWqaqZ6
         HTXyKfDb8h23Fd843oERD28czr0/GqHfUDBAdpw6R3ZA2bf72SNZnj1gPC2Bf1oM1K01
         mHWQ==
X-Gm-Message-State: AOAM532fvBb2VMdzHHJ2VyY8r7OlOLNM+JgP+pDhPFdIVsqGC64q1oFD
        c2m19K6vGr5Pzf4vILhEAO+lt1/50hoCNQ==
X-Google-Smtp-Source: ABdhPJzGJUBfC8jn1gAhsDG4i4XVmBFR5fUJC6pZnEJYT0DqoJ040+EuDixRc4Y8BFCQ2QHGOqdung==
X-Received: by 2002:a05:6000:1a8a:: with SMTP id f10mr27951844wry.232.1617025609329;
        Mon, 29 Mar 2021 06:46:49 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id x14sm29409219wrw.13.2021.03.29.06.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:46:48 -0700 (PDT)
Subject: Re: [PATCH v5 07/13] arm64: dts: mediatek: mt2712: harmonize node
 names
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
 <20210316092232.9806-7-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f4ab274f-3dd4-69f3-2bd3-cc786491bad8@gmail.com>
Date:   Mon, 29 Mar 2021 15:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-7-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> This is used to fix dtbs_check warning.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts64

> ---
> v2~v5: no changes
> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index db17d0a4ed57..a9cca9c146fd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -805,7 +805,7 @@
>  		ranges;
>  		status = "disabled";
>  
> -		usb_host0: xhci@11270000 {
> +		usb_host0: usb@11270000 {
>  			compatible = "mediatek,mt2712-xhci",
>  				     "mediatek,mtk-xhci";
>  			reg = <0 0x11270000 0 0x1000>;
> @@ -818,7 +818,7 @@
>  		};
>  	};
>  
> -	u3phy0: usb-phy@11290000 {
> +	u3phy0: t-phy@11290000 {
>  		compatible = "mediatek,mt2712-tphy",
>  			     "mediatek,generic-tphy-v2";
>  		#address-cells = <1>;
> @@ -869,7 +869,7 @@
>  		ranges;
>  		status = "disabled";
>  
> -		usb_host1: xhci@112c0000 {
> +		usb_host1: usb@112c0000 {
>  			compatible = "mediatek,mt2712-xhci",
>  				     "mediatek,mtk-xhci";
>  			reg = <0 0x112c0000 0 0x1000>;
> @@ -882,7 +882,7 @@
>  		};
>  	};
>  
> -	u3phy1: usb-phy@112e0000 {
> +	u3phy1: t-phy@112e0000 {
>  		compatible = "mediatek,mt2712-tphy",
>  			     "mediatek,generic-tphy-v2";
>  		#address-cells = <1>;
> 
