Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D103A3A953B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhFPIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:45:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59910 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:45:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15G8hWb4000690;
        Wed, 16 Jun 2021 03:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623833012;
        bh=drAzmKnTkRfUXqRP7+mn9JKkLyutK7LL/KIHYfgEfU0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WgLViXSSi3H0L1JBXJoectch7MRTSzxVkBlKAxejAsIehDSqxRGgxGKBasGEZ9Ctz
         n3pDgmHso1zYhnITCXaVm3PnrWf6XfcZ1tuiVQOkIXD64JbWP8EngRtEEYCPnnvXHF
         PS0S7m0LPdRKVxwNl/3xk6rge2iKnydFkQw54voU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15G8hWdm130374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 03:43:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 03:43:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 03:43:32 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15G8hOLJ058581;
        Wed, 16 Jun 2021 03:43:25 -0500
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am64-main: Update the location
 of TF-A
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615174325.22853-1-a-govindraju@ti.com>
 <20210615174325.22853-4-a-govindraju@ti.com>
 <20210616002005.c5vxes67pltuxiry@liking>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <bf7074a4-534b-25f9-b70e-4985ca070a6f@ti.com>
Date:   Wed, 16 Jun 2021 14:13:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616002005.c5vxes67pltuxiry@liking>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 16/06/21 5:50 am, Nishanth Menon wrote:
> On 23:13-20210615, Aswath Govindraju wrote:
>> Due to a limitation for USB DFU boot mode, SPL load address has to be less
>> than  or equal to 0x70001000. So, load address of SPL and TF-A have been
>> moved to 0x70000000 and 0x701c4000 respectively.
>>
>> Therefore, update TF-A's location in the device tree node.
> 
> One additional topic to add is the dependency on bootloader update for
> this as well. I know things are chicken or egg kind of problem, but
> will be good to mention requires newer version than 2021.xx version of
> u-boot as this is an "breaking" change. And, if we block both regions
> off for bootloader compatibility, that is not feasible given the
> limited SRAM available as well.
> 

Will include this in the repsin by indicating the version in which the
ATF has been moved.

Thanks,
Aswath

>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index 6a883f4349cb..7ab3652dfdfb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -24,8 +24,8 @@
>>  		#size-cells = <1>;
>>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>>  
>> -		tfa-sram@0 {
>> -			reg = <0x0 0x1c000>;
>> +		tfa-sram@1c4000 {
>> +			reg = <0x1c4000 0x1c000>;
>>  		};
>>  
>>  		dmsc-sram@1e0000 {
>> -- 
>> 2.17.1
>>
> 

