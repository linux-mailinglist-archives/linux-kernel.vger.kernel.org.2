Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F893B5D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhF1MCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhF1MCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:02:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:00:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r8so7177727wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OAAYW5OXFtT6zZRlw+ON+OvCdB1rmGdpZn4NmlmkWKo=;
        b=kudnq+g7bvQIO2zTBTx2crBmyW6PCd/k9FhBOAqff7d3xmvZZX3o2U5AW9vDW6aNv+
         8/LIMN2gpmlg5bVUsMwT2aqxLRdeKIgP9JnBYvhdajm5rUG6XZRebTgIzV2i2xzyuOSg
         3SQskbDr1cVLWGsTeFl/dVBlFY62kNKKvebwqS/G6eiw51omdX0ltqqAvFCGNSbRS6D6
         NxuAtDdqsfOviKv7iwVR+gikB/gugJ8d7JxhzPq44wa+3OpTTz6WqPcSm1PIb7GbV4PG
         lUUTOl4MPFxrTopn5PFqtqI1jGato/BtTn4SR3a3VsLP3e5xS8GNjWop75i5c39uppec
         1bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAAYW5OXFtT6zZRlw+ON+OvCdB1rmGdpZn4NmlmkWKo=;
        b=hanxHxUBhU6uUn6h+M2cRiV+pGk3eQptOV0uSAyTnLUj+QqiYnGlNqp6PofhBh4J1T
         +V+wfl0b48UUg5T2oGKmlnkHYKDuXqnLM3Gk8ebZI3SW+FPdqY4ckcdIBuQKuvzQVi0g
         rGJhFFx2ewFKeJ1XfWI4d6jVH+NJtDZFfquz2KQcKl3UE7BvWLaEjsSlSBfqPLJFwUj0
         4SwsKGCHpg5xqUUu1AGLvfQKXZt8PWkCcQFEgqzTuOJnRKD9jlJlsMjyNRxITFyDUyeg
         MJKBsilW3WTyJFKrnPvafXh0Lt7u+NfLK5u7KzEvsBLhbrb2yslCSTf4PNe8hTKJT/uU
         jS5Q==
X-Gm-Message-State: AOAM531lw8Lc2xKNkgsFyYEVG4r9KwTZq8nKgJFw9uPpmqDZmSmf/69F
        /tVaFKFXSnx/5bo5zHYZLdu19DYKgzM=
X-Google-Smtp-Source: ABdhPJzDgYrSFAUr8Nz3HuU8n9cxEc4DBNNm36mJL/hIuTlq2XF37hRw3lfI2cf8Vjp0HH5/EavFhw==
X-Received: by 2002:a5d:564c:: with SMTP id j12mr27119934wrw.37.1624881619504;
        Mon, 28 Jun 2021 05:00:19 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id o17sm17982413wmh.19.2021.06.28.05.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 05:00:18 -0700 (PDT)
Subject: Re: [RFC] strcpys(): New function for copying strings safely
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        glibc <libc-alpha@sourceware.org>
Cc:     "tech@openbsd.org" <tech@openbsd.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        drepper@gmail.com
References: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
 <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
 <f5bfab0dce604736b6a563a4f9f7ce43@AcuMS.aculab.com>
 <52e57bd5-0d04-4b4f-978a-8c1dbc08115c@gmail.com>
Message-ID: <d27912e6-f090-68af-295d-d40b00c1b0a7@gmail.com>
Date:   Mon, 28 Jun 2021 14:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <52e57bd5-0d04-4b4f-978a-8c1dbc08115c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 1:32 PM, Alejandro Colomar (man-pages) wrote:
>>
>> The other use is where you want a sequence of:
>>     len *= str_copy(dest + len, dest_len - len, src);
>> But don't really want to test for overflow after each call.
> 
> This is a legitimate use of strscpy().  Please, add it to glibc, as 
> there is no libc function to do that.
> 
>>
>> In this case returning the buffer length (including the added
>> '\0' on truncation works quite nicely.
>> No chance of writing outside the buffer, safe truncation and
>> a simple 'len == dest_len' check for overflow.
>>
>> OTOH there are already too many string copy functions.
> 
> There are, but because the standard ones don't serve all purposes 
> correctly, so people need to develop their own.  If libc provided the 
> necessary functions, less custom string copy functions would be 
> necessary, as Christoph said a long time ago, which is a good thing.
> 
> As I see it, there are the following, each of which has its valid usage:
> 
> strcpy(3):
>      known input && known buffer
> strncpy(3):
>      not for C strings; only for fixed width buffers of characters!
> strlcpy)3bsd):
>      known input && unknown buffer
>      Given that performance-wise it's similar to strscpy(),
>      it should probably always be replaced by strscpy().
> strscpy():
>      unknown input && truncation is silently ignored
>      Except for performance-critical applications,
>      this call may replace strcpy(3), to add some extra safety.
> strcpys():
>      unknown input && truncation may be an error (or not).
>      This call can replace strscpy() in most cases,
>      simplifying usage.
>      The only case I can see that strscpy() is superior
>      is for chains of strscpy(), where I'd only use strcpys()
>      in the last one (if any strscpy() in the chain has been
>      trunncated, so will the last strcpys() (unless it's "")).
> 
> 

BTW, for chains of str_cpy(), a strscat() and a strcats() function 
should probably replace chained strcpy()s, so it would be something like:

l = strscpy(n, dest, src);
l = strscat(n - l, dest + l, src2);
l = strscat(n - l, dest + l, src3);
...
if (strcats(n - l, dest + l, srcN, NULL))
	goto handle_truncation_or_error;

And the user should make sure that srcN is not "" unless he doesn't care 
about truncation.  Otherwise, check at every step.

I'll send my source code for strscat and strcats, if strscpy and strcpys 
are considered for addition.


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
