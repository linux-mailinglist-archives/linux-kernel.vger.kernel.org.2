Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E709334872
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhCJUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhCJUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:00:43 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08CC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:00:43 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r7so1117259ilb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qCOzpW4PznF1QKf0Ym6g+8+qtV4eMkBQiXHk1yM82Is=;
        b=C9s2CuyQR4TvO7aP86+BYu97+n4i40lH3wUcscfPQsRiSV09bOR8ILfXITT8PIFcX6
         ByoR507pvY0wFVwYopBGfeNmx6+qP7tUGetPRPhHpPjx0Tbp3mGrP3raVr6kbBYT043x
         NmG+Kv+4fz2AtMMKvI8PIoOqWx27EsfGfRz4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qCOzpW4PznF1QKf0Ym6g+8+qtV4eMkBQiXHk1yM82Is=;
        b=q0bcyEQNRBlQXPxQR3JIoZJDRUsKGJcxr/yJYdKB1DW/qnWHFu6In6F1PRLB13mcb+
         bRaTSxXy2tlBuksyDZrrULQc13BOnW2WGRK8Bn38o6IjzK9SI1lXDGnw6iytAvXkqL5G
         yEJFBHYX90+Xy4mySig0aiR3luIxTiN/+fecW2nMKfbgcaS4vRSU3ezWFvRcro+Zairc
         k3TnoEKdjIN6w7L5Ses88V5RM345FwooOAt9qTKUG6ASlBmFC/LkIKzscLmsxSmOjYFc
         XjemJZz63A4L/l0wE+rXpuC5rbajkNajHpNXrO47YBfNDHEmre7U/pl+fWu/Jo5MNic4
         EDXw==
X-Gm-Message-State: AOAM530djle45mMFOa4Eni4RKLNj8wiwWTdi5Vo88CG50mUNcbiOyrhy
        +MRdY5XgcBnsozHqyLrS1zFV/Q==
X-Google-Smtp-Source: ABdhPJyVL+43X2TmVb0Oxm+hxEmPfz1gSsk/+7MeTkPHEvUoflODj1fkAlLI9DPpELow/0M8KmO86w==
X-Received: by 2002:a05:6e02:586:: with SMTP id c6mr3931023ils.106.1615406442481;
        Wed, 10 Mar 2021 12:00:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g14sm265256ioc.38.2021.03.10.12.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 12:00:42 -0800 (PST)
Subject: Re: [PATCH 5.10 00/49] 5.10.23-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Elder <elder@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210310132321.948258062@linuxfoundation.org>
 <CA+G9fYuydf-g2FPOtP9LAX-4zY3EF64Bx0OQjbjn=a4V+0=eLA@mail.gmail.com>
 <YEkPf9e8uSLz7wtB@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <29887711-67e7-cc27-1de2-c82ac7c6ef04@linuxfoundation.org>
Date:   Wed, 10 Mar 2021 13:00:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEkPf9e8uSLz7wtB@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 11:27 AM, Greg Kroah-Hartman wrote:
> On Wed, Mar 10, 2021 at 11:08:10PM +0530, Naresh Kamboju wrote:
>> On Wed, 10 Mar 2021 at 18:54, <gregkh@linuxfoundation.org> wrote:
>>>
>>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> This is the start of the stable review cycle for the 5.10.23 release.
>>> There are 49 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 12 Mar 2021 13:23:09 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.23-rc1.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> While building stable rc 5.10 for arm64 the build failed due to
>> the following errors / warnings.
>>
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
>> CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
>> clang'
>> drivers/net/ipa/gsi.c:1074:7: error: use of undeclared identifier
>> 'GENERIC_EE_CHANNEL_NOT_RUNNING_FVAL'
>>          case GENERIC_EE_CHANNEL_NOT_RUNNING_FVAL:
>>               ^
>> 1 error generated.
>> make[4]: *** [scripts/Makefile.build:279: drivers/net/ipa/gsi.o] Error 1
> 
> Offending patch dropped, thanks.
> 

Thanks. Saw the same error on my system. Moving on to rc2.

thanks,
-- Shuah

