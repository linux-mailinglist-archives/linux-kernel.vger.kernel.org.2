Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6136454C06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhKQRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhKQRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:36:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC6C061764;
        Wed, 17 Nov 2021 09:33:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so5467853wme.0;
        Wed, 17 Nov 2021 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IljrZVfmkKHCxYMQbSMY/43208uZSuA4ajkMssOxNXQ=;
        b=UkX9HvcjswTCpEGvE9k2l62gZ9bzRtTGZnJ+UvXI/wXyMFPZYVz36qYAjECtfU2hHO
         h+nXjrXpvJ9nMIQWwkomKiFnAW5JUnzts/f09XRfzqCGfzPImZWPuJtAEvPLYOKbzReJ
         Tmsq0881b+2g3bYZF/45cTHRomS1zLKddwYP61ZJw5Cyg+s5itiexEkgO2U+k2qLx7+D
         Eoy/U0709VyJjvYcI5U4HYNpjhPJHwqXnPeO35SwFyeSKbswMxHiEMVLqNVWxRWNnlr6
         HySzjGHuo+jWsZT6Ja8qG9ATuZ4n4R8e2KqnTvsm9rJErjmzyXoSpcveecInY/4NVNWl
         YsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IljrZVfmkKHCxYMQbSMY/43208uZSuA4ajkMssOxNXQ=;
        b=SVIIAPVBhZhmdvtrcigtLHzdxnNDcpGXaEot9C2SIK3+YMJxY7yvTWPu0pR9VniVHJ
         Uju2d8tFmA5BtkZPLU02CSJYNFY4UIMujsHytX+1pPbHaCeBpocsrzWPX1Mg/gZwP2qR
         zWXkPlGk4kDq4RrYUYBvnQv8HgvSinRSk+inHw6qf0+nDiBLcn387ZntvztyPY74w+cD
         u/0G8C+WAo+zU3LAxd5tyvXRg8lfzPxFc2b0eq66ifqn01+ptmQToCf3th6QgyeYyIP/
         zv1vqKsg+01WCohHWXZ8asJDyzgcryeF/ArctyFfobyAD2CKfrwWNx36dl9XrzzyBiqu
         kFbw==
X-Gm-Message-State: AOAM5332PITVBIExxYyPC6ss3EwN6JsFr4mn+xzFEf8O5JREE4oMAcgl
        yIZBk0zSqrI8wWwCIOKG67o=
X-Google-Smtp-Source: ABdhPJwYSeSfo4vw2gAZcvsGMBvnN2B4NTBwCxzZ7Q//nD5+9c0AjD9FINSwBsfYdYXqAK9BJssh/g==
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr1657801wmj.14.1637170402185;
        Wed, 17 Nov 2021 09:33:22 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id l11sm474771wrp.61.2021.11.17.09.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:33:21 -0800 (PST)
Message-ID: <03de9880-1f1a-b07b-6ec3-279945e08cea@gmail.com>
Date:   Wed, 17 Nov 2021 18:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] arm64: dts: mt8183: add dpi node to mt8183
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110192417.4177741-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110192417.4177741-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 20:24, Fabien Parent wrote:
> From: Pi-Hsun Shih <pihsun@chromium.org>
> 
> Add dpi node to mt8183.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index ba4584faca5a..7c283c0b68b5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1443,6 +1443,17 @@ dsi0: dsi@14014000 {
>   			phy-names = "dphy";
>   		};
>   
> +		dpi0: dpi@14015000 {
> +			compatible = "mediatek,mt8183-dpi";
> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DPI_IF>,
> +				 <&mmsys CLK_MM_DPI_MM>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL>;
> +			clock-names = "pixel", "engine", "pll";


We are missing the output port node, don't we?

Regards,
Matthias

> +		};
> +
>   		mutex: mutex@14016000 {
>   			compatible = "mediatek,mt8183-disp-mutex";
>   			reg = <0 0x14016000 0 0x1000>;
> 
