Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADF3A5C48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 06:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhFNEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 00:51:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhFNEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 00:51:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15E4n3FD096428;
        Sun, 13 Jun 2021 23:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623646143;
        bh=l0Dp6sAEeHHHEtSDphW6ZwsASXVOpwcEUsPl5t6puTQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wEiNU64ib9qKHZBUseePp1U0Xnvif42LDtvbCFPrFpge5A1oRd8OQvUAj79G4oyvx
         LkZ4KuYlISfqYXktxbpXMIp5H2AsWDh6rB31MV3pRHtRZQ568IrX7IyPJlCEH4w0DN
         GnUVAA+HFHlS16cAdqOIPldZYLXwDPQZH1uZDP4A=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15E4n3FF046083
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Jun 2021 23:49:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 23:49:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sun, 13 Jun 2021 23:49:03 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15E4mxZk053498;
        Sun, 13 Jun 2021 23:49:00 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20210609140604.9490-1-vigneshr@ti.com>
 <20210611191640.lczsliyzasjie6lm@dismantle>
 <84e5865f-e107-f0e1-ca8b-b6bd655e92e6@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <36ff3c65-2f5e-2997-9fb5-a5e8d3230a75@ti.com>
Date:   Mon, 14 Jun 2021 10:18:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <84e5865f-e107-f0e1-ca8b-b6bd655e92e6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 12/06/21 12:51 pm, Vignesh Raghavendra wrote:
> +Aswath
> 
> On 6/12/21 12:46 AM, Nishanth Menon wrote:
>> On 19:36-20210609, Vignesh Raghavendra wrote:
>>> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
>>> add an entry in DT so that its not used for generic pool memory
>>> allocation.
>>
>> Are you really sure?? I know that I had set a budget for 16K in sysfw
>> when I did the memory split up for sysfw of which 16k is actually used.
>>
>> Not sure where this 256K bucket started off from.. am I missing
>> something here?
>>
> 
> Per: http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/firewalls.html
> 
> 24	dmsc	0x44060000	0x4407BFFF	dmsc,rwcd	 	 // alias for 0x701E0000
> 24	dmsc	0x701FC000	0x701FFFFF	sproxy_private,rwcd	 	 
> 24	dmsc	0x4407C000	0x4407FFFF	sproxy_private,rwcd	 	 
> 24	dmsc	0x701C0000	0x701DFFFF	everyone,rwcd	 	 
> 
> So it looks like only 128K@0x701E0000 is firewalled off. 
> Will update the patch.
> 
> This makes me wonder why ATF is being moved to 0x701a0000-0x701c0000
> leaving a hole at 0x701C0000-0x701DFFFF? 
> 
> 

The reason for leaving the hole at 0x701C0000-0x701DFFFF was because
initially there was a bug in SYSFW which lead to the usage of the above
region too by it. However, this bug was recently fixed and the the above
region can be used for ATF.

Thanks,
Aswath

>>
>>>
>>> Without this certain drivers using SRAM as generic shared memory pool
>>> may end up being allocated memory from this range and will lead to boot
>>> time crash when the reserved range is accessed (due to firewall
>>> violation).
>>>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>> index f1c42ef05e52..77b88e536534 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>> @@ -16,6 +16,10 @@ oc_sram: sram@70000000 {
>>>  		atf-sram@0 {
>>>  			reg = <0x0 0x1a000>;
>>>  		};
>>> +
>>> +		dmsc-sram@1c0000 {
>>> +			reg = <0x1c0000 0x40000>;
>>
>>> +		};
>>>  	};
>>>  
>>>  	gic500: interrupt-controller@1800000 {
>>> -- 
>>> 2.31.1
>>>
>>

