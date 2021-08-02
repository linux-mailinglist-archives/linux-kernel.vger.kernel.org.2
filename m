Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092D33DD224
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhHBIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:40:16 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:33371 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhHBIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:40:15 -0400
Received: by mail-ej1-f41.google.com with SMTP id hs10so20980997ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zz03E5xQt7p2VN7cWkxfZkNKl6W24aLbb5bhnlK6M/Y=;
        b=Jm0brBbCmMb45NvKIjlUpEMQ42Tv6H+X/Kw9HLYIZ9V1osF8QTDNxQjBN/UYR/qsUl
         ++Q8mAX9AyUpX1MM83+ua0nlgLG875tKooq4scFrK06v0FtfyMDr94Bp/t64pxjWEMN2
         Q+1wuWyThovdVUzGM16zHhSnB/d4WYw/K2WSSkG7wjZyrS9rnxQpM2JrFBCTkt/wRXo/
         EuLMOCVaUKaQVMSELZW18Ur7MkUzlAr/gAi/PjNxJgFv6SuAKyzgXZthagzchjBNFv7x
         j6rtkzOegKbT+c1/mV24ODura6q44Id+bP7LFP0PTc86n8/LCfENIQ9ynSKT+M8xBg9o
         kZKw==
X-Gm-Message-State: AOAM532R5+KxvYwXXEk+mSeAsKiQHEeMeAfE1wQrOVpfAxmZ7YSEMmQu
        MbhBZbb6V/0iFYcRWMWOjZU=
X-Google-Smtp-Source: ABdhPJwNQd3t1Hni44DinFugXrDzcKsPIzaWgkeB9qalXL+5uv984oWzkAMVLlGBGUqmkB7JpErwhg==
X-Received: by 2002:a17:906:3048:: with SMTP id d8mr14693966ejd.534.1627893604790;
        Mon, 02 Aug 2021 01:40:04 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id n10sm4284468ejk.86.2021.08.02.01.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 01:40:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] virtio-console: remove unnecessary kmemdup()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, osandov@fb.com
References: <20210801051655.79048-1-xianting.tian@linux.alibaba.com>
 <b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org>
 <5ad81a0e-fbb2-a849-6db7-f5718633d282@linux.alibaba.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a2598ec9-7bc9-be42-bcab-fa19c9e734f7@kernel.org>
Date:   Mon, 2 Aug 2021 10:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5ad81a0e-fbb2-a849-6db7-f5718633d282@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 21, 10:32, Xianting Tian wrote:
> 
> 在 2021/8/2 下午3:25, Jiri Slaby 写道:
>> Hi,
>>
>> why is this 2/2? I seem (Lore neither) to find 1/2.
> You didn't receive 1/2?
> [PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
> https://lkml.org/lkml/2021/8/1/8 <https://lkml.org/lkml/2021/8/1/8>

Oh, I did, but it's not properly threaded. PLease fix your setup.

>> On 01. 08. 21, 7:16, Xianting Tian wrote:
>>> hvc framework will never pass stack memory to the put_chars() function,
>>
>> Am I blind or missing something?
>>
>> hvc_console_print(...)
>> {
>>   char c[N_OUTBUF]
>> ...
>>   cons_ops[index]->put_chars(vtermnos[index], c, i);
>>
>> The same here:
>>
>> hvc_poll_put_char(..., char ch)
>> {
>> ...
>>    n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>>
>> AFAICS both of them *pass* a pointer to stack variable.
> 
> yes, I discussed the issue with Arnd before in below thread,  you can 
> get the history, thanks
> 
> https://lkml.org/lkml/2021/7/27/494 <https://lkml.org/lkml/2021/7/27/494>

So is this a v2? You should have noted that. And what changed from v1 too.

>>> So the calling of kmemdup() is unnecessary, remove it.
>>>
>>> Fixes: c4baad5029 ("virtio-console: avoid DMA from stack")
>>
>> This patch doesn't "Fix" -- it reverts the commit. You should've CCed 
>> the author too.
> 
> yes, we discussed ther issue in above thread, which we CCed the author.

I don't see any input from the author?


Anyway, 1/2 does not even build, so you will send v3 with all the above 
fixed, hopefully.

thanks,
-- 
js
