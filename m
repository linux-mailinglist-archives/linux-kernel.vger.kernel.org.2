Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB23F305F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhA0P0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:26:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47492 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbhA0PVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:21:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RFKj67061299;
        Wed, 27 Jan 2021 09:20:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611760845;
        bh=63J470PcJJ9jKO5/EhqKwZZS/3X0l3imNQLx4QdZ30w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H+03+aX4pt3gq/v16Qj6RCAi1P/4CJt5+KDlheRO10ztZe8fVcK+uBmoy3wGaLVtj
         09silYx96SBD5tc43IuBC/ZjV/UbGusmV9EhHH7LmB4YP3SKJNDFotjg8RIiimDKDW
         SemO6yWXm6c7ksZ+4sbY/H+X8EH6qStHGFyQm/tc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RFKjhj026205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:20:45 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:20:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:20:44 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RFKecd089291;
        Wed, 27 Jan 2021 09:20:41 -0600
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes in MMCSD subsystems
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210127150815.16991-1-a-govindraju@ti.com>
 <20210127150815.16991-3-a-govindraju@ti.com>
 <20210127151431.pzqpbtumqzpqiqop@delta>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <6f9ddf85-e1e9-426a-2436-7f323314959a@ti.com>
Date:   Wed, 27 Jan 2021 20:50:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127151431.pzqpbtumqzpqiqop@delta>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 27/01/21 8:44 pm, Nishanth Menon wrote:
> On 20:38-20210127, Aswath Govindraju wrote:
>> The following speed modes are now supported in J7200 SoC,
>> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
>> - UHS-I speed modes in MMCSD1 subsystem [1].
>>
>> Add support for UHS-I modes by adding voltage regulator device tree nodes
>> and corresponding pinmux details, to power cycle and voltage switch cards.
>> Also set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
>> device tree nodes.
>>
>> [1] - section 12.3.6.1.1 MMCSD Features, in
>>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> performance test logs using EXT4 filesystem for eMMC HS400 speed mode,
>> https://pastebin.ubuntu.com/p/KFphDYXj93/
>>
> 
> 5.11.0-rc3-next-20210118-00004 :
> 
> a) could you make sure to post patches when you test with latest next?
> b) I see 2 patches in this series, but delta seems to be 4 patches, is
> there a dependency I am not aware of?
> 

There are no dependencies. The other two commits are completely
unrelated. From next time I will make sure that I use the latest next
and the delta matches.

Thanks,
Aswath
