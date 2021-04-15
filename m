Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386CB360A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhDONex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:34:53 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:24536 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDONes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:34:48 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FDWUHr008109;
        Thu, 15 Apr 2021 15:34:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6uz0c1465Mr7NrQ4wXFaQunuUDFud5BrXBAfEglYGI4=;
 b=YljTdmTY1jCQQxC6XiUHCWeCqSwsT1ERsMTzeB6dIsfHQdUvXvLqVdKK4lliMKNm1I9B
 5Qjddswt0KWyIvS+4+bQ5AU+5iWkH1gfLgTmimtLv27ECqhCJRDc0m61FYU6tDWtRg5x
 O6sBtgKW4JzBe0ZWk7U1+GlGseTcNG3K8t2vyc5wgT60rVNAQg41y9Y//ZbzHQxsvedZ
 EBebJTGc5PLDC/5QeyPMdhJBd576nwwfwW+ibxK1be9jGdlvcn7oxPY9rfK6HKdCo43g
 FECNpdHpeiCDFAsCPNQ+StlQbWrgsP0YucOeu8+BW2V+Ig9mRJ4uEO6OOLRgv76uOpGY Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xg6w2wat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 15:34:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BABE610002A;
        Thu, 15 Apr 2021 15:34:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3FF97237049;
        Thu, 15 Apr 2021 15:34:08 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr
 2021 15:34:07 +0200
Subject: Re: [PATCH 11/13] ARM: dts: stm32: fix LTDC port node on STM32 MCU ad
 MPU
To:     Marek Vasut <marex@denx.de>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-12-alexandre.torgue@foss.st.com>
 <3b39908b-a263-a5d4-f6ac-ac30ffb06269@denx.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <36e9f0df-dfdb-e2f5-3d6e-ac32a1b8156e@foss.st.com>
Date:   Thu, 15 Apr 2021 15:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b39908b-a263-a5d4-f6ac-ac30ffb06269@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_05:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek

On 4/15/21 3:21 PM, Marek Vasut wrote:
> On 4/15/21 12:10 PM, Alexandre Torgue wrote:
>> Running "make dtbs_check W=1", some warnings are reported concerning
>> LTDC port subnode:
>>
>> /soc/display-controller@5a001000/port:
>> unnecessary #address-cells/#size-cells without "ranges" or child "reg"
>> property
>> /soc/display-controller@5a001000/port: graph node has single child node
>> 'endpoint', #address-cells/#size-cells are not necessary
> 
> btw could you retain diffstat on your patches ? It's useful to see which 
> files changed right away.
> [...]
> 
>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts 
>> b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> index 2bc92ef3aeb9..19ef475a48fc 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>> @@ -82,9 +82,15 @@
>>   };
>>   &ltdc {
>> -    status = "okay";
>> -
>>       port {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ltdc_ep0_out: endpoint@0 {
>> +            reg = <0>;
>> +            remote-endpoint = <&sii9022_in>;
>> +        };
>> +
>>           ltdc_ep1_out: endpoint@1 {
>>               reg = <1>;
>>               remote-endpoint = <&dsi_in>;
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi 
>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>> index 64dca5b7f748..e7f10975cacf 100644
>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>> @@ -277,11 +277,7 @@
>>       status = "okay";
>>       port {
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -
>> -        ltdc_ep0_out: endpoint@0 {
>> -            reg = <0>;
>> +        ltdc_ep0_out: endpoint {
>>               remote-endpoint = <&adv7513_in>;
>>           };
>>       };
> 
> I think this is wrong, the AV96 can have two displays connected to two 
> ports of the LTDC, just like DK2 for example.

As for dk2 address/size cells are added only if there are 2 endpoints. 
It is for this reason I moved endpoint0 definition from stm32mp15xx-dkx 
to stm32mp151a-dk1.dts (dk1 has only one endpoint).

Here it's the same, if you have second endpoint then adress/size will 
have to be added.

alex










