Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967B3D4A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGXUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:55:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F21C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:35:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so7056661plr.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgIQ4du+LwcUWXaHxAgZ31+dXeYJNHVY/+8yTr0JAqM=;
        b=cNPnnOw28WuslqDMCxqOiX/2tf6IVMvnXFjkZr3AeK6L3KWhVaya4JRNo7X7gEvIVo
         wb87hMMk3W7fl3UO/SOe+yPCIOiA9XhCULk4kxaBJXjYCSFqf2Gh/K3DFAEcDjNnz+2P
         GVWjQFF0QH70OcxgEQ61ZrqbSRYqxp0bnR13L3BKuHZC+DdR2oZN3f2hnEfFVr95HwyZ
         WaSQv55cTgL5jJj0fI1OFhFWURb44hWlxEOpzn2nbbAavnsTY7YT8E0OlNX+ejAhiyqj
         cpNDpqlqryGj3nljAVd/EP1zEQSyUEsuiqG9Kaqiv4Yw1eAlQ+e2s1i36+znieY0Wkey
         /6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgIQ4du+LwcUWXaHxAgZ31+dXeYJNHVY/+8yTr0JAqM=;
        b=d5mr1/eFcr8e9ldEOylq9KxhUzSxxOJ0PoroehVLtBWWsaLFTjv4mLrJ6xi1dmsiwA
         n22Y9r3qAoS7If0B1N8ffe2Q0mgzwowbYYD6QcI+POCHNOh/Ohzs35zuBvQ/uRgjBxkJ
         AQIxFl3EPFVNHKW/hOEzShSnDCIYJ+T9Byal1gKgs53BlmZUTKHhCEGgKYUhhzF6UZZe
         LpVSuRWJeMr7H98gznZrSxvuExFh8SnWQQZ92TLLvMsJbihZhQ8tPCrdi4oaiaXY3pv1
         4KL9dgDOX6VTeIQIv+mFCSDDb/I3XFYPfXpLkrGqy+Qssqn4OtUXq4VSfhBfhKVmrV1a
         rWBg==
X-Gm-Message-State: AOAM533bSdZuRyJJKEU2qIgMIhOnW9uFTiupTLBW+uprBL33EFSyOUI4
        NAhNjAZiy/OBs4QHe6ZbFAbJMg==
X-Google-Smtp-Source: ABdhPJxkP/oNT6g/p340FjBPx0WqOztkLN2r0UbuQb/tfFK9bc2aUF2jCExtitC62q+rvel9Wqk+6g==
X-Received: by 2002:a63:1220:: with SMTP id h32mr11218487pgl.446.1627162545103;
        Sat, 24 Jul 2021 14:35:45 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x7sm21621511pfn.70.2021.07.24.14.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 14:35:44 -0700 (PDT)
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
 <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk>
 <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53345d55-9f8c-13d1-9da7-08262bc81a4e@kernel.dk>
Date:   Sat, 24 Jul 2021 15:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 3:15 PM, Andy Shevchenko wrote:
> On Sat, Jul 24, 2021 at 11:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/24/21 2:05 PM, Andy Shevchenko wrote:
>>> On Sat, Jul 24, 2021 at 10:43 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 7/24/21 11:56 AM, Jens Axboe wrote:
>>>>> On 7/24/21 9:57 AM, Jens Axboe wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I ran into this when doing the last bit of testing on pending changes
>>>>>> for this release on the laptop. Outside of running testing on these
>>>>>> changes, I always build and boot current -git and my changes on my
>>>>>> laptop as well.
>>>>>>
>>>>>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
>>>>>> every single time. I just get a black screen. Tip of tree before merging
>>>>>> fixes is:
>>>>>>
>>>>>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
>>>>>> Merge: 05daae0fb033 0077a5008272
>>>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>>>> Date:   Fri Jul 23 11:30:12 2021 -0700
>>>>>>
>>>>>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
>>>>>>
>>>>>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
>>>>>> opportunistically reverted some of the most recent git pulls:
>>>>>>
>>>>>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
>>>>>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
>>>>>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
>>>>>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
>>>>>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
>>>>>>
>>>>>> as they could potentially be involved, but even with all of those
>>>>>> reverted it still won't resume.
>>>>>>
>>>>>> Sending this out in case someone has already reported this and I just
>>>>>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
>>>>>> bisect it.
>>>>>
>>>>> Ran a bisect, and it pinpoints:
>>>>>
>>>>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
>>>>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
>>>>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>> Date:   Mon Jul 12 21:21:21 2021 +0300
>>>>>
>>>>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>>>>>
>>>>> which seems odd, as it worked for me with the acpi changes reverted. It
>>>>> could be that it _sometimes_ works with that commit, not sure. Adding
>>>>> relevant folks to the CC.
>>>>>
>>>>> I'm going to revert this on top of current master and run with that
>>>>> and see if it does 10 successful resumes.
>>>>
>>>> This does appear to be the culprit. With it reverted on top of current
>>>> master (and with the block and io_uring changes pulled in too), the
>>>> kernel survives many resumes without issue.
>>>
>>> If I read correctly it seems at one of the local rebase I might have
>>> missed something.
>>>
>>> Can you replace sensor->adev with adev here
>>>
>>> https://elixir.bootlin.com/linux/v5.14-rc2/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L231
>>>
>>> and retest?
>>
>> Tried that, doesn't work unfortunately. Hung on first resume, just like
>> current -git with that single line edit.
> 
> So, does it work along with the acpi_dev_put() converted to be
> 
>   if (adev)
>     put_device(&adev->dev);
> 
> ?

Building, will test when it's done.

-- 
Jens Axboe

