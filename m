Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4691133368D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCJHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:44:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCJHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:44:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12A7iR8t016821;
        Wed, 10 Mar 2021 01:44:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615362267;
        bh=TfQQgTKeBCY4xuMtmfDUQm+/YrcItfzYj5J9OoTYvQY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ik4N/5Oumj4RnQagRniaq7Oc3tsK7T43gBQfl6u8RRV/2ZTWb8X+mN0H+C96qVR+z
         EPXgCO/JNPqAV0FLyEVc3qdRTEPgpdB2CnI15f7C7r6zyC9kCoyDQwZwH73BT9RLTW
         u9lcBpA1mqZbVAROboGSIhF8kmFABLw1n22D/OkY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12A7iRlf025991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 01:44:27 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 01:44:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 01:44:27 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12A7iNjp074705;
        Wed, 10 Mar 2021 01:44:24 -0600
Subject: Re: [PATCH 0/2] AM64: Add USB support
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20210301055109.17626-1-a-govindraju@ti.com>
 <20210301152227.f6phla2m3rz457pj@passerby>
 <85b1b60f-455c-51b8-9e28-019226413885@ti.com>
 <e8d53390-7a70-fda1-2b6c-ab252947e41b@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <44a86048-3356-0e8b-513e-1efb36f2987b@ti.com>
Date:   Wed, 10 Mar 2021 13:14:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8d53390-7a70-fda1-2b6c-ab252947e41b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 10/03/21 12:33 pm, Kishon Vijay Abraham I wrote:
> +Vinod
> 
> Hi Aswath,
> 
> On 10/03/21 12:27 pm, Aswath Govindraju wrote:
>> Hi Nishanth,
>>
>> On 01/03/21 8:52 pm, Nishanth Menon wrote:
>>> On 11:21-20210301, Aswath Govindraju wrote:
>>>> The following series of patches, add USB support for AM64.
>>>>
>>>> This series of patches depends on,
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
>>>>
>>>> Aswath Govindraju (2):
>>>>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>>>>   arm64: dts: ti: k3-am642-evm: Add USB support
>>>>
>>>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>>>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>>>>  2 files changed, 48 insertions(+)
>>>
>>> Please update the series to include SK as well.
>>>
>>
>> I was planning on posting patches that add support for USB in SK later
>> because of phy dependencies.
> 
> The dependency is only on [1] right? I've got all the required ACKs so
> it should be okay to include it in this series. (That patch will be
> required only when PCIe DT is merged for me.)
> 
> Nishant, would you be okay to merge [1] along with other patches from
> Aswath? There is no dependency as such on my other PHY patches, so don't
> think there is a need for a stable tag here.
> 
> 
> [1] ->
> https://lore.kernel.org/linux-devicetree/20210222112314.10772-4-kishon@ti.com/
>>

There is also a dependency on,

https://lore.kernel.org/linux-devicetree/20210222112314.10772-2-kishon@ti.com/

Thanks,
Aswath
