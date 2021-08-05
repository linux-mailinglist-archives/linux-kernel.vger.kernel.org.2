Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960C93E14F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbhHEMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:44:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44856 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbhHEMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:44:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 175CiB74098873;
        Thu, 5 Aug 2021 07:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628167451;
        bh=7pjBF/UArmuCRMUwAIcRjaLxP+RgNbRDP9R6RHrwlyQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zQ6RBpyWvg9wdh690ULdv+F5GXCrDLt0ph7lklqCwRssh9EPG+pBMaqtP8lvF7zwt
         z1WYUfk7TjKPzxRAl2EgV+5/H3fX9jMRA/i8D1+rm8IyNZfL6j8O4XYP6pc5GADcwH
         NTvSPXu6rcwqaO8EIAm3TT+6JBN83MjEqBXNR3rM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 175CiB8U045683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Aug 2021 07:44:11 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 5 Aug
 2021 07:44:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 5 Aug 2021 07:44:11 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 175Ci7Rc026017;
        Thu, 5 Aug 2021 07:44:08 -0500
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
 <20210802124509.z23lfg7xxkqaakbo@truce>
 <36011cee-f617-02ed-7446-c297ba65e6bf@ti.com>
 <35b0e2dc-0591-0a2f-8e3d-4177792a13fa@siemens.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <cfd7df02-37ed-6286-0232-2e92bf1f67b4@ti.com>
Date:   Thu, 5 Aug 2021 18:14:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <35b0e2dc-0591-0a2f-8e3d-4177792a13fa@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 05/08/21 6:10 pm, Jan Kiszka wrote:
> On 05.08.21 14:32, Aswath Govindraju wrote:
>> Hi,
>>
>> On 02/08/21 6:15 pm, Nishanth Menon wrote:
>>> On 15:40-20210726, Aswath Govindraju wrote:
>>>> The following series of patches add support for CAN in SoC's AM65, J721e
>>>> and AM64.
>>>>
>>>> This patch series is dependent on [1] and [2] and I have requested for an
>>>> immutable tag from the Marc Kleine-Budde(maintainer of net tree).
>>>>
>>>> [1] - https://lore.kernel.org/patchwork/patch/1423048/
>>>> [2] - https://www.spinics.net/lists/linux-can/msg08108.html
>>>>
>>>> changes since v1 -
>>>> - changed the message ram configuration to use the maximum value
>>>>   in each field, for better performance.
>>>>
>>>> Aswath Govindraju (3):
>>>>   arm64: dts: ti: am654-base-board: Disable mcan nodes
>>>>   arm64: dts: ti: k3-am64-main: Add support for MCAN
>>>>   arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
>>>>     nodes in EVM and disable them on SK
>>>>
>>>> Faiz Abbas (3):
>>>>   arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
>>>>   arm64: dts: ti: k3-j721e: Add support for MCAN nodes
>>>>   arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
>>>>     nodes
>>>
>>> I noticed in my checkup: https://pastebin.ubuntu.com/p/zSk39M943N/
>>> warnings with dtbs_check, I think the bindings need a little more help
>>> here (please also notice the iot platform warnings getting introduced).
>>>
>>
>> Jan,
>>
>> Can you please point me to the schematics for iot platform? Also, is CAN
>> subsystem brought out on the iot platform boards?
> 
> Schematics aren't publicly available. If you have specific questions, I
> may help, though.
> 
> CAN is not in use yet (not connected AFAIK).
> 

Thank you for clarifying this. I will disable the CAN DT nodes in
k3-am65-iot2050-common.dtsi in my respin.

Thanks,
Aswath

> Jan
> 
>>
>>> Since we are still working on the bindings[1], lets clean that up
>>> before we consider the dts addition. I suspect we need to cook this
>>> more towards the next cycle.
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/1470806/
>>>
>>
>> Nishanth,
>>
>> Sorry for not taking of this earlier. I'll try to get everything ready
>> for next release.
>>
>> Thanks,
>> Aswath
>>
> 

