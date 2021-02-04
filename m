Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0178630F292
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhBDLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236095AbhBDLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612438620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tt3VbFM0k436v4sSY5cZ9PKWtB+VqH1USzCLqDKr64A=;
        b=AkUKMq9/C88vieNc+owQ57DpzrKsLfBaeGlHfbG3hr2srNw31q8tdQyNBqcb9h0vZqMp+v
        LfHjk51r5smFrgKA2SWZ5ACFtQdhmXL598gmrvFGr6rSvOOajrbMvUHa5ZiVpUKaLAQNtE
        2sR2FCXYYG7dXSfeZXXCB2jl4TP1qt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-dS1MXR-aO4yup30OLsjlSQ-1; Thu, 04 Feb 2021 06:36:58 -0500
X-MC-Unique: dS1MXR-aO4yup30OLsjlSQ-1
Received: by mail-ed1-f71.google.com with SMTP id b1so2626316edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tt3VbFM0k436v4sSY5cZ9PKWtB+VqH1USzCLqDKr64A=;
        b=LBdMxJImdLT34yPSzAn6WEeRUQyp1zUDzfu1cVX5tDgXLFtxtQcuOZNXc//IAIcBP6
         xbunCqcVm6FVHWh31R16lTmd6brAHClUN1dtVWJJtaNqM7lCntF8w6UZzF2LFgKo9HL2
         boXwvmJDRZ3IJCLWBCU3MaOBaGGHHlVeeFBCLuXj+pF7/Mwi90yZ5S9j3ixCCatVN9Qx
         xa4bNcRoP3pDVnkPaSLei/Z5ixmW4gpf4lyTshFqsjsdl1R4fPBB6EVfkIJP7R7vjtng
         eR/RNW2WFliglNNe1BfWCYknBhUx9u7N5tM+E38LeZBAtFgXqA7tEZYmj2ef46+m7ve2
         ar8Q==
X-Gm-Message-State: AOAM533wkW8c7K8ywtAVeYOlt8Kw2QmFI1FtCBXpdmSlqAn32NBatbjl
        bb4DdJ5YvQyxq7KMmMvE4RdlMF7WC3CtqI3Yuy81GBMh3FNkYlvZen+5PBWS3AHNhzX3SPr+678
        u+Y3sSNfed080im5VV2R1/iNF
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr7543069edc.164.1612438617616;
        Thu, 04 Feb 2021 03:36:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVnZFJxMrhvBKoTYf/UaDGDVpftygDXQbxTux6DBN1/mx3c0o/xU8Ayk/H7c/uXSyWrrnMsg==
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr7543055edc.164.1612438617440;
        Thu, 04 Feb 2021 03:36:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v9sm2335283ejd.92.2021.02.04.03.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:36:56 -0800 (PST)
Subject: Re: drivers/platform/surface/surface3-wmi.c:60:14: warning: variable
 'status' set but not used
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <202012291140.j73hBz45-lkp@intel.com>
 <184b4ec6-65f1-5a22-487b-20cc0fb1b587@redhat.com>
 <1a749e41-86da-8607-ec39-c91cf4107a9f@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <80b763f8-8a19-aada-ae49-515fda2f209c@redhat.com>
Date:   Thu, 4 Feb 2021 12:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1a749e41-86da-8607-ec39-c91cf4107a9f@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/4/21 4:24 PM, Maximilian Luz wrote:
> On 1/4/21 3:52 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 12/29/20 4:58 AM, kernel test robot wrote:
>>> Hi Maximilian,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
>>> commit: f23027ca3d48b6f93c5994069fb25b73539fdf34 platform/surface: Move Surface 3 WMI driver to platform/surface
>>> date:   9 weeks ago
>>> config: x86_64-randconfig-r001-20201221 (attached as .config)
>>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f23027ca3d48b6f93c5994069fb25b73539fdf34
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout f23027ca3d48b6f93c5994069fb25b73539fdf34
>>>          # save the attached .config to linux build tree
>>>          make W=1 ARCH=x86_64
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>     drivers/platform/surface/surface3-wmi.c: In function 's3_wmi_query_block':
>>>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>>>        60 |  acpi_status status;
>>>           |              ^~~~~~
>>
>> I guess fixing this would require something like this:
>>
>> From: Hans de Goede <hdegoede@redhat.com>
>> Subject: [PATCH] platform/surface: surface3-wmi: Fix variable 'status' set but not used compiler warning
>>
>> Explictly check the status rather then relying on output.pointer staying
>> NULL on an error. This silences the following compiler warning:
>>
>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/surface/surface3-wmi.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
>> index 130b6f52a600..4b7f79c0b78e 100644
>> --- a/drivers/platform/surface/surface3-wmi.c
>> +++ b/drivers/platform/surface/surface3-wmi.c
>> @@ -63,6 +63,10 @@ static int s3_wmi_query_block(const char *guid, int instance, int *ret)
>>         mutex_lock(&s3_wmi_lock);
>>       status = wmi_query_block(guid, instance, &output);
>> +    if (ACPI_FAILURE(status)) {
>> +        error = -EIO;
>> +        goto out_free_unlock;
>> +    }
>>         obj = output.pointer;
>>  
>> Maximilian, can you review and/or test this fix please ?
> 
> Ah, this was on my TODO list (among looking at some other things in this
> driver), sorry that I haven't gotten to it yet. I'd have proposed pretty
> much the exact same thing.
> 
> One thing to note though: You should initialize obj with NULL. Keeping
> it uninitialized may mess with kfree() under out_free_unlock.
> 
> Unfortunately I don't have access to a Surface 3 to test, but apart from
> not initializing obj, this patch looks good to me. You may add my
> reviewed-by tag once you've fixed that.

Thank you, and sorry for being a bit slow with my follow up.

I've added the obj = NULL initialization and added your reviewed-by tag.

I'm sending this out as an official patch submission for the archives now
and then I'll apply it to my review-hans branch right away, so no need
for you to do anything :)

> Also note that drivers/platform/x86/msi-wmi.c suffers from the same
> problem in msi_wmi_query_block() and should receive a similar fix.

Thanks, I'll prep a patch for that too.

Regards,

Hans

