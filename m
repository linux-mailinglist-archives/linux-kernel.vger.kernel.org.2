Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB73B42B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFYLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:50:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B8C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:48:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i94so10291783wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kwcx9otKeRLrPfoujiGcv2pQL5iszSvQBvkikrZdgJ8=;
        b=qRWLJiX0JpHuLPVS/tsP1icZ/nNWiBpH/TQJnwa4S+y4rHPQTSSfRG7guZURO3rhRe
         ZNDaECZcynKUwMfpHkIzWWTjrdVlJlgr7u9dm9WpSpIwkcUK9LZdDvB+/lL1QWGFnhSE
         KQICngDxp8tDRBm81R43MzQO/eFrRrPdtav4Kuc91QxyxvlMk9LCqGNqXmfX/EjYx3MY
         ARdKNXoLuL2Yf2XywcbGcPWFn/lzZB+IR1I1LOZw0ih1iquHvTd8cIPnfwnXGoqqOBhP
         cRjTYmq12qjZY59gB3Pc8kr645aisuwJw4m8va8rIEaEaGITqBurUuz1hfdcV7m9YV9o
         gvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kwcx9otKeRLrPfoujiGcv2pQL5iszSvQBvkikrZdgJ8=;
        b=o7yTFAtreyohTQRopxye/zqiYh/prU85owTsDKVgqD/Y2Jp9iSbFuxwbyolUx+Qxbu
         t3T/oYNlwlFrfJ3mnUuG2zniFE0fhwfRAR5VQQT1ndxMNKxkMdcbkAyh1S+3QBx07EOl
         dBU5Ue6zon6G5N1l7XEekHzrFfahPl5OVq7NBR1fJsd/QK005h/Anz1e7rkCcNijRXGh
         k0+daod/xIM7kQW94Olf6WCy+0TP0qKWyF06P3YHe2OqlEr85q4THMR6YfFAoREqkZnj
         aG/MF8Ne1nak+hgTssQRD3eV1ayxTEzQVDMD/+VHHQ5VqRPkrLc3bilGL7t0w33SQl6n
         opVw==
X-Gm-Message-State: AOAM532NzfTyKiFugi5f08H93SvnlVIYIDJd0MCu6npOqieRqtQ2fkLb
        S/7O7H+SMfWUppJydDRiHhTlJQ==
X-Google-Smtp-Source: ABdhPJy5Gp4yNbeL/MczZpciQZE1+Pu7WBKPslzvha7jWE7uLGxGLe067X+TbgN8DO7YaMaJ9DInJw==
X-Received: by 2002:a05:6000:128b:: with SMTP id f11mr10668163wrx.171.1624621678949;
        Fri, 25 Jun 2021 04:47:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0? ([2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0])
        by smtp.googlemail.com with ESMTPSA id s23sm5862861wmh.5.2021.06.25.04.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:47:58 -0700 (PDT)
Subject: Re: Aw: Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
 <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <915b101a-6bea-ae96-78ed-d27fa5bfce3a@linaro.org>
Date:   Fri, 25 Jun 2021 13:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2021 13:03, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Freitag, 25. Juni 2021 um 11:57 Uhr
>> Von: "Daniel Lezcano" <daniel.lezcano@linaro.org>
> 
>> You should not add the fan in the mt7622.dtsi itself but in the board
>> specific file where there is a fan output on it. mt7622.dtsi is supposed
>> to be the SoC itself AFAICT.
>>
>> For instance:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n39
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n164
> 
>>> @@ -170,14 +177,12 @@
>>>  			cooling-maps {
>>>  				map0 {
>>>  					trip = <&cpu_passive>;
>>> -					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +					cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>  				};
>>
>> fan == active trip point
>>
>> This is referring to the passive trip point. So it should point to the
>> CPU as it is now. Note the order of mitigation is inverted regarding the
>> proposal description.
> 
> but we need to disable the passive trip as cpu-trotteling starts there...the higher temperature trips are currently not reached

Sorry, can you rephrase it ? I'm not getting the point.


> summary
> 
> moving fan and cpu_thermal-override to bananapi-r64.dts
> 
> passive-trip: cooling-device = <&cpu0/1 0 0> as in erics Patch
> active trip: cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> the other 2 unchanged
> 
> but i suggest changing the temperature points in mt7622 dtsi as this is SoC specific
> 
> so basicly:
> 
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -143,13 +143,13 @@ cpu_thermal: cpu-thermal {
> 
>                         trips {
>                                 cpu_passive: cpu-passive {
> -                                       temperature = <47000>;
> +                                       temperature = <70000>;

May be increase the passive temp to 75°C.

>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
> 
>                                 cpu_active: cpu-active {
> -                                       temperature = <67000>;
> +                                       temperature = <80000>;
>                                         hysteresis = <2000>;
>                                         type = "active";
>                                 };

Move the active trip 'cpu_active' to mt7622-bananapi-bpi-r64.dts. and
set it to 70°C in the mt7622-bananapi-bpi-r64.dts, so the fan will act
before the cpu throttling.

The behavior should be the following: The temperature reaches 70°C, the
fan will start, if the temperature continues to increase, it will
increase the speed. If the temperature reaches 75°C, the fan is still
rotating at full speed but the cpu begins to be throttled.

AFAIU, it is a Cortex-A53 running @1.35GH, so except the board is in a
black metal box under the sun, I don't see how we can reach this thermal
limits.

> @@ -170,8 +170,8 @@ cpu-crit {
>                         cooling-maps {
>                                 map0 {
>                                         trip = <&cpu_passive>;
> -                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                       cooling-device = <&cpu0 0 0>,
> +                                                        <&cpu1 0 0>;

You should keep it untouched.

>                                 };
> 
>                                 map1 {
> @@ -428,6 +428,7 @@ uart3: serial@11005000 {
>         pwm: pwm@11006000 {
>                 compatible = "mediatek,mt7622-pwm";
>                 reg = <0 0x11006000 0 0x1000>;
> +               #pwm-cells = <3>;
>                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
>                 clocks = <&topckgen CLK_TOP_PWM_SEL>,
>                          <&pericfg CLK_PERI_PWM_PD>,
> 
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -37,6 +37,13 @@ cpu@1 {
>                 };
>         };
> 
> +       fan0: pwm-fan {
> +               compatible = "pwm-fan";
> +               #cooling-cells = <2>;
> +               pwms = <&pwm 2 10000 0>;
> +               cooling-levels = <0 102 170 230>;
> +       };
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
> 
> @@ -582,6 +589,29 @@ &u3phy {
>         status = "okay";
>  };
> 
> +&cpu_thermal {
> +       cooling-maps {
> +               map1 {
> +                       trip = <&cpu_active>;
> +                       cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins>;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
