Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF535E707
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhDMT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhDMT2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:28:47 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:28:25 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o11so8663100qvh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8ZN7Qwwd5Ix7pE604LHRgxVLUozgSWTjN9Rn065Nm0=;
        b=PP3iAuCANMnnD5BG2ntiGPA2FwlNMHOgU6s6gp6rNGpbGZM3IdJFhOdCXLoQMrGL5c
         LBuPYHM0UfsnoZYKR8l0HFmi1aS3DSZrmSSUljyJq0GqLDhDMjew7VG90wfCLeIaY41D
         PX5fQ52pvCpxSsVSsoUFliEo3vEMoi5g4fkGpRtersFBJWXjc+TIjU/AMkiHk7e6stdG
         IKCYYTgJxoN3r6X8cGorkQYGD6yGZQjn4HuIaUs/JumRsiQOUNGbJexrqIeX6PFZzBeM
         fXsfdkwRm1+2N3JMv2SkO0C7ePbmsST034Fq6JpuZWuRumencTEu0NbM9SzV8IzCow0I
         uifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8ZN7Qwwd5Ix7pE604LHRgxVLUozgSWTjN9Rn065Nm0=;
        b=GmhSptJTTI7l5DEKIxFdfQ6mfyHG1wwxnf+XVD8fy6pfyj5JSqFx5z5ZehuYQiuF2d
         en2eG1ego/vgHvLcepP5ngUbeJfdPH/78GeiKPRvdP/VKffrBVuscADNTXoiZ2qe89fF
         9J3Jge9OZ9zeeu+xsRvKLAini9UDUG0cE6jOvc6XTHdMBb6z8MinI4uBA5j5Zh6cV2AL
         qeqJ+bEmIYi7J26sa9vxr4Shki53oa6ZGO89wGRV0EdA0UI/NSqYZowiUZ5Dchdj/Cpj
         RCYiYPBXn6l4acdoM0F1af/O9z3Ybv2MFvTBeC5+dpE66bs017WoPU+8XJ7VZKzf8hzJ
         SLNw==
X-Gm-Message-State: AOAM530FnLKSl6U7de6iI8OTTBjT0Bm9vb9DZCOs3tepdckx9rKODuJ8
        U425HOXMtz/X4acGWNMItfm5mlq8POzKuA==
X-Google-Smtp-Source: ABdhPJx4Jk9iR0YN79tqg6Frh2oZT736ordw3dNwYHyVuHbLQOJybbs3OevNIgjoOh2nF+f3T0hXOg==
X-Received: by 2002:a05:6214:248f:: with SMTP id gi15mr34367277qvb.40.1618342104272;
        Tue, 13 Apr 2021 12:28:24 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id e13sm10797545qtm.35.2021.04.13.12.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 12:28:23 -0700 (PDT)
Subject: Re: [PATCH 1/7] crypto: qce: common: Add MAC failed error checking
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-2-thara.gopinath@linaro.org>
 <20210405173600.GZ904837@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <1c3523d6-ac4d-f0b7-ad89-724ed1e4f485@linaro.org>
Date:   Tue, 13 Apr 2021 15:28:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210405173600.GZ904837@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the reviews.
I realized that I had these replies in my draft for a while and forgot 
to send them!

On 4/5/21 1:36 PM, Bjorn Andersson wrote:
> On Thu 25 Feb 12:27 CST 2021, Thara Gopinath wrote:
> 
>> MAC_FAILED gets set in the status register if authenthication fails
>> for ccm algorithms(during decryption). Add support to catch and flag
>> this error.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/crypto/qce/common.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
>> index dceb9579d87a..7c3cb483749e 100644
>> --- a/drivers/crypto/qce/common.c
>> +++ b/drivers/crypto/qce/common.c
>> @@ -403,7 +403,8 @@ int qce_start(struct crypto_async_request *async_req, u32 type)
>>   }
>>   
>>   #define STATUS_ERRORS	\
>> -		(BIT(SW_ERR_SHIFT) | BIT(AXI_ERR_SHIFT) | BIT(HSD_ERR_SHIFT))
>> +		(BIT(SW_ERR_SHIFT) | BIT(AXI_ERR_SHIFT) |	\
>> +		 BIT(HSD_ERR_SHIFT) | BIT(MAC_FAILED_SHIFT))
>>   
>>   int qce_check_status(struct qce_device *qce, u32 *status)
>>   {
>> @@ -417,8 +418,12 @@ int qce_check_status(struct qce_device *qce, u32 *status)
>>   	 * use result_status from result dump the result_status needs to be byte
>>   	 * swapped, since we set the device to little endian.
>>   	 */
>> -	if (*status & STATUS_ERRORS || !(*status & BIT(OPERATION_DONE_SHIFT)))
>> -		ret = -ENXIO;
>> +	if (*status & STATUS_ERRORS || !(*status & BIT(OPERATION_DONE_SHIFT))) {
>> +		if (*status & BIT(MAC_FAILED_SHIFT))
> 
> Afaict MAC_FAILED indicates a different category of errors from the
> others. So I would prefer that the conditionals are flattened.
> 
> Is OPERATION_DONE set when MAC_FAILED?
Yes it is. I will change the check to the pattern you have suggested. It 
is less confusing..

> 
> If so:
> 
> if (errors || !done)
> 	return -ENXIO;
> else if (*status & BIT(MAC_FAILED))
> 	return -EBADMSG;
> 
> Would be cleaner in my opinion.
> 
> Regards,
> Bjorn
> 
>> +			ret = -EBADMSG;
>> +		else
>> +			ret = -ENXIO;
>> +	}
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.25.1
>>

-- 
Warm Regards
Thara
