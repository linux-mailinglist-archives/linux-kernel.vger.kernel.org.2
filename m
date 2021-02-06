Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBF31173F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhBEXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhBEOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F03C061D7F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:57:56 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z32so5264376qtd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tmNWOER2gkNnhOJswBmgj3DRlXtWxnfQNoR9W/JQIbA=;
        b=m/CFKqbpZvVbZySHTwTbH9pKEiWK6Gm8kVo43OIFrNj/Ym/I+NWkUf3vmRGUK14WjR
         vvKQreZohNRCMs60wDLGC3qYIaidFu+B43obF2oQD/igFxS+EpDzZkdLGCGNNLBf5XKg
         q2TJlp5XyPni1kJh46L7CAjrFdeazdWUh0XH/UrSBb7eHyy0StDPk6i14XqmGzppVzPp
         MSLZDOvo5QJGHJNf8sIlzO8FyonyU+1fDIfX3kj/wHODGcwdhHmypQaY8E86Tfz9ePgH
         w3GJgfG6BPO73gbbRNzfi3umEe1LHI1KwHpjVC0w1jH0KMmpLSKOxuot1iHOz2Oc/aXH
         mMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tmNWOER2gkNnhOJswBmgj3DRlXtWxnfQNoR9W/JQIbA=;
        b=Z4IlDqNAALDO0q9Vra61/CkIKCvqLAKT9v196EYptcxIgqi/CpNBnkObZa/ajxoG0V
         Bw7HNSrqZvEs8/L2Ahi2E/nbMNykqfSTeGFSEP2fredDaARtFoNC9UVGku0ll98P7OYH
         s+9jshq3RngGHFePiFxoROYmIsOmqaOwm8XP7U0oEvjv+sRa6lJEZNjVAK1RsNN2XMt/
         E7zQLFZTtxqV1iOyNTWhmS8NUg78USfm6J3dDQUmUW9dFxxPS0wocweg3PUusisoBewH
         pZTEe9xscwh0Ww/YMlVe81gUci8BbYrH+Pz99cWTcbbVxDJbPrEK8u6efFpJvCpzg3ML
         oIGg==
X-Gm-Message-State: AOAM5321lcWsxsqHcUeGuJKi+gRGPvBYYvuIzDwfYYWDmWVFjDRuLZad
        16wq/EhRAV75X896Di4oVKOltCeWK331Mw==
X-Google-Smtp-Source: ABdhPJxwF0U5i0+S20/nnzRH0bgOLvkmNT1Tq1z6aiVrUshIuh3TWoX2zbqiv+QVoB30PEQHxE6uGA==
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr4484105qto.3.1612534099833;
        Fri, 05 Feb 2021 06:08:19 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a16sm7574046qta.69.2021.02.05.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 06:08:19 -0800 (PST)
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
 <00d759f3-8ea3-1f85-b623-225c372c0a04@linaro.org>
 <YByQpRG0SC0k0gYC@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <ed714cc0-c3ca-88ca-f57f-e2a5ccf7ef16@linaro.org>
Date:   Fri, 5 Feb 2021 09:08:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YByQpRG0SC0k0gYC@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 7:26 PM, Eric Biggers wrote:
> On Thu, Feb 04, 2021 at 07:09:53PM -0500, Thara Gopinath wrote:
>>>> @@ -260,6 +261,10 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
>>>>    	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
>>>>    	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
>>>> +	/* CE does not handle 0 length messages */
>>>> +	if (!req->cryptlen)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>
>>> For the algorithms in question, the correct behavior is to return 0.
>>
>> What do you mean? The driver should return a 0 ?

Ok. I will re-spin the series once more with this change..

> 
> Yes, there is nothing to do for empty inputs, so just return 0 (success).
> 
>>> Aren't the tests catching that difference?
>>
>> I was anyways planning on sending an email to the list with these queries.
>> But since you asked,  these are my observations with fuzz testing which I
>> have been doing quite a bit now (I am also working on adding a few qualcomm
>> AEAD algorithms support in mainline).
>>
>> - if the generic algorithm supports 0 length messages and the transformation
>> I am testing does not, the test framework throws an error and stops.
>> - key support mismatch between the generic algorithm vs my algorithm /engine
>> also does the same thing.For eg, Qualcomm CE engine does not support any
>> three keys being same for triple des algorithms. Where as a two key 3des is
>> a valid scenario for generic algorithm(k1=k3). Another example is hardware
>> engine not supporting AES192.
>>
>> How are these scenarios usually handled ? Why not allow the test framework
>> to proceed with the testing if the algorithm does not support a particular
>> scenario ?
> 
> Omitting support for certain inputs isn't allowed.  Anyone in the kernel who
> wants to use a particular algorithm could get this driver for it, and if they
> happen to use inputs which the driver decided not to support, things will break.

Ya sounds reasonable.

> 
> The way that drivers handle this is to use a fallback cipher for inputs they
> don't support.

Ok. So I will add this to my todo and make sure to have fallback ciphers 
for all the non-supported inputs. I will send this as a separate series 
and not this one.

In this case, though not supporting 0 length messages for encryption is 
valid. I don't think I have to have a fallback for this. I could have 
sworn that the test framework throws up an error for this. But I have 
been testing a lot and may be I am just confused. I will double check this.


> 
> - Eric
> 

-- 
Warm Regards
Thara
