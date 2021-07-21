Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0875F3D0A03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhGUHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:08:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53444 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhGUHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:07:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16L7mCG4028769;
        Wed, 21 Jul 2021 02:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626853692;
        bh=1aDk7xG5CK8T+x1BMKRaPnWdFNGsbaKWba8dDmulQ2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UPR+SjXX1SvxKsAbkTQexGk8PAcZBW2mr9TzC4HDdYLH32yNzr2aDQdnpnAPY0djd
         rD24pe+V/p9DPJEBIMxKeu0XhNB6TuQ0L8o/Ajq/w5ymjl6MBxTBMRckV738IfIurG
         g8f0H0XRJ0xnV4vMDthVJNWzz3ftKpwV5iHl631U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16L7mCan029728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 02:48:12 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 02:48:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 02:48:11 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16L7m7ed011393;
        Wed, 21 Jul 2021 02:48:08 -0500
Subject: Re: [PATCH 3/6] arm64: dts: ti: k3-j721e: Add support for MCAN nodes
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-4-a-govindraju@ti.com>
 <20210720145451.6eby7pbfocyyfi4e@pengutronix.de>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <41ff222b-e751-1586-b774-4e55bfe5e017@ti.com>
Date:   Wed, 21 Jul 2021 13:18:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210720145451.6eby7pbfocyyfi4e@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 20/07/21 8:24 pm, Marc Kleine-Budde wrote:
> On 20.07.2021 19:46:39, Aswath Govindraju wrote:
>> From: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Add support for 14 MCAN controllers in main domain and 2 MCAN controllers
>> present in mcu domain. All the MCAN controllers support classic CAN
>> messages as well as CAN_FD messages.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
>>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
>>  2 files changed, 224 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index cf3482376c1e..4215b8e6785a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -1940,4 +1940,200 @@
>>  			bus_freq = <1000000>;
>>  		};
>>  	};
>> +
>> +	main_mcan0: can@2701000 {
>> +		compatible = "bosch,m_can";
>> +		reg = <0x00 0x02701000 0x00 0x200>,
>> +		      <0x00 0x02708000 0x00 0x8000>;
>> +		reg-names = "m_can", "message_ram";
>> +		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 156 1>, <&k3_clks 156 0>;
>> +		clock-names = "cclk", "hclk";
>> +		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "int0", "int1";
>> +		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
> 
> Are you intentionally only enabling 1 TX buffer?
> 

I have used this configuration for testing. It can be increased to 32 if
required. Is it better to set it to the maximum number of buffers ?

Thanks,
Aswath

> Marc
> 

