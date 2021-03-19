Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596F43414AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhCSFW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:22:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51534 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhCSFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:22:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J5MGdQ016648;
        Fri, 19 Mar 2021 00:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616131336;
        bh=eEzDNDxOH/oEPWqo7+S5nkuER46NFqLgSyjszwPdSnE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M1kQtlOlzbeeNbchxa859gH9h4Lr8GZJjIZd0cPFmY8KWAXpFQNtukMyKL8QPyniD
         ugHhrFp6O3KvAvk+e/ZmLvkoaQkYxB+61MZV9GkRMJ2OvnN1b4FMo2lwUFtOgAzo5d
         AtBX/3m7De1wBhZNo5JLm5Lpz3NjKKDgUmpyUoLA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J5MGRE034134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 00:22:16 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 00:22:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 00:22:16 -0500
Received: from [172.24.145.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J5MC40084610;
        Fri, 19 Mar 2021 00:22:13 -0500
Subject: Re: [PATCH v2 0/2] AM64: Add support for GPIO
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210304112924.12470-1-a-govindraju@ti.com>
 <20210309144333.6ko6olztldslj3fo@paralegal>
 <9ba5e86d-7a60-a35b-0fb4-ddc3052eecee@ti.com>
 <20210309155850.auyuxkrv5p3gkxcd@speed>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <1ba9bfd0-a4a7-bd0a-bd0a-df10d5348a30@ti.com>
Date:   Fri, 19 Mar 2021 10:52:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309155850.auyuxkrv5p3gkxcd@speed>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 09/03/21 9:28 pm, Nishanth Menon wrote:
> On 21:20-20210309, Aswath Govindraju wrote:
>> Hi Nishanth,
>>
>> On 09/03/21 8:13 pm, Nishanth Menon wrote:
>>> On 16:59-20210304, Aswath Govindraju wrote:
>>>> The following series of patches adds support for gpio on AM642 evm/sk.
>>>>
>>>> Changes since v1:
>>>> - Added DT for gpio subsystem present in MCU domain
>>>> - reserved the mcu gpio for firmware usage
>>>>
>>>> This series of patches depend on,
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439153
>>>>
>>>>
>>>> Aswath Govindraju (2):
>>>>   arm64: dts: ti: k3-am64: Add GPIO DT nodes
>>>>   arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware
>>>>     usage
>>>>
>>>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
>>>>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 27 ++++++++++++++
>>>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++
>>>>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  5 +++
>>>>  4 files changed, 82 insertions(+)
>>>>
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>>
>>> Based on your offline comment:
>>> -----
>>>
>>> On going through the bootlogs before posting for I found the following
>>> errors,
>>>
>>> [    1.091117] davinci_gpio 601000.gpio: IRQ index 2 not found
>>> [    1.101522] davinci_gpio 601000.gpio: error -ENXIO: IRQ not populated
>>>
>>> Some issues in allocating interrupts in case of main_gpio1. I
>>> accumulated the gpio with interrupt numbers. I'll try to debug the
>>> reason behind it and update you with its status. (bootlogs of ti-sdk,
>>> also have this error).
>>>
>>> -----
>>>
>>> I am going to drop this off my queue, please update if the fixup is some
>>> system configuration error or repost with fix.
>>>
>>
>> This is expected to be a fixup in the system configuration and not a bug
>> in the patch series. So, can you please have these patches in your queue
>> ? I'll soon post the test results indicating the functioning of GPIOs.
> 
> 
> Thanks for clarifying. I will wait till the test results are posted.
> Thanks in advance for digging into this and detailed testing.
> 

I've posted a respin(v3) of this series after rebasing on top of
ti-k3-dts-next branch and adding the GPIO test logs.

Thanks,
Aswath
