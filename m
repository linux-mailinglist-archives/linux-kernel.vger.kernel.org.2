Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED23A5153
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFLXRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 19:17:32 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:47067 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFLXRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 19:17:30 -0400
Received: by mail-wr1-f42.google.com with SMTP id a11so9999249wrt.13;
        Sat, 12 Jun 2021 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yYepx29oxpeytytNEXW/8cPD3PVhclfo4gIFKtPvQCk=;
        b=QPSLoLECxudnEaF6vt//Vkze03O+SaTu9mmRiq+f5aSeT0mMXVN6v80ioh19ypZ86x
         hIHTQpmu8tFZibI+IZ+erOIsdGzIoZrVy+Nq7i0EfoDAaRst2CaiD5hTZQ4xd4nGnGwH
         MPfCqYMubeRg/ay5oIxupHfftLHUXS0kEUkQck2P1/8q4mODx9mA9/wItHePJsmaYQfi
         +UIfRRJEoiTQDLbctCx25mTc+DCPjAGnVTAZbsEoLGAcG4HSEwq2MtL4Nj8T/uWh16Ye
         zAyp/cwDslJsnpFZYQ81rdt75OwxWOk6xN64yLwyssQkGElWueqWNWcLVv0YFQ+qJCeL
         caZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yYepx29oxpeytytNEXW/8cPD3PVhclfo4gIFKtPvQCk=;
        b=WLurLun0xlcqm4OpGd95xXLu8f55HyIyI9EUrt932pB/X1tdTDNXvPo6Pi3Z8EUR92
         vfW+8ILYIQkmyOk2vAHG0LlmnXC0w/wOmWj74lQRhgn/I2BOnbQLd5WpsFXi8NwKxVa5
         6v1TkMOt10e32R78wWT2DTZOcIPoH6e2cQCuOmZM9hWfyHjkAe0yKjIhNMgf6K2fL7+6
         p+cbtBSOMYQRMgf44KguiNfxIHFX2dgSpF7yRk2Xs2AfqolQQQVvP4SfzINnApvY1QNa
         Io/fbJPrIdhesBuE5pBiK/OO32TgkWzMdGIOwptkf2Ck0qiLP+fEjdLsXernoWWnvgw4
         nv0A==
X-Gm-Message-State: AOAM5301zzc6TzfHVpJth3OpnjC8gkLKRNaO10B+PNUsjJd2B4K/yetN
        bH4GTtb0rswxJz/yCakquv4=
X-Google-Smtp-Source: ABdhPJxr7jJQldA4uVOB2+R2oea5n9g7bDjns0zi6DfHmPPP224OWv2UcHAhiqRKqP4+qrK8zIH6vg==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr11257508wrn.30.1623539653386;
        Sat, 12 Jun 2021 16:14:13 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id 4sm11293910wry.74.2021.06.12.16.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 16:14:13 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] ARM: dts: NSP: Add common bindings for MX64/MX65
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-4-mnhagan88@gmail.com>
 <20210611203031.fj3g32o7kgupgzjy@skbuf>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <0f3e81be-e99a-41fe-6898-42c4d25b21be@gmail.com>
Date:   Sun, 13 Jun 2021 00:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611203031.fj3g32o7kgupgzjy@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 21:30, Vladimir Oltean wrote:

> On Fri, Jun 11, 2021 at 12:27:15AM +0100, Matthew Hagan wrote:
>> These bindings are required for all Meraki MX64/MX65 devices.
>>
>> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
>> ---
>>  .../dts/bcm958625-meraki-mx6x-common.dtsi     | 148 ++++++++++++++++++
>>  1 file changed, 148 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
>>
>> diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
>> new file mode 100644
>> index 000000000000..47a30dedf7b3
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Common Bindings for Cisco Meraki MX64 (Kingpin) and MX65 (Alamo) devices.
>> + *
>> + * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
>> + */
>> +
>> +#include "bcm-nsp.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x60000000 0x80000000>;
>> +	};
>> +
>> +	pwm-leds {
>> +		compatible = "pwm-leds";
>> +
>> +		red {
>> +			label = "red:led";
>> +			pwms = <&pwm 1 50000>;
>> +		};
>> +
>> +		green {
>> +			label = "green:led";
>> +			pwms = <&pwm 2 50000>;
>> +		};
>> +
>> +		blue {
>> +			label = "blue:led";
>> +			pwms = <&pwm 3 50000>;
>> +		};
>> +	};
>> +};
>> +
>> +&L2 {
>> +	arm,io-coherent;
>> +	prefetch-data = <1>;
>> +	prefetch-instr = <1>;
>> +};
> It is common practice to sort labels alphabetically and nodes by unit address.
This will be done. Thanks.
>
>> +
>> +&uart0 {
>> +	clock-frequency = <62500000>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +	at24@50 {
>> +		compatible = "atmel,24c64";
>> +		pagesize = <32>;
>> +		reg = <0x50>;
>> +	};
>> +};
>> +
>> +&amac2 {
>> +	status = "okay";
>> +};
>> +
>> +&nand {
>> +	nandcs@0 {
>> +		compatible = "brcm,nandcs";
>> +		reg = <0>;
>> +		nand-on-flash-bbt;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		nand-ecc-strength = <24>;
>> +		nand-ecc-step-size = <1024>;
>> +
>> +		brcm,nand-oob-sector-size = <27>;
>> +
>> +		partition@0 {
>> +			label = "u-boot";
>> +			reg = <0x0 0x80000>;
>> +			read-only;
>> +		};
>> +
>> +		partition@80000 {
>> +			label = "shmoo";
>> +			reg = <0x80000 0x80000>;
>> +			read-only;
>> +		};
>> +
>> +		partition@100000 {
>> +			label = "bootkernel1";
>> +			reg = <0x100000 0x300000>;
>> +		};
>> +
>> +		partition@400000 {
>> +			label = "senao_nvram";
>> +			reg = <0x400000 0x100000>;
>> +		};
>> +
>> +		partition@500000 {
>> +			label = "bootkernel2";
>> +			reg = <0x500000 0x300000>;
>> +		};
>> +
>> +		partition@800000 {
>> +			label = "ubi";
>> +			reg = <0x800000 0x3f700000>;
>> +		};
>> +	};
>> +};
>> +
>> +&qspi {
>> +	status = "disabled";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&pwm {
>> +	status = "okay";
>> +	#pwm-cells = <2>;
> What is the reason for overriding this to 2?

I can't provide an explanation other than that it only works at 2.

When set to 3 I get the following:

[    0.784051] OF: /pwm-leds/red: #pwm-cells = 3 found -1
[    0.789201] of_pwm_get(): can't parse "pwms" property
[    0.794295] leds_pwm pwm-leds: error -EINVAL: unable to request PWM for red:led
[    0.801628] leds_pwm: probe of pwm-leds failed with error -22

>> +	chan0 {
>> +		channel = <1>;
>> +		active_low = <1>;
>> +		};
> Bad indentation for this bracket.
This will be removed in v3
>
>> +	chan1 {
>> +		channel = <2>;
>> +		active_low = <1>;
>> +	};
>> +	chan2 {
>> +		channel = <3>;
>> +		active_low = <1>;
>> +	};
>> +};
>> +
>> +&ccbtimer1 {
>> +	status = "disabled";
>> +};
>> +
>> +&sata_phy {
>> +	status = "disabled";
>> +};
> It is common practice to disable these in the common SoC dtsi and let
> individual boards enable them as necessary, instead of the opposite.
Will add patches in v3 to disable ccbtimers and qspi by default. The sata_phy one is not required.
>
>> -- 
>> 2.26.3
>>
>
