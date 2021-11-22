Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0445916F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhKVPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:34:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhKVPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:34:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMFVYFt003275;
        Mon, 22 Nov 2021 09:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637595094;
        bh=l4IE6N+ggau1s09k9ExcCLkrfbZHkOUKLDDQDp1KkTA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=l7LsCNtvzUMzFMuyiNF67DnAM7iMIP0ll3kwFq7xWAKzmhqREcSCt4sDkNZ8UuCyh
         a2BvTVweEtziNS4jMvRhRyk/GxHtxo+D6eC62j5Dopqk8PlAuoF4eG4HqoQmBO75sn
         +WGNb0FXjnRvvx58rhdzDQE0VMj6DgUk1fziZlz8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMFVYZh074258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 09:31:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 09:30:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 09:30:10 -0600
Received: from [10.249.45.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMFUAlL007225;
        Mon, 22 Nov 2021 09:30:10 -0600
Subject: Re: [PATCH] soc: ti: pruss: fix referenced node in error message
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>
References: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
 <d2e95cc3-2575-7c54-186e-aa421495862e@ti.com>
 <1cbf299b-cc4f-cab6-62ef-db7c19aa0876@siemens.com>
 <469b98e1-7500-0912-54c3-945c193f086a@siemens.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <a6d42845-dd9e-c8ba-cbc9-599bfe112ad3@ti.com>
Date:   Mon, 22 Nov 2021 09:30:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <469b98e1-7500-0912-54c3-945c193f086a@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Nishanth

On 11/20/21 1:53 AM, Jan Kiszka wrote:
> On 01.09.21 17:03, Jan Kiszka wrote:
>> On 23.06.21 17:51, Suman Anna wrote:
>>> On 6/21/21 1:08 PM, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> So far, "(null)" is reported for the node that is missing clocks.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Acked-by: Suman Anna <s-anna@ti.com>
>>>
>>>> ---
>>>>  drivers/soc/ti/pruss.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>>>> index f22ac1edbdd0..afc8aae68035 100644
>>>> --- a/drivers/soc/ti/pruss.c
>>>> +++ b/drivers/soc/ti/pruss.c
>>>> @@ -129,7 +129,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>>>>  
>>>>  	clks_np = of_get_child_by_name(cfg_node, "clocks");
>>>>  	if (!clks_np) {
>>>> -		dev_err(dev, "%pOF is missing its 'clocks' node\n", clks_np);
>>>> +		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
>>>>  		return -ENODEV;
>>>>  	}
>>>>  
>>>>
>>>
>>
>> This was not merged yet. Is it queued somewhere?
>>
>> Jan
>>
> 
> Second reminder - still not seeing this in upstream.

Nishanth,
Can you pick this up?

regards
Suman
