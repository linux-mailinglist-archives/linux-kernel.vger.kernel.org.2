Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5641D5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348725AbhI3Itw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:49:52 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348339AbhI3Itt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:49:49 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U7NYEa006694;
        Thu, 30 Sep 2021 10:47:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LuzvPakSGeIgrzpUBElZTEkeMxrFYfaFwh7HewqAPWs=;
 b=riU96bxiu2IzHgCfubE5+yFhTdT736xfd0meWSqb2gaJS2XmyWat0RfGl2RGKDTEHmlR
 ze9stPzbdnU5EUIQdfbuHNICLIxlVly6nrxN8Z8PlWp8ykgpDUITyNi3MxS1Nt1lurdO
 Twklu1Bj3gEnXNsyaV8KqA9p9dxTQdjbSCnoWxS1+fP2m4cs9hF5XVAqrPGjdH8ub6Md
 LvQIpOTAHW7FzTSwIMaVKytHkg4kSauknczwzA54RL/nRrtbIHwPDm/MOA9jttm82/MQ
 SofjMEslDFLc23WvJp8x4sd2tsrM0jFlTzGg9fNM0wPupj9AO71CHsBBQftiTA0qbniD Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bd0gg2ts3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 10:47:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC68B10002A;
        Thu, 30 Sep 2021 10:47:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C708A233C97;
        Thu, 30 Sep 2021 10:47:52 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 10:47:51 +0200
Subject: Re: [PATCH 1/1] ARM: dts: stm32: fix AV96 board SAI2B pin muxing on
 stm32mp15
To:     Marek Vasut <marex@denx.de>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210927114553.21843-1-olivier.moysan@foss.st.com>
 <beb6e7c8-f3c8-fc4e-6017-fea5690b9f33@denx.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <e8d40be8-045c-096a-f079-d9f6364254e9@foss.st.com>
Date:   Thu, 30 Sep 2021 10:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <beb6e7c8-f3c8-fc4e-6017-fea5690b9f33@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_02,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek

On 9/29/21 1:18 PM, Marek Vasut wrote:
> On 9/27/21 1:45 PM, Olivier Moysan wrote:
>> Fix SAI2B pin muxing for AV96 board on STM32MP15.
>> The label "sai2a-4" is defined twice. Change redundant label to 
>> "sai2b-4".
>>
>> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 
>> pins on stm32mp15")
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi 
>> b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>> index 5b60ecbd718f..b9cc9e0dd4fc 100644
>> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>> @@ -1235,7 +1235,7 @@
>>           };
>>       };
>> -    sai2b_pins_c: sai2a-4 {
>> +    sai2b_pins_c: sai2b-4 {
>>           pins1 {
>>               pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>>               bias-disable;
> 
> This mp1 pinmuxing is a total mess, sigh.

What is the issue here ?

> Can you please also fix sai1a-4 and sai1a-5, which should really be 
> sai1a-2 and sai1a-sleep-2 ? Same as the sai2b-4 and sai2b-5 should be 
> sai2b-2 and sai2b-sleep-2 .
> 
> With that, it would be perfect, thank you.
> 
> [...]

