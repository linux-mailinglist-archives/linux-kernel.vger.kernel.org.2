Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9639DDA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFGNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:32:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43818 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFGNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:32:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157DUVO4060121;
        Mon, 7 Jun 2021 08:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623072631;
        bh=t3nEGTHF9ctx5Eur/1xc5eX+Fqys3RN2zmfbaHjXrBs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KxlUVAlQAY9+IukGbroZsVMs/dF2astM/FDkfI9O0qnbZBRmYXCxy/PZsh+dX/CBH
         tloGo55n7YP+bJJTjxjFcwVIt8L7C2vpJKm7++SWNm4qX3L4/2lTNCEYpSrNmnsszG
         d8hTozUnaPM/bMX73gWma1VfcuW/auP/Evj4FDig=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157DUVXs112032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:30:31 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:30:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:30:31 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157DUPlo014065;
        Mon, 7 Jun 2021 08:30:27 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Update the location of ATF
 in SRAM and increase its max size
To:     Nishanth Menon <nm@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210604164308.16693-1-a-govindraju@ti.com>
 <20210607132831.byouctbdr62hqbpi@sneeze>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <aeac5b8c-033c-986d-485a-d06b44e14786@ti.com>
Date:   Mon, 7 Jun 2021 19:00:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607132831.byouctbdr62hqbpi@sneeze>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 07/06/21 6:58 pm, Nishanth Menon wrote:
> On 22:13-20210604, Aswath Govindraju wrote:
>> Due to a limitation for USB DFU boot mode, SPL load address has to be less
>> than  or equal to 0x70001000. So, load address of SPL and ATF have been
>> moved to 0x70000000 and 0x701a0000 respectively.
>>
>> Also, the maximum size of ATF has been increased to 0x1c000 [1].
>>
>> Therefore, update ATF's location and maximum size accordingly in the device
>> tree file.
>>
>> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> Link to corresponding U-Boot series that makes the ATF load address update,
>> - https://patchwork.ozlabs.org/project/uboot/list/?series=247265
>>
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index ca59d1f711f8..7ae28992097f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -14,7 +14,7 @@
>>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>>  
>>  		atf-sram@0 {
> 	@0 should be @1a0000 ?

Sorry, forgot to make this change. Will correct this in the respin.

Thanks,
Aswath

>> -			reg = <0x0 0x1a000>;
>> +			reg = <0x1a0000 0x1c000>;
>>  		};
>>  	};
>>  
>> -- 
>> 2.17.1
>>
> 

