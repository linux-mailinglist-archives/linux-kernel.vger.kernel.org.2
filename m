Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C42330AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhCHJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhCHJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:55:38 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBA5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:55:38 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvDHB2p5Wz1rync;
        Mon,  8 Mar 2021 10:55:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvDHB1R7yz1r1M2;
        Mon,  8 Mar 2021 10:55:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fvrJ_QkQVZtS; Mon,  8 Mar 2021 10:55:31 +0100 (CET)
X-Auth-Info: QtOASf/huVzoEk9V0QF1IiUIsbVKip7CTKjNghctd6Q=
Received: from [192.168.1.107] (92-52-238-184.pool.digikabel.hu [92.52.238.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Mar 2021 10:55:31 +0100 (CET)
Reply-To: hs@denx.de
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Teresa Remmet <T.Remmet@phytec.de>
Cc:     "krzk@kernel.org" <krzk@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20210308064046.1576267-1-hs@denx.de>
 <20210308064046.1576267-3-hs@denx.de>
 <20210308084047.numy4o2jvsiz5d3v@pengutronix.de>
 <196131b90400b434931992ba5a9078828d1eaf2a.camel@phytec.de>
 <20210308092823.a3ffj4auysnoti6o@pengutronix.de>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <d750280b-8852-7237-7f73-a399f7b4e3b1@denx.de>
Date:   Mon, 8 Mar 2021 10:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210308092823.a3ffj4auysnoti6o@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco,

On 08.03.21 10:28, Marco Felsch wrote:
> On 21-03-08 08:52, Teresa Remmet wrote:
>> Hello Marco,
>>
>> Am Montag, den 08.03.2021, 09:40 +0100 schrieb Marco Felsch:
>>> On 21-03-08 07:40, Heiko Schocher wrote:
>>>> enable the mt25qu256aba spi nor on the imx8mp-phycore-som.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> ---
>>>>
>>>>  .../dts/freescale/imx8mp-phycore-som.dtsi     | 27
>>>> +++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
>>>> b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
>>>> index 44a8c2337cee4..0284e7a5c6bba 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
>>>> @@ -65,6 +65,22 @@ ethphy1: ethernet-phy@0 {
>>>>  	};
>>>>  };
>>>>  
>>>> +&flexspi {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pinctrl_flexspi0>;
>>>> +	status = "okay";
>>>> +
>>>> +	flash0: mt25qu256aba@0 {
>>>> +		reg = <0>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		compatible = "jedec,spi-nor";
>>>
>>> Please make the compatible the first property followed by the reg
>>> property. Also you don't need to add the #size-cells and #address-
>>> cells
>>> now since you don't add a child node.
>>
>> but is this not similar to the label here? If you add partitions in the
>> bootloader you need the cells properties?
> 
> If the bootloader will add partitions the bootloader can add the
> size/address-cells too using the phandle. But this is more a nit.

Yes. I personally prefer to pass mtd partitions through kernel commandline.

I will work in your and Teresas comment, thanks!

bye,
Heiko
> 
> Regards,
>   Marco
> 
>> Teresa
>>
>>>
>>> Regards,
>>>   Marco
>>>
>>>> +		spi-max-frequency = <80000000>;
>>>> +		spi-tx-bus-width = <4>;
>>>> +		spi-rx-bus-width = <4>;
>>>> +	};
>>>> +};
>>>> +
>>>>  &i2c1 {
>>>>  	clock-frequency = <400000>;
>>>>  	pinctrl-names = "default";
>>>> @@ -217,6 +233,17 @@ MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		
>>>> 0x11
>>>>  		>;
>>>>  	};
>>>>  
>>>> +	pinctrl_flexspi0: flexspi0grp {
>>>> +		fsl,pins = <
>>>> +			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		
>>>> 0x1c2
>>>> +			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x8
>>>> 2
>>>> +			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x8
>>>> 2
>>>> +			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x8
>>>> 2
>>>> +			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x8
>>>> 2
>>>> +			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x8
>>>> 2
>>>> +		>;
>>>> +	};
>>>> +
>>>>  	pinctrl_i2c1: i2c1grp {
>>>>  		fsl,pins = <
>>>>  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x4
>>>> 00001c3
>>>> -- 
>>>> 2.29.2
>>>>
>>>>
>>>>
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
