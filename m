Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDF31EA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBRNbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:31:14 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34695 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhBRLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:45:04 -0500
Received: by mail-wr1-f53.google.com with SMTP id n4so2641642wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uWo8yYtqo2c4AZiM2olPLzWcrY1h7XAQLSU0dGJI4kA=;
        b=RDOTwqCnTC9F35E766XQnPuTCufIsc82xU7gDfvx8h+LQ4JA80x9RqoAf3dg+5tx7q
         0OMtDe4TmfPB47IWXQRZFKrcT47jKHxyGU0HHx2g2rL9K2MRP2J1mfPUw0QPe6LM9r0U
         NUhV6FKiwSSRowNUBQgNd8p504R+hVuff7XPzQvam7cibmbeMEVtPtH0TK2XJ9FgYlQr
         qY3gLnl2SJOgm4gNkJ1ltbbur5KXItn7+tma5UJQzzJ8y5xHwO22AYpQRiy7ac2btLmS
         qlYJHjJVqgjw3bl5hVdBxODvXmB/nBHgAHDUp5cGXlkpyzH9ta4v/NlgmkcvefY9KBXT
         ZNgw==
X-Gm-Message-State: AOAM530AhK4Iiy0cH0GXnpw7bFJ3Eb/NCIDkaCEQxU6wJ1JJBNR7IlxW
        YwvLgaMR9KRfVpkUflD1mZKJ264XjqUtBA==
X-Google-Smtp-Source: ABdhPJyyyfx53LASkeMjm2MZ/hol4PtA4yAuCP6z46pGk0DYkwDnQ4+aNNqGFnD6DAz+mzYm0ZJkcQ==
X-Received: by 2002:a19:6b19:: with SMTP id d25mr2305731lfa.82.1613648038111;
        Thu, 18 Feb 2021 03:33:58 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id b11sm576394lfi.174.2021.02.18.03.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 03:33:57 -0800 (PST)
Subject: Re: [PATCH] coccinelle: misc: add swap script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210216080133.455456-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
 <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com>
 <alpine.DEB.2.22.394.2102181114380.2748@hadrien>
 <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
 <alpine.DEB.2.22.394.2102181227230.2748@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <afd7f80a-90c9-9d05-cc78-aacc5495174b@linux.com>
Date:   Thu, 18 Feb 2021 14:34:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102181227230.2748@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/21 2:29 PM, Julia Lawall wrote:
> 
> 
> On Thu, 18 Feb 2021, Denis Efremov wrote:
> 
>>
>>
>> On 2/18/21 1:17 PM, Julia Lawall wrote:
>>>
>>>
>>> On Thu, 18 Feb 2021, Denis Efremov wrote:
>>>
>>>>
>>>>
>>>> On 2/18/21 12:31 AM, Julia Lawall wrote:
>>>>>> +@depends on patch@
>>>>>> +identifier tmp;
>>>>>> +expression a, b;
>>>>>> +type T;
>>>>>> +@@
>>>>>> +
>>>>>> +(
>>>>>> +- T tmp;
>>>>>> +|
>>>>>> +- T tmp = 0;
>>>>>> +|
>>>>>> +- T *tmp = NULL;
>>>>>> +)
>>>>>> +... when != tmp
>>>>>> +- tmp = a;
>>>>>> +- a = b;
>>>>>> +- b = tmp;
>>>>>> ++ swap(a, b);
>>>>>> +... when != tmp
>>>>>
>>>>> In this rule and the next one, if you remove the final ; from the b = tmp
>>>>> line and from the swap line, and put it into context code afterwards, them
>>>>> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
>>>>> function xfs_lock_two_inodes where two successive swap calls are
>>>>> generated.
>>>>>
>>>>> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
>>>>> the function ath5k_hw_get_median_noise_floor where the swap code makes up
>>>>> a whole if branch.
>>>>
>>>>> In this cases it would be good to remove the {}.
>>>>
>>>> How this can be handled?
>>>>
>>>> If I use this pattern:
>>>> @depends on patch@
>>>> identifier tmp;
>>>> expression a, b;
>>>> @@
>>>>
>>>> (
>>>>   if (...)
>>>> - {
>>>> -       tmp = a;
>>>> -       a = b;
>>>> -       b = tmp
>>>> +       swap(a, b)
>>>>         ;
>>>> - }
>>>> |
>>>> -       tmp = a;
>>>> -       a = b;
>>>> -       b = tmp
>>>> +       swap(a, b)
>>>>         ;
>>>> )
>>>>
>>>> The tool fails with error:
>>>>
>>>> EXN: Failure("rule starting on line 58: already tagged token:\nC code
>>>> context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574,
>>>> column 4, charpos = 41650\n around = 'sort',\n whole content =
>>>> \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c
>>>
>>> A disjunction basically says "at this node in the cfg, can I match the
>>> first patter, or can I match the second pattern, etc."  Unfortunately in
>>> this case the two branches start matching at different nodes, so the short
>>> circuit aspect of a disjunction isn't used, and it matches both patterns.
>>>
>>> The solution is to just make two rules.  The first for the if case and the
>>> second for everything else.
>>>
>>
>>   if (...)
>> - {
>> -       tmp = a;
>> -       a = b;
>> -       b = tmp
>> +       swap(a, b)
>>         ;
>> - }
>>
>>
>> This produces "single-line ifs".
>> Maybe generated patches can be improved somehow?
>> Moving -+; doesn't help in this case.
> 
> There is clearly some problem with the management of newlines...
> 
> The other alternative is to just have one rule for introducing swap and
> another for removing the braces around a swap, ie
> 
> if (...)
> - {
>   swap(...);
> - }
> 
> I don't think it would be motivated to remove the newline in that case.

Yes, this works. I'll send v2.

Thanks
