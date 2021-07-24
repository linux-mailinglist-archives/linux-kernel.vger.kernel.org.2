Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21A3D49CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhGXTny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:43:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B7C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:24:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y8so6109911wrt.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cjB0hBS+oWcXe0+zGAoffGrmAPv/voBHkHG2PjaPyss=;
        b=WS+LZQAiITl02OEYLhWbTnT7oGu6Z7SjyWHjPwROTmWkK2X3tW3XqBgUms4txCQXCY
         HZ1x5VPmTElEHTAy0o0KlXPGnhKyxTlDrHWG1PtRQHveRVCruKQZe3fejFPPyytMq91Z
         kJGUqcMVQ0V1FzzfmirNfF3XdO2KgIRgBol1UeeH+MjswFgdPxxqzci6N4+YUYarBQuJ
         YGpabgO06PMNLMzmvmMX1NcvyfR5LYlpmYzJMszd+Jvq1V/G0gffJait9sXsEEkULZ83
         3Pas/cbhRzaZ+C+GBMSLA7kmVe+l9OzjcOGWbeJsJcJPiymk42/AvHZUkW4h6Z6G8CfQ
         ajgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cjB0hBS+oWcXe0+zGAoffGrmAPv/voBHkHG2PjaPyss=;
        b=PHm1xjx9c6OgvFuXzRKtAFSNRMAIz0VF6kz9P24zmgT/iwnm5pvE5Eb1UufC3XJ5ZR
         ecL+/z7WtGJ0sEVkMDfqjXaYho7fdeW64TQKsJZmlenJLJeVhWhBGi6YEyo8R1zZD7c9
         mmwhSZzwuzGJ7+QSkwKsdV/8UuFRfZwGSJoagO0AoM1CLOJ4tIQI4KHaCo5bwTj/3ZH9
         bO9PDFmnaUeadAcCbfExO5WG0oaOmNCj3LIfpdZklhrZigtNnsevL8/Ap5I9LjVu3Xa1
         CLOSEEtCMXVWtEoh1bWMIOTFi8RtJkrNhvR+wIdDpLEfCwJsNjXQMhoYFGi+UcfWW4UF
         vQgA==
X-Gm-Message-State: AOAM530IUqonhyRPebOFxrpjhXMMvBc1dOzSuxg5Q14/uXH1NZ1AUKoB
        Fk/k2faqNrdH/3qnwq2NOmY=
X-Google-Smtp-Source: ABdhPJyAptwompQt/2N32SDxlylzoKa55AXwj4lhLb6LB2MSNXtYFkcn7eI5V273xIsNIXyApUv+gA==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr11503292wre.300.1627158261137;
        Sat, 24 Jul 2021 13:24:21 -0700 (PDT)
Received: from [192.168.1.158] ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id s17sm37669125wrv.2.2021.07.24.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:24:20 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
 <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <b4e8d0bc-4cf1-ac00-d76c-7d1e19eec0cc@gmail.com>
Date:   Sat, 24 Jul 2021 21:24:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcs3DCxunStWCLF+d6yFXW854sGA89tRYq6uqemDOoSYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2021 20:49, Andy Shevchenko wrote:
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

Not off the top of my head, puzzles me too. I'm building to test now.
