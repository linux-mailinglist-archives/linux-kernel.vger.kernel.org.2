Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84A04133F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhIUNXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:23:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43954
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233006AbhIUNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:23:51 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC03A3F320
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632230541;
        bh=F3KI5mCrhMB76BGjiS/WLY6vnjlNE8ox5HEGVVIIPrY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PTpLSdsxaow6jNKy8V0tZkYtkIQv8B/FJEef+lqA42j48hGXvzDpAYxU6MBAvQ8iY
         uWKyGO1kxMupPbT9BoUesMkFQXE+/awzlmHL/hFsIbMW4kWCLKhe1wdQo3MabXfR32
         RRh3djAmjvFkL46Koe6WPRq0JjUywdQcv9R/vnjegA+l2FmgO0gDQa8yQASNvznIEB
         eMINrPdAyFdXYrLaHQAIQUQkFeq9UYsRV5Rz1Kj4wPemPfHTGVgUwPAato+sgxQptZ
         2d5FnEjXQZsIxq5cHOvAnlzQj70cZfssRxbDuIRj3QM8jQ0Qvl8QBWdgNeY9ttXsNe
         Xd0u5ixSZnJjg==
Received: by mail-pl1-f198.google.com with SMTP id x5-20020a1709028ec500b0013a347b89e4so9223119plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3KI5mCrhMB76BGjiS/WLY6vnjlNE8ox5HEGVVIIPrY=;
        b=bxfiD1mAZt9/97A0nRX6ekHpXepDe9Af5qKzgiL2qxG984DHz5N9VAEG4GIe7xUtGV
         TKhDWNOm74QCTa37sjQOslhFTZ6myR0xpJCmqsgqeKLLyIeEtw1FnaZ+4Y48NB0BMo/E
         a3yiG3Ii9CP9jUwAoXvoc73i1Sz/y8mMOy2Z/yMNi5u8IVEs3o2A2Z4asogfqCJmK+8n
         bkdbDhVJHlUhw6iaSSi5I+AvH+tRL7/qFS51ePa4QiDNAS0jcuxczsuAM5See9hh2ggq
         OKEOjUCbidL4u6X1ehALIWkZ0qg78lve1KYewSONSAFXTukn4oh7iV0qK43cBSisah7r
         ekMA==
X-Gm-Message-State: AOAM533F7XYofqsfUPISC/BLp1Qc9H81vIg7KGOkwrG5SJxhyeZVv+kt
        SFH0QXCH99HovEe9nz+VzqAjmTVDLGFaQ9C1iVQiSYrG6YV8jrmXDLXVaE7p5l2tzNx1b9uspmv
        Xd6KOk9ODKhWW9BJlchDSNFZZqWcZ3EAudUPlshA4Hg==
X-Received: by 2002:a62:5fc7:0:b0:438:9e3a:b8c0 with SMTP id t190-20020a625fc7000000b004389e3ab8c0mr30550079pfb.74.1632230540444;
        Tue, 21 Sep 2021 06:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv2HJcq8NUDNBKSl0UFDV3ItaulvvPIta5Lh/0oz4qsCaZbbRsg9Acbc3EA9efc2z9IGcpdA==
X-Received: by 2002:a62:5fc7:0:b0:438:9e3a:b8c0 with SMTP id t190-20020a625fc7000000b004389e3ab8c0mr30550053pfb.74.1632230540077;
        Tue, 21 Sep 2021 06:22:20 -0700 (PDT)
Received: from [192.168.1.124] ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id q2sm2796666pjo.27.2021.09.21.06.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:22:19 -0700 (PDT)
Subject: Re: [PATCH] drm/nouveau/ga102: Free resources on error in
 ga102_chan_new()
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210920181647.22156-1-tim.gardner@canonical.com>
 <CACO55ts0kJaHr0QTzqy5r9Gq4vbV=8bMokuVHSCAqMVEOKAgDw@mail.gmail.com>
From:   Tim Gardner <tim.gardner@canonical.com>
Message-ID: <9b778fe8-be29-f8aa-a40f-b640e9d31cc6@canonical.com>
Date:   Tue, 21 Sep 2021 07:22:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACO55ts0kJaHr0QTzqy5r9Gq4vbV=8bMokuVHSCAqMVEOKAgDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/21 8:07 PM, Karol Herbst wrote:
> On Mon, Sep 20, 2021 at 8:17 PM Tim Gardner <tim.gardner@canonical.com> wrote:
>>
>> Coverity complains of a resource leak in ga102_chan_new():
>>
>> CID 119637 (#7 of 7): Resource leak (RESOURCE_LEAK)
>> 13. leaked_storage: Variable chan going out of scope leaks the storage it points to.
>> 190                return ret;
>>
>> Fix this by freeing 'chan' in the error path.
>>
> 
> yeah, this is actually a false positive. I ran your patch through
> kasan and got a use-after-free as we deallocate the passed in pointer
> after calling the function pointer to the new function. One might
> argue that the programming style isn't the best and we should be
> explicit about freeing memory though.
> 

So the caller of this constructor has to look at the error return code 
and decide whether the value stored in *pobject can be freed ? I guess 
if the caller initializes the value at *pobject to be NULL then it can 
kfree() regardless.

>> Cc: Ben Skeggs <bskeggs@redhat.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Karol Herbst <kherbst@redhat.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: nouveau@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
>> ---
>>   .../gpu/drm/nouveau/nvkm/engine/fifo/ga102.c  | 20 ++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
>> index f897bef13acf..4dbdfb53e65f 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
>> @@ -175,19 +175,21 @@ ga102_chan_new(struct nvkm_device *device,
>>                  }
>>          }
>>
>> -       if (!chan->ctrl.runl)
>> -               return -ENODEV;
>> +       if (!chan->ctrl.runl) {
>> +               ret = -ENODEV;
>> +               goto free_chan;
>> +       }
>>
>>          chan->ctrl.chan = nvkm_rd32(device, chan->ctrl.runl + 0x004) & 0xfffffff0;
>>          args->token = nvkm_rd32(device, chan->ctrl.runl + 0x008) & 0xffff0000;
>>
>>          ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->mthd);
>>          if (ret)
>> -               return ret;
>> +               goto free_chan;
>>
>>          ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->inst);
>>          if (ret)
>> -               return ret;
>> +               goto free_chan;
>>
>>          nvkm_kmap(chan->inst);
>>          nvkm_wo32(chan->inst, 0x010, 0x0000face);
>> @@ -209,11 +211,11 @@ ga102_chan_new(struct nvkm_device *device,
>>
>>          ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->user);
>>          if (ret)
>> -               return ret;
>> +               goto free_chan;
>>
>>          ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->runl);
>>          if (ret)
>> -               return ret;
>> +               goto free_chan;
>>
>>          nvkm_kmap(chan->runl);
>>          nvkm_wo32(chan->runl, 0x00, 0x80030001);
>> @@ -228,10 +230,14 @@ ga102_chan_new(struct nvkm_device *device,
>>
>>          ret = nvkm_vmm_join(vmm, chan->inst);
>>          if (ret)
>> -               return ret;
>> +               goto free_chan;
>>
>>          chan->vmm = nvkm_vmm_ref(vmm);
>>          return 0;
>> +
>> +free_chan:
>> +       kfree(chan);
>> +       return ret;
>>   }
>>
>>   static const struct nvkm_device_oclass
>> --
>> 2.33.0
>>
> 

-- 
-----------
Tim Gardner
Canonical, Inc
