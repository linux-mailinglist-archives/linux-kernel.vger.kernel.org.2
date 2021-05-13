Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8C37F798
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEMMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:13:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhEMMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:12:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14DCBCAH100536;
        Thu, 13 May 2021 07:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620907872;
        bh=cW2zgIg/Oktxd6n2CPYG9djpPhCbNXtDbLcmRLCEqXQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Lz8l6AGds50KzkIvmxzmdSpINU+7FeT6JygcGY65uAv5PtXahsdlfbztCePk4t9Hv
         48lBp9tNI1kusxJ9iqJi8a52XhDdO/nklKyucxNmj1nWIF9xL/IT/tuT4Iz07DanQy
         MuZyZByZWvb78iKj8vUMvFardOqHQje0zszWJwvk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14DCBCfu046925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 07:11:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 07:11:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 07:11:12 -0500
Received: from [10.250.232.183] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14DCB93h116594;
        Thu, 13 May 2021 07:11:10 -0500
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-main: Fix external refclk
 input to SERDES
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210512151209.27560-1-kishon@ti.com>
 <20210512151209.27560-2-kishon@ti.com>
 <20210512185157.q5sr2xqf3w5igfte@imagines>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <68c95cf1-84fa-2194-7bb1-e3c60e7f1fc0@ti.com>
Date:   Thu, 13 May 2021 17:41:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512185157.q5sr2xqf3w5igfte@imagines>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 13/05/21 12:21 am, Nishanth Menon wrote:
> On 20:42-20210512, Kishon Vijay Abraham I wrote:
>> Rename the external refclk inputs to the SERDES from
>> dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
>> respectively. Also move the external refclk DT nodes outside the
>> cbass_main DT node. Since in j721e common processor board, only the
>> cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.
>>
>> Fixes: afd094ebe69f ("arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes")
> 
> Assume we want this part of 5.13 fixes?

This doesn't fix any functionality. Okay for me to go in 5.14 along with
the rest of the series.
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
>>  2 files changed, 34 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> index 60764366e22b..86f7ab511ee8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> @@ -635,6 +635,10 @@
>>  	status = "disabled";
>>  };
>>  
>> +&cmn_refclk1 {
>> +	clock-frequency = <100000000>;
>> +};
>> +
>>  &serdes0 {
>>  	serdes0_pcie_link: link@0 {
>>  		reg = <0>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index c2aa45a3ac79..002a0c1520ee 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -8,6 +8,20 @@
>>  #include <dt-bindings/mux/mux.h>
>>  #include <dt-bindings/mux/ti-serdes.h>
>>  
>> +/ {
>> +	cmn_refclk: cmn-refclk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <0>;
>> +	};
>> +
>> +	cmn_refclk1: cmn-refclk1 {
> 
> Just curious: why cant we use the standard nodenames with clock?

We can use standard names here. Is there any defined nodename for
clocks? clk or clock? Don't see $nodename defined for clocks in
dt-schema repository.

Thanks
Kishon
