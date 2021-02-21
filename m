Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A920E320B07
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBUOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:44:43 -0500
Received: from marcansoft.com ([212.63.210.85]:57058 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUOol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:44:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 61B25425BE;
        Sun, 21 Feb 2021 14:43:54 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-26-marcan@marcan.st>
 <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <2e10f1e6-c86f-33ad-0c7b-4fefe4f28163@marcan.st>
Date:   Sun, 21 Feb 2021 23:43:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 04.29, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 09:17:13PM +0900, Hector Martin wrote:
>> +	memory@800000000 {
>> +		device_type = "memory";
>> +		reg = <0 0 0 0>; /* To be filled by loader */
> 
> dtc and dtschema might complain, so could you set here fake memory
> address 0x800000000? Would that work for your bootloader?

Yeah, the bootloader just replaces the entire property anyway. I'll fill 
in some dummy values (the real usable memory range is to some extent 
dynamic and depends on firmware).

>> +	};
>> +};
>> +
>> +&serial0 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/apple/apple-m1.dtsi b/arch/arm64/boot/dts/apple/apple-m1.dtsi
>> new file mode 100644
>> index 000000000000..45c87771b057
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/apple/apple-m1.dtsi
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright The Asahi Linux Contributors
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/apple-aic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +	compatible = "apple,m1", "apple,arm-platform";
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "apple,icestorm";
>> +			device_type = "cpu";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "spin-table";
>> +			cpu-release-addr = <0 0>; /* To be filled by loader */
>> +		};
> 
> New line after every device node, please.

Added newlines after all the CPU nodes.

> With this minor changes, fine for me:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks!

v3 will rename this file to apple/t8103.dtsi and the board file to 
t8103-j274.dts to better match other platforms (and to use the proper 
SoC ID for the M1); please let me know if you're okay keeping the 
Reviewed-by for that.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
