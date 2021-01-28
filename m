Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4B307AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhA1QXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:23:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48954 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhA1QXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:23:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SGLQPf096821;
        Thu, 28 Jan 2021 10:21:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611850886;
        bh=WNPd19A6ZtEmXx99rm146phP+kamA89IVTD2nlMa+3o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a6F0mkCyCRv177V5XkYGbbl4T94yEqk903KIxBy0cQX4TVpLdgIeL/cvX96SD+0xb
         yCXSiucblmvM742ScDIaaKH3Z3CfKGjq1QFcmrt5C5lJT3ee+yKLhRNLd4TXTLxIC1
         invW25XhtJRPgKvrkdbqK8HLapXlB4E486Yz94yA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SGLQRE028573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 10:21:26 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 10:21:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 10:21:26 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SGLL8S064659;
        Thu, 28 Jan 2021 10:21:22 -0600
Subject: Re: [PATCH v3 1/2] dts: ti: k3-j7200-main: Add support for zeroth
 instance of GPIO subsystem
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
 <20210127150815.16991-2-a-govindraju@ti.com>
 <20210127151256.tgbhpngy6fi43edj@create>
 <9308ad5d-48bd-ebd2-2ea3-9775b8c11163@ti.com>
 <20210127155441.e2oho7m4aeovkafw@absinthe>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9959fc6b-1f3f-53b4-91fd-a8dc46a871b6@ti.com>
Date:   Thu, 28 Jan 2021 21:51:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127155441.e2oho7m4aeovkafw@absinthe>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 27/01/21 9:24 pm, Nishanth Menon wrote:
> On 20:56-20210127, Aswath Govindraju wrote:
>> Hi Nishanth,
>>
>> On 27/01/21 8:42 pm, Nishanth Menon wrote:
>>> On 20:38-20210127, Aswath Govindraju wrote:
>>>> Add support for the zeroth instance of GPIO subsystem in the main domain.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>
>>>
>>> I really dont want to pick up one patch per node instance. It is hard
>>> to scale and just creates a lot of noise.
>>>
>>
>> As the main goal of the patch series was to add support for higher speed
>> modes in MMC, I added only the required ones. If required I will send a
>> follow up patch to add the remaining GPIO nodes.
> 
> 
> I dont plan on picking this patch up in it's current form. please send a
> patch with all the gpio nodes added in as it makes no sense to split
> these out.
> 

I have sent a respin for this patch series(v4) which adds all the GPIO
nodes in the device tree files.

Thanks,
Aswath
