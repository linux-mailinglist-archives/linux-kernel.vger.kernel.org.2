Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2E3B40FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFYJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFYJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:59:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:57:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o22so4923887wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXR0Jto15p9D6SXD9so7u+A/IVvd9POUcHlyax5EA1Q=;
        b=cjBsefTsH+8iWqNb5tJUjU4+p/+aBifMkCkjwOnqsHUn6jefOgZXyp07SoXTLVv3UJ
         0b0XViNGme3bChT6OpT/zVbW6U/4y6ZFzxq/JrxuzmAFcrlXZdYf3dEoQrRsqNqKVW9o
         4giDfrGrz3KWCO+DAGaqyVfkbNvcjNKfR6rxVKqR8l8CosCTp23YIbDVvCD22X4WQpdT
         uG8pzSCMirxNPqR22ZQpYonP+lLYdkLcq/0C4y7maHhj/8bh3wol5zk9LajHaJ7Rl9bT
         nchMxhtET2fuxSuvDURU9KAudg0AUgcYIq+ZrO0D1Jof/26BempxFRQ64ktO8U2LoZkx
         cOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXR0Jto15p9D6SXD9so7u+A/IVvd9POUcHlyax5EA1Q=;
        b=ly7SAP3Kkc0ndhUDMftJAFTDAwfDUDZI6RNr33tdqFF4jQWCfrXinFgGOM6kstzAKV
         7MEKN5RYZKtXv3z/HLeYk5uXY2wfsHPL7+NqRAGqI+JIqOTxTyT3dBHiTBKBLja2bnty
         mDOT8X0jzsvOfo7uTYZ2my3lRLUPKeEtq0aZydGkGAHrqLyNfhOg3X6kj3nSEf/0I0x8
         cuye4cd46xUqZKhOWfnQ5EqY5MCAuJlloU8XeHGyt400sLzV7albhNBgdh1tXK7YyMTS
         sfMll94APn7sbxKF8XSQOp6FUrmwoYHx1u+wWaBtoHcGHL0TsajD7EAk8KM76Ddh3+C2
         p0Ow==
X-Gm-Message-State: AOAM533IYQ+2i6Ioe3PrSX3qTrZ4LmdJTVC0O6yjoLJ+hsmxwwh8tRjP
        Z4d5f1ea38YssgltXft+Q7d6QA==
X-Google-Smtp-Source: ABdhPJw08HAiAJAuqs2vuWjjX1R7qU+vfjz0Pw1It39O79illPxSUSjz0ErIOOIUdhwWa3pTWaLZ7A==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr9734097wmi.148.1624615025903;
        Fri, 25 Jun 2021 02:57:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0? ([2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0])
        by smtp.googlemail.com with ESMTPSA id v22sm4851249wmh.40.2021.06.25.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 02:57:05 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     Frank Wunderlich <frank-w@public-files.de>,
        Eric Woudstra <ericwouds@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
Date:   Fri, 25 Jun 2021 11:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frank,

On 25/06/2021 10:16, Frank Wunderlich wrote:
> Hi,
> 

>> Gesendet: Donnerstag, 24. Juni 2021 um 15:29 Uhr Von: "Eric
>> Woudstra" <ericwouds@gmail.com> The SOC runs unthrotlled slowly to
>> 80 degrees. This takes minutes.
Polling interval 1 second or less does not matter much when looking at
these temperature rise times
>> 
>> After that in more then an hour it slowly creeps up to 85. I
>> believe
the design is so that the SOC, under normal circumstances, can run at
1.35 GHz without throttling frequency, without heatsink. It just needs a
safeguard for different circumstances.
>> 
>> Most of these SOCs can also run in industrial grade circumstances,
which means up to 85 degrees ambient temperature already . If not
industrial then this would be 60 degrees ambient already
>> 
>> But only someone at Mediatek can confirm this
> 
> maybe Matthias knows anybody? get_maintainers-script shows no mtk
> employee for mtk_thermal driver,
added Sean and Ryder as common Linux-Contacts...
> 
> Daniel from openwrt have some other mt7622 Boards maybe he can test
the Fan approach below
> 
>> On Jun 24, 2021, 12:21 PM, at 12:21 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>>> Found that:
>>> 
>>> 
https://download.kamami.pl/p579344-MT7622A_Datasheet_for_BananaPi_Only%281%29.pdf
>>> 
>>> Chapter 3.3 - Thermal Characteristics
>>> 
>>> Given the values I suggest:
>>> 
>>> - Passive - 80°C
>>> 
>>> - Hot - 90°C
>>> 
>>> - Critical - 100°C
> 
> maybe adding FAN (r64, don't know for other mt7622 boards) for lower
> 2
trips (with adjusted temperature points) and cpu-throtteling for upper 2
trips

It depends what you want to achieve first:

 - better / sustained performance, then fan before

 - quiet device or power saving (on battery) then cpu throttling before

That is board specific, it should be tuned on DT board specific file.

Some comments below:

> something like this (used the 70/80 trip points discussed before):
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi

You should not add the fan in the mt7622.dtsi itself but in the board
specific file where there is a fan output on it. mt7622.dtsi is supposed
to be the SoC itself AFAICT.

For instance:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n39

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n164

> @@ -134,6 +134,13 @@
>  		};
>  	};
>  
> +	fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		pwms = <&pwm 2 10000 0>;
> +		cooling-levels = <0 102 170 230>;
> +	};
> +
>  	thermal-zones {
>  		cpu_thermal: cpu-thermal {
>  			polling-delay-passive = <1000>;
> @@ -143,13 +150,13 @@
>  
>  			trips {
>  				cpu_passive: cpu-passive {
> -					temperature = <47000>;
> +					temperature = <70000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
>  				cpu_active: cpu-active {
> -					temperature = <67000>;
> +					temperature = <80000>;
>  					hysteresis = <2000>;
>  					type = "active";
>  				};
> @@ -170,14 +177,12 @@
>  			cooling-maps {
>  				map0 {
>  					trip = <&cpu_passive>;
> -					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  				};

fan == active trip point

This is referring to the passive trip point. So it should point to the
CPU as it is now. Note the order of mitigation is inverted regarding the
proposal description.

>  				map1 {
>  					trip = <&cpu_active>;
> -					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  				};
>  
>  				map2 {
> @@ -428,6 +433,7 @@
>  	pwm: pwm@11006000 {
>  		compatible = "mediatek,mt7622-pwm";
>  		reg = <0 0x11006000 0 0x1000>;
> +		#pwm-cells = <3>;
>  		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&topckgen CLK_TOP_PWM_SEL>,
>  			 <&pericfg CLK_PERI_PWM_PD>,
> 
> 
> regards Frank
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
