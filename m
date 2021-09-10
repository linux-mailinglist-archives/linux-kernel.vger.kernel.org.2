Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5783D406DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhIJPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:05:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:04:28 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bd1so3302680oib.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1pwlVxDkfCa0su9+pm6vroWkQFMoA+AryU161sjcxfk=;
        b=Upka5ZzTcAbnaXhLgktHI/hEk3sA+dwVQL8Kt+LeTHdDwSOL5teaXo51VLxQLrhTY0
         zHaWBnbao+/ZYQx7iQ8KNffO8Bwbw3ZrHKOfKEOWTxxgq+zd9iZ0xBxL2zkqLVuGUR6C
         3I1+nnsaV1qxKKvfek19l7XxI5oG5T1gDXUHzxFkcqwMbgCJD1MazII9eIFRVbqjJsXO
         IKiOtRNl9mjhkvh46uw34cfWYOwMduNhvPj40XmfrZaa2b96CUkLr8iDIYwlLZmWoFtc
         ooHZx5cKluVeam5DJudtqN6O9eSdqoCM3BIAn/oNpmSD+wPhZDmiiJ+yRcmjPefk7x/9
         n5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pwlVxDkfCa0su9+pm6vroWkQFMoA+AryU161sjcxfk=;
        b=j29v7LSptHKW1Dh41HfEgvIMQtojKuFbYfRGZiKRCMh1nwr5CSH4lBWwxCTOhmpPyP
         sNBGJvsSkD5Q4lMjLfXE908hQaCvnSXkxxzNQY5jH0hHA7w1WoyJL1D6u2RYXWDxCrIG
         SwONPKpxGajqSeoyfXrB45KSkvJiyRdjTHQFq4Dphk1QEUGpw/HmIrU7B1dqTbA7uOBs
         M9rRsS74LRrCqVg/hVIVyyjxnYJePkLJ+ghDNccPqkv/4bzR5KUUDNxJMMOl9t2wn9lW
         p4AcSJkWKV8C1v91BWV93GZhqSGXcx4Pp28wEUVS3Lmw1rAnCwVP6rAnPWevdkzar4qW
         w1PA==
X-Gm-Message-State: AOAM533+A7Qj748JE+W/q389SttZWjewQ38cfTzEa0G9cL8IJwcezvPP
        3yrWmkXhCpFJ0CeakETb+IfWzQ==
X-Google-Smtp-Source: ABdhPJxSGAPtW3Oy2T5TFXP6JxfWfln/a1Zc6o7Sj8HhmrsyQ7Zv1HwU0sge2r1VlGeYw6LAnrGExA==
X-Received: by 2002:aca:d02:: with SMTP id 2mr4489656oin.126.1631286267793;
        Fri, 10 Sep 2021 08:04:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 99sm1276993otd.2.2021.09.10.08.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 08:04:27 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
Message-ID: <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
Date:   Fri, 10 Sep 2021 09:04:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 7:57 AM, Jens Axboe wrote:
> On 9/9/21 9:36 PM, Al Viro wrote:
>> On Thu, Sep 09, 2021 at 09:30:03PM -0600, Jens Axboe wrote:
>>
>>>> Again, we should never, ever modify the iovec (or bvec, etc.) array in
>>>> ->read_iter()/->write_iter()/->sendmsg()/etc. instances.  If you see
>>>> such behaviour anywhere, report it immediately.  Any such is a blatant
>>>> bug.
>>>
>>> Yes that was wrong, the iovec is obviously const. But that really
>>> doesn't change the original point, which was that copying the iov_iter
>>> itself unconditionally would be miserable.
>>
>> Might very well be true, but... won't your patch hit the reimport on
>> every short read?  And the cost of uaccess in there is *much* higher
>> than copying of 48 bytes into local variable...
>>
>> Or am I misreading your patch?  Note that short reads on reaching
>> EOF are obviously normal - it's not a rare case at all.
> 
> It was just a quick hack, might very well be too eager to go through
> those motions. But pondering this instead of sleeping, we don't need to
> copy all of iov_iter in order to restore the state, and we can use the
> same advance after restoring. So something like this may be more
> palatable. Caveat - again untested, and I haven't tested the performance
> impact of this at all.

Passes basic testing for me. I added a sysctl switch for this so I can
compare performance, running my usual peak-perf-single-core benchmark.
That one does ~3.5M IOPS, using polled IO. There's always a slight
variability between boots and builds, hence the sysctl so I could
toggle this behavior on the fly.

Did a few runs, and the differences are very stable. With this enabled,
we spend about 0.15% more time in io_read(). That's only worth about
5K IOPS at 3.5M, not enough to notice as the variation for the 1 second
reporting window usually swings more than that:

Old behavior:
IOPS=3536512, IOS/call=32/31, inflight=(75)
IOPS=3541888, IOS/call=32/32, inflight=(64)
IOPS=3529056, IOS/call=32/31, inflight=(119)
IOPS=3521184, IOS/call=32/32, inflight=(96)
IOPS=3527456, IOS/call=32/31, inflight=(128)
IOPS=3525504, IOS/call=32/32, inflight=(128)
IOPS=3524288, IOS/call=32/32, inflight=(128)
IOPS=3536192, IOS/call=32/32, inflight=(96)
IOPS=3535840, IOS/call=32/32, inflight=(96)
IOPS=3533728, IOS/call=32/31, inflight=(128)
IOPS=3528384, IOS/call=32/32, inflight=(128)
IOPS=3518400, IOS/call=32/32, inflight=(64)

Turning it on:
IOPS=3533824, IOS/call=32/31, inflight=(64)
IOPS=3541408, IOS/call=32/32, inflight=(32)
IOPS=3533024, IOS/call=32/31, inflight=(64)
IOPS=3528672, IOS/call=32/32, inflight=(35)
IOPS=3522272, IOS/call=32/31, inflight=(107)
IOPS=3517632, IOS/call=32/32, inflight=(57)
IOPS=3516000, IOS/call=32/31, inflight=(96)
IOPS=3513568, IOS/call=32/32, inflight=(34)
IOPS=3525600, IOS/call=32/31, inflight=(96)
IOPS=3527136, IOS/call=32/31, inflight=(101)

I think that's tolerable, it was never going to be absolutely free.

What do you think of this approach? Parts of iov_iter are going to
remain constant, like iter_type and data_source. io_uring already copies
iter->count, so that just leaves restoring iov (and unionized friends),
nr_segs union, and iov_offset;

We could pretty this up and have the state part be explicit in iov_iter,
and have the store/restore parts end up in uio.h. That'd tie them closer
together, though I don't expect iov_iter changes to be an issue. It
would make it more maintainable, though. I'll try and hack up this
generic solution, see if that looks any better.

-- 
Jens Axboe

