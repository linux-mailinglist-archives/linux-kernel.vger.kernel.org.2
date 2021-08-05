Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33B43E14C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhHEMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:33:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41052 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhHEMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:33:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 175CWaH7092873;
        Thu, 5 Aug 2021 07:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628166756;
        bh=XUSqxi7FM17TLwc2Nhza1mKB2e3Rf7quG1dYWp2LQ6g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hx+jDxOVr7AEZNV4zwp6slrUOBmUiK6tB3QUUNpttazCoWtODkRQY7ec4p7213T2c
         CND0JDZoA9LsABzOy/FzFXGV1Z1PP0H5WJ6FwulUw6M+U1dggHaKxBU0ih8l0zW4td
         I48Xi0wB9eLHfux9pKz78KAa33QMZoUvrS2eWJ0U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 175CWaSg002800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Aug 2021 07:32:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 5 Aug
 2021 07:32:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 5 Aug 2021 07:32:36 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 175CWVh9004024;
        Thu, 5 Aug 2021 07:32:33 -0500
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
To:     Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
 <20210802124509.z23lfg7xxkqaakbo@truce>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <36011cee-f617-02ed-7446-c297ba65e6bf@ti.com>
Date:   Thu, 5 Aug 2021 18:02:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802124509.z23lfg7xxkqaakbo@truce>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/08/21 6:15 pm, Nishanth Menon wrote:
> On 15:40-20210726, Aswath Govindraju wrote:
>> The following series of patches add support for CAN in SoC's AM65, J721e
>> and AM64.
>>
>> This patch series is dependent on [1] and [2] and I have requested for an
>> immutable tag from the Marc Kleine-Budde(maintainer of net tree).
>>
>> [1] - https://lore.kernel.org/patchwork/patch/1423048/
>> [2] - https://www.spinics.net/lists/linux-can/msg08108.html
>>
>> changes since v1 -
>> - changed the message ram configuration to use the maximum value
>>   in each field, for better performance.
>>
>> Aswath Govindraju (3):
>>   arm64: dts: ti: am654-base-board: Disable mcan nodes
>>   arm64: dts: ti: k3-am64-main: Add support for MCAN
>>   arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
>>     nodes in EVM and disable them on SK
>>
>> Faiz Abbas (3):
>>   arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
>>   arm64: dts: ti: k3-j721e: Add support for MCAN nodes
>>   arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
>>     nodes
> 
> I noticed in my checkup: https://pastebin.ubuntu.com/p/zSk39M943N/
> warnings with dtbs_check, I think the bindings need a little more help
> here (please also notice the iot platform warnings getting introduced).
> 

Jan,

Can you please point me to the schematics for iot platform? Also, is CAN
subsystem brought out on the iot platform boards?

> Since we are still working on the bindings[1], lets clean that up
> before we consider the dts addition. I suspect we need to cook this
> more towards the next cycle.
> 
> [1] https://lore.kernel.org/patchwork/patch/1470806/
> 

Nishanth,

Sorry for not taking of this earlier. I'll try to get everything ready
for next release.

Thanks,
Aswath

