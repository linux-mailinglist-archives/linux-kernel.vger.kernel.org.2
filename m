Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373F13D49D9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGXTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:46:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B12C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:26:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so8741103pjd.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VWuuNI6Xb2RFYqy1iWJswkxFbRA/0CxM5zxC4XKOv0=;
        b=H0d85riqqkKwU0ZXYARkySGdeZc49SmsLD/aH9rWkX0XJIli+Hv3sCU62kew42KXuj
         2Wl/lc4r9fryQv4emrxSEQIQIrLY1P00e8d6ta1LlE/9V/aVoEb4b07KemPUcEelxiIF
         LzzhVgXGA+nsNy98FpJWVy1oVzfHm64Ca7xjIbm2b2fYmoWdJozp/2v6fxG9Ht0CRGMF
         EuUp07VetQeRRyOjV67wkaod4rnVWWuPSti9wbD/1VKy3F8nnqEcN3NeL7R0NewO2bUI
         ncu8lEmuDxfT5x+NwnBP8xNZ9iaZ2O0vSGkvsNkbEFgFLoAYbLW+0I9lWJqO2grCThsf
         o1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VWuuNI6Xb2RFYqy1iWJswkxFbRA/0CxM5zxC4XKOv0=;
        b=Ytp2q7UcJ3xN2cqgaYMc0jBheCej5FktYCnQO9tBKlKtSGGb8PW9ZNBlBzsGdNoett
         s3iGVyNbQbTaYCx/0pxtCvin4fRiBZqYNgiPTgVHxPo/qgvtZ4HXDkdw8O5Xn+fSl9G1
         YV2WXykF6OsSoM3/vpQ1w8E9HxDMO3wog0feqUiVtO7YUShLrAYhJzVXVF8drNxilwZN
         oUEI3USyeNJEOh7rEAsi1N4k8IhlwfmnTafUdo3r2/N4TaMM4E1Lr1oFUTRh/kr1CeKu
         evtzl5I+lUtMWyz2CZSCxkVf9eyoT9srLLW7fcRQkM3oSZB2jcvwl24mTK5lnl3iyBaH
         RLdQ==
X-Gm-Message-State: AOAM5318tfOlIWqI0HqgH8l2/hE29e+efD3cq+xfHhgE+r6J0JWoKieE
        +hPyZsnd6UD2BX8/Z2kYb5I/AA==
X-Google-Smtp-Source: ABdhPJyIdeI592RiIdGUpNlQjIe+TWFAoNvK00VNe2PK8j888A6PgFMt7fysiL4gvU4SzpJvcqG5LQ==
X-Received: by 2002:a17:90b:209:: with SMTP id fy9mr9931038pjb.187.1627158397738;
        Sat, 24 Jul 2021 13:26:37 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id m2sm17917461pja.52.2021.07.24.13.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:26:37 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
 <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
 <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk>
Date:   Sat, 24 Jul 2021 14:26:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 2:05 PM, Andy Shevchenko wrote:
> On Sat, Jul 24, 2021 at 10:43 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 7/24/21 11:56 AM, Jens Axboe wrote:
>>> On 7/24/21 9:57 AM, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> I ran into this when doing the last bit of testing on pending changes
>>>> for this release on the laptop. Outside of running testing on these
>>>> changes, I always build and boot current -git and my changes on my
>>>> laptop as well.
>>>>
>>>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
>>>> every single time. I just get a black screen. Tip of tree before merging
>>>> fixes is:
>>>>
>>>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
>>>> Merge: 05daae0fb033 0077a5008272
>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Date:   Fri Jul 23 11:30:12 2021 -0700
>>>>
>>>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
>>>>
>>>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
>>>> opportunistically reverted some of the most recent git pulls:
>>>>
>>>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
>>>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
>>>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
>>>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
>>>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
>>>>
>>>> as they could potentially be involved, but even with all of those
>>>> reverted it still won't resume.
>>>>
>>>> Sending this out in case someone has already reported this and I just
>>>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
>>>> bisect it.
>>>
>>> Ran a bisect, and it pinpoints:
>>>
>>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
>>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
>>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Date:   Mon Jul 12 21:21:21 2021 +0300
>>>
>>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>>>
>>> which seems odd, as it worked for me with the acpi changes reverted. It
>>> could be that it _sometimes_ works with that commit, not sure. Adding
>>> relevant folks to the CC.
>>>
>>> I'm going to revert this on top of current master and run with that
>>> and see if it does 10 successful resumes.
>>
>> This does appear to be the culprit. With it reverted on top of current
>> master (and with the block and io_uring changes pulled in too), the
>> kernel survives many resumes without issue.
> 
> If I read correctly it seems at one of the local rebase I might have
> missed something.
> 
> Can you replace sensor->adev with adev here
> 
> https://elixir.bootlin.com/linux/v5.14-rc2/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L231
> 
> and retest?

Tried that, doesn't work unfortunately. Hung on first resume, just like
current -git with that single line edit.

-- 
Jens Axboe

