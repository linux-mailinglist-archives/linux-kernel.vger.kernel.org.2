Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95711453024
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhKPLVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhKPLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:21:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA8C061570;
        Tue, 16 Nov 2021 03:18:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso2086657wme.3;
        Tue, 16 Nov 2021 03:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=lRQsw39q87TQG3Wp6ZE2EXeT9gINH2OmBiOA+uRkqxQ=;
        b=KIxBCbNz0wInKJ4xL7ysL7HnsAj0vjREmYXCFrVjQEI5Dvbu/PmHu0IGw5ytlhWRyF
         9vlnI12EOPWfDcahPufAsmA6r/5CRq8DNX7k9RGqLDrXm03heDGHuhJpIzm56UkiYwF9
         ChAUQSfRl3lXVJvhK6o2GRSUmXOnB59EfBvqjf+cdKHVvtZb4eRA7c0GIMRS3YSa7bPw
         SuBCkjvg3hKTxe8j34ACZt6rQBpVbZ5r2OcNRNCcp+HZeVNsqKs9LvXPE/+2YrO3li8H
         jSJIVbMyGWE0tWiTbyhCRYjI7xGH7i1p6U20UbjTFNFlaLV9cnWjZPQDj2PiJYqLWRFq
         fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=lRQsw39q87TQG3Wp6ZE2EXeT9gINH2OmBiOA+uRkqxQ=;
        b=cyhZlS0nALsj08P36vax/GdQe6hab6a2V/m6BeN/rrOn9cAjNHbHYzAmSFzY2OOhG9
         zYEucmBfNB9W+GUhEJzi2dCOBCFLexvRVUxU009+21Jmq46sbH1ZhwZ7gzYLqG96g+kT
         SNvUJ35kM2QF1qCSIFs12kA1O9v5DXMYQWpwQZl5lvTYgrluZZsirZnZnxF7H42EnLkP
         jFeQJpFA1+RFSx/Jx+2wmqFYQ25/AAT4nSCtZwmdH8zI+KaPQS45L3bifYDHhsFayw8U
         idRh0QXn8YxosWokP1KPzp9Yj4exdmwll68GwcxqF0kGXQFoT+vH98DQ6mPGvcTai3J3
         9sDQ==
X-Gm-Message-State: AOAM530kjL5MMl2ZX/9urW5IXaAMMNVHPq1iKr/8Uuzlg4Ndfui8QeRX
        JjZevgdZyeQTWG/3yQe4Yyc=
X-Google-Smtp-Source: ABdhPJyn0V0nVHouB1Hkda0tjQ7aSEr2Na6ZMxg689+Jn3ahbpWWZ2Vl46C7RY1O0tp9iYgEeFArIw==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr71149885wms.12.1637061495153;
        Tue, 16 Nov 2021 03:18:15 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id j40sm2454114wms.19.2021.11.16.03.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:18:14 -0800 (PST)
Message-ID: <c5c0849d-a95a-25a0-11f8-9156770afc10@gmail.com>
Date:   Tue, 16 Nov 2021 12:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
References: <20211018114009.13350-1-sam.shih@mediatek.com>
 <20211018114009.13350-3-sam.shih@mediatek.com>
 <d411aec5-efa8-c71d-8179-54ff52c17039@gmail.com>
 <d299493d8fec0f34f527942f2cdedf15f2136c9a.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: mediatek: add basic mt7986a support
In-Reply-To: <d299493d8fec0f34f527942f2cdedf15f2136c9a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2021 02:39, Sam Shih wrote:
> Hi,
> 
> On Mon, 2021-11-15 at 17:27 +0100, Matthias Brugger wrote:
>> Hi,
>>
>> On 18/10/2021 13:40, Sam Shih wrote:
>>> Add basic chip support for Mediatek mt7986a, include
>>> basic uart nodes, rng node and watchdog node.
>>>
>>> Add cpu node, timer node, gic node, psci and reserved-memory node
>>> for ARM Trusted Firmware.
>>>
>>
>> What is the exact difference between mt7986a and mt7986b? Right now,
>> it's only
>> the compatible, for that it makes no sense to split them.
>>
> 
> The difference between mt7986a and mt7986b is pinout which described
> in our pinctrl patch series
> https://lore.kernel.org/all/20211022124036.5291-3-sam.shih@mediatek.com/
> 
> You are right, in this "basic SoC support" patch series, only show
> compatible differences
> 
>> It would be good to see what the exact differences are, so that we
>> can see if it
>> makes sense to have one of the alternatives:
>> 1) use a common mt7986.dtsi which get included by mt7986[a,b].dtsi
>> 2) Use on mt7986.dtsi and only add one mt7986a.dtsi or mt7986b.dtsi
>> which has
>> add-ons.
>>
> 
> In this case, can we use solution (1) to create a generic mt7986.dtsi
> in this patch series, and add mt7986[a,b].dtsi to the dts part of the
> pinctrl patch series to separate the difference nodes?
> 

If the only difference is the GPIO controller then why not go with solution 2. 
Create a mt7986.dtsi which holds e.g. the node for pincontroller mt7986a and 
then create a mt7986b.dtsi that just changes compatible and gpio-ranges:

&pio {
    compatible = "mediatek,mt7986b-pinctrl";
    gpio-ranges = <&pio 0 0 41>, <&pio 66 66 35>;
}

What do you think?

Regards,
Matthias

>>> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
>>>
>>> ---
>>> v7: added memory node back to dts
>>> v6: removed clock and pinctrl node, to separate basic part into a
>>> single
>>>       patch series
>>>
>>> Original thread:
>>>
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211004124155.1404-1-sam.shih@mediatek.com/__;!!CTRNKA9wMg0ARbw!xCEW0lwTKx4k272sWASoi90y_yRyQdAx0oNJC-jSAIWnIEkprJD-gAc1ugCvo0ex$
>>>   
>>>
>>> v5: follow reviewr's comment: removed clock freqency node in timer
>>> due to
>>>       we have set CNTFRQ_EL0 in ATF firmware, and also corrected
>>> GICD range
>>> v4: added missing gic register bases, and fixed range of GICR
>>> v3: used the stdout-path instead of console=ttyS0
>>> v2: modified clock and uart node due to clock driver updated
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>>>    arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts |  38 +++++
>>>    arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 149
>>> +++++++++++++++++++
>>>    3 files changed, 188 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 4f68ebed2e31..e6c3a73b9e4a 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>>> b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>>> new file mode 100644
>>> index 000000000000..ca074cf8e578
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>>> @@ -0,0 +1,38 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2021 MediaTek Inc.
>>> + * Author: Sam.Shih <sam.shih@mediatek.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt7986a.dtsi"
>>> +
>>> +/ {
>>> +	model = "MediaTek MT7986a RFB";
>>> +	compatible = "mediatek,mt7986a-rfb";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart0;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +		bootargs = "earlycon=uart8250,mmio32,0x11002000
>>> swiotlb=512";
>>
>> We normally don't add earlycon parameter to the normal bootargs, as
>> it's only
>> for debugging. Also what do we need the swiotlb? Are there any
>> limitation in the
>> HW that makes us need it?
>>
> 
> Thank you for your suggestion, as far as I know, it should not have
> hardware limitations. This bootargs is just inherent from mt7622-
> rfb.dts, I will delete it and test again on our development board.
> 
>> Regards,
>> Matthias
>>
>>> +	};
>>> +
>>> +	memory {
>>> +		reg = <0 0x40000000 0 0x40000000>;
>>> +	};
>>> +};
>>> +
>>> +&uart0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&uart1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&uart2 {
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
>>> new file mode 100644
>>> index 000000000000..75912bcf6c9c
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
>>> @@ -0,0 +1,149 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2021 MediaTek Inc.
>>> + * Author: Sam.Shih <sam.shih@mediatek.com>
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +/ {
>>> +	compatible = "mediatek,mt7986a";
>>> +	interrupt-parent = <&gic>;
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	system_clk: dummy40m {
>>> +		compatible = "fixed-clock";
>>> +		clock-frequency = <40000000>;
>>> +		#clock-cells = <0>;
>>> +	};
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		cpu0: cpu@0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a53";
>>> +			enable-method = "psci";
>>> +			reg = <0x0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu1: cpu@1 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a53";
>>> +			enable-method = "psci";
>>> +			reg = <0x1>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu2: cpu@2 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a53";
>>> +			enable-method = "psci";
>>> +			reg = <0x2>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu3: cpu@3 {
>>> +			device_type = "cpu";
>>> +			enable-method = "psci";
>>> +			compatible = "arm,cortex-a53";
>>> +			reg = <0x3>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +	};
>>> +
>>> +	psci {
>>> +		compatible  = "arm,psci-0.2";
>>> +		method      = "smc";
>>> +	};
>>> +
>>> +	reserved-memory {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges;
>>> +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
>>> +		secmon_reserved: secmon@43000000 {
>>> +			reg = <0 0x43000000 0 0x30000>;
>>> +			no-map;
>>> +		};
>>> +	};
>>> +
>>> +	timer {
>>> +		compatible = "arm,armv8-timer";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>>> +		gic: interrupt-controller@c000000 {
>>> +			compatible = "arm,gic-v3";
>>> +			#interrupt-cells = <3>;
>>> +			interrupt-parent = <&gic>;
>>> +			interrupt-controller;
>>> +			reg = <0 0x0c000000 0 0x10000>,  /* GICD */
>>> +			      <0 0x0c080000 0 0x80000>,  /* GICR */
>>> +			      <0 0x0c400000 0 0x2000>,   /* GICC */
>>> +			      <0 0x0c410000 0 0x1000>,   /* GICH */
>>> +			      <0 0x0c420000 0 0x2000>;   /* GICV */
>>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>> +		};
>>> +
>>> +		watchdog: watchdog@1001c000 {
>>> +			compatible = "mediatek,mt7986-wdt",
>>> +				     "mediatek,mt6589-wdt";
>>> +			reg = <0 0x1001c000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>>> +			#reset-cells = <1>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		trng: trng@1020f000 {
>>> +			compatible = "mediatek,mt7986-rng",
>>> +				     "mediatek,mt7623-rng";
>>> +			reg = <0 0x1020f000 0 0x100>;
>>> +			clocks = <&system_clk>;
>>> +			clock-names = "rng";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		uart0: serial@11002000 {
>>> +			compatible = "mediatek,mt7986-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11002000 0 0x400>;
>>> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&system_clk>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		uart1: serial@11003000 {
>>> +			compatible = "mediatek,mt7986-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11003000 0 0x400>;
>>> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&system_clk>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		uart2: serial@11004000 {
>>> +			compatible = "mediatek,mt7986-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x11004000 0 0x400>;
>>> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&system_clk>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +	};
>>> +
>>> +};
>>>
> 
> Regards,
> Sam
> 
