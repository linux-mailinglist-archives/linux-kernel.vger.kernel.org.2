Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244930F7A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhBDQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhBDPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:11:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A23C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:11:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o10so6122565wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLHUheX144OUCKrRDcQ3sskV3anc0+eFy1rDH/g9KUo=;
        b=ofW8Zg13fOOYn/rvPdARW/xpvDh/i9PblhVOZqwAuj4Kktui9pwUTA/EXUanbTUM//
         1OFfCw8mZI9zbLPvJH4XxSlCHNbR18sdt9y0sOn7eihZiD2ouhjLoqj6+U5VCbeZD/GR
         C0uzalJqZzLejZWpWBecSIapQdXg5C4jOltfnTvpiXAlOGP8xh2k2p9xiN5kMfg3LKtK
         6G4QNHUrWFthegZIQrOgca1axBq0MsUIChYilgOS46G0lZ/7sOpmiBSLgkeksjl4BU6t
         PrVoGhBPRy6pEo3zDwgxnQpVHo3K5YNbCxXFz0ZK7M2UKJdGbgIstFSwybpKb9penGxZ
         Z/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLHUheX144OUCKrRDcQ3sskV3anc0+eFy1rDH/g9KUo=;
        b=TyA0jC8TcrE7PbIiFqjV8n8vjhAnHsOL+ry4xkc2oP/Fu7JLul/fYYRCfPcGDpWYQk
         eI5e4ImMaR0qlYJ8ZTB/HLzEdYaS9v8u/2UhNrKJWIsZrNdq8GYgCk90Zk0wEJFyH/Hx
         RP48xMAcmwTL4tYoFqoEGs+Vs5C0Y8WxrFQVSw+hSmY0hMC9mak9wufYuSY05PukUQ+b
         QvyI951vTr9/oVKU6tb7FfaH5ih0ev3WWJHcMpoPQWVJvCuFcUAx5oQx3vKTP0O9kVg9
         VujNiTZasZC48nudOx+hKFJD16hNd756yZzwrKc4iOQb3HPhRB/oJPwL8g/mTm2AcJ3t
         s+gg==
X-Gm-Message-State: AOAM530Tihmmg3fxn6uB1TjKwYbxQ9cVwiDTiL7mCgtjV3YFlvVJhkJ0
        RBFMhpa6ghimLk+FNwTrR28=
X-Google-Smtp-Source: ABdhPJzzMh3+ci+6dagHGTuJ+OUpUC36f/ka5fE3vHaDUZ+geZ9I0jUbcNus8eDU5zQGeL6jQzTeVw==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr8933wml.52.1612451458908;
        Thu, 04 Feb 2021 07:10:58 -0800 (PST)
Received: from [192.168.2.202] (p5487b0c0.dip0.t-ipconnect.de. [84.135.176.192])
        by smtp.gmail.com with ESMTPSA id y63sm6238750wmd.21.2021.02.04.07.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 07:10:58 -0800 (PST)
Subject: Re: drivers/platform/surface/surface3-wmi.c:60:14: warning: variable
 'status' set but not used
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <202012291140.j73hBz45-lkp@intel.com>
 <184b4ec6-65f1-5a22-487b-20cc0fb1b587@redhat.com>
 <1a749e41-86da-8607-ec39-c91cf4107a9f@gmail.com>
 <80b763f8-8a19-aada-ae49-515fda2f209c@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <db324b69-8046-86c1-a42a-578e2c934f55@gmail.com>
Date:   Thu, 4 Feb 2021 16:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <80b763f8-8a19-aada-ae49-515fda2f209c@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 12:36 PM, Hans de Goede wrote:
> Hi,
> 
> On 1/4/21 4:24 PM, Maximilian Luz wrote:
>> On 1/4/21 3:52 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12/29/20 4:58 AM, kernel test robot wrote:
>>>> Hi Maximilian,
>>>>
>>>> FYI, the error/warning still remains.
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
>>>> commit: f23027ca3d48b6f93c5994069fb25b73539fdf34 platform/surface: Move Surface 3 WMI driver to platform/surface
>>>> date:   9 weeks ago
>>>> config: x86_64-randconfig-r001-20201221 (attached as .config)
>>>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f23027ca3d48b6f93c5994069fb25b73539fdf34
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout f23027ca3d48b6f93c5994069fb25b73539fdf34
>>>>           # save the attached .config to linux build tree
>>>>           make W=1 ARCH=x86_64
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>      drivers/platform/surface/surface3-wmi.c: In function 's3_wmi_query_block':
>>>>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>>>>         60 |  acpi_status status;
>>>>            |              ^~~~~~
>>>
>>> I guess fixing this would require something like this:
>>>
>>> From: Hans de Goede <hdegoede@redhat.com>
>>> Subject: [PATCH] platform/surface: surface3-wmi: Fix variable 'status' set but not used compiler warning
>>>
>>> Explictly check the status rather then relying on output.pointer staying
>>> NULL on an error. This silences the following compiler warning:
>>>
>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>    drivers/platform/surface/surface3-wmi.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
>>> index 130b6f52a600..4b7f79c0b78e 100644
>>> --- a/drivers/platform/surface/surface3-wmi.c
>>> +++ b/drivers/platform/surface/surface3-wmi.c
>>> @@ -63,6 +63,10 @@ static int s3_wmi_query_block(const char *guid, int instance, int *ret)
>>>          mutex_lock(&s3_wmi_lock);
>>>        status = wmi_query_block(guid, instance, &output);
>>> +    if (ACPI_FAILURE(status)) {
>>> +        error = -EIO;
>>> +        goto out_free_unlock;
>>> +    }
>>>          obj = output.pointer;
>>>   
>>> Maximilian, can you review and/or test this fix please ?
>>
>> Ah, this was on my TODO list (among looking at some other things in this
>> driver), sorry that I haven't gotten to it yet. I'd have proposed pretty
>> much the exact same thing.
>>
>> One thing to note though: You should initialize obj with NULL. Keeping
>> it uninitialized may mess with kfree() under out_free_unlock.
>>
>> Unfortunately I don't have access to a Surface 3 to test, but apart from
>> not initializing obj, this patch looks good to me. You may add my
>> reviewed-by tag once you've fixed that.
> 
> Thank you, and sorry for being a bit slow with my follow up.

No worries.
  
> I've added the obj = NULL initialization and added your reviewed-by tag.
> 
> I'm sending this out as an official patch submission for the archives now
> and then I'll apply it to my review-hans branch right away, so no need
> for you to do anything :)
> 
>> Also note that drivers/platform/x86/msi-wmi.c suffers from the same
>> problem in msi_wmi_query_block() and should receive a similar fix.
> 
> Thanks, I'll prep a patch for that too.

Perfect, thanks!

Regards,
Max

> 
> Regards,
> 
> Hans
> 
