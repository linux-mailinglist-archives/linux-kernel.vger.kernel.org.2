Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693CB3220F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBVUwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhBVUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:52:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79805C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:51:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q7so14821144iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kuUm+XwaOMq3E6+R97zywmgPDYZMExhRWYsNZ2tzM1k=;
        b=fshLji8N5sLxudDYL0zctHxlngBXio5EBB4HIyt9yiFXqb1lvBv7Hbg+a7SdaXnU92
         t0Z88p6rhVp/LijwWirktql4JIJkb3Keslasl6Nr4g75JqqmbL+wXydCnu7Ugt6pdfTv
         qTcfLe0SVAhU+urDYqQa/2mcMfm2rDU+5gpBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kuUm+XwaOMq3E6+R97zywmgPDYZMExhRWYsNZ2tzM1k=;
        b=OSyaQgE7tQojhmaeHZcdcVNjLEYtDvNTBSyczH0GSELBGojfx6byqWfeNQO9lodLBW
         ozjwO3yJvfPYbYc6c2bAFqTXdQKTsLZebvOrNULjYnoXrRc0FuwAKYazDArHw8/Y1moE
         gITQ9tAzCdGJVmA4rRW+/DGej5jZpsPTwZ6ONCigGkz48NmQ3WAYpIVjVfEN7bshRfCW
         Mt1iHDR+c54EdfOVD2ikvYO4911q2qf76eSWMBAWxvQXV4ySTE7hITwT/0D6abn5YTap
         2rdi1sHscLQF5p+KAucGL8dr8wvaNi9KqG2nldug54NlAcoG/kiEwiUNEM8u814LideH
         Q66g==
X-Gm-Message-State: AOAM530014E9Lbbulfv3XXPHL+7QbcUl71x0TYDI+D5QrghG6lhbRGjT
        ZFenZf1sPE1nRCRdEulwC6o1yQ==
X-Google-Smtp-Source: ABdhPJwzv6hjO87ytJYuheqlXuPEKrgLDRMEEqLMjH49Kte3lJoKPb495/7/SFdW8rMylcM2rbxG/A==
X-Received: by 2002:a5e:dd46:: with SMTP id u6mr14196077iop.73.1614027118926;
        Mon, 22 Feb 2021 12:51:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d12sm12524039ila.71.2021.02.22.12.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 12:51:58 -0800 (PST)
Subject: Re: [PATCH 1/2] lockdep: add lockdep_assert_not_held()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1613171185.git.skhan@linuxfoundation.org>
 <37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org>
 <YCljfeNr4m5mZa4N@hirez.programming.kicks-ass.net>
 <20210215104402.GC4507@worktop.programming.kicks-ass.net>
 <79aeb83a288051bd3a2a3f15e5ac42e06f154d48.camel@sipsolutions.net>
 <YCqbehyyeUoL0pPT@hirez.programming.kicks-ass.net>
 <eb819e72fb2d897e603654d44aeda8c6f337453f.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c9293180-3eba-a5f3-b34e-b44ebdd60077@linuxfoundation.org>
Date:   Mon, 22 Feb 2021 13:51:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <eb819e72fb2d897e603654d44aeda8c6f337453f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 9:10 AM, Johannes Berg wrote:
> On Mon, 2021-02-15 at 17:04 +0100, Peter Zijlstra wrote:
>> On Mon, Feb 15, 2021 at 02:12:30PM +0100, Johannes Berg wrote:
>>> On Mon, 2021-02-15 at 11:44 +0100, Peter Zijlstra wrote:
>>>> I think something like so will work, but please double check.
>>>
>>> Yeah, that looks better.
>>>
>>>> +++ b/include/linux/lockdep.h
>>>> @@ -294,11 +294,15 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
>>>>   
>>>>   #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
>>>>   
>>>> -#define lockdep_assert_held(l)	do {				\
>>>> -		WARN_ON(debug_locks && !lockdep_is_held(l));	\
>>>> +#define lockdep_assert_held(l)	do {					\
>>>> +		WARN_ON(debug_locks && lockdep_is_held(l) == 0));	\
>>>>   	} while (0)
>>>
>>> That doesn't really need to change? It's the same.
>>
>> Correct, but I found it more symmetric vs the not implementation below.
> 
> Fair enough. One might argue that you should have an
> 
> enum lockdep_lock_state {
> 	LOCK_STATE_NOT_HELD, /* 0 now */
> 	LOCK_STATE_HELD, /* 1 now */
> 	LOCK_STATE_UNKNOWN, /* -1 with your patch but might as well be 2 */
> };
> 
> :)
> 


Thank you both. Picking this back up. Will send v2 incorporating
your comments and suggestions.

thanks,
-- Shuah





