Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0F41DCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhI3PHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:07:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235547AbhI3PHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:07:47 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UDUKPh006556;
        Thu, 30 Sep 2021 17:05:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sspGCg/P+hrJnTfsc1SrMwVnAR/3nxeD+gtuxpS5IiQ=;
 b=3N+iS++7Dx0oCCzhKcR+yKwrvwy+vQfuqhzBPj6pF11pCgtAcRPiDW9j3sYI6DnO+HDr
 X1nBnNqcM1hKNDqq/G8cCXSX5BPZTDraKSt955VkoK+Ot83dR74RyUmeAgBneitrqQdh
 Dt/oCso4n2EWHzziukyocysFbHvMhQCJcfFd5N30ihikO2dozrDoZXww3gHdQ8oJ4ybF
 V9psSspNagjdDkZGKs7Ib3ZYI5JuROUDQ4CYW5fGlyvxOaDAyd1IKBR7aaI1ZbuJpmez
 03HL/QyWBfgAGjaFkYGO7Y5vSkQuSlPqVF4dgdN5g4ROVh0ZGaob/vKm7qkNZ+ULus+Q 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bde69rh62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 17:05:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F0A410002A;
        Thu, 30 Sep 2021 17:05:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D0232A4D71;
        Thu, 30 Sep 2021 17:05:53 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 17:05:52 +0200
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
 <e8d40be8-045c-096a-f079-d9f6364254e9@foss.st.com>
 <cfbb8475-ad1e-9075-cd82-92a8b315efc9@denx.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <9b278eb2-7ca9-0e4b-ecb1-5949ce3c5c10@foss.st.com>
Date:   Thu, 30 Sep 2021 17:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cfbb8475-ad1e-9075-cd82-92a8b315efc9@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_05,2021-09-30_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 12:26 PM, Marek Vasut wrote:
> On 9/30/21 10:47 AM, Alexandre TORGUE wrote:
>> Hi Marek
>>
>> On 9/29/21 1:18 PM, Marek Vasut wrote:
>>> On 9/27/21 1:45 PM, Olivier Moysan wrote:
>>>> Fix SAI2B pin muxing for AV96 board on STM32MP15.
>>>> The label "sai2a-4" is defined twice. Change redundant label to 
>>>> "sai2b-4".
>>>>
>>>> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 
>>>> pins on stm32mp15")
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>> ---
>>>>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi 
>>>> b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>> index 5b60ecbd718f..b9cc9e0dd4fc 100644
>>>> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>> @@ -1235,7 +1235,7 @@
>>>>           };
>>>>       };
>>>> -    sai2b_pins_c: sai2a-4 {
>>>> +    sai2b_pins_c: sai2b-4 {
>>>>           pins1 {
>>>>               pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>>>>               bias-disable;
>>>
>>> This mp1 pinmuxing is a total mess, sigh.
>>
>> What is the issue here ?
> 
> The same-old discussion about where to place the pinmux nodes, whether 
> we should have these clusters of pre-defined options in ...pinctrl.dtsi, 
> or whether we should do more nxp-like per-board configuration.

ok it's a bit more precise. Honestly I don't understand why the current 
topology is an issue here. Maybe pinctrl SAI nodes names are not well 
chosen or are not enough explicit. Concerning our topology and the NXP 
ones both exists and both have advantages and drawbacks. For ST boards 
(DK/EV) we want to keep all configs in the same place.

As I prefer to not re open this topic again and again, feel free to add 
your pin config in your dts board file, I'll accept it.
