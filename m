Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACA45E128
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356606AbhKYTue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350222AbhKYTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:48:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961CEC0613F4;
        Thu, 25 Nov 2021 11:44:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so29809271edc.6;
        Thu, 25 Nov 2021 11:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9oU1uXkriAScBT39Syg/FKdxMTMlNc0lBFBBQ20vggw=;
        b=JPHd9H3xP1jgvn5m4y21YhcKXqZIu/T7fmE2AkgGyO5anSKGRQiZ8blYyEHwr5giH/
         4VmsEIsQ+3wlv5BnT2OA4Cl4B0IXP7eEyFTWel9hinLR3sOIoCJO6SuYvpxHcyjXp6jM
         NxP3ccnej5BnWEEWt0/ig+1B4wp4rqpE4L4Wnpq7OjWh5RZ3r7ch4thiiM4RwHU+YHa3
         12J8noIJ9cioC0bxD/78KT4mRWVS3d28hWvfLVg+sHpPEaARnU64Si5ADH0nkt5H8i6S
         i0Dcigb/zDaXvV9Jf+91MPzxOrR+C2SaB1j8rCYH6bc0U5HroQCLP1TvNU5Kujn+pC03
         dPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9oU1uXkriAScBT39Syg/FKdxMTMlNc0lBFBBQ20vggw=;
        b=HqzmHDq4c0o2dS+O2pt3ksDz3357kwhKax7x0s8TjhVi02xzIrRGFPRAkxNugSri9M
         CyoalT9cX1u9eKNsPBuy0EaNJUhSptnbUK1SyTukoT5/cIjOHBNczXncmWXLROOZHaPU
         irAmPnR5wInKewtGw1KLHZht8whWW+pAgQLTaNo4mkucNlTMex1XVHcn0oXQj4ZYBnbk
         tSH+fJGJMUh1wDdNfwVZhnaZHNAhI3DJn7O/Hse7tpf73ySj/n4+YidkZdVniuyYe0+H
         aoUbBjwjR0SMVKHgpWnInOFo3MgCQyapnoI+veAtdBG95T/zSW5wGN+glDfFLKjCFv2q
         MYqw==
X-Gm-Message-State: AOAM530IOiTVR0zjX/8TEIcUDt8hpIkFo6bTNiriqZaAmfzftNbqtHx8
        fMiZZtJYHErLUFT5VRb9mqQ/H3iZMhU=
X-Google-Smtp-Source: ABdhPJwSUdOD7SkfpYIj1CJ/H6tTynOlhCey4yG3EibrwCFGYc6TrtV7+5IkHQMGUFdN/ktderw++Q==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr34540749ejc.142.1637869458116;
        Thu, 25 Nov 2021 11:44:18 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e15sm2465981edq.46.2021.11.25.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 11:44:17 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: enable vop2 and hdmi tx on
 quartz64a
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     s.hauer@pengutronix.de, benjamin.gaignard@collabora.com,
        hjc@rock-chips.com, heiko@sntech.de, pgwipeout@gmail.com
References: <20211117143347.314294-11-s.hauer@pengutronix.de>
 <20211117154429.2274443-1-michael.riesch@wolfvision.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <db4731a5-56b9-f1f8-2d3f-c62bb7e3b91a@gmail.com>
Date:   Thu, 25 Nov 2021 20:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117154429.2274443-1-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 4:44 PM, Michael Riesch wrote:
> Enable the RK356x Video Output Processor (VOP) 2 on the Pine64
> Quartz64 Model A.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 4d4b2a301b1a..9fba790c6af4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -205,6 +205,16 @@ &gmac1m0_clkinout
>  	status = "okay";
>  };
>  
> +&hdmi {

> +	status = "okay";
> +	avdd-0v9-supply = <&vdda_0v9>;
> +	avdd-1v8-supply = <&vcc_1v8>;

Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

> +};
> +
> +&hdmi_in_vp0 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> @@ -546,3 +556,17 @@ bluetooth {
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&vop {

> +	status = "okay";

status below

> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0_out_hdmi {
> +	status = "okay";
> +};
> 
