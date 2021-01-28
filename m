Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086A6307BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhA1RMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhA1RKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459DC061786;
        Thu, 28 Jan 2021 09:09:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so6182366wry.2;
        Thu, 28 Jan 2021 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tEVqKu7FgZ3q3m21a4cGa3XUWQDQS1wP9EjmTKGEaoY=;
        b=MRqCu5mtJ+wjFomv0GrHbvuU3gJRB8Oa9rBSW5MmrlRHEI6YjzJuTGWjPDTjcpsHND
         TuNGR37KbLkob2dmJVtnnuU0F/1jBJlrTPnJtmRWjYAyJLHKRysU885nndZuTVf6Vcqo
         ij4xtisRWqKUMA1lpUCcji+T/PX0S8tNTuPf3aIZvBCb4RiZmQQc2g9lZt1c8COuyaX7
         0MEGQt945zI9rOjwYn/6lXKJtA7o/LnRTfv0u8Lu8zlATiCyKI6TZslsFY6dM3d7TmNr
         rSfxIi3c2RixwqbGMEJIa7sVRsuUuAoICvzmbMn6mQtC+GZhTp6ctwG+S1p7BJiNvP24
         MQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tEVqKu7FgZ3q3m21a4cGa3XUWQDQS1wP9EjmTKGEaoY=;
        b=AR5BKzweaukKY9s8IbCNXDfj4nE4R3VSRs/+eO6Ir38RvuOBmOWFGaCkij1VW1sfxg
         FwsXUHDb6g3z2Hubb8ZfDgwfJhlPa6lEtZaG+2OjHwJLbHQYTFhRfjgAr3hNSZf7Nx3r
         WstUY9F4wYOgeenqwEAH2CgBFh1nrgCD5n6HD8dbE/fpq7pAUnmfn5GWDEYT1zxsw7Ig
         sUy6uPG0F07T3F/n2g4GIj8KLhgVnsK9FirHEGFOOk8bK2XoPklYOy6lSmCVtQzBph2V
         99qKC1LDDMQrSl6cv31cj4IgvjCyRhkXI4olUtv692psolZtFqUFe+YOitwvaT4wNcQL
         bDzw==
X-Gm-Message-State: AOAM530YF8dF2j+pH5sfLk42dEZKPje8IhwjYlkSBuWhG2j7UukIR3vm
        UOhp+n/eaxejY5Rd87ZteCs=
X-Google-Smtp-Source: ABdhPJx3OAVUYMraz4xXNNRgbJXMdMzftTGhMi5Q+H8urVhjLESWRY74Z4FSwt4sUXjWfMNzL+fnMQ==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr17187188wrv.211.1611853776675;
        Thu, 28 Jan 2021 09:09:36 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d2sm8378815wre.39.2021.01.28.09.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:09:35 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mt8183: Add missing power-domain for pwm0
 node
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210113215723.71966-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <78b5a9be-1d2e-fc99-85a6-296872761f25@gmail.com>
Date:   Thu, 28 Jan 2021 18:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113215723.71966-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2021 22:57, Enric Balletbo i Serra wrote:
> The MT8183 display PWM device will not work until the associated
> power-domain is enabled. Add the power-domain reference to the node
> allows the display PWM driver to operate and the backlight turn on.
> 
> Fixes: f15722c0fef0 ("arm64: dts: mt8183: Add pwm and backlight node")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

applied to v5.11-next/dts64

Thanks!

> 
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index bda283fa9245..8471c973dfd5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -661,6 +661,7 @@ pwm0: pwm@1100e000 {
>  			compatible = "mediatek,mt8183-disp-pwm";
>  			reg = <0 0x1100e000 0 0x1000>;
>  			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  			#pwm-cells = <2>;
>  			clocks = <&topckgen CLK_TOP_MUX_DISP_PWM>,
>  					<&infracfg CLK_INFRA_DISP_PWM>;
> 
