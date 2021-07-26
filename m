Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6D63D5486
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhGZHCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:02:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhGZHCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:02:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16Q7hEDb040963;
        Mon, 26 Jul 2021 02:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627285394;
        bh=Z7jD0mQAoy3ojk+iiHUn5mhLG0G8KU5yeTjQ/OUuIHc=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=rCaB7D0oplf2khih2XUOj5Lad1KWQq/J9d8A238aNupC4FA2uYhARrkeY+ql68CUI
         W7LZBO8cr/OX0kOME9wpHGxSJB1smNF2e0RjV+PQCmTkdCZzx9w1DoejEH4T5Za3p4
         bzmASsw9oLH+3myDJHjS/gt5MWTqPonpt+1dElmM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16Q7hE3L036458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 02:43:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 02:43:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 02:43:14 -0500
Received: from [10.250.148.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16Q7h9gu048924;
        Mon, 26 Jul 2021 02:43:10 -0500
Subject: Re: [PATCH 3/6] arm64: dts: ti: k3-j721e: Add support for MCAN nodes
From:   Aswath Govindraju <a-govindraju@ti.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-4-a-govindraju@ti.com>
 <20210720145451.6eby7pbfocyyfi4e@pengutronix.de>
 <41ff222b-e751-1586-b774-4e55bfe5e017@ti.com>
Message-ID: <65368cf6-afad-cb08-1b27-883e8e7eafef@ti.com>
Date:   Mon, 26 Jul 2021 13:13:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <41ff222b-e751-1586-b774-4e55bfe5e017@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 21/07/21 1:18 pm, Aswath Govindraju wrote:
> Hi Marc,
> 
> On 20/07/21 8:24 pm, Marc Kleine-Budde wrote:
>> On 20.07.2021 19:46:39, Aswath Govindraju wrote:
>>> From: Faiz Abbas <faiz_abbas@ti.com>
>>>
>>> Add support for 14 MCAN controllers in main domain and 2 MCAN controllers
>>> present in mcu domain. All the MCAN controllers support classic CAN
>>> messages as well as CAN_FD messages.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
>>>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
>>>  2 files changed, 224 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> index cf3482376c1e..4215b8e6785a 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> @@ -1940,4 +1940,200 @@
>>>  			bus_freq = <1000000>;
>>>  		};
>>>  	};
>>> +
>>> +	main_mcan0: can@2701000 {
>>> +		compatible = "bosch,m_can";
>>> +		reg = <0x00 0x02701000 0x00 0x200>,
>>> +		      <0x00 0x02708000 0x00 0x8000>;
>>> +		reg-names = "m_can", "message_ram";
>>> +		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
>>> +		clocks = <&k3_clks 156 1>, <&k3_clks 156 0>;
>>> +		clock-names = "cclk", "hclk";
>>> +		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
>>> +			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
>>> +		interrupt-names = "int0", "int1";
>>> +		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
>>
>> Are you intentionally only enabling 1 TX buffer?
>>
> 
> I have used this configuration for testing. It can be increased to 32 if
> required. Is it better to set it to the maximum number of buffers ?
> 

I have now set all the parameters that can be configured, to the their
max values.

"bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;"

Earlier while setting only one tx buffer I was unintentionally limiting
it. As far as I was able to search, the only constraint in setting them
to max values is the memory space allocated for message ram. As in this
case there is enough memory for configuring the message ram with max
values for all parameters, I see that memory space wouldn't be an issue.

After setting the above mentioned configuration I was able to perform a
few tests and they were passing.

I will fix this configuration and send a respin for this series.

Thanks,
Aswath

> Thanks,
> Aswath
> 
>> Marc
>>
> 

