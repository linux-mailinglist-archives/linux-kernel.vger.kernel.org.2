Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649D334ACAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:40:53 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:46755 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCZQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:40:38 -0400
Received: by mail-wm1-f49.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3314485wmf.5;
        Fri, 26 Mar 2021 09:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pk/5UKNO88VEsaxaSJL6OfiLNZz47MnFtkb7BXkXp/o=;
        b=TxoD+zLvizVjXMlyuXySn+gXN3yrFa8hV9PYg3LkDqqw+GETgiIIFuEGmcdwVe6dGU
         dj70PhVDuhugdvaKSfkjbQP2QAzfGXbbSOExmFJhaccxuPSafweRgRknYrzrk/EeD/av
         rEgcxTru48CFm4hZU65SKtX+b3RAZJxmXYxRaVI7tAGr105xA633z2Z0q4qcSKnq0xBX
         TfoGx4uz8z9tbTHBLtN5F9oWJCoIayruRsMk8/olQF1qciTRZ6ngupv7+zxij7OEMgem
         Gha3UxvUyTyHygrHO+mIJQNLbx03z11tqIE2TQKVXXOSUB3j9dQxLDBQfjCbROYv7XJr
         3r7Q==
X-Gm-Message-State: AOAM533e/coBdZiUv386PbgGjcGrtWna+nm1NOny9kCXIoXxuboxoc10
        7RPL2zbCFlV+CNIqh8Vjy0E=
X-Google-Smtp-Source: ABdhPJzQPcCPbUx9hgnmB/XItfMqBozcGPkCmxgGm+kYCoWozgc53vmI57T8/JVWX33AGp5WlBb/kA==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr13819443wma.170.1616776836836;
        Fri, 26 Mar 2021 09:40:36 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h12sm7320219wrv.58.2021.03.26.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 09:40:36 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: exynos: Add front camera support to I9100
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210326162501.355292-1-timon.baetz@protonmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <7864559f-f406-647d-0500-741aae3f8e1a@kernel.org>
Date:   Fri, 26 Mar 2021 17:40:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326162501.355292-1-timon.baetz@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 17:25, Timon Baetz wrote:
> Add node for Samsung S5K5BAF CMOS image sensor and
> enable the associated MIPI CSI-2 receiver node.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index 228de6d8c9d1..d31146c08b84 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -147,6 +147,36 @@ battery@36 {
>  		};
>  	};
> 
> +	i2c_s5k5baf: i2c-gpio-1 {
> +		compatible = "i2c-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sda-gpios = <&gpc1 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpc1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +
> +		s5k5bafx@2d {

The node name should be generic, so "image-sensor".

> +			compatible = "samsung,s5k5baf";
> +			reg = <0x2d>;
> +			vdda-supply = <&cam_io_en_reg>;
> +			vddreg-supply = <&vt_core_15v_reg>;
> +			vddio-supply = <&vtcam_reg>;
> +			clocks = <&camera 0>;
> +			clock-names = "mclk";
> +			stbyn-gpios = <&gpl2 0 1>;

GPIO_ACTIVE_LOW

> +			rstn-gpios = <&gpl2 1 1>;
> +			clock-frequency = <24000000>;
> +


Best regards,
Krzysztof
