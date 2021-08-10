Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77953E509A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhHJB2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:28:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13407 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhHJB2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:28:30 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkFbx2JylzcmLm;
        Tue, 10 Aug 2021 09:24:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 09:28:07 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 09:28:06 +0800
Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com>
 <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <03d7c7be-2f19-9fdf-2a4e-f49a62bb82f6@huawei.com>
Date:   Tue, 10 Aug 2021 09:28:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/10 6:52, Leo Li wrote:
> 
> 
>> -----Original Message-----
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>> Sent: Tuesday, June 15, 2021 8:16 AM
>> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Mark Kettenis <mark.kettenis@xs4all.nl>;
>> devicetree <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
>> kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
>> Cc: Zhen Lei <thunder.leizhen@huawei.com>
>> Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
>> LX2160A UART
>>
>> Mark Kettenis told us that:
>> According to the NXP documentation, the LX2160A has a real PL011 UART.
>>
>> Therefore, rewrite it to the compatible string of pl011. The property "current-
>> speed" specific to "arm,sbsa-uart" is also deleted.
> 
> Sorry that I missed the discussion on the v1.  But looks like this change breaks the LX2160 boot.  The AMBA matching doesn't seem to work.  And the console is not registered correctly.

https://lore.kernel.org/linux-arm-kernel/cba3a29f-92b5-072a-9a27-60240f072dad@huawei.com/

Maybe we should fall back to v1.

> 
> [    0.639055] OF: amba_device_add() failed (-2) for /soc/serial@21c0000
> [    0.645612] OF: amba_device_add() failed (-2) for /soc/serial@21d0000
> 
>>
>> Suggested-by: Shawn Guo <shawnguo@kernel.org>
>> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>> index c4b1a59ba424..d2e6f7285674 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>> @@ -920,34 +920,30 @@ QORIQ_CLK_PLL_DIV(8)>,
>>  		};
>>
>>  		uart0: serial@21c0000 {
>> -			compatible = "arm,sbsa-uart","arm,pl011";
>> +			compatible = "arm,pl011", "arm,primecell";
>>  			reg = <0x0 0x21c0000 0x0 0x1000>;
>>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> -			current-speed = <115200>;
>>  			status = "disabled";
>>  		};
>>
>>  		uart1: serial@21d0000 {
>> -			compatible = "arm,sbsa-uart","arm,pl011";
>> +			compatible = "arm,pl011", "arm,primecell";
>>  			reg = <0x0 0x21d0000 0x0 0x1000>;
>>  			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> -			current-speed = <115200>;
>>  			status = "disabled";
>>  		};
>>
>>  		uart2: serial@21e0000 {
>> -			compatible = "arm,sbsa-uart","arm,pl011";
>> +			compatible = "arm,pl011", "arm,primecell";
>>  			reg = <0x0 0x21e0000 0x0 0x1000>;
>>  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> -			current-speed = <115200>;
>>  			status = "disabled";
>>  		};
>>
>>  		uart3: serial@21f0000 {
>> -			compatible = "arm,sbsa-uart","arm,pl011";
>> +			compatible = "arm,pl011", "arm,primecell";
>>  			reg = <0x0 0x21f0000 0x0 0x1000>;
>>  			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>> -			current-speed = <115200>;
>>  			status = "disabled";
>>  		};
>>
>> --
>> 2.25.1
>>
> 
> .
> 
