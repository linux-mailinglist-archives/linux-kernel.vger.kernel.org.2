Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E644329CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhJRWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhJRWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:35:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412FC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:33:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so44189063wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBrHKx5MlDJhM1Fjd8a1chOOO8qrN1C7K+G5IYkgtk0=;
        b=FVJ38wshuhiEMGZnG9xJ6dbiV6m2JwHT1aKqPQHsHrxm6imeslk/ThnFHLwAjjphnP
         m5neceYs+svCu17i2lBCSNHeAQF+Uodti/KCDM8R3/JD31p1Qd8LzlN9j8her/kRvr0C
         FIpVX1gRVsf+igOAhdVTBJTyjQREhFzM0/v+yiEqo9ovRCxEFj7N+mXCihDCo34ZHDK6
         cfFEMemuSjq7HAAFz1B+W2IDNMVt01+/+PHBP/bHW4LcPArfDbEh8kJ4qmofjcjANbXL
         LvRZ9w5mZJqyWJYAT1L4kmRXL3gIR/utDvVGY3zb0DiOQxJI5mjy4mdnF9eWeXRpFfcQ
         fiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBrHKx5MlDJhM1Fjd8a1chOOO8qrN1C7K+G5IYkgtk0=;
        b=veuMJAku/n3MHgKP8Nu3pZ3gevVs7V+qpnBfu+yT9+eWXS67QOn5XL9ktRSX2Lx16L
         iTatWuu3FN5gzzCssxJLVXsDxKgffHs4Cq7ItKAXKnxfDueNxk36LiY7p6Spp3bYmQIG
         bj6cchQyTIl5Lp3i017cIh+wgrKW0qkg2p3X5N++0gaOvJ6ty09gZuDl2wQOsa9tkRBL
         TGRHlbxBgxWIfcDQJYBAugFW83TLwF/PTq4RhokK/qPvhVSDkaWunXJi068dAfwxPxtI
         TveuupsBHHFrHgXtIk63T4Vjq9yUeWXbtNUXgD90VkXyUQzB9+YdF67hh77TsMmm3PiH
         Nefg==
X-Gm-Message-State: AOAM532x8QID7lPzARDDmzDwc9m8k5Rbj0kzqSe+FhUYsuUd4NyYJizR
        aO+Z1nGg5oq2iU7MQWY/AQk=
X-Google-Smtp-Source: ABdhPJyGvQO9mNXYnlXjU1fpfLr81rrYr+4yqWGrq53TNhfv/Ap/TMlLzgv3jVdz6m+cgfJmqglR8Q==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr39019740wrm.271.1634596385433;
        Mon, 18 Oct 2021 15:33:05 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::3de4? ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm610308wma.48.2021.10.18.15.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:33:05 -0700 (PDT)
Message-ID: <5880bb1e-46b5-4c90-294f-8a5f5f20a4df@gmail.com>
Date:   Tue, 19 Oct 2021 00:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] staging: r8188eu: Makefile: don't overwrite global
 settings
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016173544.25376-1-martin@kaiser.cx>
 <20211016173544.25376-3-martin@kaiser.cx>
 <c66442a2-51fd-70bf-d9cf-5991c0d88a76@gmail.com>
 <20211017174621.dkunl2xhjg4yn2at@viti.kaiser.cx>
 <54987f44-cabf-c12c-ae3b-341ff6b1ed98@gmail.com> <YW2KGZ6+ZdQzwQu4@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YW2KGZ6+ZdQzwQu4@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 16:52, Greg Kroah-Hartman wrote:
> On Sun, Oct 17, 2021 at 10:46:11PM +0200, Michael Straube wrote:
>> On 10/17/21 19:46, Martin Kaiser wrote:
>>> Thus wrote Michael Straube (straube.linux@gmail.com):
>>>
>>>> On 10/16/21 19:35, Martin Kaiser wrote:
>>>>> Remove settings from the Makefile that are set by higher-level Makefiles.
>>>
>>>>> Some of those settings might have been useful when the driver was
>>>>> maintained out of tree.
>>>
>>>>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>>>>> ---
>>>>>     drivers/staging/r8188eu/Makefile | 14 --------------
>>>>>     1 file changed, 14 deletions(-)
>>>
>>>>> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
>>>>> index fccf7e6d1520..8294fb69ecf9 100644
>>>>> --- a/drivers/staging/r8188eu/Makefile
>>>>> +++ b/drivers/staging/r8188eu/Makefile
>>>>> @@ -1,8 +1,3 @@
>>>>> -SHELL := /bin/bash
>>>>> -EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
>>>>> -EXTRA_CFLAGS += -O1
>>>>> -
>>>>> -ccflags-y += -D__CHECK_ENDIAN__
>>>>>     OUTSRC_FILES :=				\
>>>>>     		hal/HalHWImg8188E_MAC.o	\
>>>>> @@ -46,15 +41,6 @@ _OS_INTFS_FILES :=				\
>>>>>     _HAL_INTFS_FILES += $(OUTSRC_FILES)
>>>>> -SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
>>>>> -
>>>>> -ARCH ?= $(SUBARCH)
>>>>> -CROSS_COMPILE ?=
>>>>> -KVER  ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
>>>>> -KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
>>>>> -MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless
>>>>> -INSTALL_PREFIX :=
>>>>> -
>>>>>     rtk_core :=				\
>>>>>     		core/rtw_ap.o		\
>>>>>     		core/rtw_br_ext.o	\
>>>
>>>
>>>> Hi Martin, this patch introduces a GCC warning on my system.
>>>
>>>> drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function
>>>> 'rtw_wx_set_enc_ext':
>>>> drivers/staging/r8188eu/os_dep/ioctl_linux.c:1929:9: warning: 'strncpy'
>>>> specified bound 16 equals destination size [-Wstringop-truncation]
>>>>    1929 |         strncpy((char *)param->u.crypt.alg, alg_name,
>>>> IEEE_CRYPT_ALG_NAME_LEN);
>>>>         |
>>>
>>>
>>> Hi Michael,
>>>
>>> thanks for reporting this. So far, I can't reproduce the warning, even
>>> if I enable -Wstringop-truncation explicitly. I tried this with gcc
>>> 8.3.0 (Debian buster) on x86_64.
>>
>> Hi Martin,
>>
>> probably only newer gcc versions produce this warning. On my system
>> the gcc version is 11.2.1 (openSUSE Tumbleweed).
> 
> I have gcc 11.1.0 here and I can not duplicate this warning.  And it
> looks like the code matches other places in the kernel where this
> happens, so I'll just take this for now and see if someone wants to send
> me a real fix for it, as it is independent of this Makefile change.
> 
> thanks,
> 
> greg k-h
> 

I totally forgot that I have an alias for building that sets W=1.
That's why I got this warning...

However, I sent a patch to fix it.

Thanks,
Michael
