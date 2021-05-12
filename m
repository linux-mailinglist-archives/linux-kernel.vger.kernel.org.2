Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9237EAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbhELTRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhELQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:47:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E0C08EB20;
        Wed, 12 May 2021 09:20:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d11so24219161wrw.8;
        Wed, 12 May 2021 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g3cwY6Hzy6EqdwJaqVSzBqAF7NmFEme2hYX8gRSTBJ8=;
        b=gC0znr5PRqA5wRxIgIiAmKgcHzgv0b4bKRjccuLX6Iwidd0KlUZ2dVEKJTX4BS6Qtn
         mI5KQGsRLvvomQg3r1/1EuhiaVFE3MPEuthJz3koNfy/MJItDQkBi/+PawpVMNsJwalC
         rPEk4mSaplt1hE0GFzt4Ku+/sK1bZF4w6A5yyLuqrz73ySV3uM6cB7yojp4KImi9JDhO
         iv6ajbxfjtSdxh87h+6h+9VE4LucPMWfTDDhDViS7Umn+ktC1mRacDEjrc+Helrg8dhj
         V7VWK8KnfqeqXjjL9lW3JSEt7a8kPfmPsJvV6dApGLFHwmMOqqW/Wgf8UQpvBroTgKLj
         6DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3cwY6Hzy6EqdwJaqVSzBqAF7NmFEme2hYX8gRSTBJ8=;
        b=mez7OvqSkUeoMmccXKkpYux0eUkLClyM2Ci/XvvYpG8s3MhGvxpTHoySs/qVsrgAZw
         FHe45UNVzpISu3M2bftvfRJBuQxkGyrhr2yk9P/P4hZ6p61QwP6tUeKQvrOHszQQuCon
         47ioomL6CbjAX3SI1rLsA6cRxS8q3uL94+JqJKzc7q/UTmaxqt/nF1DkvB0k9KJhvaWR
         dBmIN+bu4if4cAnK9khzOXkC0t6AJgn0z75JW2ltVJogOTTUUjBREQB5qRsEEr6qjGRL
         /Uitgnlj1DpPUexIA6MotlMJbIoZZhH88EEMcS2DK1+fyNiOme8lWQ3Zs9CfoI2BjPOc
         A4bA==
X-Gm-Message-State: AOAM531kYtL2dHSpm9ceI/gIhvcZZbASvMeV9L+ucEtr3mBAZTeGDH6Y
        kQMPNxeE8L+E041UeOu6zIU/uJ6IiImAyw==
X-Google-Smtp-Source: ABdhPJwxmmhuNFN4Qj6xtMqbuk5mOqU/iFz28N2vLzffR4UhACjE+oiPI8EWzNhx1E44PPwQUX6Z7Q==
X-Received: by 2002:a5d:4a51:: with SMTP id v17mr42251239wrs.259.1620836449668;
        Wed, 12 May 2021 09:20:49 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id f7sm135279wmq.30.2021.05.12.09.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 09:20:49 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] arm64: dts: mediatek: mt8167: add some DRM nodes
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210406113631.2675029-1-fparent@baylibre.com>
 <20210406113631.2675029-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <df4c57f9-115b-c4da-e656-e4bdec62c2d7@gmail.com>
Date:   Wed, 12 May 2021 18:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210406113631.2675029-3-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

As you might remember this patch didn't hit mainline in the last merge window.
Actually there are some concerns about the driver architecture [1].

Apart from that small comment below.

[1]
https://lore.kernel.org/linux-mediatek/CAK8P3a2Qg-uz0kMXFMrvRjUv3NRvZXjTwS1P5MDvFk3feYaBzg@mail.gmail.com/

On 06/04/2021 13:36, Fabien Parent wrote:
> Add all the DRM nodes required to get DSI to work on MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2
> 
> V3:
> 	* Removed unicode character in commit summary
> V2:
> 	* No changes
> 
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 149 +++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 9029051624a6..17942095944e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -16,6 +16,19 @@
>  / {
>  	compatible = "mediatek,mt8167";
>  
> +	aliases {
> +		aal0 = &aal;
> +		ccorr0 = &ccorr;
> +		color0 = &color;
> +		dither0 = &dither;
> +		dsi0 = &dsi;
> +		ovl0 = &ovl0;
> +		pwm0 = &disp_pwm;
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +		wdma0 = &wdma;
> +	};
> +
>  	soc {
>  		topckgen: topckgen@10000000 {
>  			compatible = "mediatek,mt8167-topckgen", "syscon";
> @@ -114,6 +127,13 @@ vdecsys: syscon@16000000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		mutex: mutex@14015000 {
> +			compatible = "mediatek,mt8167-disp-mutex";
> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +		};
> +
>  		pio: pinctrl@1000b000 {
>  			compatible = "mediatek,mt8167-pinctrl";
>  			reg = <0 0x1000b000 0 0x1000>;
> @@ -126,6 +146,135 @@ pio: pinctrl@1000b000 {
>  			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		rdma1: rdma1@1400a000 {
> +			compatible = "mediatek,mt8167-disp-rdma",
> +				     "mediatek,mt2701-disp-rdma";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		disp_pwm: disp_pwm@1100f000 {
> +			compatible = "mediatek,mt8167-disp-pwm",
> +				     "mediatek,mt8173-disp-pwn";

Should be "mediatek,mt8173-disp-pwm" right?
I'll un-stage this patch but keep the rest for v5.14. Please re-submit once the
driver binding is clarified.

Regards,
Matthias
