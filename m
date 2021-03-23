Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406243457CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCWG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:29:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46092 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCWG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:29:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12N6TOcF102486;
        Tue, 23 Mar 2021 01:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616480964;
        bh=sUo6zOb86QRv/BWcOTr9noe3RI1fgCJxzPswTPoFg6o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VRwToIipljqW6aHfYvaSSYDep0Jk0cQaw08nRQNooRM+PwWznNXsGVLiOjEeXZ/v1
         28mqnZWfwvEWBJfMf1kmYfNCh1heH+ccEd8jqFTBK4q5ux+J/gppzJpPKC9DzdPDNH
         W5wHD4zYGS+oHHI+mPl+rQmDMg3l9d4qXqsIqzmY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12N6TOWM130951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Mar 2021 01:29:24 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 23
 Mar 2021 01:29:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 23 Mar 2021 01:29:24 -0500
Received: from [10.250.232.216] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12N6TJeO038866;
        Tue, 23 Mar 2021 01:29:20 -0500
Subject: Re: [PATCH v7 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
To:     Aswath Govindraju <a-govindraju@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210322131206.24887-1-a-govindraju@ti.com>
 <20210322131206.24887-4-a-govindraju@ti.com>
 <20210322153547.d5hkqydpe372rpwg@manicure>
 <bff2481a-31a1-788b-2c80-dbf876b7a6ae@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <599d06e5-2b8f-011f-cf8d-3ccf34ee37b1@ti.com>
Date:   Tue, 23 Mar 2021 11:59:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bff2481a-31a1-788b-2c80-dbf876b7a6ae@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 23/03/21 10:54 am, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 22/03/21 9:05 pm, Nishanth Menon wrote:
>> On 18:42-20210322, Aswath Govindraju wrote:
>>> The following speed modes are now supported in J7200 SoC,
>>> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
>>> - UHS-I speed modes in MMCSD1 subsystem [1].
>>>
>>> Add support for UHS-I modes by adding voltage regulator device tree nodes
>>> and corresponding pinmux details, to power cycle and voltage switch cards.
>>> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
>>> device tree nodes.
>>>
>>> Also update the delay values for various speed modes supported, based on
>>> the revised january 2021 J7200 datasheet[2].
>>>
>>> [1] - section 12.3.6.1.1 MMCSD Features, in
>>>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf,
>>>       (SPRUIU1A – JULY 2020 – REVISED JANUARY 2021)
>>>
>>> [2] - https://www.ti.com/lit/ds/symlink/dra821u.pdf,
>>>       (SPRSP57B – APRIL 2020 – REVISED JANUARY 2021)
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  .../dts/ti/k3-j7200-common-proc-board.dts     | 42 +++++++++++++++++++
>>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 14 ++++++-
>>>  2 files changed, 54 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>> index b493f939b09a..de8c06bdc825 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>> @@ -16,6 +16,29 @@
>>>  		stdout-path = "serial2:115200n8";
>>>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
>>>  	};
>>> +
>>> +	vdd_mmc1: fixedregulator-sd {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vdd_mmc1";
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		regulator-boot-on;
>>> +		enable-active-high;
>>> +		gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
>>
>> is that gpio ?
> 
> Yes, that is correct. I'll correct it in the respin
> 
>> I'd encourage to use vin-supply as well.
> 
> Will add this in respin.
> 
>>
>>> +	};
>>> +
>>> +	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
>> 	What does this drive? TLV71033 ?
> 
> Yes, this node models the TLV71033 voltage regulator that switches the
> MMC IO signal voltage level between 3.3V and 1.8V.

Nope. Unlike J721e SOM which uses TLV71033 for switching voltage, J7200
SOM directly uses GPIO input to PMIC to control the output voltage. So
this should model the gpio input to PMIC.

Thanks
Kishon
