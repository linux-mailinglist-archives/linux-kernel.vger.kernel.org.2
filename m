Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA736093E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhDOMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:24:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232842AbhDOMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:24:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FCCh6W018070;
        Thu, 15 Apr 2021 14:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=F/GalzWzm89gxShNFkNRH3cF1SeIQnv7lFFgZazi5ZQ=;
 b=gQ5SO8rWCWnYxZBEOdMNQbwMf98LxmuB0V4phCMQ3NG40IwZ7kjIpuvoMjJksPQrpNA2
 B7E1C93lNcvWnttQuzXK2Cgk1Q23TWM/tsSibX/FSZAa3+XKA7t00qfuhbrhB2fxxTbm
 WmnRw8Ra9AbM+zyq2qxsvORGIn0eA1rFuf7EVYyQKILpuq2BX++pvxffSoaFGHDnl4pg
 rNjjDLHjtnTWDW7Z4ZWzXI8GwK1ixiCuBWWiJsEZzgXQXQSkz31njrDWw3PDGRybnbyE
 BPAZArpPxHVSoBiIzjvrXzShLpFjiQZvZ1TjhjSHcnGol9EL85AjERUzhyfkYQsUYbkw iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37wx3yyyga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 14:23:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E71110002A;
        Thu, 15 Apr 2021 14:23:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 351CC22D63C;
        Thu, 15 Apr 2021 14:23:34 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr
 2021 14:23:33 +0200
Subject: Re: [PATCH 12/13] ARM: dts: stm32: fix DSI port node on STM32MP15
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-13-alexandre.torgue@foss.st.com>
 <ececc78c-4fca-bb93-ef62-5d107501d963@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <96da49dc-f24d-aa12-e1d8-39b5a5b6fbc9@foss.st.com>
Date:   Thu, 15 Apr 2021 14:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ececc78c-4fca-bb93-ef62-5d107501d963@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 4/15/21 12:43 PM, Ahmad Fatoum wrote:
> Hi,
> 
> On 15.04.21 12:10, Alexandre Torgue wrote:
>> Running "make dtbs_check W=1", some warnings are reported concerning
>> DSI. This patch reorder DSI nodes to avoid:
>>
>> soc/dsi@5a000000: unnecessary #address-cells/#size-cells without
>> "ranges" or child "reg" property
> 
> This reverts parts of commit 9c32f980d9 ("ARM: dts: stm32: preset
> stm32mp15x video #address- and #size-cells"):
>      
>      The cell count for address and size is defined by the binding and not
>      something a board would change. Avoid each board adding this
>      boilerplate by having the cell size specification in the SoC DTSI.
>      
> 
> The DSI can have child nodes with a unit address (e.g. a panel) and ones
> without (ports { } container). ports is described in the dtsi, panels are
> described in the dts if available.
> 
> Apparently, the checker is fine with
> ports {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> };
> 
> I think my rationale for the patch above was sound, so I think the checker
> taking offense at the DSI cells here should be considered a false positive.

If it's a "false positive" warning then we need to find a way to not 
print it out. Else, it'll be difficult to distinguish which warnings are 
"normal" and which are not. This question could also be applied to patch[3].

Arnd, Rob what is your feeling about this case ?

thanks
alex



> Thanks,
> Ahmad
> 
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157.dtsi b/arch/arm/boot/dts/stm32mp157.dtsi
>> index 54e73ccea446..c355fcf26ec3 100644
>> --- a/arch/arm/boot/dts/stm32mp157.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp157.dtsi
>> @@ -24,8 +24,6 @@
>>   			clock-names = "pclk", "ref", "px_clk";
>>   			resets = <&rcc DSI_R>;
>>   			reset-names = "apb";
>> -			#address-cells = <1>;
>> -			#size-cells = <0>;
>>   			status = "disabled";
>>   
>>   			ports {
>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> index 19ef475a48fc..763dde1dbbaf 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> @@ -36,6 +36,8 @@
>>   &dsi {
>>   	status = "okay";
>>   	phy-dsi-supply = <&reg18>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>>   
>>   	ports {
>>   		port@0 {
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
>> index 6fe5b0fee7c4..4625bb58cc6d 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
>> @@ -102,6 +102,8 @@
>>   &dsi {
>>   	phy-dsi-supply = <&reg18>;
>>   	status = "okay";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>>   
>>   	ports {
>>   		port@0 {
>>
> 
