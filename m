Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB77E3676BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhDVBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhDVBYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:24:53 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A367C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:24:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso26630000otm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ozvREo55yzyTmh3+SdduMkSnhDPSnqzL0MqxxdtGMM=;
        b=KpqE9gEXwK0E801R2lpes0ehZGN59SzpZEIgNUxpw2yWfGtEb9GGFUuLQS/dk0ykov
         9ePEvlqk42ngQ/ymSNYiqyaVIzhDT5z6qYBnnT8PLnsFlBK3I9bxtIXlPKCX45LUKeVY
         5cu843YQ4/Y9mErbV2ZzcyAlOhTsoFL7SSpX9gCm7cK3GUQo37xNal87tHiRqKvjoo6Y
         W9+nsyytWxycOR4RLaPJ/eiJp8c36pqD5x9ee2Is1isWl06FIYMigV3gFQrkryssbWrn
         HeQ0/lhpNmDS5qvVSNteNhaXMscBihQD28kUQp8zHGUKx+KphV1r999s0B4i9GvVxMte
         OduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9ozvREo55yzyTmh3+SdduMkSnhDPSnqzL0MqxxdtGMM=;
        b=aebozu5j3pBuEBSyylRShK1PW82QHhxrJ81UNPDvOrqvAk6DA+nQvP5l3qgfXcV5bx
         84SZdQwE46KucNTXtle+RYmIhFIeE0us0YRrbmItg1bnFpAfgLSOACXbRA2mSlUdp8rK
         8cqqazm+wY4SRGTElBYCHvRDtjsEUY0Ni9EUSOoz5D2u7qFrv9FZBBq82LeOGh6a7SHa
         SEIdNWEiUJhYZnWM8Uon8bnn66lumM2pojE3Dp/TcRo64aNP1hpJRtq21s+0x9TgakXB
         oHGBUzLYMG92kMEZmgj3DP4bRp0noL1O6jyxKbiR1rEK6/ogWKTvglY9KpDD7TuKYa8e
         +s2w==
X-Gm-Message-State: AOAM5325Djimh8v+ttJm80tMmfc0hlbxF6Y3Kljpj7xrWoVwY6encHxs
        FHC61RwqCulXWh3OV/4N3MSm/Od86Qk=
X-Google-Smtp-Source: ABdhPJztbRnTk14VzVYP4IIxmG8VqFLcdAjo+tvny57irMkPJxdRBup/ay/y5rIfDYG1UhbacmIsKA==
X-Received: by 2002:a9d:664c:: with SMTP id q12mr773843otm.163.1619054659108;
        Wed, 21 Apr 2021 18:24:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm284836oob.12.2021.04.21.18.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 18:24:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] static_call: Fix unused variable warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20210422003334.139452-1-linux@roeck-us.net>
 <20210421204139.669f5c22@oasis.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6cccb650-9aef-f16c-7ec5-53d3042af292@roeck-us.net>
Date:   Wed, 21 Apr 2021 18:24:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421204139.669f5c22@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 5:41 PM, Steven Rostedt wrote:
> 
> Second patch with the exact same update. Perhaps we should take one
> before we get more of them ;-)
> 
> https://lore.kernel.org/lkml/20210416194300.3952208-1-cmllamas@google.com/
> 

Sorry, I missed the other one.

Guenter

> -- Steve
> 
> 
> On Wed, 21 Apr 2021 17:33:34 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> If CONFIG_MODULES=n, the following build warning is reported.
>>
>> kernel/static_call.c: In function ‘__static_call_update’:
>> kernel/static_call.c:153:18: warning: unused variable ‘mod’
>>
>> Mark the variable as __maybe_unused to fix the problem.
>>
>> Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
>> Reported-by: Zach Reizner <zachr@google.com>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  kernel/static_call.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/static_call.c b/kernel/static_call.c
>> index 2c5950b0b90e..8211a34251f8 100644
>> --- a/kernel/static_call.c
>> +++ b/kernel/static_call.c
>> @@ -150,7 +150,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>>  
>>  	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
>>  		bool init = system_state < SYSTEM_RUNNING;
>> -		struct module *mod = site_mod->mod;
>> +		struct module __maybe_unused *mod = site_mod->mod;
>>  
>>  		if (!site_mod->sites) {
>>  			/*
> 

