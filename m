Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7617A35E70B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbhDMTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhDMTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:30:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB83C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:30:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 18so239425qtz.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVwoQvaJMxO+yP07DhbysT5h5ccAWpMl0VED6nG2Vg0=;
        b=CluRNLj9fbx1ugBM+N2UuM5PObwNeOIlaq1OfkyrXK+H3bNheYPoAPiT8SCAFj7DM1
         +whx+6Kgc+RlG2Hh/7tmPxBxZuWizsP9YXTt5XJurMtBjnK237cktUo3SoruhUPTle6R
         TDgd0tifyPROWrB7tvDr8RG+/XeNbVKLRzpRGDVAf69N4dfoK71Zg9p1Cqj9WxEXhepd
         9zqff+/PUvN3ekkHJwOGnTHCwdgYJ5M7UngCTRZos0kARvDVr9ZlFurOOzimpsO2zhzW
         D1a41Mmkjf7jTlaMGC8XORvzx+VHv6nZ0dngfU6ISD0q1cPABCfjKPcrMBwkJ69Jf108
         zheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVwoQvaJMxO+yP07DhbysT5h5ccAWpMl0VED6nG2Vg0=;
        b=gDci+RTej0Ujgbg3fgZPQQGISNphhnws76PQ6BwyYKBi2ByYMqpTR8m09BAcKikQli
         ljZdSSM8+TQJH9fPPow8lsd/QB0+5VvUtW+qi/vbmJzSaeKguDtoUh654tZ19s7hwpe6
         2v36rZ1nf3KGF7f6fKn00+49ccDBqFzYvvf/UiCGH8+uwASC6i9Gq+g864Gn1nopjoG7
         i9R/YRA0b9HzaLIgl7T9/FRGB16P6yMqRVKQNRP+aA94izkgeLIEB5Uln0u6vQhr7/cd
         Zw0R+7BQb43/NI62QmZmZSORYQYg3QfArmcD8P0QTWICyhwyWJSaN1hcuC1c3xn8nSb3
         8O3w==
X-Gm-Message-State: AOAM533b1yuBjxcLR8QBPiT29qES4J+y/hTuy5kCy90+ZIsbSf02Y3Kz
        q8ehgjp8GbfSPUrPK6JCDvQbIF5Dz/lO/g==
X-Google-Smtp-Source: ABdhPJyii68iBe3CU49SfFfMkpT0rTLbBweiiuqgEh1H92k89lhaew7v3NoiqjSsHdZ3Xn/lvzZc6g==
X-Received: by 2002:ac8:7a77:: with SMTP id w23mr15765350qtt.277.1618342206911;
        Tue, 13 Apr 2021 12:30:06 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id l124sm182499qkf.38.2021.04.13.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 12:30:06 -0700 (PDT)
Subject: Re: [PATCH 3/7] crypto: qce: Add mode for rfc4309
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-4-thara.gopinath@linaro.org>
 <20210405223247.GC904837@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <39683997-42ad-bd91-0c31-a9e982e0ba61@linaro.org>
Date:   Tue, 13 Apr 2021 15:30:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210405223247.GC904837@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/21 6:32 PM, Bjorn Andersson wrote:
> On Thu 25 Feb 12:27 CST 2021, Thara Gopinath wrote:
> 
>> rf4309 is the specification that uses aes ccm algorithms with IPsec
>> security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
>> in the crypto driver.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/crypto/qce/common.h | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
>> index 3bc244bcca2d..3ffe719b79e4 100644
>> --- a/drivers/crypto/qce/common.h
>> +++ b/drivers/crypto/qce/common.h
>> @@ -51,9 +51,11 @@
>>   #define QCE_MODE_CCM			BIT(12)
>>   #define QCE_MODE_MASK			GENMASK(12, 8)
>>   
>> +#define QCE_MODE_CCM_RFC4309		BIT(13)
>> +
>>   /* cipher encryption/decryption operations */
>> -#define QCE_ENCRYPT			BIT(13)
>> -#define QCE_DECRYPT			BIT(14)
>> +#define QCE_ENCRYPT			BIT(14)
>> +#define QCE_DECRYPT			BIT(15)
> 
> Can't we move these further up, so that next time we want to add
> something it doesn't require that we also move the ENC/DEC bits?

Yes I will change it to BIT(30) and BIT(31)

> 
>>   
>>   #define IS_DES(flags)			(flags & QCE_ALG_DES)
>>   #define IS_3DES(flags)			(flags & QCE_ALG_3DES)
>> @@ -73,6 +75,7 @@
>>   #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
>>   #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
>>   #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
>> +#define IS_CCM_RFC4309(mode)		((mode) & QCE_MODE_CCM_RFC4309)
> 
> While leaving room for the typical macro issues, none of the other
> macros wrap the argument in parenthesis. Please follow the style of the
> driver, and perhaps follow up with a cleanup patch that just wraps them
> all in parenthesis?

This does throw up a checkpatch warning if I don't wrap "mode" in 
parenthesis. How about I keep this for now and I will follow up with a 
clean up for rest of the macros later ?

> 
> Regards,
> Bjorn
> 
>>   
>>   #define IS_ENCRYPT(dir)			(dir & QCE_ENCRYPT)
>>   #define IS_DECRYPT(dir)			(dir & QCE_DECRYPT)
>> -- 
>> 2.25.1
>>

-- 
Warm Regards
Thara
