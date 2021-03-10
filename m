Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764A333361B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhCJHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:04:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34446 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCJHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:04:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12A73lms050086;
        Wed, 10 Mar 2021 01:03:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615359827;
        bh=7ERRQXqMUOVBW/HB76it/z+tAHme5PnGyXsOO0Vj83Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ac+UMbIZIaHugw24GxqovY0vxFYKsH9ne+DZhfoTriO5A1TL5WrY2ildsdOWr9KCE
         zd8uNFy7zV/PjIBGspkO906rZLCvBF/1TtPu/GyVhL7Io1QqNz6AM+Ej2ycfwj4AwA
         TW3kksXyKean/upVApNRqOYgR3KfsEn2ME1qY7kw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12A73lKM077056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 01:03:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 01:03:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 01:03:46 -0600
Received: from [10.250.234.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12A73gDH012060;
        Wed, 10 Mar 2021 01:03:43 -0600
Subject: Re: [PATCH 0/2] AM64: Add USB support
To:     Aswath Govindraju <a-govindraju@ti.com>, Nishanth Menon <nm@ti.com>
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e8d53390-7a70-fda1-2b6c-ab252947e41b@ti.com>
Date:   Wed, 10 Mar 2021 12:33:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85b1b60f-455c-51b8-9e28-019226413885@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Vinod

Hi Aswath,

On 10/03/21 12:27 pm, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 01/03/21 8:52 pm, Nishanth Menon wrote:
>> On 11:21-20210301, Aswath Govindraju wrote:
>>> The following series of patches, add USB support for AM64.
>>>
>>> This series of patches depends on,
>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
>>>
>>> Aswath Govindraju (2):
>>>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>>>   arm64: dts: ti: k3-am642-evm: Add USB support
>>>
>>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>>>  2 files changed, 48 insertions(+)
>>
>> Please update the series to include SK as well.
>>
> 
> I was planning on posting patches that add support for USB in SK later
> because of phy dependencies.

The dependency is only on [1] right? I've got all the required ACKs so
it should be okay to include it in this series. (That patch will be
required only when PCIe DT is merged for me.)

Nishant, would you be okay to merge [1] along with other patches from
Aswath? There is no dependency as such on my other PHY patches, so don't
think there is a need for a stable tag here.

Thanks
Kishon

[1] ->
https://lore.kernel.org/linux-devicetree/20210222112314.10772-4-kishon@ti.com/
> 
> Thanks,
> Aswath
> 
