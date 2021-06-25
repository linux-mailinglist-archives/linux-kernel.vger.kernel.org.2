Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5033B40B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFYJmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFYJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:42:36 -0400
X-Greylist: delayed 1045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Jun 2021 02:40:16 PDT
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E2DC061574;
        Fri, 25 Jun 2021 02:40:16 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1lwi2t-0000zB-Rr; Fri, 25 Jun 2021 11:22:44 +0200
Date:   Fri, 25 Jun 2021 11:22:31 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
Message-ID: <YNWgVxvNbwNcT3B8@makrotopia.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 10:16:43AM +0200, Frank Wunderlich wrote:
> Hi,
> 
> > Gesendet: Donnerstag, 24. Juni 2021 um 15:29 Uhr
> > Von: "Eric Woudstra" <ericwouds@gmail.com>
> > The SOC runs unthrotlled slowly to 80 degrees. This takes minutes. Polling interval 1 second or less does not matter much when looking at these temperature rise times 
> > 
> > After that in more then an hour it slowly creeps up to 85. I believe the design is so that the SOC, under normal circumstances, can run at 1.35 GHz without throttling frequency, without heatsink. It just needs a safeguard for different circumstances.
> > 
> > Most of these SOCs can also run in industrial grade circumstances, which means up to 85 degrees ambient temperature already . If not industrial then this would be 60 degrees ambient already 
> > 
> > But only someone at Mediatek can confirm this 
> 
> maybe Matthias knows anybody?
> get_maintainers-script shows no mtk employee for mtk_thermal driver, added Sean and Ryder as common Linux-Contacts...
> 
> Daniel from openwrt have some other mt7622 Boards maybe he can test the Fan approach below

I got Linksys E8450 aka. Belkin RT3200 ( https://fcc.io/K7S-03571 ) as
well as Ubiquiti UniFi 6 LR ( https://fcc.io/SWX-U6LR ). Both got quite
massive customized heatsinks (see internal photos on FCC submission),
which results in much better heat dissipation than just having the
naked chip like on the BPi-R64.
Hence I also can't test the fan approach on boards other than the R64.


> 
> > On Jun 24, 2021, 12:21 PM, at 12:21 PM, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > >Found that:
> > >
> > >https://download.kamami.pl/p579344-MT7622A_Datasheet_for_BananaPi_Only%281%29.pdf
> > >
> > >Chapter 3.3 - Thermal Characteristics
> > >
> > >Given the values I suggest:
> > >
> > > - Passive - 80°C
> > >
> > > - Hot - 90°C
> > >
> > > - Critical - 100°C
> 
> maybe adding FAN (r64, don't know for other mt7622 boards) for lower 2 trips (with adjusted temperature points) and cpu-throtteling for upper 2 trips
> 
> something like this (used the 70/80 trip points discussed before):
> 
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
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
>  
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
