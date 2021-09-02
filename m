Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7BD3FEEAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbhIBNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhIBNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:32:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499CC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:31:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u9so2956134wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0klcoy5VB86GBCo6ovw09LEEA190St+8JgjCktZXyg=;
        b=Nm2sKFRgc19AZSbWMlfNGpn2GO7OzBeHhRab2mdYgOGjNL7jzChX6s0+5tMqd9MiqM
         I2uYdDlppCvhcxTl+Jd4vqqI/NyQyh5ibkkGMHMofx00rHofjRHpJSg3RkjoqPin4A0N
         CTkY7G9Cp8v5CJX+K7sSB41bzNats1NVUgY1V4vJJcxrJ5vkNN235FwhSqxErHKWSB36
         wTHylKGCtkyQVUqJy9Sr0jlFcfIVygJATZiWMyP+xlnIY6Pt0yDPXSCtPKEhUyH1VdjV
         QXO8+SWo9Se011tDFBWbIsE1fBNLljh/TuvncHhXQWG8WwNRmTl/O9fUiGpsKSGv4aP+
         jvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n0klcoy5VB86GBCo6ovw09LEEA190St+8JgjCktZXyg=;
        b=Skq1ud0yIMsbMIKBDLu/XAYxmPh/CiEUecr+yhAQyAPNvq0pGUPxXOGRTFtkyw25Jj
         uXBB8vO7m9OPWSLhtW3ckX4+3v4PXY2cvPfVhZ6BhyAHK/4sx0WJaUqz7PsrzA4Nne0u
         e9SdqynxlWsQbR9pCJH7dtTF9JW88F6BFKMZo7LXwGWfzWc+i7oFIPIW3bIhXukEIeB5
         dl+nADGiQawVjOid8Hx8HkgMnUuq5AtrtcEwRR0u80u8+OzsxsJ/X5rGcxFgWtLidozf
         UDFToeWDrh4Y9oUZZAXe9tAarMcOi/pXNDfI4lP++2WEUf1a8RgaSrfttvd2Fa9D/Hm+
         y1pw==
X-Gm-Message-State: AOAM532nA9e2FRv/+fpku0xEfnXEQN6pdXQRGKg6GTZEcvsC0IlY43Rm
        QUUMB5hGxiBTZNsfNIzVP1ad6Q==
X-Google-Smtp-Source: ABdhPJxVkAODoZdK0YV812Ax+02FJZZFtxOsdh1Ky9ABLZ78x+taEK+4gT2cUQiffXDITf3pXqYMuQ==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr3735550wrq.47.1630589461939;
        Thu, 02 Sep 2021 06:31:01 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:98:6312:3c8:6531? ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id o15sm1959424wra.3.2021.09.02.06.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:31:01 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com, Artem Lapkin <email2tema@gmail.com>
References: <20210811050941.398360-1-art@khadas.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
Date:   Thu, 2 Sep 2021 15:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811050941.398360-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/08/2021 07:09, Artem Lapkin wrote:
> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3d8b1f4f2..1efdbb61e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>  			status = "disabled";
>  		};
>  
> +		spdifin: audio-controller@400 {
> +			compatible = "amlogic,g12a-spdifin",
> +			"amlogic,axg-spdifin";
> +			reg = <0x0 0x400 0x0 0x30>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFIN";
> +			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> +			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> +			clock-names = "pclk", "refclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
> +			status = "disabled";
> +		};
> +
> +		spdifout: audio-controller@480 {
> +			compatible = "amlogic,g12a-spdifout",
> +			"amlogic,axg-spdifout";
> +			reg = <0x0 0x480 0x0 0x50>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFOUT";
> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
> +			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
> +			clock-names = "pclk", "mclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
> +			status = "disabled";
> +		};
> +
>  		tdmout_a: audio-controller@500 {
>  			compatible = "amlogic,sm1-tdmout";
>  			reg = <0x0 0x500 0x0 0x40>;
> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
>  			status = "disabled";
>  		};
>  
> +		spdifout_b: audio-controller@680 {
> +			compatible = "amlogic,g12a-spdifout",
> +			"amlogic,axg-spdifout";
> +			reg = <0x0 0x680 0x0 0x50>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFOUT_B";
> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
> +			<&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
> +			clock-names = "pclk", "mclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
> +			status = "disabled";
> +		};
> +
>  		toacodec: audio-controller@740 {
>  			compatible = "amlogic,sm1-toacodec",
>  				     "amlogic,g12a-toacodec";
> 

Jerome could you quickly review this ?

Thanks,
Neil
