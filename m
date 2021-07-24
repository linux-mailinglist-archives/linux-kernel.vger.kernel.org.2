Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372ED3D49DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhGXTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:47:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BFAC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:28:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so6984311plt.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JYolHVchREh/KWdS8LrNr4kryr2W4zC5g2MTzhWKM20=;
        b=Y1DePayUyAqdWxD6tuNKT4ikxwIteJuYEoJ70oRuui1kZjWGxp2kkr4d+IkLoLsiUz
         mhcQwNIfoj/SipOXHp8pqBBoTkKMYHO4kSjeq2iaL921azcnD+Bv9LtzsJCPEXLVFrzt
         8Veiwg5R4LC2qzBIIH3HJJreszv9oSowbBJnTChDJmUiu/v6XqTOho1iO/ewYz2tRL4V
         pCPma0MJcZsalMm7CpIA2ktGwsgqO5CiHxu4hc426GP9SUf8B8z0pWKlV33XLp73lmLb
         2iW3AmYCx5unNk1RhzwkRfZ3M3aWJ7yIsscm64Ea76l4EwXkVlpapHlY3Jmox2t1lZYq
         SX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYolHVchREh/KWdS8LrNr4kryr2W4zC5g2MTzhWKM20=;
        b=eBOIVgpFETfsJyJQelGlfQmCJATgy6SDry3TK/ImEubESn0oWkmLIDZgzYDZKqGpVT
         Q8s4lrmwZ5DefpeDyb7d5NCOo/Ph0w6sZ//TxMWdk8vDewP3uIAYCX2dM6ov+z+5MRgL
         MJWENc09WCCDqXkn90jo/RYIybQTZD2sJWoWj+4bb+OlgdB5iJP40f8euVOQGGcR3BKS
         yGWgPRWgcPEC9R0gkubDY1r0Q+U2UJrv/gOvD/8xoXXStT3I15RM442f/f+wSXcyFsJk
         dfLeMFLzR1a9pGZ8OXe6sNPiV/CLMmAsu3T4Yse8oc8oLMyTs6KeLkfmBSIlJ9CC7inE
         3C7w==
X-Gm-Message-State: AOAM533e+51mwYQQeonGtJMOadL21Bm6A9qHqgILCFdwEDGK+7LianjI
        L733AfYR8zSCx/d16AdCG9oEUw==
X-Google-Smtp-Source: ABdhPJzJqjJRpZv4MGAt9rmilR88qOL/7NAhafTCqeYWUktDdTbb1DQsSSZTmvFhshFolhGXBlqyQw==
X-Received: by 2002:a17:90a:6686:: with SMTP id m6mr10078817pjj.109.1627158493964;
        Sat, 24 Jul 2021 13:28:13 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id g4sm44380563pgn.45.2021.07.24.13.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:28:13 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
 <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5991fa18-a20d-7f61-f992-668562148adf@kernel.dk>
Date:   Sat, 24 Jul 2021 14:28:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 1:49 PM, Andy Shevchenko wrote:
> On Sat, Jul 24, 2021 at 8:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 7/24/21 9:57 AM, Jens Axboe wrote:
> 
>>> I ran into this when doing the last bit of testing on pending changes
>>> for this release on the laptop. Outside of running testing on these
>>> changes, I always build and boot current -git and my changes on my
>>> laptop as well.
>>>
>>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
>>> every single time. I just get a black screen. Tip of tree before merging
>>> fixes is:
>>>
>>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
>>> Merge: 05daae0fb033 0077a5008272
>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date:   Fri Jul 23 11:30:12 2021 -0700
>>>
>>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
>>>
>>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
>>> opportunistically reverted some of the most recent git pulls:
>>>
>>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
>>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
>>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
>>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
>>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
>>>
>>> as they could potentially be involved, but even with all of those
>>> reverted it still won't resume.
>>>
>>> Sending this out in case someone has already reported this and I just
>>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
>>> bisect it.
>>
>> Ran a bisect, and it pinpoints:
> 
> Thanks for the report!
> 
>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Date:   Mon Jul 12 21:21:21 2021 +0300
>>
>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>>
>> which seems odd, as it worked for me with the acpi changes reverted. It
>> could be that it _sometimes_ works with that commit, not sure. Adding
>> relevant folks to the CC.
>>
>> I'm going to revert this on top of current master and run with that
>> and see if it does 10 successful resumes.
> 
> This commit touches two parts (and API) EFI for Apple devices (seems
> not your case) and CIO2 bridge (Camera device on Intel Sky Lake and
> Kaby Lake machines). The EFI code runs at boot time AFAIU and CIO2
> code runs at device's ->probe() time. I'm a bit puzzled as to why it
> affects resume parts... Daniel, any ideas?

That does match my camera type at least, but apart from that, no ideas.
Does seem to be very reliable, as per the one-liner test I just made.
Unfortunately I don't have a way to log a crash, since it's just a
laptop...

Rebuilding with the revert again, should be solid (I'll retest, since
you never know with issues like this).

-- 
Jens Axboe

