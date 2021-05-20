Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD138AFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhETNTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:19:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54948 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhETNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:19:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KDINWt024415;
        Thu, 20 May 2021 08:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621516704;
        bh=p8siWvPgn0JnO9HX8NwOfzd3HcBfDidAJFOIef3h5PQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DFEUU/F5mgy2/kxC/e8YIJTt1QScZ8hXyXD+hga89s2lcfNYYCr9SXgVSFf02ItSW
         iighND7gOlnnyYOIv+i7i1bVBaU+rN6+/ss8gEkJO3Uu2/lDEYkOTnfhsL45+DPBuL
         6DVkXmEVbDUjeAX9fZGPhTo7A6bryd9bIJy/sGLg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KDIN4u089905
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 08:18:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 08:18:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 08:18:23 -0500
Received: from [10.250.234.58] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KDIKk5051020;
        Thu, 20 May 2021 08:18:21 -0500
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
 <68c95cf1-84fa-2194-7bb1-e3c60e7f1fc0@ti.com>
 <20210513140137.5uvftgtsku3xfobz@engraving>
 <81b7dc76-0918-0a95-5715-cf701e638bbe@ti.com>
 <20210517140519.4ltzvw3k74z72urz@dingo>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3529e35f-0bef-fd8c-515a-6d4552f2467d@ti.com>
Date:   Thu, 20 May 2021 18:48:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210517140519.4ltzvw3k74z72urz@dingo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 17/05/21 7:35 pm, Nishanth Menon wrote:
> On 14:00-20210517, Kishon Vijay Abraham I wrote:
>> Hi Nishanth,
>>
>> On 13/05/21 7:31 pm, Nishanth Menon wrote:
>>> On 17:41-20210513, Kishon Vijay Abraham I wrote:
>>>> Hi Nishanth,
>>>>
>>>> On 13/05/21 12:21 am, Nishanth Menon wrote:
>>>>> On 20:42-20210512, Kishon Vijay Abraham I wrote:
>>>>>> Rename the external refclk inputs to the SERDES from
>>>>>> dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
>>>>>> respectively. Also move the external refclk DT nodes outside the
>>>>>> cbass_main DT node. Since in j721e common processor board, only the
>>>>>> cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.
>>>>>>
>>>>>> Fixes: afd094ebe69f ("arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes")
>>>>>
>>>>> Assume we want this part of 5.13 fixes?
>>>>
>>>> This doesn't fix any functionality. Okay for me to go in 5.14 along with
>>>> the rest of the series.
>>>
>>>
>>>>>
>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>> ---
>>>>>>  .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
>>>>>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
>>>>>>  2 files changed, 34 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>>>>>> index 60764366e22b..86f7ab511ee8 100644
>>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>>>>>> @@ -635,6 +635,10 @@
>>>>>>  	status = "disabled";
>>>>>>  };
>>>>>>  
>>>>>> +&cmn_refclk1 {
>>>>>> +	clock-frequency = <100000000>;
>>>>>> +};
>>>>>> +
>>>>>>  &serdes0 {
>>>>>>  	serdes0_pcie_link: link@0 {
>>>>>>  		reg = <0>;
>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>>>> index c2aa45a3ac79..002a0c1520ee 100644
>>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>>>> @@ -8,6 +8,20 @@
>>>>>>  #include <dt-bindings/mux/mux.h>
>>>>>>  #include <dt-bindings/mux/ti-serdes.h>
>>>>>>  
>>>>>> +/ {
>>>>>> +	cmn_refclk: cmn-refclk {
>>>>>> +		#clock-cells = <0>;
>>>>>> +		compatible = "fixed-clock";
>>>>>> +		clock-frequency = <0>;
>>>>>> +	};
>>>>>> +
>>>>>> +	cmn_refclk1: cmn-refclk1 {
>>>>>
>>>>> Just curious: why cant we use the standard nodenames with clock?
>>>>
>>>> We can use standard names here. Is there any defined nodename for
>>>> clocks? clk or clock? Don't see $nodename defined for clocks in
>>>> dt-schema repository.
>>>
>>> Looking at the fixed-clock example, lets go with clock
>>
>> Since I have two clocks here adding clock@0 and clock@1 introduces the
>> following error.
>> /home/a0393678/repos/linux-wip/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
>> /: clock@0: 'anyOf' conditional failed, one must be fixed:
>>         'reg' is a required property
>>         'ranges' is a required property
>>
>> The current "fixed-clock" binding doesn't allow adding "reg" property.
>> We'll stick to non standard names? or do you think the binding has to be
>> fixed?
> 
> Look at other fixed-clock examples in other arm64 examples
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi#n147
> is a good one.. Binding is fine, IMHO.

Ah Thanks. It only has to be prefixed with clock-.

Thanks
Kishon
