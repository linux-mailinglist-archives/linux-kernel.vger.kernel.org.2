Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E739EE16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFHF0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:26:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46768 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHF0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:26:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1585Ohcv071596;
        Tue, 8 Jun 2021 00:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623129883;
        bh=MiomeBKdGuUjQiTfzTbKXHj9oqvow/F9u+TZwL2rqzQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fmA5DM2/FigyKfCnoYtQVeqzSk7KEszIHf1vNTR5Ex7t+U0ZhJd9a7vMKwzERTQrF
         bu9hG6SZO5/Vlk9+OTaZIQ4WEkACOqJyqRueJMx0B/YMP2fB2fqDUv5WHfUJIF/QLT
         NSGAsgl08t7Kdg8QUE9a7xHjEjAzAI0RCVXeybzY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1585OhBg007040
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jun 2021 00:24:43 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 00:24:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 8 Jun 2021 00:24:43 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1585OcEO026973;
        Tue, 8 Jun 2021 00:24:39 -0500
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210608051414.14873-1-a-govindraju@ti.com>
 <20210608051414.14873-2-a-govindraju@ti.com>
 <8d466cbc-eb35-42a8-d4d6-5bcf44cf965e@siemens.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <fb6c6c73-a29b-e190-b4c0-3b8b030d8268@ti.com>
Date:   Tue, 8 Jun 2021 10:54:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d466cbc-eb35-42a8-d4d6-5bcf44cf965e@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 08/06/21 10:50 am, Jan Kiszka wrote:
> On 08.06.21 07:14, Aswath Govindraju wrote:
>> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
>> Therefore, fix the property accordingly.
>>
> 
> Is there a patch for Documentation/devicetree/bindings/spi/omap-spi.txt
> on the way as well that makes this even clearer?
> 

Yes, these fixes are a part of conversion of omap-spi.txt to yaml
format. In the yaml file the type for the property is mentioned.

Link to yaml conversion patch,
https://lore.kernel.org/patchwork/project/lkml/list/?series=503240

>> Fixes: e180f76d0641 ("arm64: dts: ti: Add support for Siemens IOT2050 boards")
>> Fixes: 5da94b50475a ("arm64: dts: ti: k3-am654: Enable main domain McSPI0")
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
>>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> index f4ec9ed52939..23d51b6a9cf2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -575,7 +575,7 @@
>>  
>>  	#address-cells = <1>;
>>  	#size-cells= <0>;
>> -	ti,pindir-d0-out-d1-in = <1>;
>> +	ti,pindir-d0-out-d1-in;
>>  };
>>  
> 
> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
> 

Thanks,
Aswath

> Jan
> 
>>  &tscadc0 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index eddb2ffb93ca..1b947e2c2e74 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -299,7 +299,7 @@
>>  	pinctrl-0 = <&main_spi0_pins_default>;
>>  	#address-cells = <1>;
>>  	#size-cells= <0>;
>> -	ti,pindir-d0-out-d1-in = <1>;
>> +	ti,pindir-d0-out-d1-in;
>>  
>>  	flash@0{
>>  		compatible = "jedec,spi-nor";
>>
> 
> 

