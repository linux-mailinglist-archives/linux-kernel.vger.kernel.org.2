Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8755C3A4D56
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFLHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:23:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhFLHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:23:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15C7LlC1067900;
        Sat, 12 Jun 2021 02:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623482507;
        bh=YzSaoRQU35DpLlcWUVC889LLvvrRwlO1hWjuvl74KpI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e8BAXI0fJ7Jm+izmuW8MDcjtWCvDZaLnUwNuv8bInZPv7/D6MFNh6KobPkF2otcEA
         89z8Tg3tLTBBTD6MtQvkVGIE8T0HkpvSK3exJ9LMp8N0Glrz54w+yzpl7rWF6TtRfe
         pdtyCxN4+jJOF4Bq6knLJRIKP40A6Q1O/wV9uoZ8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15C7LlRN035598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Jun 2021 02:21:47 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 12
 Jun 2021 02:21:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sat, 12 Jun 2021 02:21:46 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15C7LhVb089548;
        Sat, 12 Jun 2021 02:21:44 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Aswath Govindraju <a-govindraju@ti.com>
References: <20210609140604.9490-1-vigneshr@ti.com>
 <20210611191640.lczsliyzasjie6lm@dismantle>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <84e5865f-e107-f0e1-ca8b-b6bd655e92e6@ti.com>
Date:   Sat, 12 Jun 2021 12:51:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611191640.lczsliyzasjie6lm@dismantle>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Aswath

On 6/12/21 12:46 AM, Nishanth Menon wrote:
> On 19:36-20210609, Vignesh Raghavendra wrote:
>> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
>> add an entry in DT so that its not used for generic pool memory
>> allocation.
> 
> Are you really sure?? I know that I had set a budget for 16K in sysfw
> when I did the memory split up for sysfw of which 16k is actually used.
> 
> Not sure where this 256K bucket started off from.. am I missing
> something here?
> 

Per: http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/firewalls.html

24	dmsc	0x44060000	0x4407BFFF	dmsc,rwcd	 	 // alias for 0x701E0000
24	dmsc	0x701FC000	0x701FFFFF	sproxy_private,rwcd	 	 
24	dmsc	0x4407C000	0x4407FFFF	sproxy_private,rwcd	 	 
24	dmsc	0x701C0000	0x701DFFFF	everyone,rwcd	 	 

So it looks like only 128K@0x701E0000 is firewalled off. 
Will update the patch.

This makes me wonder why ATF is being moved to 0x701a0000-0x701c0000
leaving a hole at 0x701C0000-0x701DFFFF? 


> 
>>
>> Without this certain drivers using SRAM as generic shared memory pool
>> may end up being allocated memory from this range and will lead to boot
>> time crash when the reserved range is accessed (due to firewall
>> violation).
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index f1c42ef05e52..77b88e536534 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -16,6 +16,10 @@ oc_sram: sram@70000000 {
>>  		atf-sram@0 {
>>  			reg = <0x0 0x1a000>;
>>  		};
>> +
>> +		dmsc-sram@1c0000 {
>> +			reg = <0x1c0000 0x40000>;
> 
>> +		};
>>  	};
>>  
>>  	gic500: interrupt-controller@1800000 {
>> -- 
>> 2.31.1
>>
> 
