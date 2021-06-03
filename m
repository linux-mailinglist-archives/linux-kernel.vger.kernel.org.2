Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAE39A2EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFCOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:20:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43152 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhFCOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:20:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EIGjt008940;
        Thu, 3 Jun 2021 09:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622729896;
        bh=ij5t3iomRX42uD/qcjWKu9Nr7FU30eNoiO6l8qKL690=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bc5QX5n+/jlNmf3rTR0R9/MyrjlQt+IT1QYYZcy2yoKOxII5l8Qz0C3hhohKq/MmA
         c5D2hCSVcXv9hDQ55JKOlrXEfk3ZqPp9cYJjiJFTtaZm32k2GDwDCtOv0yTyPd6W+O
         drYb/IR6bk01qN6i2s++utKuipOHeNA+Oz0cEHCY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EIG3x044695
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:18:16 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:18:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:18:16 -0500
Received: from [10.250.235.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EIBE6072498;
        Thu, 3 Jun 2021 09:18:13 -0500
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-am64-main: Add PCIe DT node
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
 <20210526142921.12127-3-kishon@ti.com>
 <20210526185133.sm2iqqpequz3mmvq@crafty>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ab908779-804f-75c3-d9cc-98a3a558e686@ti.com>
Date:   Thu, 3 Jun 2021 19:48:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210526185133.sm2iqqpequz3mmvq@crafty>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 27/05/21 12:21 am, Nishanth Menon wrote:
> On 19:59-20210526, Kishon Vijay Abraham I wrote:
>> AM64 has one PCIe instance which can be configured in either
>> host mode (RC) or device mode (EP). Add PCIe DT node for host
>> mode and device mode here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 46 ++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index a67f10406a8e..9c77f7da5d28 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -728,4 +728,50 @@
>>  			#clock-cells = <1>;
>>  		};
>>  	};
>> +
>> +	pcie0_rc: pcie@f102000 {
>> +		compatible = "ti,am64-pcie-host", "ti,j721e-pcie-host";
>> +		reg = <0x00 0x0f102000 0x00 0x1000>,
>> +		      <0x00 0x0f100000 0x00 0x400>,
>> +		      <0x00 0x0d000000 0x00 0x00800000>,
>> +		      <0x00 0x68000000 0x00 0x00001000>;
>> +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> [...]
>> +
>> +	pcie0_ep: pcie-ep@f102000 {
> Hmm... 
> Warning (unique_unit_address): /bus@f4000/pcie@f102000: duplicate unit-address (also used in node /bus@f4000/pcie-ep@f102000)
> we could pick reg for pcie-ep for node address, instead of intd_cfg address?
> 
> OR, does that mess something else up?

yeah, that actually require changes in the binding to fix it properly,
since only the first entry in reg should be given for unit address.

Thanks
Kishon

> 
>> +		compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
>> +		reg = <0x00 0x0f102000 0x00 0x1000>,
>> +		      <0x00 0x0f100000 0x00 0x400>,
>> +		      <0x00 0x0d000000 0x00 0x00800000>,
>> +		      <0x00 0x68000000 0x00 0x08000000>;
> 
> [...]
> 
