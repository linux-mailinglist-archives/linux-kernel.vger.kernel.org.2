Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D3A3426D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCSU0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhCSU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:26:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97BC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:26:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r17so4458483pgi.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DZnZz49iawE3OZlAe1Ih+YRDhBu+JzguYvzhzsJxLQQ=;
        b=BNgkduZW1CtflRKtlMGZvaKNp3OQC2y/o3lEnR9p4G43/wVO1iWiYNI//ZeUyPYczL
         JxQmlabl0+UevAMdYJDZyfLGANjBUf51GHntjCiG1Ll7BuJc1mBWROvSmfqvgA+I4jaA
         /JaHybC//mimlScpJ2Lyg4WyGYYV8k+iJNfjPO3RXIGJFVU3bz59Ckuf6Zl9B9DJPVBn
         QcRqoAx/KegyaaXpeu1TZvJK3hCUNvquczHAeEFDo4p8k/tuCstTLk3cLioExTXgLFQQ
         0yiTJIGQLSf1QENbMRBcl7Vly70ss8xDwGtelMH8m14fyyIHeXhZZujTRSvUHnoNaIaJ
         fZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZnZz49iawE3OZlAe1Ih+YRDhBu+JzguYvzhzsJxLQQ=;
        b=bFV20rgy0GzqZqICFYIxaLPCsRGw6EKH18GbEOliZ0MiTumEuLs8uz7WtuOFeKE2mX
         8CpN4FUm4DfYlMCxSTphuEA4MFJfXj6nxlYPdz9gcukAEbfdW0Wwra2j3XhdbGsyjtwn
         mjPE/IvJk2tOu7JddmzsyDwvy+62K0uOAlt12kddSoVwvRfrcHl2k9yBHv5g2BfsXoH+
         5Lt5uplqXu/r1q4gR4KoidHyzCFLfSU8edUbo0e32FlDAqKVyuBiaqKneuJJdy+pNRVG
         WG6hs/O/OigIgzZJbCL/VKzje3RPcMY/ljqpXeoG1Cj6Ravht8RM3REt7DRxG/r14kPa
         +Ddg==
X-Gm-Message-State: AOAM530wHCqfb5XtpaoCORR57kyAqOUxkgtBUaOWfTPOxj432DMxErB9
        MuIqvmuTAc3JxXpoijYEMawBFVuC/hWSKA==
X-Google-Smtp-Source: ABdhPJwgDCOD+fVy9f1NB/SJZgCnmAks8peYsEJrcP/owyjiSB2PNfW1J2EQu5hvf8JhzwJIV1mDaw==
X-Received: by 2002:a63:b12:: with SMTP id 18mr13052286pgl.45.1616185565830;
        Fri, 19 Mar 2021 13:26:05 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 197sm6306527pfc.1.2021.03.19.13.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:26:04 -0700 (PDT)
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@bombadil.infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319195451.32456-1-unixbhaskar@gmail.com>
 <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
 <YFUEgeN+oR9n8uoN@Gentoo>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbe0aede-d821-3d26-d8b0-999f0adb406d@kernel.dk>
Date:   Fri, 19 Mar 2021 14:26:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFUEgeN+oR9n8uoN@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 2:07 PM, Bhaskar Chowdhury wrote:
> On 13:03 Fri 19 Mar 2021, Randy Dunlap wrote:
>>
>> Hm, needs some spacing fixes IMO. See below.
>>
>>
>> On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:
>>
>>>
>>> s/funtion/functions/
>>>
>>> Plus the sentence reconstructed for better readability.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>> Changes from V1:
>>>  Randy's suggestions incorporated.
>>>
>>> block/blk-mq-tag.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 9c92053e704d..c2bef283db63 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>> }
>>>
>>> /**
>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>> - * complete funtion is run
>>> + * blk_mq_tagset_wait_completed_request - wait until all the  req's
>>
>>                                                             the req's
>>
>>> + *  functions completed their run
>>
>> and more indentation + wording on that line above:
>>  *        functions have completed their run
>>
> Apology...my bad ...fixing ...V3 ...in quick time ...

Easy, let's get this right instead of spinning tons of versions of a
trivial patch. The text should be:

Wait until all scheduled request completions have finished.

If we're fixing a typo, let's actually make it understandable too...

-- 
Jens Axboe

