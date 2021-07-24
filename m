Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFF63D49A5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhGXTD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGXTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:03:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9DC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:43:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e10so7154924pls.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i7U4eF8t9vBBB3goiXq5GssrwlXInMV9N0xmLVsG14s=;
        b=DxO0Qm3NbDikMSodIrDH41mOt999KikZjf4ejaSvm/PcFdNtX4EVXprXjzZN/oK/sw
         Q23jFiJwRz5Fphi+Yep+wfTi8jXz0gO0mwOOChCbXtY7tXPeffE33GOhMNda+EFlHsI4
         Y4CWE/cg7fS76nLX8kYsZ+3Zwg3V3GJyD0MvvZGHflrqbKBD4aCZfnvHBPBNOCX+X6sq
         qfLoVz4KWqD0awksll+s0HZ1TGux8isIZlXRQSPDfG4HOWMncDlXMplu1HXY2pRExgbC
         1wSWUGdWqZP/PmPzROgc50NnUWMh+ZrmoyG31oLQPG+sIl51Zm9iFvPLYZpm7mP3HxSE
         kWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7U4eF8t9vBBB3goiXq5GssrwlXInMV9N0xmLVsG14s=;
        b=mYrv7ZhlqIQuTTBbniGvZ19KWt6tQITS7WOixDuu4SFBFE7UWGuE6jJAkmw45Kg4Qu
         qz28zKv7YQcguVu51+i+8dMkIkDAxmpjUxpeP7i7rlPw97okQC9IRKolGsiLkuNhCvZA
         PS/9XuM3rvT9KDayo+eu2rT9YsXbtmvAToWHzJwucihQ/REdNzLMPuRVXB2vuR8g/R8v
         LfKv3bK6wT9AHgHXA2ntWHG8Dl4iixn+ZhpB3t+rnTT5en7hWgd/5QWNJ+Rwg6w3OG3x
         V+oZMzQ+FaQHlNdYl9vmXTeC4JqQm0XiK3DZoBLfsl7ElWrR1syn8G08ugl2jlEqeMpj
         u2oA==
X-Gm-Message-State: AOAM532shm8Sx+9P5+KyNo2OyAldwMjyk1x+3E1Fn4zW3NBUlr2NISfn
        kbApVUvH04jaLbNkK3/MXeT16w==
X-Google-Smtp-Source: ABdhPJwvQ0ch3sQUfTNAc+j3beENgOIqylMzlxQ7WjCCSJfw/RR2bhhS9p1AjuP/fOSp0areGTe60A==
X-Received: by 2002:a17:90a:4d04:: with SMTP id c4mr18767867pjg.148.1627155837658;
        Sat, 24 Jul 2021 12:43:57 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id iy13sm9314168pjb.28.2021.07.24.12.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 12:43:57 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
From:   Jens Axboe <axboe@kernel.dk>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
Message-ID: <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
Date:   Sat, 24 Jul 2021 13:43:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 11:56 AM, Jens Axboe wrote:
> On 7/24/21 9:57 AM, Jens Axboe wrote:
>> Hi,
>>
>> I ran into this when doing the last bit of testing on pending changes
>> for this release on the laptop. Outside of running testing on these
>> changes, I always build and boot current -git and my changes on my
>> laptop as well.
>>
>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
>> every single time. I just get a black screen. Tip of tree before merging
>> fixes is:
>>
>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
>> Merge: 05daae0fb033 0077a5008272
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Fri Jul 23 11:30:12 2021 -0700
>>
>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
>>
>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
>> opportunistically reverted some of the most recent git pulls:
>>
>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
>>
>> as they could potentially be involved, but even with all of those
>> reverted it still won't resume.
>>
>> Sending this out in case someone has already reported this and I just
>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
>> bisect it.
> 
> Ran a bisect, and it pinpoints:
> 
> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
> Date:   Mon Jul 12 21:21:21 2021 +0300
> 
>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
> 
> which seems odd, as it worked for me with the acpi changes reverted. It
> could be that it _sometimes_ works with that commit, not sure. Adding
> relevant folks to the CC.
> 
> I'm going to revert this on top of current master and run with that
> and see if it does 10 successful resumes.

This does appear to be the culprit. With it reverted on top of current
master (and with the block and io_uring changes pulled in too), the
kernel survives many resumes without issue.

-- 
Jens Axboe

