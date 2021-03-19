Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548034289F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCSWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCSWTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:19:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:19:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b184so6846815pfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BD+VfRoydYrASGxg5Ib4qr6UrU6U/TzxczcWIWtTd2s=;
        b=AQkkLPNSB1VNXqWlemjOZHstfRJukntygckumgr2Qc/6PAkghOVuvexja+Dclo8FDC
         ry5Z2K5ocBXAWKrGoHkSjuIpB5H3jdf/WLgaN+N6p9oRAU9Z/J6gkKNIN5r9UJWXtflF
         YIfxYHjiUFbu99Kulmpp6aYKiTUP1IBuLWiy5xE35OPotaWW8DhtWyWqz+y88r9tx8/p
         TzXlN7CyaBwrifYehdlq3Ni9RqDPfwax3/WTgWWllFI4oHezSjyYFcY31FqqJ2NA7SZ/
         jo+VB0hKqQ/4Om87+i9vJ9Jwtpjmfjav9Ij8N8Lpt3qFsEBqknmbua3Gm2ajDkIoK9du
         qn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BD+VfRoydYrASGxg5Ib4qr6UrU6U/TzxczcWIWtTd2s=;
        b=cBWK/q02drN+ipG+o8rVCNBE6HLoHU6HQLqDnmOCZS+0QL+chSizrohXBLdFKYmo4q
         xsb2c+m3esj6i/IAq8HuDkJ84//pCLlApwyYpz9livQLC11RgVTQi030KubkM3nu0UXB
         v7S4NzwY0swZTaroiIowRKutF/x/ETdjOw48MM/kem4xH6deBRkcV7KJAMXavm/MJ3h3
         W7kFT+VDW6tpeCKbLp8IepHGvG/iVUO8hWYDH0CBsAvBQyaP0uLD0z5cvENTAzYRJBBZ
         Wbz/2K8oZ5CQrzVHhmTqbxDHgS2QiWLF5ubrdNCXtM0xG5FEebhG8dP38UBFzbIKByQm
         8I6w==
X-Gm-Message-State: AOAM533pKp0sb/UTZx2b0U/ewzLpqO8we+FFVKyIMsrnkTWAZnZR8OpX
        KYFPTma0Amh1VD3we7Wwuvf56w==
X-Google-Smtp-Source: ABdhPJw31H1VtA23Jfjq7QX+DBSiPfCHLpFatd+t/WMmugwJoo1ksfu//ATzunSwobsq8NVVwfptQA==
X-Received: by 2002:a63:2349:: with SMTP id u9mr4725583pgm.361.1616192390004;
        Fri, 19 Mar 2021 15:19:50 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q66sm6578761pja.27.2021.03.19.15.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 15:19:49 -0700 (PDT)
Subject: Re: [PATCH V3] blk-mq: Trivial typo fix and sentence construction for
 better readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210319202359.8893-1-unixbhaskar@gmail.com>
 <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk> <YFUMFBB8iuoSULxL@Gentoo>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <080d3720-3174-e47f-95a1-ad7640a64051@kernel.dk>
Date:   Fri, 19 Mar 2021 16:19:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFUMFBB8iuoSULxL@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 2:39 PM, Bhaskar Chowdhury wrote:
> On 14:27 Fri 19 Mar 2021, Jens Axboe wrote:
>> On 3/19/21 2:23 PM, Bhaskar Chowdhury wrote:
>>>
>>> A typo fix and sentence reconstruction for better readability.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>>   Changes from V2:
>>>   Thanks, Randy and Tom for the suggestion,mould it.
>>>   Missed the subject line prefix of pattern,so added back
>>>
>>>  block/blk-mq-tag.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 9c92053e704d..9da426d20f12 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>>  }
>>>
>>>  /**
>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>> - * complete funtion is run
>>> + * blk_mq_tagset_wait_completed_request - wait until all the req's
>>> + * functions completed their run
>>
>> This is still nonsense, see reply to previous version.
>>
> Well, I was just trying get a sense of your sense...so ...it's all yours
> fella,take on ...

It's not my sense, I didn't write that function or comment. Just seems
pointless to me to update it and not get it actually legible and
correct, which is why I sent you a suggestion to what should be. From
that point of view, the suggested change actually makes it _worse_,
because "requests functions completed their run" doesn't mean anything.
At least the current one is kind of legible, since the "complete
function" refers to the IPI completion function, which is what we're
waiting for here.

In any case, what I replied in v2 should be generally readable, and
avoids the weird req's thing too which I really dislike. Just uses
requests, that's correct and avoids a nonsensical possessive.

So do send a v4 if you want with that wording.

-- 
Jens Axboe

