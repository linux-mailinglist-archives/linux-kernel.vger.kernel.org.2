Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB153AC818
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhFRJ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhFRJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:57:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0FC061574;
        Fri, 18 Jun 2021 02:55:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gt18so14912555ejc.11;
        Fri, 18 Jun 2021 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6OHpzFqMhfGysmy1AjapbSWOUF8PkX0rUS/FwR+ecA=;
        b=qaGlPMxABKfJyXTb0/wTCoPW8b97JlTZ0vf0gVMPkt/LRRigN3XmsHfRkDH34vMx4F
         AGicn5KaCu4h2i/4Zqf99m9qL0/5lZMu9kbouE3ItC+sCCztNaH5FoI5Js4evjaD5ex7
         VcbTr9paOIua3fsblA5xFO9erK5kRnLXGHuFFW3x3ndVNN3NJZACi/9Mp+TRwZQoMywn
         0+q1JLhhMAUUS7aE8iosmainGCTJ2WXcj0khqBOs7lJ+4M/7tBuh/bmh01n7oxRnnxkA
         3d5ycOADzsI8J7VLxMbLVlKO1wEiP3VTf9eKkF0RgvTvEX+NCsKujQgeEHWc42vv/kJJ
         cZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6OHpzFqMhfGysmy1AjapbSWOUF8PkX0rUS/FwR+ecA=;
        b=RUUsrHcWMMy4IPHJ+749uSMM1ti935MklfKNDv8TGzFU1GYQE1r3QqW5MkOGs4RNpu
         r5Eufv7IV1M3BQBKaGxfnpfFEYrgF5JIkVQEEkIgX+1zeKlys5BMmzrpYzYki8/SjRb9
         /yPa+dBSpYXP0qKq2ImIa8dmKMleSmQK1KlcowT4a6hzEozpbbJSMleg81zXF9Mk72kL
         pHZP4TAv0HXHWvrSuky/W1Ur+X+GOnw2+JsdVimMPZVrjvYL7xu8ldRgqbkDPXOVBMW3
         C+wP4LKmhk4ImU5VuIEEM78i1+osHQAsiJyhJK38njp2xE6BV4f8k17383HkDwQ0iXJs
         pnvg==
X-Gm-Message-State: AOAM5302ZAT4XBlD6ihHOZWOQhzOwtHHUcRvqLFPEghVRckUPCW+LHkQ
        1S9YWxQsVxqHdWlWZGKWXb8=
X-Google-Smtp-Source: ABdhPJykYF/zptHx7zpqrTLT8w4dZMVzpPcKGfLn8gJgk3Tcqhei8wEXFKxedWCrPXnMb0HoLCs3Dg==
X-Received: by 2002:a17:907:1b20:: with SMTP id mp32mr10188290ejc.495.1624010101951;
        Fri, 18 Jun 2021 02:55:01 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n18sm818960ejx.41.2021.06.18.02.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 02:55:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add ES8316 codec for Rock Pi4
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210617044955.598994-1-knaerzche@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <d562b025-23cc-f26d-b118-e269501f459b@gmail.com>
Date:   Fri, 18 Jun 2021 11:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617044955.598994-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 6/17/21 6:49 AM, Alex Bee wrote:
> Rock Pi4 boards have the codec connected to i2s0 and it is accessible
> via i2c1 address 0x11.
> Add an audio-graph-card it.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 7d0a7c697703..e5c1083174ff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -36,6 +36,12 @@ sdio_pwrseq: sdio-pwrseq {
>  		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>  	};
>  
> +	sound {
> +		compatible = "audio-graph-card";

> +		label = "rockchip,rk3399";

See previous discussion:

https://lore.kernel.org/linux-rockchip/e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com/

It seems that aplay/linux? adds "-1" to it and removes the comma and
"-", so we get:

hdmisound
rockchiprk3399
rockchiprk339_1

Shouldn't we label it with something that reflect the function/output.
Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
Make a shorter label without spaces or special chars, so that chars
don't get removed?

Proposal:

Analog
HDMI
ES8316 <---
SPDIF


Possible example solutions:

[PATCH] arm64: dts: rockchip: more user friendly name of sound nodes
https://lore.kernel.org/lkml/20210110151913.3615326-1-katsuhiro@katsuster.net/

===

Johan

> +		dais = <&i2s0_p0>;
> +	};
> +
>  	vcc12v_dcin: dc-12v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -422,6 +428,20 @@ &i2c1 {
>  	i2c-scl-rising-time-ns = <300>;
>  	i2c-scl-falling-time-ns = <15>;
>  	status = "okay";
> +
> +	es8316: codec@11 {
> +		compatible = "everest,es8316";
> +		reg = <0x11>;
> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint = <&i2s0_p0_0>;
> +			};
> +		};
> +	};
>  };
>  
>  &i2c3 {
> @@ -441,6 +461,14 @@ &i2s0 {
>  	rockchip,capture-channels = <2>;
>  	rockchip,playback-channels = <2>;
>  	status = "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&es8316_p0_0>;
> +		};
> +	};
>  };
>  
>  &i2s1 {
> 
