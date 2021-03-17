Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA4733E6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCQCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCQCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:08:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A096C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:08:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 130so37424072qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5K+i9EB30YDCBf5Ec7nN0Kmlxn8dBvWA2QPUBF4tmM0=;
        b=ZKtMYKT3DClvewV7ca7X458r647Gl63Q2Y28BVG0C9oKSr1btE07Eo0tVaR4IRhZJG
         IJpFOKKwhuRdcy2O+0UeHmfAKU5CeJEf6++TP9YgjMBtg/KBLlMgg1bnReMIT/asVE88
         Ey3oB2IA00vUJwztNsH3fiQKB7gg8eEvQrDT3F71NHFo7z4ACNQwoV19Y2QEhIE6/IKs
         z9pRZ5N1pShZXWmZ8OC2CzPq3fkOp51QjOSnHtrQo9Yu8m+7rOJH0a6aLbkxjPIx65ju
         VlE9f2Hd4l4jktA7pTHef9vLPQ7ZMMXCZigmP2zdHRgjxrtF0sTPMuOaS2tKkbTfSk5C
         U3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5K+i9EB30YDCBf5Ec7nN0Kmlxn8dBvWA2QPUBF4tmM0=;
        b=KE0wgBbzLwn87gfZBIJQXDH+Rwu7AH4ve6tIbnfG0Pm5YBTYsv7IwPNmkaHrELzn0K
         7R1LKzB5TY4UUMtWrPH8fvgMb0+n1nqLyMCYHPziZWFWJLhEKt0ERSBCwNpy/Cs1ffPr
         i4C0c/fQT3bPjymvsR2f6JJUh42HvkR/cOk41MXYaRAhs7Ygg9azK8Xe4IUk6jurZMGY
         EgGBVhxWMr+dF+Uh2qSzqfIW7Mm/RfU7MrarSg0fRNadV5h7TMz6ssUtZYWukn9un6MG
         mjyw3lDLdAyE4ZIpAPpYpxqz2yjh8yu0gdqjLRNop/pNSf1eMQrmCUfAtrSFEykaduIt
         YYQA==
X-Gm-Message-State: AOAM533OcZMHAxg6BGOQXR9LO1JZeR9juyTlKCC6L8ULARHEydbqfEi+
        taWG5UIe5O9RE6IMlXtbAGE23zgZQ4PxgA==
X-Google-Smtp-Source: ABdhPJyqKJsLFZkTCPWcsm5q4dBZRSraW2bsrajiGbsdcfZ/rP9PVKt5GCeNE7n50dmUAxIoFOhiUA==
X-Received: by 2002:a05:620a:55a:: with SMTP id o26mr2267267qko.43.1615946920091;
        Tue, 16 Mar 2021 19:08:40 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id t5sm12956454qkt.66.2021.03.16.19.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 19:08:39 -0700 (PDT)
Subject: Re: [PATCH 0/7] Add support for AEAD algorithms in Qualcomm Crypto
 Engine driver
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eric Biggers <ebiggers@google.com>, ardb@kernel.org,
        sivaprak@codeaurora.org, linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210304053027.GC25972@gondor.apana.org.au>
 <CALD-y_y8qidsypp7=F-5OLitaq3B1E==c+eQgyqq7hv9t3xcmw@mail.gmail.com>
 <20210312130221.GB17238@gondor.apana.org.au>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <35ef6e54-7865-4587-49b5-711b63b38319@linaro.org>
Date:   Tue, 16 Mar 2021 22:08:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312130221.GB17238@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 8:02 AM, Herbert Xu wrote:
> On Thu, Mar 04, 2021 at 01:41:15PM -0500, Thara Gopinath wrote:
>>
>> Yes it did. The last patch adds fallback for unsupported cases and
>> this will make it pass the fuzz tests.
> 
> Please include this information in the next round.

I will. Thanks!
> 
> Thanks,
> 

-- 
Warm Regards
Thara
