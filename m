Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96A1329FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbhCBDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbhCAUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:52:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF279C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 12:51:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so9387146wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3TCiyD0sBiky8Yki0GxnMn5W+L9plvRMksgNQ+SKsA=;
        b=KpgyPpbxJxYPvkbOYBUSlByQdJUFM4zA6QwGayo3tdYWFdziET4lC7mkE8uq7UjhHW
         vvhkS5JlPCspbTLI0he4AlwsjBswXex2Z80a+5n0CQpwX42ra1ulg8ZZk1Ctc1ML+++l
         U23HJLdQ441xEN4M6BQTYe8+ieabXJLOIognwv7dc/zwHgGVDlFm8UjO5OhIgEOJ2D1i
         b2Gr28TKCNwUApkNlZCDeeeykhdYIcoQfYF4y/e0lHJRXkQlbZJaYj9NFgxGJa++KIwC
         YhO8XsStPmF6ijNHUvhVg5W+h0/o8+W49fpJydpdRE7extm4EeWaErMdnCnNbSHmK0gF
         7z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3TCiyD0sBiky8Yki0GxnMn5W+L9plvRMksgNQ+SKsA=;
        b=F4cKwru6oO088y78kA7ooleqpXDBi6RJws7q/x9ZXrZMGf9aaL2L5ljI4aVnNgIKvc
         rIjZrZEWPBkrUu0AHEcjO0hBbD31ASt3j/gTfwroEkCWTl0ucvB4dF9OL4sZ1qzrKd8w
         C9zWI0SbYNriLfI+GWi/EU8JHE+qpVuzTv9IExdIi2B2qWFtDbmkcPajVyZSLtIgTEeo
         nHcSsi4KW8OXzZ4MsB5MBeu9d1zficeR8PY2xlK8ISOfRoKyEfL7QYGKohpNE4ZuK4s6
         ZZ/O6AP7EWL2z/7FeBlIdlbjnsSK1HCOC6zSHgBIrToZMbjxvwyez4G/w/iriwAshtiN
         KY8A==
X-Gm-Message-State: AOAM530HS5IN+BcbgM7iMWvzqjN7wzYq63zGLQ7eTHP//+CzZ4UmiFlG
        wL9QT0aEu/E3sjPcKQjtpcJSaFAY0PXHh8BA
X-Google-Smtp-Source: ABdhPJyLhr8w3VQcYYwA/FpQA+GcbBcxKp+nZJpO3kIgRuJYrzldqVnPoqHwYBT2HHyIu4NpGSMq2w==
X-Received: by 2002:adf:b749:: with SMTP id n9mr18536547wre.267.1614631918256;
        Mon, 01 Mar 2021 12:51:58 -0800 (PST)
Received: from [192.168.190.215] ([94.136.13.132])
        by smtp.gmail.com with ESMTPSA id h2sm30893843wrq.81.2021.03.01.12.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 12:51:58 -0800 (PST)
Subject: Re: [PATCH] crypto: expose needs_key in procfs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210301165917.2576180-1-christoph.boehmwalder@linbit.com>
 <YD02vJhFkFiARX0q@gmail.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Message-ID: <e82c30b0-e96f-d5cd-f7a3-d97f4e049b83@linbit.com>
Date:   Mon, 1 Mar 2021 21:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YD02vJhFkFiARX0q@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.21 19:47, Eric Biggers wrote:
> On Mon, Mar 01, 2021 at 05:59:17PM +0100, Christoph Böhmwalder wrote:
>> Currently, it is not apparent for userspace users which hash algorithms
>> require a key and which don't. We have /proc/crypto, so add a field
>> with this information there.
>>
>> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>>
>> ---
>>   crypto/shash.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/crypto/shash.c b/crypto/shash.c
>> index 2e3433ad9762..d3127a0618f2 100644
>> --- a/crypto/shash.c
>> +++ b/crypto/shash.c
>> @@ -477,6 +477,9 @@ static void crypto_shash_show(struct seq_file *m, struct crypto_alg *alg)
>>   	seq_printf(m, "type         : shash\n");
>>   	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
>>   	seq_printf(m, "digestsize   : %u\n", salg->digestsize);
>> +	seq_printf(m, "needs key    : %s\n",
>> +		   crypto_shash_alg_needs_key(salg) ?
>> +		   "yes" : "no");
>>   }
>>   
> 
> Do you have a specific use case in mind for this information?  Normally, users
> should already know which algorithm they want to use (or set of algorithms they
> might want to use).

I have a pretty specific use case in mind, yes. For DRBD, we use crypto 
algorithms for peer authentication and for the online-verify mechanism 
(to verify data integrity). The peer authentication algos require a 
shared secret (HMAC), while the verify algorithms are just hash 
functions without keys (we don't configure a shared secret here, so 
these must explicitly be "keyless").

Now, we also have a solution which sits on top of DRBD (LINSTOR), which 
resides purely in userspace. We recently implemented a feature where 
LINSTOR automatically chooses the "best" verify algorithm for all nodes 
in a cluster. It does this by parsing /proc/crypto and prioritizing 
accordingly. The problem is that /proc/crypto currently doesn't contain 
information about whether or not an algorithm requires a key – i.e. 
whether or not it is suitable for DRBD's online-verify mechanism.

See this commit for some context:
https://github.com/LINBIT/drbd/commit/34ee32e6922994c8e9390859e1790ca

> 
> Also, what about algorithms of type "ahash"?  Shouldn't this field be added for
> them too?

You're right. Since we only work with shash in DRBD, I blindly only 
considered this. I will add the field for ahash too.

> 
> Also, what about algorithms such as blake2b-256 which optionally take a key (as
> indicated by CRYPTO_ALG_OPTIONAL_KEY being set)?  So it's not really "yes" or
> "no"; there is a third state as well.

Correct me if I'm missing something, but crypto_shash_alg_needs_key reads:

static inline bool crypto_shash_alg_needs_key(struct shash_alg *alg)
{
	return crypto_shash_alg_has_setkey(alg) &&
		!(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY);
}

So this already accounts for optional keys. It just returns "no" for an 
optional key, which seems like reasonable behavior to me (it doesn't 
*need* a key after all).

Another option would be to make it "yes/no/optional". I'm not sure if 
that's more desirable for most people.

> 
> - Eric
> 
Thanks,
--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
