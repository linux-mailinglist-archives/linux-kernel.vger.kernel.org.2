Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0551837AC26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhEKQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:42:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52664 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEKQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:42:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BGeppc006708;
        Tue, 11 May 2021 11:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620751251;
        bh=o0HigsdKBe5csPaBHc4l860DJcWkFyEglcaRFartKRc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oL2vUGClingUoyiqXnrYDLRmre7RZUPnK1FEB6DY7zeqj3/zyUV3rJn3sRrnyY/tQ
         BxXPy1C4EoVF0bYEHxkjkb7VCYw24J7P7X5TOpgRhfIsTwlGLHG1b8mAVi9JysA6ZV
         2yjzDfzVPMbWWdikMTB96sRSU859iN1CivMSjK3Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BGepT2036484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 11:40:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 11:40:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 11:40:51 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BGehbM007316;
        Tue, 11 May 2021 11:40:45 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
To:     Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210511095339.16268-1-a-govindraju@ti.com>
 <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
 <7561137c-adf1-bf03-c442-ff8174b2f143@ti.com>
 <95539fea-8190-7a3d-05aa-90824eb03293@siemens.com>
 <20210511163357.2kp2jpg4uyk5nb5u@sizing>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <ba0bff36-5e1a-9f4e-2952-e8ca79456988@ti.com>
Date:   Tue, 11 May 2021 22:10:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511163357.2kp2jpg4uyk5nb5u@sizing>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth, Jan,

On 11/05/21 10:03 pm, Nishanth Menon wrote:
> On 17:26-20210511, Jan Kiszka wrote:
> [...]
>>>>> +&sdhci1 {
>>>>> +	no-1-8-v;
>>>>> +};
>>>>> +
>>>>
>>>> Let's move that to k3-am65-iot2050-common.dtsi, to avoid repeating
>>>> yourself. There is already a sdhci1 extension.
>>>>
>>>
>>> The reason why I added these tags in board dts and not in the common
>>> dtsi is because if it was added in the common board then for all the iot
>>> boards this will be applicable and in future if a different version of
>>> iot boards use S.R. 2.0 then we might have to change it again.
>>
>> Yes, we will have to take care of the split-up for SR2.0-based variants.
>> I didn't have the chance study their DTs yet but I strongly suspect that
>> there will be more differences. Then we may add some
>> k3-am65-iot2050-common-{SR1,SR2}.dtsi.
>>
>> So, I would not try to refactor when not all variables are on the table yet.
> 
> 
> I agree with Jan. lets bring it in the current common.dtsi and see the
> sr2 introduction separately.
> 

okay, I'll post a respin of this patch making this change.

Thanks,
Aswath
