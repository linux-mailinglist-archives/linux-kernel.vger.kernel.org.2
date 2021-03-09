Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2105F332A61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCIP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:26:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42498 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhCIP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:26:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129FPqPo010686;
        Tue, 9 Mar 2021 09:25:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615303552;
        bh=NYLOclSzkzCtpSynCghJLlkHYe/TU1BtDuQ/hHQ4Pnc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Eyc8IdFfzweyNb/A+4pAnZGv2shINl3JmcJANuUSYtCL1sXsLa5Ver6Cz+2NAEukp
         sT4zEXPzYXciskFm8WhfIQ/MvTOo2+jvxgJ30VxS184bodoqZSvPXVtiECWhUZIiTZ
         svv/0pFgUMbsm/j2ShnU8ziJv/geSyuCMF9QsVN4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129FPp1s012742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 09:25:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 09:25:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 09:25:51 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129FPmLF114290;
        Tue, 9 Mar 2021 09:25:48 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add support for SPI EEPROM
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210301060518.19550-1-a-govindraju@ti.com>
 <c06a39c5-88eb-1e6d-4ae2-796981db1e71@ti.com>
 <20210309145426.tgt7ltlh22slygfm@santa>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <a256e792-1d1f-5df4-bca0-4add18ac83b4@ti.com>
Date:   Tue, 9 Mar 2021 20:55:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309145426.tgt7ltlh22slygfm@santa>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 09/03/21 8:24 pm, Nishanth Menon wrote:
> On 20:18-20210309, Vignesh Raghavendra wrote:
>>
>>
>> On 3/1/21 11:35 AM, Aswath Govindraju wrote:
>>> Add pinmux details and device tree node for the EEPROM attached to SPI0
>>> module in main domain.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>
>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> Regards
>> Vignesh
>>
>>>
>>> This patch depends on,
>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210301055109.17626-3-a-govindraju@ti.com/
> 
> 
> Can you drop this dependency and rebase on top of my -next branch or
> linux-next ? I am not able to apply the patch directly and would like to
> avoid hand modifying the patch.
> 

ok, I'll post a respin after dropping this dependency and picking up the
reviewed by.

Thanks,
Aswath

>>>
>>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>> index bfd849a29655..bc5bd7f896ab 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>>> @@ -139,6 +139,15 @@
>>>  			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
>>>  		>;
>>>  	};
>>> +
>>> +	main_spi0_pins_default: main-spi0-pins-default {
>>> +		pinctrl-single,pins = <
>>> +			AM64X_IOPAD(0x0210, PIN_INPUT, 0) /* (D13) SPI0_CLK */
>>> +			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0) /* (D12) SPI0_CS0 */
>>> +			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0) /* (A13) SPI0_D0 */
>>> +			AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
>>> +		>;
>>> +	};
>>>  };
>>>  
>>>  &main_uart0 {
>>> @@ -245,6 +254,19 @@
>>>  	pinctrl-0 = <&main_usb0_pins_default>;
>>>  };
>>>  
>>> +&main_spi0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&main_spi0_pins_default>;
>>> +	ti,pindir-d0-out-d1-in = <1>;
>>> +	eeprom@0 {
>>> +		compatible = "microchip,93lc46b";
>>> +		reg = <0>;
>>> +		spi-max-frequency = <1000000>;
>>> +		spi-cs-high;
>>> +		data-size = <16>;
>>> +	};
>>> +};
>>> +
>>>  &sdhci0 {
>>>  	/* emmc */
>>>  	bus-width = <8>;
>>>
> 

