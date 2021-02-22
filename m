Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C743221D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBVVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhBVVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:54:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:53:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w18so5439050plc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YMNvXqgDpF9HouPg0QcLn/+RJ1NLhHHsUE+Y7c84cLA=;
        b=eebvjb9yQvYQdCeHjY4g5/xqHcvnglVajV32ANntQFrVgWJwDB2Lb2J0Ong5RypA7k
         mY4k5AWYn5ruIaugQY5HC6RtLt3Ozxw0PRAUN7XJH6/dUqjLkCmYROnrhgRMYfiKF2qS
         zij6nFynsN1laRn/t3rVOriNocrcvRfujLxeyWkRZUjhPFgh801kCDrukEUFx8i0ltpR
         PNPlFSIyI2aiyTWm8waIw+ul+IWGJSBi3i9c7dqUBeVtVh36ImQ2AZhjIk/f6pE5AxdR
         FMyNFoaUHZcrrQuTNFOAV+BEggnAvCsv+aqfFjZPYAtIvJ+xny55BuXCYEvfUyC//LfX
         b03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMNvXqgDpF9HouPg0QcLn/+RJ1NLhHHsUE+Y7c84cLA=;
        b=UNXpH55K2SYK+ga7DZz7E1lalV1PUL/tXEQQmJ53q6P9emNBlvliig/qBDxE53MG61
         Y1zZq77dVJ9Xxq2kvK1cu0u/9Az+aLLrjxM4/yJenCgkdcR6atvoGmCLRpI6TP7TbYIV
         oRwLDs/lJwtL6Jn8aUdHijJ8yUTrFmWSVZmvpCZWJDbqdJErlyNX50TR2gjvgyGFpywM
         3p3cktkiTsEpdw5e6/cYiOgzDcIqpgzys4XVNjg9rPuHT9eUNVk1sI08L/xz139iZb/o
         4N2ElOomlXLi3CqDkG+/mfyTdnc/w8VlVsLHXZSRdmjDAwMfMSqKbpIdJIAdOmwjzzwF
         AEPA==
X-Gm-Message-State: AOAM532qzkwot62aue04e5wRKI9dPrCOeTqtr1EoL+jBB4uXgrEGX2AV
        mfL2EwoGqIKNjJfN7Ulb3dtdpoKEo0skJA==
X-Google-Smtp-Source: ABdhPJybfVstV/OkAVQrDqetgnsgPPHCADZWxR4X31Fvu32w10ROYhrX5ovvEP/qzSVB3h7uj5j5pQ==
X-Received: by 2002:a17:90a:df8a:: with SMTP id p10mr12634093pjv.4.1614030837668;
        Mon, 22 Feb 2021 13:53:57 -0800 (PST)
Received: from ?IPv6:2600:380:493c:45f7:fe5e:b489:9535:921e? ([2600:380:493c:45f7:fe5e:b489:9535:921e])
        by smtp.gmail.com with ESMTPSA id o185sm20374834pfb.196.2021.02.22.13.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 13:53:57 -0800 (PST)
Subject: Re: [PATCH] percpu_counter: increase batch count
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk>
 <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org>
 <919b3aa5-7332-0817-3b70-4f20ae6410a8@kernel.dk>
 <alpine.LSU.2.11.2102221309570.4728@eggly.anvils>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5eea419a-e0b5-2652-3f35-5042d7925e23@kernel.dk>
Date:   Mon, 22 Feb 2021 14:53:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2102221309570.4728@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 2:31 PM, Hugh Dickins wrote:
> On Thu, 18 Feb 2021, Jens Axboe wrote:
>> On 2/18/21 4:16 PM, Andrew Morton wrote:
>>> On Thu, 18 Feb 2021 14:36:31 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
>>>> days is kind of silly as systems have gotten much bigger than in 2009 when
>>>> this heuristic was introduced.
>>>>
>>>> Bump it to capping it at 256 instead. This has a noticeable improvement
>>>> for certain io_uring workloads, as io_uring tracks per-task inflight count
>>>> using percpu counters.
> 
> I want to quibble with the word "capping" here, it's misleading -
> but I'm sorry I cannot think of the right word.

Agree, it's not the best wording. And if you can't think of a better
one, then I'm at a loss too :-)

> The macro is max() not min(): you're making an improvement for
> certain io_uring workloads on machines with 1 to 15 cpus, right?
> Does "bigger than in 2009" apply to those?

Right, that actually had me confused. The box in question has 64 threads,
so my effective count was 128, or 256 with the patch.

> Though, io_uring could as well use percpu_counter_add_batch() instead?

That might be a simpler/better choice!

> (Yeah, this has nothing to do with me really, but I was looking at
> percpu_counter_compare() just now, for tmpfs reasons, so took more
> interest.  Not objecting to a change, but the wording leaves me
> wondering if the patch does what you think - or, not for the
> first time, I'm confused.)

I don't think you're confused, and honestly I think using the batch
version instead would likely improve our situation without potentially
changing behavior for everyone else. So it's likely the right way to go.

Thanks Hugh!

-- 
Jens Axboe

