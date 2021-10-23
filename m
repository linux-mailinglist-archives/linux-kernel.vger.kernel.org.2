Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57943852A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJWULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:11:37 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:61356 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhJWULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:11:36 -0400
Received: from [192.168.1.18] ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id eNKMmCzHkTdRTeNKMmKPAW; Sat, 23 Oct 2021 22:09:16 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Oct 2021 22:09:16 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH] coresight: Use devm_bitmap_zalloc when applicable
To:     Joe Perches <joe@perches.com>, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e5fe23370794e2f5442e11e7f8455ddb06e4b10a.1635016943.git.christophe.jaillet@wanadoo.fr>
 <663d3820f118c37a81529b3362b95e09c8e75e9f.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <bb913ce7-bae6-3b3e-180f-946786f7d300@wanadoo.fr>
Date:   Sat, 23 Oct 2021 22:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <663d3820f118c37a81529b3362b95e09c8e75e9f.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/10/2021 à 21:36, Joe Perches a écrit :
> On Sat, 2021-10-23 at 21:24 +0200, Christophe JAILLET wrote:
>> 'drvdata->chs.guaranteed' is a bitmap. So use 'devm_bitmap_kzalloc()' to
>> simplify code, improve the semantic and avoid some open-coded arithmetic
>> in allocator arguments.
> []
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> []
>> @@ -862,7 +862,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct stm_drvdata *drvdata;
>>   	struct resource *res = &adev->res;
>>   	struct resource ch_res;
>> -	size_t bitmap_size;
>>   	struct coresight_desc desc = { 0 };
>>   
>>   	desc.name = coresight_alloc_device_name(&stm_devs, dev);
>> @@ -904,9 +903,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>   	else
>>   		drvdata->numsp = stm_num_stimulus_port(drvdata);
>>   
>> -	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
>> -
>> -	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
>> +	guaranteed = devm_bitmap_zalloc(dev, drvdata->numsp, GFP_KERNEL);
>>   	if (!guaranteed)
>>   		return -ENOMEM;
>>   	drvdata->chs.guaranteed = guaranteed;
> 
> guaranteed is also pretty useless
> 

I agree, but removing it would make the line with devm_bitmap_zalloc() 
86 chars. This would not be consistent with the rest of the file and 
would (IMHO) require splitting.

Let see if the maintainer prefer saving one additional line of code, or 
keeping the logic in place.

CJ

