Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972543FDE37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbhIAPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:04:38 -0400
Received: from goliath.siemens.de ([192.35.17.28]:35120 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhIAPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:04:37 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 181F3Q09005589
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 17:03:27 +0200
Received: from [167.87.73.68] ([167.87.73.68])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 181F3PEX018035;
        Wed, 1 Sep 2021 17:03:25 +0200
Subject: Re: [PATCH] soc: ti: pruss: fix referenced node in error message
To:     Suman Anna <s-anna@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
References: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
 <d2e95cc3-2575-7c54-186e-aa421495862e@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1cbf299b-cc4f-cab6-62ef-db7c19aa0876@siemens.com>
Date:   Wed, 1 Sep 2021 17:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d2e95cc3-2575-7c54-186e-aa421495862e@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.21 17:51, Suman Anna wrote:
> On 6/21/21 1:08 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> So far, "(null)" is reported for the node that is missing clocks.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Acked-by: Suman Anna <s-anna@ti.com>
> 
>> ---
>>  drivers/soc/ti/pruss.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>> index f22ac1edbdd0..afc8aae68035 100644
>> --- a/drivers/soc/ti/pruss.c
>> +++ b/drivers/soc/ti/pruss.c
>> @@ -129,7 +129,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>>  
>>  	clks_np = of_get_child_by_name(cfg_node, "clocks");
>>  	if (!clks_np) {
>> -		dev_err(dev, "%pOF is missing its 'clocks' node\n", clks_np);
>> +		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
>>  		return -ENODEV;
>>  	}
>>  
>>
> 

This was not merged yet. Is it queued somewhere?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
