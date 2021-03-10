Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B26334964
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCJVEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhCJVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:03:58 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C950C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:03:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d5so16928457iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7TZW3chgCc+0y/3+EkFW15rPjwwCaz9mJXTQWeD1vUQ=;
        b=PWkf509rM6EcQZyKCB1ZsQURZFNtObvpMLqMIN3cp+Yg1D+81Uszh+ROa6OLXIGtTL
         iVhjiMe/AclwMG6NfPsIgiiIIJKg+aL46Z9DysQqA/IjvYXTzgCSTVzNQ0l74mGzDj4h
         XvniMZkAVJf4Ka4YXgQVIBGLujvdV3Jbyb6XpDb3xCYAxcPghpUZkRpvGrOFJuBEvv8u
         A8q/B8twfLOWkq8T9jT8vu32T1C60RVhx5LJqKRw/fWlh76B17cxw7MtIBM/tUVkjtdy
         xC1fXnzp2dIsduGHTmyLx5qVN/wdEg8Eqr6ariI+Mscq18ExUw5psFnKA3eX0nylzb1u
         u+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TZW3chgCc+0y/3+EkFW15rPjwwCaz9mJXTQWeD1vUQ=;
        b=VIiH4tz2M2EQTx3nc5GZgg8/INUN460lx4AZHYjmPxp9GHmEWM2YnORWCbQMI4KcWc
         LaWuAqSW3zPLOZNL3PnNcGKsSeR0ZWXsgZtl2D1jzrXdxy5UvebP35Fhm8G8Rfckmzyc
         NiU4XD580xa/OpFTOO9SVaZQLsJCzrfgDaY9VhuCS79Yd/+Sk+fkfw03UtDwvXpQ2QXP
         EUkGXukYMj7+aTVMEw0mwme6pDMR/8bDU5ELhtWweg2eqAMzQdMZHd/RGpISjuM3aUCT
         fK7Can6avfITUJnR5vSh0CdzD5BQXwiTVio0bnb3J4lyPHsblnIrqaz37vAfMJ38zTyc
         fO3A==
X-Gm-Message-State: AOAM530Sa+iB5yktbOj+bIyrIuDYYDcsTmgMuWERt+houP+oN67xBl4r
        PeXAmB25FXtA3THIh/pI4XyCkYDNSJJpsw==
X-Google-Smtp-Source: ABdhPJwvOw39GBFFGko5CbEq/Ukp5Sw1DoVTkfQGboi5Nw01NeJZaWiYKOpO81ZLR7NeGmXLnqVHVQ==
X-Received: by 2002:a05:6e02:1bef:: with SMTP id y15mr1455387ilv.17.1615410237420;
        Wed, 10 Mar 2021 13:03:57 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m11sm334927iop.11.2021.03.10.13.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 13:03:56 -0800 (PST)
Subject: Re: -Walign-mismatch in block/blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
 <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
 <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
 <20210310205250.hpe4wcgn4yh3rjqz@archlinux-ax161>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9834f7fc-f4d2-2230-7e1f-9b607ea782de@kernel.dk>
Date:   Wed, 10 Mar 2021 14:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310205250.hpe4wcgn4yh3rjqz@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 1:52 PM, Nathan Chancellor wrote:
> On Wed, Mar 10, 2021 at 01:40:25PM -0700, Jens Axboe wrote:
>> On 3/10/21 1:33 PM, Nathan Chancellor wrote:
>>> On Wed, Mar 10, 2021 at 01:21:52PM -0700, Jens Axboe wrote:
>>>> On 3/10/21 11:23 AM, Nathan Chancellor wrote:
>>>>> Hi Jens,
>>>>>
>>>>> There is a new clang warning added in the development branch,
>>>>> -Walign-mismatch, which shows an instance in block/blk-mq.c:
>>>>>
>>>>> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
>>>>> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
>>>>> result in an unaligned pointer access [-Walign-mismatch]
>>>>>                 smp_call_function_single_async(cpu, &rq->csd);
>>>>>                                                     ^
>>>>> 1 warning generated.
>>>>>
>>>>> There appears to be some history here as I can see that this member was
>>>>> purposefully unaligned in commit 4ccafe032005 ("block: unalign
>>>>> call_single_data in struct request"). However, I later see a change in
>>>>> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
>>>>> cache layout") that seems somewhat related. Is it possible to get back
>>>>> the alignment by rearranging the structure again? This seems to be the
>>>>> only solution for the warning aside from just outright disabling it,
>>>>> which would be a shame since it seems like it could be useful for
>>>>> architectures that cannot handle unaligned accesses well, unless I am
>>>>> missing something obvious :)
>>>>
>>>> It should not be hard to ensure that alignment without re-introducing
>>>> the bloat. Is there some background on why 32-byte alignment is
>>>> required?
>>>>
>>>
>>> This alignment requirement was introduced in commit 966a967116e6 ("smp:
>>> Avoid using two cache lines for struct call_single_data") and it looks
>>> like there was a thread between you and Peter Zijlstra that has some
>>> more information on this:
>>> https://lore.kernel.org/r/a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk/
>>
>> Ah now I remember - so it's not that it _needs_ to be 32-byte aligned,
>> it's just a handy way to ensure that it doesn't straddle two cachelines.
>> In fact, there's no real alignment concern, outside of performance
>> reasons we don't want it touching two cachelines.
>>
>> So... what exactly is your concern? Just silencing that warning? Because
> 
> Yes, dealing with the warning in some way is my only motivation. My
> apologies, I should have led with that. I had assumed that this would
> potentially be an issue due to the warning's text and that rearranging
> the structure might allow the alignment to be added back but if there is
> not actually a problem, then the warning should be silenced in some way.

Right, that's what I was getting at, but I needed to page that context
back in, it had long since been purged :-)

> I am not sure if there is a preferred way to silence it (CFLAGS_... or
> some of the __diag() infrastructure in include/linux/compiler_types.h).

That's a good question, I'm not sure what the best approach here would
be. Funnily enough, on my build, it just so happens to be 32-byte
aligned anyway, but that's by mere chance.

-- 
Jens Axboe

