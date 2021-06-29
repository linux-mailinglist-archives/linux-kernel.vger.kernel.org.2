Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1B3B6FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhF2JJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhF2JJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:09:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C23C061574;
        Tue, 29 Jun 2021 02:06:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p8so8767331wrr.1;
        Tue, 29 Jun 2021 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xUNa+0KV7B+vXGxAAaNhqc6ILKPrP8e6nGYC6NphWSA=;
        b=Vu+xtrLTkJeh5aC5cORWSlDNFiwk1Ep9IDbU6YLNus2SyHOTPFGMpB4hpjwEu6xjrx
         FxYvLll3mp6UpO2ZrGYwoNoegsMO13EAHAs6PkNHX1GVOGXj0B/8e5KahXvd9EWaD+Q5
         VDhmCY0MY+vXv2+QoHaNEqgr1pR/+LwtiNt7qosHe/OOHMEN9Fh2IYIRbpFZbMI+RNQw
         TSK4AAXGtKpdeyE2hCrvIGPilXdPe+1gf8sr7mo+pplIOLM1bMnPiTxpE93wahQKycD6
         WeYOBp5m6x10oQ2mLdRV189fp8nqbtlUzcogzJ7XgyaxRACpDXS+Xs+AvOooO4LPiq/w
         6UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xUNa+0KV7B+vXGxAAaNhqc6ILKPrP8e6nGYC6NphWSA=;
        b=qZ2w19YL9ZtP0ZMDZrY54motekdOU6xSdFwbFcP3sPvfA904tz8XoGsfyEUk3aJhaE
         5AvZRBtryvJckhpnaX1E5F9+EK8BD7amZLx6r+nniqy8/pRBKkscFqbm87QAFAA1B1te
         4bom/83a1SqqVimuPOATPyIpRKsuRYuQ1xx1I6HSBULl/qSOjtB2EIcCcaJ6GtOl6+en
         nPTCN3xxvztLt98KAxPi0kKIvCNEKAL89Tp2WRUZarZSXXfUAra8/oBGLGmrX/lCmbTj
         uYiHy+pXi5AzagfW8PzEdkXyRRgTH0UNBTnoZKellFb+2kkQVd4AixD1zK/es6qWwpTT
         2qCw==
X-Gm-Message-State: AOAM5313zT0RkUGVpw36zsHcI8udZ1YA8V3TomZdrcJUB7NneUUS+vNC
        agKyUlecyOpXdmNsvi2lbrQ77D9upqRA
X-Google-Smtp-Source: ABdhPJwvKWCQVsOJd9eUeFeHQfLFrIdvqdtZZcxsszSocuFblwXkrTqLQOVIRnfeVYIvo7ZariePdA==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr15179890wrv.209.1624957613371;
        Tue, 29 Jun 2021 02:06:53 -0700 (PDT)
Received: from [192.168.200.247] (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.gmail.com with ESMTPSA id l15sm17628496wrt.47.2021.06.29.02.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 02:06:52 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: add rock-pi-4 analog audio
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     jack@radxa.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>
References: <20210628113033.9145-1-adrian.ratiu@collabora.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <7f806d30-594e-2325-615a-8fee875c83a8@gmail.com>
Date:   Tue, 29 Jun 2021 11:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628113033.9145-1-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

I've submitted similar patch already. Its part of [1]

There is no headphone detection pin in the schematics, btw.

[1] 
https://patchwork.kernel.org/project/linux-rockchip/cover/20210618181256.27992-1-knaerzche@gmail.com/

Best,

Alex

Am 28.06.21 um 13:30 schrieb Adrian Ratiu:
> This adds the necessary pinctrl and nodes to enable the
> analog audio on rk3399 rock-pi-4 SBCs using the es8316
> codec and the audio-graph-card driver.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>   .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index b28888ea9262..77781d9150ac 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -128,6 +128,12 @@ vdd_log: vdd-log {
>   		regulator-max-microvolt = <1400000>;
>   		vin-supply = <&vcc5v0_sys>;
>   	};
> +
> +	sound {
> +		compatible = "audio-graph-card";
> +		label = "rockchip,rk3399";
> +		dais = <&i2s0_p0>;
> +	};
>   };
>   
>   &cpu_l0 {
> @@ -422,6 +428,24 @@ &i2c1 {
>   	i2c-scl-rising-time-ns = <300>;
>   	i2c-scl-falling-time-ns = <15>;
>   	status = "okay";
> +
> +	es8316: codec@11 {
> +		compatible = "everest,es8316";
> +		reg = <0x11>;
> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
> +		clock-names = "mclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_det_pin>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint = <&i2s0_p0_0>;
> +			};
> +		};
> +	};
>   };
>   
>   &i2c3 {
> @@ -441,6 +465,14 @@ &i2s0 {
>   	rockchip,capture-channels = <2>;
>   	rockchip,playback-channels = <2>;
>   	status = "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&es8316_p0_0>;
> +		};
> +	};
>   };
>   
>   &i2s1 {
> @@ -556,6 +588,12 @@ wifi_host_wake_l: wifi-host-wake-l {
>   			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
> +
> +	es8316 {
> +		hp_det_pin: hp-det-pin {
> +			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
>   };
>   
>   &pwm2 {
