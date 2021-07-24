Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26E93D4A13
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGXUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:40:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896AC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:21:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w12so6190836wro.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZFnDpTkyOcGtXAifOc4HEoukOCA6+5Q8Wz8eagFaaE=;
        b=CopXkmYRD2otz5oiYl0hZf4/sIuLtyNAWfjf9+fiC1EXISz267JjWjuJgtUqozWyOR
         Kkg1/yBvZsnBUp5e3SmNOsnm8ry99abjvrskLKId4xXUaGv80f9WGvspLR2P2OemB+ln
         Twc1/HmLfzHRARvJtVifc/aZfcarNamR/4wwT/+7Lvcz7H36bQvZOwD+bA6hjivPnjn0
         sk6tPNMPOqTUY89xDJscABZj7eKYEKnmlvn/09qp8TGlVRuydytVN+e+x0+w2Tvy9NZm
         S7kOVw4Ty2KGbYrQBU0oneKzgCKeSidP0HAfzIlxVMd3yHzHM86qi54/+S/dhEs+IAmq
         I//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZFnDpTkyOcGtXAifOc4HEoukOCA6+5Q8Wz8eagFaaE=;
        b=TecHXZChODx1cT7KWGDPtWuYaokW+QMyHMDO+nTDcQHFU51B7UaH6E5jrS//2IqMvi
         TtpEkJw2dDwIvYiK1ZpxVUnC7f0Rnl8bGt4/W5SC12NcK533lKJk0nTkdbCy6bjX44HJ
         YigzbCiiKlKT7BSNKUD35JVSl+0uQjjXtHuF2HlxTXYQ68MCASPhQMGF3/ucrX49npd+
         NWL8N5uxO/hdfIW5SZq9p6hhg2iuttcJEuBqhKRuhyrRcEz74MVWGn4xOaTi/j3ZToaH
         0NfGEmDzf2CBUWhEIVH8rXseufgl3yTXVmYy8hwHQuLB7eQF4X+RgKbNg7AFBfphVhBZ
         VZAw==
X-Gm-Message-State: AOAM531enA2NK5GjN8VUCEQHd7TU/0Nn5CEwZZTAsthTfabODjCGZ5u/
        IJswB67r3CJ4wGPMOFRpMXdczad3nVI=
X-Google-Smtp-Source: ABdhPJyl9Fy+4w8FL+hvPvM4tiUGiAtigAKofJXUBPRl++vlCsEQ2oxy4xR037CDTqcPCDvI2DyGUg==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr11409866wrs.405.1627161666519;
        Sat, 24 Jul 2021 14:21:06 -0700 (PDT)
Received: from [192.168.1.158] ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id e15sm36317734wrp.29.2021.07.24.14.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 14:21:05 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
 <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
 <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com>
 <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk>
 <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <85cd7b22-b437-2c47-d532-0a167339df48@gmail.com>
Date:   Sat, 24 Jul 2021 22:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2021 22:15, Andy Shevchenko wrote:
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

For me; yes. I replicated the issue, and adding the if (adev) guard and
the previous change you mentioned clears it again.
