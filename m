Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA833E6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCQCJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCQCJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:09:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:09:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a9so37409369qkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/MD2a5jJm1VTg2rLp8ZvV5PbVeWqLk6KDwdIiH3D7ok=;
        b=ZTaOzuB+ptoZaIS7ucnPtUjZ9ehUlHs6z1oq1rXOyLKK+S1K6qLgIkqDf9I4N6nCXV
         EA3XCld0w8N7rzIwb0+Ho89U0oNBDnVLTs7vBptEpo4YfDkOyFmVF5WCgTylSamJ7f1L
         ZnML3cfh5KJ6IxkSYSrFrR01mpmoyN7FlyB5Zn7dfcTk5B+ydRJHV6Gtq4+/I5a9/sDT
         WHbgI4qSL5Yq/Z7Fo+RbeyRL9Zbf1sL2qLHGmp5czAccTdDq8G9yqCinsiJLVQfGdp4R
         3kHYr0VULHgD4t7X4pT1TxLh5nMTu/rCM4r/uR3z1Uif3iJ2Ho4GTj9S5T2SFG2Vkxfd
         IOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MD2a5jJm1VTg2rLp8ZvV5PbVeWqLk6KDwdIiH3D7ok=;
        b=fJHoS1RiwZuvUL0AjB0ThEW0S8R66YyfwyTFC1Jg1oL6TXZcO1zhlB7Do+KYggbMfO
         NRQ7wQnE8gZ0DWeN9uYLpH+TZsADiKF5YYuz5aUsJGv/AgVTaCEhvEHe/MRKojUSNBGl
         JJl2iSXWAac/3QReww4lY/qlsMK+2/1G9nHDK6elDLDbEShSRC07UGAO8EDOrYVdCenK
         WRJdBuVQ2AtDaT5nYPjoL850p3Y/HYB9wOyapp3BkNOPbTemXsJYzTHpq+lyrz2XZyeR
         y5gWtLgqMoQI2iCewdLk2k9Zd85+PZ0bNaFgBQkHhkS92VDcAZXJl0cTO6RO6cT7x9xa
         0Vyg==
X-Gm-Message-State: AOAM533XwfNLH08Sim782QhYPU5Zzh2lA/wi7RAH7wdu7RB374z9oHLJ
        zIwuET6CyZIm8/VkT6/Zwh5xZM4huH6qdw==
X-Google-Smtp-Source: ABdhPJxX1ZLdrxaGMH0MG4DE9v5rUZ/KwcbMeoSoaule+9shT5XPe5Azmr/p44YCEokJ/QbubV7g6g==
X-Received: by 2002:a37:6108:: with SMTP id v8mr2312231qkb.448.1615946982331;
        Tue, 16 Mar 2021 19:09:42 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id l5sm14057275qtj.21.2021.03.16.19.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 19:09:41 -0700 (PDT)
Subject: Re: [PATCH 4/7] crypto: qce: Add support for AEAD algorithms
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-5-thara.gopinath@linaro.org>
 <20210312130150.GA17238@gondor.apana.org.au>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <69c608d4-5dff-b33b-e112-2b2603ecfd27@linaro.org>
Date:   Tue, 16 Mar 2021 22:09:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312130150.GA17238@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 8:01 AM, Herbert Xu wrote:
> On Thu, Feb 25, 2021 at 01:27:13PM -0500, Thara Gopinath wrote:
>>
>> +static int
>> +qce_aead_async_req_handle(struct crypto_async_request *async_req)
>> +{
>> +	struct aead_request *req = aead_request_cast(async_req);
>> +	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
>> +	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
>> +	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
>> +	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
>> +	struct qce_device *qce = tmpl->qce;
>> +	enum dma_data_direction dir_src, dir_dst;
>> +	unsigned int totallen;
>> +	bool diff_dst;
>> +	int ret;
>> +
>> +	if (IS_CCM_RFC4309(rctx->flags)) {
>> +		memset(rctx->ccm_rfc4309_iv, 0, QCE_MAX_IV_SIZE);
>> +		rctx->ccm_rfc4309_iv[0] = 3;
>> +		memcpy(&rctx->ccm_rfc4309_iv[1], ctx->ccm4309_salt, QCE_CCM4309_SALT_SIZE);
>> +		memcpy(&rctx->ccm_rfc4309_iv[4], req->iv, 8);
>> +		rctx->iv = rctx->ccm_rfc4309_iv;
>> +		rctx->ivsize = AES_BLOCK_SIZE;
>> +	} else {
>> +		rctx->iv = req->iv;
>> +		rctx->ivsize = crypto_aead_ivsize(tfm);
>> +	}
>> +	if (IS_CCM_RFC4309(rctx->flags))
>> +		rctx->assoclen = req->assoclen - 8;
>> +	else
>> +		rctx->assoclen = req->assoclen;
>> +
>> +	totallen = rctx->cryptlen + rctx->assoclen;
> 
> This triggers a warning on totallen not being used.  Please fix.

hmm.. this is strange. I could swear that I checked for warnings before 
sending this out. But I will fix this. I will wait for a couple of more 
days for any other comments and then spin a v2.

> 
> Thanks,
> 

-- 
Warm Regards
Thara
