Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C563454BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbhKQRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhKQRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:31:24 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4EC061570;
        Wed, 17 Nov 2021 09:28:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z200so2945457wmc.1;
        Wed, 17 Nov 2021 09:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xCAjuM6xrMxdm2CIKZbX9BC7fNzMpEXwSr+NlcFIgXY=;
        b=PS5HmOY111lxaOKyFH5b7wLUoIO4BkbIWwJWMSbYG+9lI+D9XepvBN4yIdSO22FXET
         lcsowfM2saoih0R3aQm/0loM9yfqCRB6khY8d1iP9lDM+3tqtAiKsxr5EF4eZ8Xw5BjS
         b11+/u7HBi10leypAOTxiE6vWIvvE50tvUtpVw91XbWl93OuEwHJkuT7uY7oguiKgq2q
         7vcnwYWGJi37PiLNGUNcygYLgC7BvONlH0t+xu3cjjSQp683FUb+Xn5d5ids/6N2XLut
         nLE7I15VjcmNV0RpqMZruHqCwS5sRubsgKNkJo9P6ij91/sQT3u0NaVFDbiu5R8Hpe3q
         MMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xCAjuM6xrMxdm2CIKZbX9BC7fNzMpEXwSr+NlcFIgXY=;
        b=H7vaH9RLjWKAgzj3HUEjO06zxZUukqCuMeBzXqDLaNW+WZW4Jna5I41yoQ0xDvxbpM
         gawKQTVE+oXYwbnQzqMC5iNJhL0PgX9DntaOBMsAaZTDnQns28tXcanTlZ19zHo/x+QV
         MF6wbeHxYQmuOB8bxGeMPajM+LGm6B7FaHMPnRrTBP96Q+649Q6wuB1qVF742oHxoWWa
         pYfCPavm4a2kWAA5yRfm8DKViA+ObV/bn67+g9Q989SZVAvUWlyJTP+7Aqq1gC4dc0oX
         y1+FUtcKUnWbHtuZq54wQCCNvHFIIVZVittEzpxUtVMU4eU9XQSzk/BZ7xrYF0yO0GAm
         aXBw==
X-Gm-Message-State: AOAM532gVCYbLnf/G6akn7+9mJpl7giSfB1Qn8lX3OJCvBfpy02lAO6e
        mKqShOW2mrxT+QDYVDIGpsk=
X-Google-Smtp-Source: ABdhPJwl4Lr4z57Y0zAraZ6nqqnmdjjF1I7QV2xUuRwF5x+SjagSG9FFzeJcB7mHvGPWPSqjqhTPsA==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr1528602wmj.179.1637170104238;
        Wed, 17 Nov 2021 09:28:24 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id n8sm464457wrp.95.2021.11.17.09.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:28:23 -0800 (PST)
Message-ID: <4a2afd96-49c6-3ee8-bc00-42dbd87a71cb@gmail.com>
Date:   Wed, 17 Nov 2021 18:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND] arm64: dts: mediatek: mt8516: remove 2 invalid i2c
 clocks
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110193520.488-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110193520.488-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 20:35, Fabien Parent wrote:
> The two clocks "main-source" and "main-sel" are not present in the
> driver and not defined in the binding documentation. Remove them
> as they are not used and not described in the documentation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.16-next/dts64

thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 27 ++++++------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index bbe5a1419eff..d1b67c82d761 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -345,14 +345,9 @@ i2c0: i2c@11009000 {
>   			reg = <0 0x11009000 0 0x90>,
>   			      <0 0x11000180 0 0x80>;
>   			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
> -			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> -				 <&infracfg CLK_IFR_I2C0_SEL>,
> -				 <&topckgen CLK_TOP_I2C0>,
> +			clocks = <&topckgen CLK_TOP_I2C0>,
>   				 <&topckgen CLK_TOP_APDMA>;
> -			clock-names = "main-source",
> -				      "main-sel",
> -				      "main",
> -				      "dma";
> +			clock-names = "main", "dma";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			status = "disabled";
> @@ -364,14 +359,9 @@ i2c1: i2c@1100a000 {
>   			reg = <0 0x1100a000 0 0x90>,
>   			      <0 0x11000200 0 0x80>;
>   			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> -			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> -				 <&infracfg CLK_IFR_I2C1_SEL>,
> -				 <&topckgen CLK_TOP_I2C1>,
> +			clocks = <&topckgen CLK_TOP_I2C1>,
>   				 <&topckgen CLK_TOP_APDMA>;
> -			clock-names = "main-source",
> -				      "main-sel",
> -				      "main",
> -				      "dma";
> +			clock-names = "main", "dma";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			status = "disabled";
> @@ -383,14 +373,9 @@ i2c2: i2c@1100b000 {
>   			reg = <0 0x1100b000 0 0x90>,
>   			      <0 0x11000280 0 0x80>;
>   			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
> -			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> -				 <&infracfg CLK_IFR_I2C2_SEL>,
> -				 <&topckgen CLK_TOP_I2C2>,
> +			clocks = <&topckgen CLK_TOP_I2C2>,
>   				 <&topckgen CLK_TOP_APDMA>;
> -			clock-names = "main-source",
> -				      "main-sel",
> -				      "main",
> -				      "dma";
> +			clock-names = "main", "dma";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			status = "disabled";
> 
