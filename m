Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3112C31015F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhBEAKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhBEAKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:10:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F79C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:09:56 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z22so3828462qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SI5j+iF4abUgLvTfrUu5p8XYf5nU55OwaIfuxVg8Ap0=;
        b=H9ym7IUTalqakgHKC0f0MtYjYUKCC3VtKcANjxlXeqjZ7aiQWyr39E31AuAsXHAgks
         lo80EjeggpY0ZpTNhkLNAvCfZldD1KQ+9A4/6iinHlL1rnlzLql5c4lqTRWiA7h32lIa
         8gfC600dffl+16Mj/FB9cb8rwIF+5fst+oUkCw53F0KHS7knK6G/NeI7n4oxdxH1tBX9
         e8WDJAiJgg1LoXjIj/sCkCc0fOYzC8RHEfz2ol+cgH1We4a/WSnErfkwi0A0QOcfnXoU
         8ujRTjHfe4RBFvHeS/yzl5mh5KES6CHbXmza4UsVWzdOh1mHMwZJ9VUs0zLvKSla4wNh
         RKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SI5j+iF4abUgLvTfrUu5p8XYf5nU55OwaIfuxVg8Ap0=;
        b=lOHCnaQfjTjjl7VEE2vC4sKU/y4g1ia/uwMB5ZdDwLgbhnnntWNI0MoM8YccPQey5f
         kyw7/W9v7D5/nRkWI/ojfND+nzaNPJL1VLBGDMZR4lcp8K97TRItGhaNw44YKctYLbNT
         LF/fS+3s7vpakgJdc5QHqlT6QP7uC0rY/Xif9y/XuuF0Yh9r9zYRa7MejjZqmmO7Ao97
         mcqFH+jqb0V2HXMEc2guUnacCyFWrVPohb8syHQ9YHe4SgmzmFtlfo4LGroKlXHp/DXD
         1Mt4JO2umG9lNkatQXWykGgTr/AqFBNJG/AbLlaqz0m9eHeg//9OAgYvtVjSuc1VTePV
         0AMw==
X-Gm-Message-State: AOAM533EKChnIw/WRZExQ2hgKTt0xO4agi5xqEbGo8KQWJyCCXR0Qfsj
        EPC67v01Ed6UrbKzNWTNDxMU9ReEoqcfrw==
X-Google-Smtp-Source: ABdhPJxYtAZhjVVST7Vak3wz59xZUtUViRe7TuK1cZsxuylDhIFq0ONt6NQhA0p8PuqQloxt4VKF5w==
X-Received: by 2002:ac8:7768:: with SMTP id h8mr2048041qtu.331.1612483794726;
        Thu, 04 Feb 2021 16:09:54 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id q6sm6959212qkq.34.2021.02.04.16.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 16:09:54 -0800 (PST)
Subject: Re: [PATCH v5 05/11] crypto: qce: skcipher: Return error for zero
 length messages
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org, ardb@kernel.org,
        sivaprak@codeaurora.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
 <20210204214359.1993065-6-thara.gopinath@linaro.org>
 <YBx5yWhKtT2EC2Ce@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <00d759f3-8ea3-1f85-b623-225c372c0a04@linaro.org>
Date:   Thu, 4 Feb 2021 19:09:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBx5yWhKtT2EC2Ce@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2/4/21 5:48 PM, Eric Biggers wrote:
> On Thu, Feb 04, 2021 at 04:43:53PM -0500, Thara Gopinath wrote:
>> Crypto engine BAM dma does not support 0 length data. Return unsupported
>> if zero length messages are passed for transformation.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/crypto/qce/skcipher.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
>> index de1f37ed4ee6..331b3c3a5b59 100644
>> --- a/drivers/crypto/qce/skcipher.c
>> +++ b/drivers/crypto/qce/skcipher.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/types.h>
>> +#include <linux/errno.h>
>>   #include <crypto/aes.h>
>>   #include <crypto/internal/des.h>
>>   #include <crypto/internal/skcipher.h>
>> @@ -260,6 +261,10 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
>>   	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
>>   	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
>>   
>> +	/* CE does not handle 0 length messages */
>> +	if (!req->cryptlen)
>> +		return -EOPNOTSUPP;
>> +
> 
> For the algorithms in question, the correct behavior is to return 0.

What do you mean? The driver should return a 0 ?

> 
> Aren't the tests catching that difference?

I was anyways planning on sending an email to the list with these 
queries. But since you asked,  these are my observations with fuzz 
testing which I have been doing quite a bit now (I am also working on 
adding a few qualcomm AEAD algorithms support in mainline).

- if the generic algorithm supports 0 length messages and the 
transformation I am testing does not, the test framework throws an error 
and stops.
- key support mismatch between the generic algorithm vs my algorithm 
/engine also does the same thing.For eg, Qualcomm CE engine does not 
support any three keys being same for triple des algorithms. Where as a 
two key 3des is a valid scenario for generic algorithm(k1=k3). Another 
example is hardware engine not supporting AES192.

How are these scenarios usually handled ? Why not allow the test 
framework to proceed with the testing if the algorithm does not support 
a particular scenario ?

> 
> - Eric
> 
-- 
Warm Regards
Thara
