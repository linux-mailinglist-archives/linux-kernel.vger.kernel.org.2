Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73940309D54
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhAaPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhAaOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:55:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD23C061573;
        Sun, 31 Jan 2021 06:54:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p15so13775001wrq.8;
        Sun, 31 Jan 2021 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WkJeFPw2kQQYHxR9X8QVdj9OOIogYHSGaWROQp6d23w=;
        b=qAwxHB4OJZlkt7/CPjTCYo6CtGO7S/7mZXEp2zMkfCcGo6xRAAB+laUFvPRmVamoJ3
         0IPPFq0o6NNSlu96vVQh6i1Nkjj3I06oTrz0OlBjCsMkn2tCdv9OTmlL+iYtyyd7zYm0
         syjj1KcONDNeS6HJWFbqh56V+UpM1ygGP9yd2v5bIhuA0FDwbCWUXNs5/RQ4EPKyyWeN
         IoFQfBJsWE3psQkQZBgVkwGP5jTSyGGNbR6EVfK1gsjMiZ/rJx3WxK2ViAGL7Znrg2OU
         rIbQmrGFwxHUn5qOXt0IZIA46U/AfHeLwIZVCOTMKNloO4XzMlk5EmjHnaB/d08ynQkt
         3D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WkJeFPw2kQQYHxR9X8QVdj9OOIogYHSGaWROQp6d23w=;
        b=MrFgARmmZpm78mupGd+kGEVgA9TPAwTkoyPpjqFovFBZ1WMiuoqPVvMbVBVzYY97Ks
         Ss6ATFNmn9XY4nFlHI5Ce7zwOdkqeB1khdAo/U3JHFwh6knB8Y5Iv7MpepZRnW7F+Sx0
         rnxPKU4UjGu+MdVIbLa4gXkcuVf6PZRpy0sdHAKxdGavsFSl4UiIiQYI6VXuPHGMP60B
         g9xH67xtBO6tQr3Low41zgC4uyUMW5xSiPPuA9fXf3CAAXC+hsGrAItUrASYhoDHL/7J
         O/4Y51EtLgwUDqx2tCGFSRly05xch81P41zumgIPMri1bj53qROFKgg40LOlyb5TgGQB
         +BBw==
X-Gm-Message-State: AOAM531SlGNhmJqmqXR9CBLspmus6veF8aYqpYoQJvn88HZT/+UgkWIG
        eNcptTbrG24+Bi0tJqiw4CxBc1TFO1QvEhNp
X-Google-Smtp-Source: ABdhPJyPJoHnFnU9o8NjgJCD2yBaBGx2MRUsaYHuoUq3BmTa4p8Vbt9wj2k3kE4ie+qGvWgXRchg2A==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr14323248wrr.189.1612104870716;
        Sun, 31 Jan 2021 06:54:30 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id s25sm17872026wmj.24.2021.01.31.06.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:54:30 -0800 (PST)
Subject: Re: [PATCH v4 1/3] arm64: dts: mt8183: config dsi node
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210113110400.616319-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5c30dc00-2d0e-8538-fe55-c57e70d46b70@gmail.com>
Date:   Sun, 31 Jan 2021 15:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113110400.616319-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2021 12:03, Hsin-Yi Wang wrote:
> Config dsi node for mt8183 kukui. Set panel and ports.
> 
> Several kukui boards share the same panel property and only compatible
> is different. So compatible will be set in board dts for comparison
> convenience.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---

Whole series applied to v5.11-next/dts64

Thanks!

> change:
> v4: add backlight and enable mipi_tx0
> ---
>  .../mediatek/mt8183-kukui-krane-sku176.dts    |  5 +++
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 42 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> index 47113e275cb52..721d16f9c3b4f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> @@ -16,3 +16,8 @@ / {
>  	model = "MediaTek krane sku176 board";
>  	compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
>  };
> +
> +&panel {
> +        status = "okay";
> +        compatible = "boe,tv101wum-nl6";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index bf2ad1294dd30..da1e947587074 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -249,6 +249,36 @@ &cpu7 {
>  	proc-supply = <&mt6358_vproc11_reg>;
>  };
>  
> +&dsi0 {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	panel: panel@0 {
> +		/* compatible will be set in board dts */
> +		reg = <0>;
> +		enable-gpios = <&pio 45 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel_pins_default>;
> +		avdd-supply = <&ppvarn_lcd>;
> +		avee-supply = <&ppvarp_lcd>;
> +		pp1800-supply = <&pp1800_lcd>;
> +		backlight = <&backlight_lcd0>;
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port {
> +			dsi_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> @@ -290,6 +320,10 @@ &i2c6 {
>  	clock-frequency = <100000>;
>  };
>  
> +&mipi_tx0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	status = "okay";
>  	pinctrl-names = "default", "state_uhs";
> @@ -547,6 +581,14 @@ pins_clk {
>  		};
>  	};
>  
> +	panel_pins_default: panel_pins_default {
> +		panel_reset {
> +			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
> +			output-low;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	pwm0_pin_default: pwm0_pin_default {
>  		pins1 {
>  			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
> 
