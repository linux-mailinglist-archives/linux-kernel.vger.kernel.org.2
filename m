Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826AE3D4A24
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGXU7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:59:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC03C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:39:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso9390845pjn.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BBcwNBcUBXrnpymC3n2dRy/tBFByP21UShzLJbu3Q28=;
        b=pgwcZHbEXSH026YNZUlGZcrmMBfXCuvPMz9V3Espe9WE03Dyz8TbH4fkbdrLd7aB4C
         4yxoLmhXn/xjsqUnMxnBBqeoMxtg3sCSsXUAvTP1gxJpwpwphgCHmMiO5siCSiGKx5PR
         W5tE6xHIbNaToaBniTPmkJBfzMVZbY7OJ1SGqiErnoVArQzfDHIRVSjxWxg2MVTCUAHT
         NrxxFdhTUAjp5jOA3CMWsH1paVdmHa3rVtjyfMZyRZGwydhjtsTiLaE8uE5PDSk8Zckh
         eomUQZqj8YVGbZUD+a1SiP+rIezFA95qP9aDJMvZ0qAaR/TgHBEfPGf5lM956uJ22ieW
         9KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBcwNBcUBXrnpymC3n2dRy/tBFByP21UShzLJbu3Q28=;
        b=B5etGy3D/XhcmrcaccM2ih4ZSGi1vIjkyIADynPQ4gG9Xlqqp3Mm3wp9u97PV+IYth
         l+YtRpTgzrSsOt7xOkAMzMS3ZTex/7DCqriy4e0CSav/jG0BYyrPEwLM5vb5ERut3/gj
         +7cr3UfxuqrP9EFVaKLu2Nut0WKdAC0j40ZNVLogmOW82CLRlXmvYTSSrHOC9FCNNsFl
         wU7gFXLox4OMIZtvRNl436MYacjnXEFSmlg8IJ8Uq8B3JBcFhBz26tMRKftsgYaK3G83
         ouPRSRQ3DvSwZTsnC55w09SFBA2A2AaYCNKw6xqzqgdfQseduic7SfdFJYUrJAQBmrrT
         KKFA==
X-Gm-Message-State: AOAM53070yuolUWV7P4BnEzkjs9SF24Lu8Rtb7iUFS+4F4hBEa44VETx
        NDkshJlfAlWxMF7/DXXHp/oCxA==
X-Google-Smtp-Source: ABdhPJzwiEEx11r+Rvp/5oVRyClrYOBOcDA8aPop7g8mfddCfYBG+mnsVo0eXWuiBATGvd/SbImYng==
X-Received: by 2002:a05:6a00:1713:b029:332:7eca:41a1 with SMTP id h19-20020a056a001713b02903327eca41a1mr10764838pfc.26.1627162788006;
        Sat, 24 Jul 2021 14:39:48 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t22sm10661390pjo.3.2021.07.24.14.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 14:39:47 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
From:   Jens Axboe <axboe@kernel.dk>
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
 <53345d55-9f8c-13d1-9da7-08262bc81a4e@kernel.dk>
Message-ID: <7632e656-ff4d-3964-b3fc-5802935183c8@kernel.dk>
Date:   Sat, 24 Jul 2021 15:39:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <53345d55-9f8c-13d1-9da7-08262bc81a4e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 3:35 PM, Jens Axboe wrote:
> On 7/24/21 3:15 PM, Andy Shevchenko wrote:
>> On Sat, Jul 24, 2021 at 11:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 7/24/21 2:05 PM, Andy Shevchenko wrote:
>>>> On Sat, Jul 24, 2021 at 10:43 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>> On 7/24/21 11:56 AM, Jens Axboe wrote:
>>>>>> On 7/24/21 9:57 AM, Jens Axboe wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I ran into this when doing the last bit of testing on pending changes
>>>>>>> for this release on the laptop. Outside of running testing on these
>>>>>>> changes, I always build and boot current -git and my changes on my
>>>>>>> laptop as well.
>>>>>>>
>>>>>>> 5.14-rc1 + changes works fine, current -git and changes fail to resume
>>>>>>> every single time. I just get a black screen. Tip of tree before merging
>>>>>>> fixes is:
>>>>>>>
>>>>>>> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
>>>>>>> Merge: 05daae0fb033 0077a5008272
>>>>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>>>>> Date:   Fri Jul 23 11:30:12 2021 -0700
>>>>>>>
>>>>>>>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
>>>>>>>
>>>>>>> Since bisection takes forever on the laptop (gen7 x1 carbon), I
>>>>>>> opportunistically reverted some of the most recent git pulls:
>>>>>>>
>>>>>>> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
>>>>>>> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
>>>>>>> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
>>>>>>> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
>>>>>>> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
>>>>>>>
>>>>>>> as they could potentially be involved, but even with all of those
>>>>>>> reverted it still won't resume.
>>>>>>>
>>>>>>> Sending this out in case someone has already reported this and I just
>>>>>>> couldn't find it. If this is a new/unknown issues, I'll go ahead and
>>>>>>> bisect it.
>>>>>>
>>>>>> Ran a bisect, and it pinpoints:
>>>>>>
>>>>>> 71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
>>>>>> commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
>>>>>> Author: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>>> Date:   Mon Jul 12 21:21:21 2021 +0300
>>>>>>
>>>>>>     ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
>>>>>>
>>>>>> which seems odd, as it worked for me with the acpi changes reverted. It
>>>>>> could be that it _sometimes_ works with that commit, not sure. Adding
>>>>>> relevant folks to the CC.
>>>>>>
>>>>>> I'm going to revert this on top of current master and run with that
>>>>>> and see if it does 10 successful resumes.
>>>>>
>>>>> This does appear to be the culprit. With it reverted on top of current
>>>>> master (and with the block and io_uring changes pulled in too), the
>>>>> kernel survives many resumes without issue.
>>>>
>>>> If I read correctly it seems at one of the local rebase I might have
>>>> missed something.
>>>>
>>>> Can you replace sensor->adev with adev here
>>>>
>>>> https://elixir.bootlin.com/linux/v5.14-rc2/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L231
>>>>
>>>> and retest?
>>>
>>> Tried that, doesn't work unfortunately. Hung on first resume, just like
>>> current -git with that single line edit.
>>
>> So, does it work along with the acpi_dev_put() converted to be
>>
>>   if (adev)
>>     put_device(&adev->dev);
>>
>> ?
> 
> Building, will test when it's done.

Yep, works with acpi_dev_put() checking for != NULL before doing the
put.

-- 
Jens Axboe

