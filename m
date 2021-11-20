Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E36457C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhKTH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:57:25 -0500
Received: from gecko.sbs.de ([194.138.37.40]:41522 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235020AbhKTH5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:57:23 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AK7rrpX005425
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Nov 2021 08:53:53 +0100
Received: from [167.87.1.34] ([167.87.1.34])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AK7rqx9018678;
        Sat, 20 Nov 2021 08:53:52 +0100
Subject: Re: [PATCH] soc: ti: pruss: fix referenced node in error message
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Suman Anna <s-anna@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
References: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
 <d2e95cc3-2575-7c54-186e-aa421495862e@ti.com>
 <1cbf299b-cc4f-cab6-62ef-db7c19aa0876@siemens.com>
Message-ID: <469b98e1-7500-0912-54c3-945c193f086a@siemens.com>
Date:   Sat, 20 Nov 2021 08:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1cbf299b-cc4f-cab6-62ef-db7c19aa0876@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 17:03, Jan Kiszka wrote:
> On 23.06.21 17:51, Suman Anna wrote:
>> On 6/21/21 1:08 PM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> So far, "(null)" is reported for the node that is missing clocks.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Acked-by: Suman Anna <s-anna@ti.com>
>>
>>> ---
>>>  drivers/soc/ti/pruss.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>>> index f22ac1edbdd0..afc8aae68035 100644
>>> --- a/drivers/soc/ti/pruss.c
>>> +++ b/drivers/soc/ti/pruss.c
>>> @@ -129,7 +129,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>>>  
>>>  	clks_np = of_get_child_by_name(cfg_node, "clocks");
>>>  	if (!clks_np) {
>>> -		dev_err(dev, "%pOF is missing its 'clocks' node\n", clks_np);
>>> +		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
>>>  		return -ENODEV;
>>>  	}
>>>  
>>>
>>
> 
> This was not merged yet. Is it queued somewhere?
> 
> Jan
> 

Second reminder - still not seeing this in upstream.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
