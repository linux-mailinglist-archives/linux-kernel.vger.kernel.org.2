Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB63E5491
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhHJHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbhHJHs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:48:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D0C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:48:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so1258960wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3X7GU0Q/4kIdlftXZNDYWFqtztkfUdLJOvlg5BxTdA=;
        b=WXcmipQZFcMdc0p7vhOxoaa4gEFzolTVMjv2pQ+kTvqMZYsycltOJ+y1MCobdXy+30
         JOKJCdsHeBpUq6AI8NnFMpDJMzq+zNUkuCf2R8WyaUbueTSztkcQZsPgRNecI/vIgnCF
         rfjeaEyiLefIYw9cizljRa6N4ljDIJSwZ8GbhhVghagc8YMGT97JFflyETNZmNrkEw4r
         OrqOJ1ElbGAPufPXjrkWroUwztRBxT9FfRP7S5f4q7TPFwq4Xz6lQnj8wq85YIDhQ6wo
         kyBzaFthEU6g5d9DEEWyTojQTfQimkw+7WbWxHgVI+LpHauhPbUKUtb9S2Vffjo6yUYQ
         Dn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U3X7GU0Q/4kIdlftXZNDYWFqtztkfUdLJOvlg5BxTdA=;
        b=ZnfatdaX2WJOrer1m0AzSLg0D5ZRzttJZ7adsjbTCQ011EHFyK5JzHrEvrlJbPlXEe
         L4y9hB7inKmFh19JQX/LERvxJ9vL6O6suQJMFrsiLlp9K5a7N/iIctpO91H+F0eHwgL+
         cLvND55tYHhQRyNzwDraLgrQ03Z19um48NFXZv11FxpPt+OXPvH4xxJ5hVtW5vrnRDUZ
         KiodzYdG7cMAn8+JyLF45MuFNXrFwqvedL4cv3UGHivAwZUDqmb37aFouK5Mghba3bLt
         7ZuRoA4ZJ8bVR9ml0VkUxX4KijQJ8tg5pTkZqAa49Kiz99ixdhvAYFx0WqZz4o1HdM+r
         RKYQ==
X-Gm-Message-State: AOAM533H13HU4IVfukzA1lTcRun5P1yI6e5OGY/9p4k6ZnzgBNRjWmXi
        m7XUhYjYjXVzYVZFnrOD2i2KvqXTjJAi7qdc
X-Google-Smtp-Source: ABdhPJxN5+EbW8dWjwkIOdFVoyE0zxBvIYfwUJiIptC47NVz8jB5PvMzNLoBGIkdLoULMJmYQH47wQ==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr14275408wml.158.1628581715772;
        Tue, 10 Aug 2021 00:48:35 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:b710:2b6e:27aa:f0a0? ([2001:861:44c0:66c0:b710:2b6e:27aa:f0a0])
        by smtp.gmail.com with ESMTPSA id r10sm5325150wrq.32.2021.08.10.00.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 00:48:35 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to nexbox-a1
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210804140029.4445-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7f060ba5-139a-3656-53ac-0ecef37ac496@baylibre.com>
Date:   Tue, 10 Aug 2021 09:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804140029.4445-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2021 16:00, Christian Hewitt wrote:
> Add initial support limited to HDMI i2s and SPDIF (LPCM).
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index dfa7a37a1281..236c0a144142 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -10,6 +10,7 @@
>  /dts-v1/;
>  
>  #include "meson-gxm.dtsi"
> +#include <dt-bindings/sound/meson-aiu.h>
>  
>  / {
>  	compatible = "nexbox,a1", "amlogic,s912", "amlogic,meson-gxm";
> @@ -24,6 +25,13 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	spdif_dit: audio-codec-0 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "DIT";
> +	};
> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
> @@ -75,6 +83,59 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "NEXBOX-A1";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-3 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status = "okay";
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &cec_AO {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
