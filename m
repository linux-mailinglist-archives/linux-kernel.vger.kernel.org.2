Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9945E0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356686AbhKYTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhKYTKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:10:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DEC061574;
        Thu, 25 Nov 2021 11:07:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so29359639edb.8;
        Thu, 25 Nov 2021 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RETl6EZ/q+KZQKZQu0x6dpqQFHJLgaukB+KnrSsVWE=;
        b=gAPMEiTgu4btwGQ8d7RmgT8TGL3bXGeUy0Lx6GU06BEZ0uzPUfsZKeAYyskjgsKY2n
         J6w44kxfSf7g2wg2vuuvtZ1hrIcKiNMNRcD3Qzpn2ygOAvPQZTltx8lhRncgam/DzmyI
         z19LfOAV5nAsE9SQ5/2Uz/ufwYKpGsmKiKv+pHVt+w9rJviqfCDgcnqfV9Nloecry+H/
         FxBp4nS8f/iTg5qJgVOpLT6RBSRXgwEjeT3fiWLu2QwLkTZAWMC+iQ9XadAmwPkj2ICc
         +Ml+7CwNFhUVdrv527GDQQ/cE3zqmJ2EiVbwtFYOrOi6/+04yJ7JPves8T94CkHHZZjI
         oWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RETl6EZ/q+KZQKZQu0x6dpqQFHJLgaukB+KnrSsVWE=;
        b=BpUd4zir4xE6gNWSBl+a2by3TbC9oR06E9szB/PfNZwhwTW0Dd/eYcftADFBAQZ11w
         cpF+p9hVFfIJTFInsF0jP021dknzIGq1g4fXvCt30+RYKd2J/zGy+CzbUDO4dHQHnu/N
         9bqVopi5BUuYoNhSSCtBhZw5GaoVqsXFslr0re1e8wKKuZ+eXud3VSyuC7PDAGE6TNmk
         G+Adji5nigfxnjcXTLgkTyxGZVy5tPPaWfowQ4w/Cj2WG0TilBquAIosezRKHxfjnCda
         dMhuk1M6pllAbvGYszFhmqRk1GkQhH9rgkNvpg56FWGoq6gcX/nbt6P34znTN1MizJT7
         rLUg==
X-Gm-Message-State: AOAM532FyzYJfGeSFj27BKrKE9GZCQfOvQsLkoX8Bd9ypp7usO/Qxszp
        SEfOYXlddYQc0oO+LQX9bYcHc4LsgEg=
X-Google-Smtp-Source: ABdhPJzdR4fS3FSUgtdtqASK6+b1zMem6EG63SPfkBRBIsZFX7+F/U/i1bney2lGJqz6OmegdjV52A==
X-Received: by 2002:a05:6402:34d1:: with SMTP id w17mr41913845edc.229.1637867242903;
        Thu, 25 Nov 2021 11:07:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b11sm2893032edz.50.2021.11.25.11.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 11:07:22 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
 <20211125100836.423808-2-frattaroli.nicolas@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <08774d87-97e0-6afa-2816-bf78949e4e68@gmail.com>
Date:   Thu, 25 Nov 2021 20:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125100836.423808-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Some comments...

On 11/25/21 11:08 AM, Nicolas Frattaroli wrote:
> This adds the i2s0 node and an hdmi-sound sound device to the
> rk356x device tree. On the rk356[68], the i2s0 controller is
> connected to HDMI audio.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 32 ++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 3c09cf6d4c37..ad4053402eef 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -614,6 +614,21 @@ hdmi_in_vp2: endpoint@2 {
>  		};
>  	};
>  

> +	hdmi_sound: hdmi-sound {

Some DT sort rules:

For nodes:
Sort things without reg alphabetical first,
then sort the rest by reg address.

> +		compatible = "simple-audio-card";

simple-audio-card,name = "HDMI";

> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;

> +		simple-audio-card,name = "hdmi-sound";

Exceptions:
Sort simple-audio-card,name above other simple-audio-card properties.

Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
Make a shorter label without spaces or special chars, so that chars
don't get removed?
See "aplay -l" screen print.

Maybe rename to "HDMI"?

> +		status = "disabled";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0_8ch>;
> +		};

Add empty line between nodes.

Not sure if Heiko cares, but when alphabetical sort I get this:
simple-audio-card,codec
simple-audio-card,cpu

> +		simple-audio-card,codec {
> +			sound-dai = <&hdmi>;
> +		};
> +	};
> +
>  	qos_gpu: qos@fe128000 {
>  		compatible = "rockchip,rk3568-qos", "syscon";
>  		reg = <0x0 0xfe128000 0x0 0x20>;
> @@ -789,6 +804,23 @@ spdif: spdif@fe460000 {
>  		status = "disabled";
>  	};
>  
> +	i2s0_8ch: i2s@fe400000 {
> +		compatible = "rockchip,rk3568-i2s-tdm";
> +		reg = <0x0 0xfe400000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
> +		assigned-clock-rates = <1188000000>, <1188000000>;
> +		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
> +		clock-names = "mclk_tx", "mclk_rx", "hclk";
> +		dmas = <&dmac1 0>;
> +		dma-names = "tx";
> +		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
> +		reset-names = "tx-m", "rx-m";
> +		rockchip,grf = <&grf>;
> +		#sound-dai-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	i2s1_8ch: i2s@fe410000 {
>  		compatible = "rockchip,rk3568-i2s-tdm";
>  		reg = <0x0 0xfe410000 0x0 0x1000>;
> 
