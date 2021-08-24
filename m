Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E53F5842
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhHXGcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhHXGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:32:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68AC061796
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:31:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q21so2632081plq.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RJLKyp38KKp0MOjglAw2SCG7gTfsR3oHk7zotek8Wt0=;
        b=RKNta29d8EnjicCdSrII2r5VS4AAV/eVWQ1h9PJjjEFOmKyLAo/dsS1HL3JjePxsAa
         2MWTtvY7NtDSZseLkkkgG9HSVZUxCjPl7x4MrZmjKMFl2qGvkq2XK8pQDoJ7ZYRtEAhG
         45I2x1InnOvlWmnE3CPqFwgFMC3bU95MkTaXbjQiQojtav7q70401LKRESKibqrvlM6c
         5w/a2HCw47LD8psdzg5hkrdf7AEuhlDQpwkf98hSrHiNWzE5tMLrfeM7/imY2HCD1ymb
         RZzFCEeo+FjtSGOfU0ZBmUjvwwH3alQOaXmfbH0PDczyDOLr8CoY0wO148USU83G5MAZ
         bQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RJLKyp38KKp0MOjglAw2SCG7gTfsR3oHk7zotek8Wt0=;
        b=rMtmt76IcpGBvs98fZTEfJLqrK96zxbC2ohKlk4msRnEPxEsbUk/AZt/aMmnkW4Hzm
         ctz7R+96n6nXj1UduLIG+LYBf4MT/eaZu1cQv15FYBtltKidriVWjVSBS5RY6fhsNzPd
         NvxrWM57XhAz5gv4B0Zbko3W2wEYw78OzFuPLQcujKSptucpT+X7azV6AKyN/OieTa6m
         mN0lCEx+FzBjaHOwkuDczIJ0IyKdd5i8BZT3zJUzR7zR8CMDjRHQV1HT8c0R1P6oD0cC
         7KhHYen5KBR3B6UXjzsCALYiJ5eGsghWMJ4zJsggDcDw7iTOKTUH0GE09C7okO8qDHhw
         uTJA==
X-Gm-Message-State: AOAM530pWDARYwa4QxcDN0Vx8e1pcicJoxzGU0KWz4P0zL3UgAGgCoT3
        BakLyIh+EaYUpsMwu6y/jBaXEA==
X-Google-Smtp-Source: ABdhPJwEUsqkdyZvUbiqMXccroIdnfyzORvPfxNam8AKJQFPuftiTWDAWi7umArFvE/gf9wzNAdq3w==
X-Received: by 2002:a17:902:ff0f:b0:132:3793:3b0e with SMTP id f15-20020a170902ff0f00b0013237933b0emr13824766plj.57.1629786708244;
        Mon, 23 Aug 2021 23:31:48 -0700 (PDT)
Received: from [192.168.10.23] (124-171-108-209.dyn.iinet.net.au. [124.171.108.209])
        by smtp.gmail.com with UTF8SMTPSA id z12sm7328887pfe.79.2021.08.23.23.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 23:31:47 -0700 (PDT)
Message-ID: <ec7a7443-9896-decd-9757-0cbe9740b237@ozlabs.ru>
Date:   Tue, 24 Aug 2021 16:31:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH v5 08/11] powerpc/pseries/iommu: Update
 remove_dma_window() to accept property name
Content-Language: en-US
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-9-leobras.c@gmail.com>
 <8dbd08fb-375c-9f21-f8ab-bec163b157bf@linux.ibm.com>
 <2653ee3e582ba181651e4842821e64d3323fa566.camel@gmail.com>
 <f9f7bcd75d534ebde7cc83c4138176da4680e30f.camel@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <f9f7bcd75d534ebde7cc83c4138176da4680e30f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2021 16:12, Leonardo Brás wrote:
> On Tue, 2021-08-17 at 02:59 -0300, Leonardo Brás wrote:
>> Hello Fred, thanks for the feedback!
>>
>> On Tue, 2021-07-20 at 19:51 +0200, Frederic Barrat wrote:
>>>
>>>
>>> On 16/07/2021 10:27, Leonardo Bras wrote:
>>>> Update remove_dma_window() so it can be used to remove DDW with a
>>>> given
>>>> property name.
>>>>
>>>> This enables the creation of new property names for DDW, so we
>>>> can
>>>> have different usage for it, like indirect mapping.
>>>>
>>>> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
>>>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>    arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++--------
>>>> --
>>>>    1 file changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/iommu.c
>>>> b/arch/powerpc/platforms/pseries/iommu.c
>>>> index 108c3dcca686..17c6f4706e76 100644
>>>> --- a/arch/powerpc/platforms/pseries/iommu.c
>>>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>>>> @@ -830,31 +830,32 @@ static void remove_dma_window(struct
>>>> device_node *np, u32 *ddw_avail,
>>>>                          np, ret,
>>>> ddw_avail[DDW_REMOVE_PE_DMA_WIN],
>>>> liobn);
>>>>    }
>>>>    
>>>> -static void remove_ddw(struct device_node *np, bool remove_prop)
>>>> +static int remove_ddw(struct device_node *np, bool remove_prop,
>>>> const char *win_name)
>>>>    {
>>>
>>>
>>> Why switch to returning an int? None of the callers check it.
>>
>> IIRC, in a previous version it did make sense, which is not the case
>> anymore. I will revert this.
>>
>> Thanks!
> 
> Oh, sorry about that, it is in fact still needed:


Then you should have added it in 10/11.

> 
> It will make sense in patch v5 10/11:
> On iommu_reconfig_notifier(), if (action == OF_RECONFIG_DETACH_NODE),
> we need to remove a DDW if it exists.
> 
> As there may be different window names, it tests for DIRECT64_PROPNAME,
> and if it's not found, it tests for DMA64_PROPNAME.
> 
> This approach will skip scanning for DMA64_PROPNAME if
> DIRECT64_PROPNAME was found, as both may not exist in the same node.
> But for this approach to work we need remove_ddw() to return error if
> the property is not found.
> 
> Does it make sense? or should I just test for both?

Or you could just try removing both without checking the return code, it 
is one extra of_find_property in very rare code path. Not worth 
reposting though imho. (sorry I was off last week, catching up). Thanks,



-- 
Alexey
