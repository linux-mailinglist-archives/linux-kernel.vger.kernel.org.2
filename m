Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36CC332B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhCIPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:51:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48196 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhCIPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:51:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129FovTR075264;
        Tue, 9 Mar 2021 09:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615305057;
        bh=f6ZNtjDoKQyQddsQ9O3LGJGZKVZq4b7dQx6K3P+l204=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pKpdBDpKWXkXBBD2GEc0sepgfNBNPOS9DO6GifIFCRKUA8pPBkans0eHDumwlCJhR
         A68x3KkwaPA7Xo2jOE7rV0IBRvcGCFC1ci6Nc/Muty3eq1BIF9PHiKqpp9qMrVA0on
         gVZiDr2Za+RjtUNfO4VftVwcrgM5ciX2kYDOvDOc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129FovbH031419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 09:50:57 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 09:50:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 09:50:56 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129FoqJN005180;
        Tue, 9 Mar 2021 09:50:53 -0600
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
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9ba5e86d-7a60-a35b-0fb4-ddc3052eecee@ti.com>
Date:   Tue, 9 Mar 2021 21:20:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309144333.6ko6olztldslj3fo@paralegal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 09/03/21 8:13 pm, Nishanth Menon wrote:
> On 16:59-20210304, Aswath Govindraju wrote:
>> The following series of patches adds support for gpio on AM642 evm/sk.
>>
>> Changes since v1:
>> - Added DT for gpio subsystem present in MCU domain
>> - reserved the mcu gpio for firmware usage
>>
>> This series of patches depend on,
>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439153
>>
>>
>> Aswath Govindraju (2):
>>   arm64: dts: ti: k3-am64: Add GPIO DT nodes
>>   arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware
>>     usage
>>
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 27 ++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++
>>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  5 +++
>>  4 files changed, 82 insertions(+)
>>
>> -- 
>> 2.17.1
>>
> 
> 
> Based on your offline comment:
> -----
> 
> On going through the bootlogs before posting for I found the following
> errors,
> 
> [    1.091117] davinci_gpio 601000.gpio: IRQ index 2 not found
> [    1.101522] davinci_gpio 601000.gpio: error -ENXIO: IRQ not populated
> 
> Some issues in allocating interrupts in case of main_gpio1. I
> accumulated the gpio with interrupt numbers. I'll try to debug the
> reason behind it and update you with its status. (bootlogs of ti-sdk,
> also have this error).
> 
> -----
> 
> I am going to drop this off my queue, please update if the fixup is some
> system configuration error or repost with fix.
> 

This is expected to be a fixup in the system configuration and not a bug
in the patch series. So, can you please have these patches in your queue
? I'll soon post the test results indicating the functioning of GPIOs.

Thanks,
Aswath
