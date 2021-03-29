Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7854F34D3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhC2P0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhC2P0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:26:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD4C061574;
        Mon, 29 Mar 2021 08:26:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g25so6854351wmh.0;
        Mon, 29 Mar 2021 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pVsxfbxI3K7GA4FFYH0yy3ggGjDTL25VjE0xUpkqj58=;
        b=WXDtbKB0+76S9xXdtQ6UIVOL98eUnJU766WdbNd+xYvGjtL8AOwVQpm9tG+igKGair
         hk7lm4iFc2636sXASZJi9HHOi/Jv3dokvUDsdU8ZUutqY0YoSrpqlA3NNDlGgnjaCoc4
         oUM9G1dcGQpjhKtBC0oJDoVQBNYZG+t5eo1nmAsC5TgEwMMGTWBK2UmEHzYyy7V5XWF/
         2fOowYxTQkzlKH7ils/Dqbi9zfEAF0m6jjx4Sf3KSNWVazCnn4fIQdReIXI364uDdCwQ
         QVeDjB9y2DmpUj0w/uWOUTnhRFZA8GknPiVaXN5w4d6UphRKdaKYjOkcPytNVQvAI31w
         3a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pVsxfbxI3K7GA4FFYH0yy3ggGjDTL25VjE0xUpkqj58=;
        b=eOG6MHlb+PEYzp3PXwh71b42pA+n4Uj4ZfYgl9qNMRRKY3tqLnsJOumy7UilXJXmrm
         zza07KVRV4GMAXCnzncfbXzlqcIGHDTiGEOvxB1B2qwON/4NR2oACv8u4151ntSD96M3
         ZJmo4q3cTmog+FzMLpfR08oIr2lb8H0rJ7faeSJty0GxVxBZL37LJK4txjxuw5XzWKPI
         g0kE2szemMw8iwAi56ET3u6kxlREXPm00gZAcWm8EPJiNyRD3kT+xpFaS9TOkwZYy1Y6
         oTTmOXvNjYknEDtYMORAtT6Q8gw6OS3l2TpzsezcTk4gU3IMgitxTfd+ZA18/iuosEZO
         whCw==
X-Gm-Message-State: AOAM5325LApivd5ubdjrYJtX9y0FzzKsza2Hq0DK6Z54ehfu7egXQssH
        cRHyzOm5dxxi/Xg2mryatVHNSm69t6tNwQ==
X-Google-Smtp-Source: ABdhPJzjfFaDdwLJ9ucjx+qAIuDEy4nFJSnA1nNxnCmsCL449bMsQm0G7Y9a/8Po9VAybCyw92ZR2A==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr25159222wmq.175.1617031590669;
        Mon, 29 Mar 2021 08:26:30 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id e17sm34198560wra.65.2021.03.29.08.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:26:30 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8183: Add gce client reg for display
 subcomponents
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210324070842.1037233-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <aa98e29a-3e8e-db22-50e8-e0b8fa496bdf@gmail.com>
Date:   Mon, 29 Mar 2021 17:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324070842.1037233-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2021 08:08, Hsin-Yi Wang wrote:
> Add mediatek,gce-client-reg for mmsys, ccorr, aal, gamma, dither.
> 
> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.12-next/dts64

Thanks!

> ---
> v1->v2:
> Add for mmsys.
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 80519a145f13..16f4b1fc0fb9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -983,6 +983,9 @@ mmsys: syscon@14000000 {
>  			compatible = "mediatek,mt8183-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
>  			#clock-cells = <1>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>  		};
>  
>  		ovl0: ovl@14008000 {
> @@ -1058,6 +1061,7 @@ ccorr0: ccorr@1400f000 {
>  			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
>  		};
>  
>  		aal0: aal@14010000 {
> @@ -1067,6 +1071,7 @@ aal0: aal@14010000 {
>  			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
>  		};
>  
>  		gamma0: gamma@14011000 {
> @@ -1075,6 +1080,7 @@ gamma0: gamma@14011000 {
>  			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
>  		};
>  
>  		dither0: dither@14012000 {
> @@ -1083,6 +1089,7 @@ dither0: dither@14012000 {
>  			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
>  		};
>  
>  		dsi0: dsi@14014000 {
> 
