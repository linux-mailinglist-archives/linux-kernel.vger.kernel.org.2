Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F404F309BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhAaL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhAaKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:24:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270AC061573;
        Sun, 31 Jan 2021 02:24:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o5so502251wmq.2;
        Sun, 31 Jan 2021 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ru2rO2yhua9+/LiL9x6aOskXku+UM0Dk2x5D7eM0aho=;
        b=QY5W8LpiU3GmqEvw8ULAPBNY3Rkks478hId72TlT99mTaxuTis9f7GlqCuBNRyysnY
         9AQuQktXE8rofClF3uduebi2eb3IxiEBsVX6jiAKrmE9nmt7HG35IJDjLY1FN2ZQi3Uq
         AdAf+0RQ0BUTIAJ1/jzUyRxKXg6amOMEtJUnHLm/8qShzCibORhcp5wgvCt7vwgWE51K
         6SECAT3ZNXTWzpoUaBpJDjZzOd2gcpPY+1Gg6NNG/PaAzN+stNGVS7HB7sOUpF6xMSAU
         2RKdodUZ+FmszqPZkIJNPRMG8+qLFZkE7aWZ+PO40jRIKhHg22+nmIh591pW+AbqL8Rm
         iSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ru2rO2yhua9+/LiL9x6aOskXku+UM0Dk2x5D7eM0aho=;
        b=nz+xrONhyXfU+1Fv4rA6+pUfR+WcI5rFsdV4An/K847um7OCuPHc7mSC2SFzM1Chxn
         C1FldNFHMbBPob/JC2R7PPA0JBQA6PYCU1/ITR7iS2dc24q9cRKas12/me6IbKGT5ctU
         7aYUdVp7GnJ9p4Z5qtKThwI16uJr/iSB+sCCf5bsWiONu3WDq9/sXLDvsomBnUNZLjgk
         gbZbS01DUVizVd7OCLXdQVf+zsJjxgLuGow3NP00F/8Kr0EubQMYHF8d0ifC/EzNWn7k
         cNBI2BLqdoeNB40+H34Y6wlecGiKqwBS2Cy3fRcGlYMNAEd9RwNpSpFOtPakzcf7JZEq
         6pPg==
X-Gm-Message-State: AOAM531UfVz/RkopPAoGZEocTK2zOVhtgY1nKqj9hFieL6XtJ6ViPJBy
        /BtIgqYDt+G9IxTEm68Kt5ov+j+ZojKIiA==
X-Google-Smtp-Source: ABdhPJwj9QtL7ZtO8ulHa+YKzFUenC9NT3LZxlPFnC4njmGylmm+KEpJk4h4xPKyxhtYkS66PMDfuw==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr10536856wmj.161.1612088645329;
        Sun, 31 Jan 2021 02:24:05 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c5sm22763738wrn.77.2021.01.31.02.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 02:24:04 -0800 (PST)
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8516: add support for
 APDMA
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201209114736.70625-1-fparent@baylibre.com>
 <20201209114736.70625-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <80b768e1-9e46-88d7-a56b-c90a46bd3a10@gmail.com>
Date:   Sun, 31 Jan 2021 11:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201209114736.70625-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2020 12:47, Fabien Parent wrote:
> Add support the APDMA IP on MT8516. APDMA is a DMA controller
> for UARTs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 

Applied to v5.11-next/dts64

Thanks a lot!

> V3: remove unicode symbol that slips into patch summary
> V2: Add missing dma-names properties on uart nodes
> 
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index e6e4d9d60094..b80e95574bef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -276,6 +276,27 @@ gic: interrupt-controller@10310000 {
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
>  
> +		apdma: dma-controller@11000480 {
> +			compatible = "mediatek,mt8516-uart-dma",
> +				     "mediatek,mt6577-uart-dma";
> +			reg = <0 0x11000480 0 0x80>,
> +			      <0 0x11000500 0 0x80>,
> +			      <0 0x11000580 0 0x80>,
> +			      <0 0x11000600 0 0x80>,
> +			      <0 0x11000980 0 0x80>,
> +			      <0 0x11000a00 0 0x80>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_LOW>;
> +			dma-requests = <6>;
> +			clocks = <&topckgen CLK_TOP_APDMA>;
> +			clock-names = "apdma";
> +			#dma-cells = <1>;
> +		};
> +
>  		uart0: serial@11005000 {
>  			compatible = "mediatek,mt8516-uart",
>  				     "mediatek,mt6577-uart";
> @@ -284,6 +305,9 @@ uart0: serial@11005000 {
>  			clocks = <&topckgen CLK_TOP_UART0_SEL>,
>  				 <&topckgen CLK_TOP_UART0>;
>  			clock-names = "baud", "bus";
> +			dmas = <&apdma 0
> +				&apdma 1>;
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
>  
> @@ -295,6 +319,9 @@ uart1: serial@11006000 {
>  			clocks = <&topckgen CLK_TOP_UART1_SEL>,
>  				 <&topckgen CLK_TOP_UART1>;
>  			clock-names = "baud", "bus";
> +			dmas = <&apdma 2
> +				&apdma 3>;
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
>  
> @@ -306,6 +333,9 @@ uart2: serial@11007000 {
>  			clocks = <&topckgen CLK_TOP_UART2_SEL>,
>  				 <&topckgen CLK_TOP_UART2>;
>  			clock-names = "baud", "bus";
> +			dmas = <&apdma 4
> +				&apdma 5>;
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
>  
> 
