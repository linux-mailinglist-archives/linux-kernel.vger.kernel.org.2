Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EAD3E14EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhHEMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:40:40 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:37820 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240369AbhHEMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:40:39 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 175CeAd8001024
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 14:40:10 +0200
Received: from [167.87.0.185] ([167.87.0.185])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 175Ce702021254;
        Thu, 5 Aug 2021 14:40:08 +0200
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
To:     Aswath Govindraju <a-govindraju@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
 <20210802124509.z23lfg7xxkqaakbo@truce>
 <36011cee-f617-02ed-7446-c297ba65e6bf@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <35b0e2dc-0591-0a2f-8e3d-4177792a13fa@siemens.com>
Date:   Thu, 5 Aug 2021 14:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <36011cee-f617-02ed-7446-c297ba65e6bf@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 14:32, Aswath Govindraju wrote:
> Hi,
> 
> On 02/08/21 6:15 pm, Nishanth Menon wrote:
>> On 15:40-20210726, Aswath Govindraju wrote:
>>> The following series of patches add support for CAN in SoC's AM65, J721e
>>> and AM64.
>>>
>>> This patch series is dependent on [1] and [2] and I have requested for an
>>> immutable tag from the Marc Kleine-Budde(maintainer of net tree).
>>>
>>> [1] - https://lore.kernel.org/patchwork/patch/1423048/
>>> [2] - https://www.spinics.net/lists/linux-can/msg08108.html
>>>
>>> changes since v1 -
>>> - changed the message ram configuration to use the maximum value
>>>   in each field, for better performance.
>>>
>>> Aswath Govindraju (3):
>>>   arm64: dts: ti: am654-base-board: Disable mcan nodes
>>>   arm64: dts: ti: k3-am64-main: Add support for MCAN
>>>   arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
>>>     nodes in EVM and disable them on SK
>>>
>>> Faiz Abbas (3):
>>>   arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
>>>   arm64: dts: ti: k3-j721e: Add support for MCAN nodes
>>>   arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
>>>     nodes
>>
>> I noticed in my checkup: https://pastebin.ubuntu.com/p/zSk39M943N/
>> warnings with dtbs_check, I think the bindings need a little more help
>> here (please also notice the iot platform warnings getting introduced).
>>
> 
> Jan,
> 
> Can you please point me to the schematics for iot platform? Also, is CAN
> subsystem brought out on the iot platform boards?

Schematics aren't publicly available. If you have specific questions, I
may help, though.

CAN is not in use yet (not connected AFAIK).

Jan

> 
>> Since we are still working on the bindings[1], lets clean that up
>> before we consider the dts addition. I suspect we need to cook this
>> more towards the next cycle.
>>
>> [1] https://lore.kernel.org/patchwork/patch/1470806/
>>
> 
> Nishanth,
> 
> Sorry for not taking of this earlier. I'll try to get everything ready
> for next release.
> 
> Thanks,
> Aswath
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
