Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064A237AF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhEKTub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhEKTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:50:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCC6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:49:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so18517894otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pmkqgPMF5ceXIIKhSMwOqpjXSv0jHA6XJLmFaPUUq7Q=;
        b=UD0NjasZFb44xuO9e2QIKz62+dpk+P9m8NklcStwlx3+Ah9FeF4emjrnQnqjsr7FrO
         5vyI5jE0BQT2n1sCDpdpkF4T0lENVjepWIOpsLTc4gdP8rtgxykX2OHbymDZ9rzgCZJA
         eG7+tXQhlvEk2XfWOOLPxX51HezQLOelubWVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pmkqgPMF5ceXIIKhSMwOqpjXSv0jHA6XJLmFaPUUq7Q=;
        b=RWDCrnyJHEGtbutyEJ8afvU9SNLTKFr/KpeFpAvjeEKXT/FZdm0brNfR590dLQMTVQ
         RJjurvWXKCxXBdXo3qI36oM+p606r0HD6r268ybNnR/XmzbFUb9U7aH1bsb1WxYvZ2xd
         iS8YIMa19KpXSD/xRJrbjbngb2kjzRxJ6g5E6Bzy0cUTgad6+DaMmE2cV1M2hLemkpef
         uKdIV4masS2OZKVAKo5DxCDmGHhEkWsk0NatMI5baVw9MK5qKZae0QBILs/waWw+ovAB
         PY3PIgfIh8LR4lh+ouVv5CW6wkexp8QQIuB6eRjOpjwZBzscwwONgtclLwRoBuUZWU+m
         W6Rw==
X-Gm-Message-State: AOAM532wl2zGbTlKj/0AoLomMBaA+dl2PpoEmrG47TxuI+oR7Hi+xSGn
        /X/2n7rgguUKftaBol5t1l3lZA==
X-Google-Smtp-Source: ABdhPJwJWMmsKBZ36Qw/UXEXFmR5kjq9X8PaGE8a2Xk4ECco0rZT34WOQRbXHVU1vS3J7bUlPN7QRQ==
X-Received: by 2002:a9d:7b57:: with SMTP id f23mr27282453oto.150.1620762562505;
        Tue, 11 May 2021 12:49:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm3450477ooq.2.2021.05.11.12.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:49:21 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/342] 5.11.20-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210510102010.096403571@linuxfoundation.org>
 <396382a7-9a50-7ea1-53a9-8898bf640c46@linuxfoundation.org>
 <YJqIOajso0EyqgjO@kroah.com>
 <3244bd40-3afa-8386-3378-220ff2e2527d@linuxfoundation.org>
 <YJq0yCirpEV+bgC/@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01f12fb8-b4e0-189d-61fe-ace8c4c65b10@linuxfoundation.org>
Date:   Tue, 11 May 2021 13:49:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJq0yCirpEV+bgC/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 10:46 AM, Greg Kroah-Hartman wrote:
> On Tue, May 11, 2021 at 10:16:00AM -0600, Shuah Khan wrote:
>> On 5/11/21 7:35 AM, Greg Kroah-Hartman wrote:
>>> On Mon, May 10, 2021 at 04:48:01PM -0600, Shuah Khan wrote:
>>>> On 5/10/21 4:16 AM, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 5.11.20 release.
>>>>> There are 342 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed, 12 May 2021 10:19:23 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.20-rc1.gz
>>>>> or in the git tree and branch at:
>>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
>>>>> and the diffstat can be found below.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>>
>>>>
>>>> Compiled and doesn't boot. Dies in kmem_cache_alloc_node() called
>>>> from alloc_skb_with_frags()
>>>>
>>>> I will start bisect.
>>>>
>>>> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> It might be due to 79fcd446e7e1 ("drm/amdgpu: Fix memory leak") which I
>>> have reverted from 5.12 and 5.11 queues now and pushed out a -rc2.  If
>>> you could test those to verify this or not, that would be great.
>>>
>>
>> I am seeing other display issues as well. This might be it.
>>
>> I couldn't find rc2. Checking out
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> linux-5.11.y
> 
> Ah, sorry, pushed the -rc2 patch out now, but the -rc git tree has it as
> well.
> 

5.11.20-rc2 compiled and booted on my test system with 79fcd446e7e1
reverted. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
