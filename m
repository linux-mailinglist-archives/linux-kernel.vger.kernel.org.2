Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0997C36DE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhD1R1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241602AbhD1R1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619630784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gG7pVgMu1dn0fnwqtPsC3vyUDfxQRZUfZPSBpjAVrzc=;
        b=GWfdqDfnvH9tDGe9ldzevIZcM6OHLJLwsAKW3AaTCCuLZ1UUV9dgbuZ5W/bojJPahVvigh
        936LOkvRP8NtSLj5kmqarDs/UNKPe3rcP2LrShLcYd3AsrXisCxP6K4FmrFUDxrb6q7G22
        alO66e7WYR//epDZqDhy2/0BI/cKmMU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-vGzJbsVYMvm_Nyj534Hrtw-1; Wed, 28 Apr 2021 13:26:23 -0400
X-MC-Unique: vGzJbsVYMvm_Nyj534Hrtw-1
Received: by mail-qv1-f69.google.com with SMTP id f17-20020a05621400d1b029019a6fc802f7so28630243qvs.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gG7pVgMu1dn0fnwqtPsC3vyUDfxQRZUfZPSBpjAVrzc=;
        b=naVQrqYNwAyU5UpUq94m5FHAe05U/XJnHOB4+xLTKmcTZ750WbnW9uFR85LUDqiDvd
         /co0jXYpYpCB6OmLuEt3d7/+473okY9gUd1Oa3E2vG1elbjGFnIIgllBag06abO5KtwY
         KejG5cV9yy1tYNAjPhlx3Crio1tZzWg6gkBZxlTyZU/zQBhyw+BmUJbybbrciGrNYvsI
         UEx1DBMHNKLTBPP7T925JJge3peOOPvbPsVhZzw1FeU9KCk5RFs3UUwVmq51KL3NXYXx
         H6xPcYUtUX3pfZoiSgfhSjN/KzzMl2ZcsLvGHE7DIserUUDgDeLeUu7MZtLxspp7Uh77
         VAlA==
X-Gm-Message-State: AOAM532p4uw6wSZkKD5nGbm/tLIyM06DUehlll7jmg+UtrEsypmFL92K
        d7LLzEMHPTThOuebJTnnNPwWaTFgA9i1gsaXZ9EBBoaev4yRxurxw/NJ2t/9WGXHYmtMhYTXMj4
        N15M4mX20EPlcd+6/IhvY3cv+
X-Received: by 2002:ac8:490c:: with SMTP id e12mr27530984qtq.351.1619630779648;
        Wed, 28 Apr 2021 10:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu2q1hIZae88kkzy/WSBPDkP1/cW/HkadfScxYQv9g52d1g+ZXvDeMNI33o6wcG2j8+Yaqzg==
X-Received: by 2002:ac8:490c:: with SMTP id e12mr27530954qtq.351.1619630779252;
        Wed, 28 Apr 2021 10:26:19 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m14sm426385qtq.59.2021.04.28.10.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 10:26:18 -0700 (PDT)
Subject: Re: [PATCH] bus: fsl-mc: fix improper free of mc_dev
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        Nathan Chancellor <nathan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210427183624.2790305-1-trix@redhat.com>
 <CAKwvOd=LSs6gdGj-FAuCTrPrH6ik6PVxYX+_tFK9G1OW0vdMAA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <975e8af4-d1b6-0440-7447-1e06e514ca8a@redhat.com>
Date:   Wed, 28 Apr 2021 10:26:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=LSs6gdGj-FAuCTrPrH6ik6PVxYX+_tFK9G1OW0vdMAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 12:19 PM, Nick Desaulniers wrote:
> On Tue, Apr 27, 2021 at 11:36 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>>
>> fsl-mc-bus.c:891:2: warning: Attempt to free released memory
>>          kfree(mc_dev);
>>          ^~~~~~~~~~~~~
>>
>> In this block of code
>>
>> if (strcmp(obj_desc->type, "dprc") == 0) {
>> ..
>>    mc_bus = kzalloc(..)
>>    mc_dev = &mc_bus->mc_dev;
> Thanks for the patch.
>
> Aren't the allocations for mc_bus and mc_dev mutually exclusive based
> on that conditional? If so...
>
>> mc_dev is not alloc-ed, so it should not be freed.
>> Old handler triggers a false positive from checkpatch, so add a
>> comment and change logic a bit.
>>
>> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> index 380ad1fdb745..fb3e1d8a7f63 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -887,8 +887,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>>
>>   error_cleanup_dev:
>>          kfree(mc_dev->regions);
>> +       /* mc_dev is only allocated when it is not part of mc_bus */
>> +       if (!mc_bus)
>> +               kfree(mc_dev);
>>          kfree(mc_bus);
>> -       kfree(mc_dev);
> The error handling here seems quite wrong (regardless of your patch).
> mc_dev->regions is allocated by fsl_mc_device_get_mmio_regions() IIUC.
> Wouldn't the first `goto error_cleanup_dev;` taken end up passing an
> uninitialized pointer to kfree()?

On the first goto, mc_dev->regions, because of the kzalloc, the value 
would be

mc_bus->mc_dev.regions , should be 0 or

mc_dev->regions, which also should be 0

and kfree handles 0.

>
> what if `strcmp(obj_desc->type, "dprc") == 0` is false? We allocate
> `mc_dev`, but then call kfree on `mc_bus`?

mc_bus is initialized to NULL, which makes the call to kfree safe.

The original handler was

if (mc_bus)

   kfree(mc_bus)

else

   kfree(mc_dev)

I tried this first, which works, but checkpatch throw a warning for 
kfree(mc_bus).

This change makes the 'else' with the !mc_bus

> I think it would be safer to locally save the result of
> `strcmp(obj_desc->type, "dprc") == 0`, then check that throughout this
the local mc_bus is only set in this block, so I don't think another 
local is needed.
> function, including the error handling at the end, or use multiple
> labels to unwind the allocations correctly.

The goto's could be finer grained because some of the mc_dev->regions 
are known to be unallocated.

Changing these would not be a fix and it could be argued the simpler, 
less efficent error handling works as designed.

Tom

>
>>          return error;
>>   }
>> --
>
> --
> Thanks,
> ~Nick Desaulniers
>

