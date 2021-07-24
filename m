Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E93D49E7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGXTxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:53:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D85C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:34:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c11so7043849plg.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JslaJqcZxJ/P1yFKyliDO3CypPZcvDdVxEQWIzt90HM=;
        b=g8TgWxXbPhJY1xLApWG4ZKFGmNts+QqrpDCk4e8EkiOQrmXXDbfMlF9vHt/O3q+6/R
         eSu2g0LrYqwCWd4tT79ukldwJog+XeZJdDKsDFV6LCBh++VnSz3jk/UNMuOgoxV9QZ0K
         53h5OdJt82mUEi6tssRvkXSJprJ+iQJ+3CSubKyWqBwOY8LpJevthFi/CUa3IxTT23Sh
         CySq0rwtY7cxxQraujJtR6EggdJuXFYJHGPGLw95Lm+fFYUtUQBq2KrQODgFEN+VrS7l
         hdZtv7E8mnnlUX4KS1pbDKPfcCPxy0fo+j85Lzx++ToNvYlqNUUmdyc/xoqY0jb0zWPz
         BS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JslaJqcZxJ/P1yFKyliDO3CypPZcvDdVxEQWIzt90HM=;
        b=NFI8TEQ/r8kQ9KaimS2D1s7VjD/6WZcVc+7MttcsTnTk7D0ZXaU0SlW6MzyNFxyFxB
         3rhITgmbXh5WvBbRFrZd0Snb4EsCRuMelg1HZl7/0R1AHXisKDmyNxS+PKf4uJ6r9mqX
         S8d72JIgi8ShKLaWUucdB2qcPoU5tSHpKc/flWlzRLU//rmVIaiIR2kA7dyik9EChFX5
         q/hcnRaQvu7PyNLBxh+ryXvme8xGrQegw+wykXH6xaLOUgdp1UTtymOl+9yr9cYT/7Go
         vC/sewysyCbI9hpn/X0W34bWZose9VwEaaQrBu9vlfO5dAUEQ6C/Kj1z8NeH6HBFN6AL
         MYhw==
X-Gm-Message-State: AOAM531F43iU9JjT9pGQG9HR3gyB+HRkH/1CoU9RudUJK4ypUGPJFRpq
        dWQO7WHnGarpQTrwjNSaTQXINw==
X-Google-Smtp-Source: ABdhPJx9j6EvifYO16jK7sPBZdM79k3/dNmJCuqqg5AbF1fD72eRfsbytC26smEmV7l55of/byEJ4A==
X-Received: by 2002:a17:90a:ea98:: with SMTP id h24mr18894940pjz.7.1627158862988;
        Sat, 24 Jul 2021 13:34:22 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id q9sm30028737pgt.65.2021.07.24.13.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:34:22 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
From:   Jens Axboe <axboe@kernel.dk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
 <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
 <5991fa18-a20d-7f61-f992-668562148adf@kernel.dk>
Message-ID: <be9f9aa1-51c7-49e4-efa6-a22c8f0d49a3@kernel.dk>
Date:   Sat, 24 Jul 2021 14:34:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5991fa18-a20d-7f61-f992-668562148adf@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 2:28 PM, Jens Axboe wrote:
> On 7/24/21 1:49 PM, Andy Shevchenko wrote:
>> On Sat, Jul 24, 2021 at 8:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/24/21 9:57 AM, Jens Axboe wrote:
>>
>>>> I ran into this when doing the last bit of testing on pending
>>>> changes for this release on the laptop. Outside of running testing
>>>> on these changes, I always build and boot current -git and my
>>>> changes on my laptop as well.
>>>>
>>>> 5.14-rc1 + changes works fine, current -git and changes fail to
>>>> resume every single time. I just get a black screen. Tip of tree
>>>> before merging fixes is:
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
>>
>> Thanks for the report!
>>
>>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
>>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
>>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Date:   Mon Jul 12 21:21:21 2021 +0300
>>>
>>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>>>
>>> which seems odd, as it worked for me with the acpi changes reverted.
>>> It could be that it _sometimes_ works with that commit, not sure.
>>> Adding relevant folks to the CC.
>>>
>>> I'm going to revert this on top of current master and run with that
>>> and see if it does 10 successful resumes.
>>
>> This commit touches two parts (and API) EFI for Apple devices (seems
>> not your case) and CIO2 bridge (Camera device on Intel Sky Lake and
>> Kaby Lake machines). The EFI code runs at boot time AFAIU and CIO2
>> code runs at device's ->probe() time. I'm a bit puzzled as to why it
>> affects resume parts... Daniel, any ideas?
> 
> That does match my camera type at least, but apart from that, no
> ideas. Does seem to be very reliable, as per the one-liner test I just
> made. Unfortunately I don't have a way to log a crash, since it's just
> a laptop...
> 
> Rebuilding with the revert again, should be solid (I'll retest, since
> you never know with issues like this).

Works fine again with the revert. It really does seem to be that commit
that is problematic.

-- 
Jens Axboe

