Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF21935684D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbhDGJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350270AbhDGJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:46:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA42C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:46:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b133-20020a1c678b0000b02901231346381dso817258wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gtSTu4ozECxUjEi0hKFQnozmLfj1cbDOGz3NG1Yhu3c=;
        b=UqZgo5srz7oGoMxxgJ10mhX7JsO0z0SVItepKoCMYAQZUhY27Yn5ezBBWj8D/9kbfQ
         pvcsWNLEKza4owVAznW0kVeLGbt2za/N45X1EZATFwCnqfnVXGqeZoPNsehU69enpEUt
         sVYVmZuVnXpIIITcdDAbVLp/I3HOAb+TLb6tkvkWV8XNmiYR/H750GZAQxmOFIurbU8i
         0pl2Oz5V8lUJWfDgpgzCY74GtxL3D3ctj1EcpXdlW0Hp97rVK/vpaweS2o6GUu+4y2TX
         JUVNrXppAA6W2BmA5FyIrS1hVPBVF1zKaZdjUGcp+Zgbsjsk8ReRByPTfxOvuabO5pe3
         vpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gtSTu4ozECxUjEi0hKFQnozmLfj1cbDOGz3NG1Yhu3c=;
        b=CqgmgoGQnORWk5n3ZXoouSbsq2j3CPcuoYo2wM6wHDSEhIfnrCR+8sLjzLzpVF05rk
         Sf14c7BO7Hxw0cFw1R8uq4+J3whQMY8ybioj9J9KcxWqQ4ohNOHOvAiZcDCzVM9MqwG7
         Gqg5atBukrJ/0HA7X5+2vFntGmM0x+b395mrIwpddWEXidYSeVga0VbzhzvwXRPZqT4S
         9rpKO+P+z4czaiH3m/bHC9hCbyYcawsUvQGzJD3s1dwbYmrxnsfgMvkCZSbsFEzMYl9P
         iB2zFBX0Pu76JskH/H3iRe06BbyJVH5KwS4LLz03oo0fYWkGho7lDJEMEogwJSsstoCH
         JwtQ==
X-Gm-Message-State: AOAM531hC5IZ6fQmTde4BdhsQPV2TRVA2dyicCligYY/TSK9BsWwFaC4
        MQzAE7q8h8Ge4NvkXc4wopU=
X-Google-Smtp-Source: ABdhPJxa6CeE6bwXYczYWLQhg3liK3Wt8T5rNe9DbMzAKV+LoZqDY9T7pvhkRivjSiJAQhFe5QxmsA==
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr2302414wme.64.1617788784569;
        Wed, 07 Apr 2021 02:46:24 -0700 (PDT)
Received: from ?IPv6:2001:818:de85:7e00:ef5c:3f2a:a646:d6ec? ([2001:818:de85:7e00:ef5c:3f2a:a646:d6ec])
        by smtp.gmail.com with ESMTPSA id r5sm1719060wrx.87.2021.04.07.02.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 02:46:24 -0700 (PDT)
Subject: Re: [RESEND PATCH] staging: emxx_udc: Ending line with argument
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
 <YGy4LXHBrBb/r3dk@kroah.com> <4c7df741-4e73-2ac4-f0d8-c9513ae29c88@gmail.com>
 <YG1FI38zNbidjt9q@kroah.com> <4d7ebe9c-8ebc-2fc9-10ed-6756ab42d5d7@gmail.com>
 <YG1usolTNEOfDqXh@kroah.com>
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Message-ID: <e7a18709-0b26-751e-6ba4-b43dd89c203f@gmail.com>
Date:   Wed, 7 Apr 2021 10:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YG1usolTNEOfDqXh@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 07/04/21 09:34, Greg KH escreveu:
> On Wed, Apr 07, 2021 at 09:16:44AM +0100, Beatriz Martins de Carvalho wrote:
>> Em 07/04/21 06:37, Greg KH escreveu:
>>> On Tue, Apr 06, 2021 at 09:00:07PM +0100, Beatriz Martins de Carvalho wrote:
>>>> Em 06/04/21 20:36, Greg KH escreveu:
>>>>> On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
>>>>>> Cleans up check of "Lines should not end with a '('"
>>>>>> with argument present in next line in file emxx_udc.c
>>>>>>
>>>>>> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
>>>>>> ---
>>>>>>     drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>>>>>>     1 file changed, 4 insertions(+), 7 deletions(-)
>>>>> Why is this a [RESEND] ?
>>>>>
>>>>> What happened to the first version?
>>>> Sorry, I didn't receive your review, and in kernelnewbies tutorial, they say
>>>> if not receive a response, may have missed the patch, so I resent it.
>>> Do you have a pointer to your previous patch in the lore.kernel.org
>>> archives anywhere?  I can't seem to find it.
>>
>> I found this, it's what is you need?
>>
>> https://lore.kernel.org/linux-staging/20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com/
> Ah, yes, I saw Julia's review and assumed you would fix up your patch
> based on her comments.  Please do not ignore review comments, it makes
> everyone's lives harder.
Sorry, I didn't fix up my patch based on her comments, because to do 
this was
to revert all my patch or will break a code line if I remaining within 80
characters. How the code line still stays between 85 or 90 I assumed 
that was
ok, so I was waiting for your review. Now I saw that I should send this 
answer
to her. What should I do with the patch?

Thank you for all reviews, I'm learning a lot about how to do a good
contribution and the importance of answer all reviews.
> thanks,
>
> greg k-h
Beatriz Carvalho
