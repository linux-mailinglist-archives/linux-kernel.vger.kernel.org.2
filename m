Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB4350B22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 02:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhDAA1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 20:27:15 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:53375 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhDAA0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 20:26:47 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BB7D2671;
        Wed, 31 Mar 2021 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617236804;
        bh=08q8G8cOLWIoXLhWzNvhwkZkkwwSWLtrKtMQolz2+nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onCzU11hP1AaLG+0phTmNhjFRbWgpUS8nWL3STZ9pI+MHxiFvMBK0zPeKuVlhRaZA
         VXtkcnsEA7uqtFeVaDqwy0ebG8LqJVBpLo2flwQwafrINTP10dUuDfA2oxE8VTCxqQ
         zo/jpxQcSB6XLHwyGbCaGWorkFspZ8EZ2o+GKOs4=
Date:   Wed, 31 Mar 2021 19:26:41 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
Message-ID: <YGUTQZJLyILvdKhl@hatter.bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-4-zev@bewilderbeest.net>
 <815c666b-d657-4d0a-bea4-d2e182d9e5d1@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <815c666b-d657-4d0a-bea4-d2e182d9e5d1@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:04:51PM CDT, Andrew Jeffery wrote:
>
>
>On Tue, 30 Mar 2021, at 10:53, Zev Weiss wrote:
>> This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
>> mini-ITX board that we hope can provide a decent platform for OpenBMC
>> development.
>>
>> This initial device-tree provides the necessary configuration for
>> basic BMC functionality such as host power control, serial console and
>> KVM support, and POST code snooping.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
>>  1 file changed, 188 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>> b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>> new file mode 100644
>> index 000000000000..27b34c3cf67a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/dts-v1/;
>> +
>> +#include "aspeed-g5.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +#include <dt-bindings/i2c/i2c.h>
>> +
>> +/{
>> +	model = "ASRock E3C246D4I BMC";
>> +	compatible = "aspeed,ast2500";
>> +
>> +	aliases {
>> +		serial4 = &uart5;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart5;
>> +		bootargs = "console=tty0 console=ttyS4,115200 earlyprintk";
>> +	};
>> +
>> +	memory@80000000 {
>> +		reg = <0x80000000 0x20000000>;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		heartbeat {
>> +			/* BMC_HB_LED_N */
>> +			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger = "timer";
>> +		};
>> +
>> +		system-fault {
>> +			/* SYSTEM_FAULT_LED_N */
>> +			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
>> +			panic-indicator;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		uid-button {
>> +			label = "uid-button";
>> +			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(F, 1)>;
>> +		};
>> +	};
>> +
>> +	iio-hwmon {
>> +		compatible = "iio-hwmon";
>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
>> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
>> +			<&adc 10>, <&adc 11>, <&adc 12>;
>> +	};
>> +};
>
>You're hooking up the ADC lines to the iio-hwmon bridge...
>> +
>> +&adc {
>> +	status = "okay";
>> +};
>
>But you haven't requested the ADC lines from pinmux here.
>
>It will *happen* to work as expected because ADC is the default mux
>state for the pins, but by not requesting the lines you're leaving the
>pins available for a conflicting request, which can be annoying to
>debug.
>

Ack, thanks -- will fix & resend.

>> +
>> +&kcs3 {
>> +	status = "okay";
>> +	aspeed,lpc-io-reg = <0xca2>;
>> +};
>
>Given you need KCS support, do you mind testing my KCS series?
>
>https://lore.kernel.org/linux-arm-kernel/20210319062752.145730-1-andrew@aj.id.au/
>

Sure, I'll try to give that a shot and report back in the next day or 
two.

>The cover letter got detached, and is here:
>
>https://lore.kernel.org/linux-arm-kernel/20210319061952.145040-1-andrew@aj.id.au/
>
>Andrew
