Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F72354157
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhDELD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhDELD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:03:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9ECC061756;
        Mon,  5 Apr 2021 04:03:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so12103661edu.10;
        Mon, 05 Apr 2021 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CVqkD3AatIpXd53BFyXyyzJdd7n0kKZfEfddTgAIcf8=;
        b=KuJD2F8msRNqfeOT3+a1Pgux00oPtqxE2cAqS4reEwbAwzT2UavpbsydpH599R2SBQ
         kuY/0uvZse0/p57ykkczCurI1r0mlLS/i7HprIxCjlREhV8j8eUKWtrpuIWoisivdhQj
         sid40fOfhRpkpV4wI4BmqLISeU98m9co3gXjYNTOmwJPdKuB5LsDV+k2yy/kAZd+8CuC
         eCrjMzmG+I4NooaGYEkWohkBbUEcZdK/BiMEEhHmHZ52KPN9nPZBInGctJdSu+snqUzP
         UuTUlHBOYfdho5c8OAaix8VNTzj/HNCOZ0YHaIZ5SMA69LW7Y+eNC2MQnMBpLkqiFiCT
         SX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVqkD3AatIpXd53BFyXyyzJdd7n0kKZfEfddTgAIcf8=;
        b=XODi/oGCiK2rMGD7R+7LzPMGGNwK4u/6ffbz6yMVKcTL8jWWxHtZ3c9mqYnagQBgOV
         yznNqeQSxE49njqYvEOUoEsIjRLsiB6EFmPkAWY3ALp1srQVqoaW1gT1sDtHKxTlwVhl
         3Mldx+ERJ+n00/n34eHWXDgba14SZT2ghpR8GzJg9JStV6Z/JIEIsEFKPaif5zGynHfO
         0dbN6QTuiyCUyXwDdQeiPoA/SSmZ1P5sUCnhjJawloSWGkOM7LA38lsb5XWrHsqwMNGB
         emuvgMUrhBaPx1SHdOaH7j3ltwcTTKtewSqqvJSUz/1DvLYdIJPEBBq77LAw/carj1T9
         XzxQ==
X-Gm-Message-State: AOAM530M5v6GcgwZTCn4KPMS72elsz1t/W/bTDxFEhnKJZZQviaQE3xp
        oU1mBJ7oC3EwbXCWqgpH9R8QBUVW/fj4nA==
X-Google-Smtp-Source: ABdhPJzbTGWEO3xL3cM0NMU0xLRnQ1CoUFtXI2zfKTRgSn7BR69n+VrvGMGcQo6esEMLvyrIjU3B0g==
X-Received: by 2002:aa7:c6d2:: with SMTP id b18mr30554061eds.183.1617620629736;
        Mon, 05 Apr 2021 04:03:49 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id lm24sm8555756ejb.53.2021.04.05.04.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 04:03:49 -0700 (PDT)
Subject: Re: [PATCH v2] rockchip: enabled LAN port on NanoPi R2S
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210405093423.16149-1-cnsztl@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c12341c8-8590-8314-d59b-3d5903041491@gmail.com>
Date:   Mon, 5 Apr 2021 13:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210405093423.16149-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianling,

On 4/5/21 11:34 AM, Tianling Shen wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> Enable the USB3 port on the FriendlyARM NanoPi R2S.
> This is required for the USB3 attached LAN port to work.
> 
> Signed-off-by: David Bauer <mail@david-bauer.net>
> [added device node for USB Ethernet controller]
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> index faf496d789cf..18936b393d9d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> @@ -13,6 +13,10 @@
>  	model = "FriendlyElec NanoPi R2S";
>  	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
>  
> +	aliases {
> +		ethernet1 = &r8153;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
> @@ -37,6 +41,16 @@
>  		};
>  	};
>  

> +	vcc_rtl8153: vcc-rtl8153-regulator {

sort nodename

> +		compatible = "regulator-fixed";
> +		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8153_en_drv>;
> +		regulator-always-on;

> +		regulator-name = "vcc_rtl8153";

exception to the sort rule
sort regulator-name above all other regulator properties

> +		enable-active-high;

sort

----
Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

----

> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
> @@ -265,6 +279,12 @@
>  			};
>  		};
>  	};
> +
> +	usb {
> +		rtl8153_en_drv: rtl8153-en-drv {
> +			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>  };
>  
>  &io_domains {
> @@ -364,6 +384,18 @@
>  	dr_mode = "host";
>  };
>  
> +&usbdrd3 {
> +	dr_mode = "host";
> +	status = "okay";
> +

> +	r8153: usb-eth@2 {

With YAML undocumented additional properties and nodes generate
notifications.
We need a change in the documents below for that.
rockchip,dwc3.yaml > usb-drd.yaml > usb.yaml

Is there a standard for the usb-eth nodename?

> +		compatible = "realtek,rtl8153";

Since a while Rob has improved has scripts.
There's no escape anymore.
Add a YAML document to this serie for "realtek,rtl8153".

Improve checking for undocumented compatible strings
https://github.com/devicetree-org/dt-schema/commit/93e7ada8d53af099074cb5d53f7caa12835784e0

> +		reg = <2>;

Why 2 ?

> +

> +		local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */

This is a private property.
In a generic dts that's up to the user.

> +	};
> +};
> +
>  &usb_host0_ehci {
>  	status = "okay";
>  };
> 

