Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C08450153
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhKOJ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbhKOJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:28:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFBC06120E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:25:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i5so29305508wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q56pxBIS1WlDqqoLNnvpb0MNdsfXj3HDaGEh+gHhZCw=;
        b=PaCHbIXuSPCdDANjN4U9zKwOXJtO7jNqk9GilGYFrqwAaQxNfGRMU8FD2Ep2Wpz0kJ
         /CuuOI3lHr8hXKXwYukDKT6CYaAqTtfwpESArqWWIL78T9kfNvADDwedKoPx7VdLKhwT
         ZU1YQILcJyfTQbjjT9KeI96sTt4Tz3X4+JnWXP46lezgxRmfSL7XrowWGM2P3SjiXu2M
         Y/W+0J3CHSV7ukj6JxItJyZAEyxEXHXghCNIyJjVwVQFk2G36rX9sOjoKaVEgjru9tI3
         l2K1aNu+ElE7tpyTxAasl91jB8StZw6yIfdiJpYgnRZHcRmArWRfX4vfOg45oI4GAc+u
         y3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q56pxBIS1WlDqqoLNnvpb0MNdsfXj3HDaGEh+gHhZCw=;
        b=yjbMJ3AFSNFmoojWRBSVLj6IEBwCIhTO+3IpqhtfW1ZXID8amtUsTFxgoDmZktWm+n
         6EC2SJyksXjv7YevTIbA7ot0M5sMeny2NOLjBzVEvKx+8/ePpjIiSVdcPyg2TIHfcL+P
         l3/IpjyGUBzVOHHkhQvx6uR0jlCjmbZ6l821ZIwePQcj2Bb3CGRvrA2VTW/PjK9o47/e
         p+2kb8u45vS5BtXraAsufcIjurxe7RHZQO136B2Z+qfVFFfoiUWvWr2PYB7A5fixafrS
         kAN4d39nKKFK6le//kFdMfQgCiCH3JUFbw+x3Mxx5Nqi8pe6KmvdA2VudAivLfqrh63L
         w5bw==
X-Gm-Message-State: AOAM5325/UE/B96phCJM7Wk9uOHpAPVi1OI+DsAa+/2AS4EzJm8ltHHA
        9ujbWaik36s0aed2y1izUP7ZqA6yNCiA3fZ5
X-Google-Smtp-Source: ABdhPJwS9Fqbw9DfB3Wz6gbqs5XRxFnnVuhmfXM8K2OMm9THO4OZYoLKqWkTLP+HsQM2T9+YrleMIQ==
X-Received: by 2002:adf:ef52:: with SMTP id c18mr45839204wrp.162.1636968311298;
        Mon, 15 Nov 2021 01:25:11 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:f56f:2409:301:93ad? ([2001:861:44c0:66c0:f56f:2409:301:93ad])
        by smtp.gmail.com with ESMTPSA id h16sm15190587wrm.27.2021.11.15.01.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 01:25:10 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: meson-gxbb-wetek: use updated LED
 bindings
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211012052522.30873-1-christianshewitt@gmail.com>
 <20211012052522.30873-4-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d8bac7a1-0d0f-7c07-ad50-7d317f22fab5@baylibre.com>
Date:   Mon, 15 Nov 2021 10:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012052522.30873-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2021 07:25, Christian Hewitt wrote:
> Update the dts to use the newer style of LED bindings.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index a4d34398da35..94dafb955301 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include "meson-gxbb.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	aliases {
> @@ -26,8 +27,10 @@
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		led-system {
> -			label = "wetek-play:system-status";
> +		led-power {
> +			/* red in suspend or power-off */
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_POWER;
>  			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  			panic-indicator;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
