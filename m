Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007D38CC86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbhEURrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhEURrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:47:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862DBC061574;
        Fri, 21 May 2021 10:45:57 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso18783947ote.1;
        Fri, 21 May 2021 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fl2/VZAFYEJxYvUBCQJ31kt31+9YYEbeso+EDFYr6Nw=;
        b=ae+FdE6iReeeI6DHKwxhMANMtyfPz0DsAYa5tIVkGYOEs96BQ8RCgMRnCq0aHtvDm3
         8q2NC5xIQrR4kTW8G3v28xp/i9bgQe+D5UVD77jD36Z1FQ/fpTb/HWbJpDuJ2zheT1X1
         kNWiBoqB9+XaWJ6jf5ypejSFrgx/kX4RQWLi5QK3mqt6IUFfxJYAD8lMAYDwGqSDQBs5
         XmuX4lzVquRl4ZTlIX44H8ovM8tETCWy38A+tZj5RylzpXkruIFF0ew/tDZ76IeE5pRi
         4s8y1KCX2hLgB2TVyjSQJj3zwk8ATRyTegclRZXxDJGrSKhtiX8FVGb2dBZnklk4/66J
         eiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fl2/VZAFYEJxYvUBCQJ31kt31+9YYEbeso+EDFYr6Nw=;
        b=ba0BV728EGe2I0m85f/pEw2m4/XhSx6o1abx91/1S6wHotxSqGITugoeQfKE56qi0x
         EUVEh9qlEVu4wq84+/k8Zbn4QkMTg8NYsC30MVJnxN1pjpNpbR5XEfphtuddJi4drTtr
         RTp46DxdaXmX1C39pra5ILAm8mvoxeKqvniqVxIoLbiDBVRNdMAeB76mG7iGRe9PkGW1
         E7ShBjUCjek3x3ln5bQViSuKJtg7NzNiFwfrTm/bLGcTjaDO8q7kjw++qBtp83pHxhMQ
         KdCUmpeQ+15LjguEI54f6biJsRsmF4+TSQKsWNOZrub5MCEnAhwdMBSvfWT+DlqkSx43
         tQ4A==
X-Gm-Message-State: AOAM53358qvb8hGJ7tMiQVILvBkGajAp9uzyE5zIiDn0T+X2TfM148dN
        05/hnU41d5Zfq5Jin+dd+pFW7rjEj2k=
X-Google-Smtp-Source: ABdhPJzrV3qv55FqlzG2NPCfThyYNQO9AgUwaEU5zITJo2Mv7ZsSdFHKR0RZjkeWg/gBHEdXgN3NnA==
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr9102433otd.77.1621619156454;
        Fri, 21 May 2021 10:45:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4sm1443280otr.80.2021.05.21.10.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 10:45:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Wei Huang <wei.huang2@amd.com>, Borislav Petkov <bp@alien8.de>,
        David Bartley <andareed@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
References: <20210520174130.94954-1-andareed@gmail.com>
 <YKeHBI757jX65ULa@zn.tnic> <2ba654b5-1c08-85da-b932-9d5a92d5c930@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
Message-ID: <13e9db0f-a1d7-8699-a7d9-90246c7df553@roeck-us.net>
Date:   Fri, 21 May 2021 10:45:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2ba654b5-1c08-85da-b932-9d5a92d5c930@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 9:05 AM, Wei Huang wrote:
> 
> 
> On 5/21/21 5:10 AM, Borislav Petkov wrote:
>> On Thu, May 20, 2021 at 10:41:30AM -0700, David Bartley wrote:
>>> This is required to support Zen3 APUs in k10temp.
>>>
>>> Signed-off-by: David Bartley <andareed@gmail.com>
>>> ---
>>>   arch/x86/kernel/amd_nb.c | 3 +++
>>>   include/linux/pci_ids.h  | 1 +
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>>> index 09083094eb57..23dda362dc0f 100644
>>> --- a/arch/x86/kernel/amd_nb.c
>>> +++ b/arch/x86/kernel/amd_nb.c
>>> @@ -25,6 +25,7 @@
>>>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>>>   #define PCI_DEVICE_ID_AMD_19H_DF_F4    0x1654
>>> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>>>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>>>   static DEFINE_MUTEX(smn_mutex);
>>> @@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
>>> +    { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>>>       {}
>>>   };
>>> @@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
>>> +    { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>>>       {}
>>>   };
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index 4c3fa5293d76..5356ccf1c275 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -555,6 +555,7 @@
>>>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>>>   #define PCI_DEVICE_ID_AMD_19H_DF_F3    0x1653
>>> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>>
>> I don't see this define used anywhere else besides amd_nb.c. If there's
>> no use for it outside of that file, I'm moving it there...?
>>
>> Or does it need to get added to that k10temp_id_table in k10temp.c too?
> 
> [+Guenter]
> 
> I think it needs to be added to k10temp.c as well. In the meanwhile, k10temp_probe() shall be extended with support for family 19h, model 0x5x.
> 

Yes, it does [1]. Fine with me though to define it locally there.
I personally find that easier since it would avoid the recurring
"I don't see this define used anywhere else besides xxx".
Someone else can clean that up later if so desired.

Thanks,
Guenter

---
[1] https://patchwork.kernel.org/project/linux-hwmon/patch/20210517064131.4369-1-andareed@gmail.com/
