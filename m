Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73332E1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEFd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:33:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEFd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:33:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1255XpYt004969;
        Thu, 4 Mar 2021 23:33:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614922431;
        bh=siHMwNox/zbXyEPsyAE+BFuaVspi6bVUQpkrRS/na7Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ytCKBciLCqS6iBn+dWAdz7C4zYOxz/ezqJtpbkiBu7xb+s8506r0mR1icpjR+WzMm
         jUWg3QHYg2rfQMUF55t35jPGH8Y6yfsZ5acAUUHHoPMBAWm2r1P50G1l1e4nWh7gZq
         dP56/4ckmjU9cQk7I74Zudt8dyGmsu1yyhECS9l8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1255XptA051357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 23:33:51 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 23:33:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 23:33:51 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1255XgNh090731;
        Thu, 4 Mar 2021 23:33:44 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update the speed modes
 supported and their itap delay values for MMCSD subsystems
To:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210225132736.26429-1-a-govindraju@ti.com>
 <969c38e2-01e8-55a1-b97e-cf72f07fcd62@ti.com>
 <20210305051403.y4lzv5woisimzlgb@persuader>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <5742f7bb-4c5b-2fe0-7cff-04cfcde2caa1@ti.com>
Date:   Fri, 5 Mar 2021 11:03:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305051403.y4lzv5woisimzlgb@persuader>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 05/03/21 10:44 am, Nishanth Menon wrote:
> On 10:59-20210301, Kishon Vijay Abraham I wrote:
>> On 25/02/21 6:57 pm, Aswath Govindraju wrote:
>>> According to latest errata of J721e [1], HS400 mode is not supported
>>> in MMCSD0 subsystem (i2024) and SDR104 mode is not supported in MMCSD1/2
>>> subsystems (i2090). Therefore, replace mmc-hs400-1_8v with mmc-hs200-1_8v
>>> in MMCSD0 subsystem and add a sdhci mask to disable SDR104 speed mode.
>>>
>>> Also, update the itap delay values for all the MMCSD subsystems according
>>> the latest J721e data sheet[2]
>>>
>>> [1] - https://www.ti.com/lit/er/sprz455/sprz455.pdf
>>> [2] - https://www.ti.com/lit/ds/symlink/tda4vm.pdf
>>>
>>> Fixes: e6dc10f200da ("arm64: dts: ti: j721e-main: Add SDHCI nodes")
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> 
> In some offline testing, I realized that the patch wont apply cleanly to e6dc10f200da
> 
> cd48ce86a4d0c1ffec86aa46a26da993c9af5f53 might be a better candidate for
> this - I will drop the patch from my queue in the morning, could you
> update the patch with a new rev with appropriate Fixes?
> 

Sorry, I'll send a respin(v2) of this patch after correcting the fixes
tag to,
Fixes: cd48ce86a4d0 ("arm64: dts: ti: k3-j721e-common-proc-board: Add
support for SD card UHS modes")

Thanks,
Aswath
