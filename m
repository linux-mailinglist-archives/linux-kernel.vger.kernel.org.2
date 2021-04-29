Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7373C36E59B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhD2HKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhD2HKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:10:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F7C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:09:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g65so6010109wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGQKcvz7hC4nUFEHdDadJU+QZacItzjYP+ScbOMh1Aw=;
        b=1E9n8OGXToC0MSju3Flt6bn5DIN3r1e1ekVoS9QnDIDsM7q9vgo6IIPwARbyDobdkZ
         DYzkqOzRpL/vSgZ66x5I3136OTtUE31feFT+8G5FxPJAwVQFjUikVImrBWBo3M5troG8
         MsHv3psM9NMtq3CNZgSaufEbg53GGNIgERZEavlQP9Q6tjFzyEJ93YbrKHeoJeBVP5Tu
         IbZi+bRyFeTziY3IUIF2Kbd1Aw6fFvihOy2rRu0r5JP/xzG4tuCyHLiDVRctI6/qAwDT
         vJZuzSWMGkxvEqNkKvDyInlXBC7nhORgrSdaYPmc+Ta91SGxZFttYb+IMKqese66fZ9q
         JYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lGQKcvz7hC4nUFEHdDadJU+QZacItzjYP+ScbOMh1Aw=;
        b=V97+LuCnELo7FbpCQcGN31Zk39d2ntSk/19WEi1ABFDEk4iHjFGk8wdPJnIudpdg2f
         AijrPDK8GjyBX+ROAd991l/Raxofy/QJvNJPaBwdFtaCEh3k5Gsjtmzukk8WAkjqi2h0
         own/6YlHsGmEC3mXJf5pqAMx/I6gU1v8OwpgpGUvpZXECLNKm4pieQkjvBK+vk1Y6IpN
         RZxonHofnrhtsbd3Lp404MWa6mQeaE6Y4VYZK1iNk5xaojnXTqTVuXBPID/LtIbuN9Qq
         XMnCy3wBGMmQqOAlOwcLLSysqvxDByadYZWDrFH7knx4NEAYBbYNFl21T9AFG1eaBjCk
         /BCQ==
X-Gm-Message-State: AOAM530KSYhQipWvTWWa00R0q2YL4DEGS0TBvb3agmnsvT7XjRHyO1xE
        ASS/E4CNIL3tymPWitgShjKhgEEkCCb3pAG7
X-Google-Smtp-Source: ABdhPJzJCsoIlJD/C9JSCk3Ow6k2ys4QaWLWVgm6T6H5RWE8KSBa8ZvwFssGIDpCX3oPdWkMPE+efw==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr35571333wmc.92.1619680159135;
        Thu, 29 Apr 2021 00:09:19 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:c304:4b2b:4a79:1da9? ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id e12sm3171283wrt.51.2021.04.29.00.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:09:18 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
To:     Chen-Yu Tsai <wens@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210429060830.6266-1-wens@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <509d541c-a91a-a1f0-e37f-b239f1d3219b@baylibre.com>
Date:   Thu, 29 Apr 2021 09:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429060830.6266-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 08:08, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The NanoPi K2 has a AP6212 WiFi+BT combo module. The WiFi portion is
> already enabled. The BT part is connected via UART and I2S.
> 
> Enable the UART and add a device node describing the Bluetooth portion
> of the module.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 7273eed5292c..10f48fb1af61 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -385,9 +385,19 @@ &uart_AO {
>  
>  /* Bluetooth on AP6212 */
>  &uart_A {
> -	status = "disabled";
> +	status = "okay";
>  	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>  	pinctrl-names = "default";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		clocks = <&wifi_32k>;
> +		clock-names = "lpo";
> +		vbat-supply = <&vddio_ao3v3>;
> +		vddio-supply = <&vddio_ao18>;
> +		host-wakeup-gpios = <&gpio GPIOX_21 GPIO_ACTIVE_HIGH>;
> +		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  /* 40-pin CON1 */
> 

Thanks !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
