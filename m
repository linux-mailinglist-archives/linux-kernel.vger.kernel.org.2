Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475BC31018F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhBEAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBEAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:24:55 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF52C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:24:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id n15so5320141qkh.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZgarHMUxIZlnytWyvoqUUIQG5N3AYseK/6JWelyc+G8=;
        b=qgFmqFjhCsdsQIS9AwSyR4wvdBUIyt4rlSaAedFOAujp0lxrkGMHZbyilt02fXFjyC
         unV5jhegvjujJCR5AMJCJHC2D6N+Qyo3EbU8fPVwsXMZD0kZ8KRy/UIMF4UUXX6PiwFU
         rAImr1DSLLi+whx6WubuRa7aw7sMZ+vRjhVlTj8u7qen3oTUtdJbEcMgJKwnth+GPTIh
         2zsRHBZ/ES7qs523OVeOa/mSGk9S+9gjNyXtXkAFLLGPa3tk+Io2qm4MNxO+mPhN4lCJ
         m8TvBH87bzGB1iZuylYdtU8mjkjcGdt9gErt+uuvvc9p1WKC56a1I3ejAzGPMGEzWPJe
         9d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZgarHMUxIZlnytWyvoqUUIQG5N3AYseK/6JWelyc+G8=;
        b=PLi8B0Idc00fr+CETKzifBQ7d+xYfrZ6pMLKc9CbQiqt7l+paFxK/ZDUa/ERasNULo
         5uPw4in2KMV1BLzbdg7xDoHXoxFXkM/KrEgdLxqYH20itYhhImrHLOa2nP63h1fV/hOb
         LLHJf2Vauz4w1YZ07u09U6Aif95QhL43haAGTHVStA2QjUPsAQSV73+qI0pT8bnlAJQs
         hegM4QKAGJnXFRDW3hKXyi6CNbPd9TE1WyppR3vNh3sm/rSVMrimWo/ojis5A1/n1fXR
         EXSkVKSlYIMuy9PRihiYMULnZSqQf8TYucOKWBeFjKlm5tkZNV6RsjbVJ2gptLK/wI+k
         i2oA==
X-Gm-Message-State: AOAM532iW0YDNvAzKSd2epUjG97xzNrOT9tCna31ybcXZ8tCFSZiQ1P1
        D3PPtISv8c7JVChO21SWaXhKpbjgnOzxyw==
X-Google-Smtp-Source: ABdhPJzeONNYoBKMawygUTeT5+85SqU9aIi7mbOHmm4ahuYPydsPu5aV68tONfLEwOR/QxWxaV6zwQ==
X-Received: by 2002:a05:620a:ed8:: with SMTP id x24mr1839168qkm.381.1612484653806;
        Thu, 04 Feb 2021 16:24:13 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id l22sm6348879qtl.96.2021.02.04.16.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 16:24:13 -0800 (PST)
Subject: Re: [PATCH v5 06/11] crypto: qce: skcipher: Return error for
 non-blocksize data(ECB/CBC algorithms)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org, ardb@kernel.org,
        sivaprak@codeaurora.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
 <20210204214359.1993065-7-thara.gopinath@linaro.org>
 <YBx6S+up7YD2eCuU@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <ee73454b-32cc-4ab5-b499-2941aa496532@linaro.org>
Date:   Thu, 4 Feb 2021 19:24:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBx6S+up7YD2eCuU@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 5:50 PM, Eric Biggers wrote:
> On Thu, Feb 04, 2021 at 04:43:54PM -0500, Thara Gopinath wrote:
>> +	/*
>> +	 * ECB and CBC algorithms require message lengths to be
>> +	 * multiples of block size.
>> +	 * TODO: The spec says AES CBC mode for certain versions
>> +	 * of crypto engine can handle partial blocks as well.
>> +	 * Test and enable such messages.
>> +	 */
>> +	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
>> +		if (!IS_ALIGNED(req->cryptlen, blocksize))
>> +			return -EINVAL;
> 
> CBC by definition only operates on full blocks, so the TODO doesn't make sense.
> Is the partial block support really CTS-CBC?

Ya you are right. It should be CTS-CBC and not AES CBC. Though the spec 
is quite fuzzy about this part.

I can remove the comment and spin the next version or just leave it 
there for now and remove it later.

> 
> - Eric
> 

-- 
Warm Regards
Thara
