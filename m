Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF273054BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhA0Heh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317485AbhA0AEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:04:05 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6BC061D7C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:37:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 16so17711ioz.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XLkL9gAp4GOcfsip1seBzPhJM2LBpEpWuh61DioHRU=;
        b=cfLqWE29sj/lQDsw/lGzxCK7GsTQRxm5SiWfZypeNNd1phdgawIKcSP7GwcJ3ubiqS
         IlxcaPR/uYu9xTYPrkadFY53RuhVylezfhJcO1sRxaxaxprUzFKA9z8mkkPiwyVeSFFE
         TArgTP04G1sFFBlsFnIho2sNoCWIM5PPh4TjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XLkL9gAp4GOcfsip1seBzPhJM2LBpEpWuh61DioHRU=;
        b=I3fls2q9afiVTfuLbDWFOXLsvVUBK7gDQ8FXTLL1bHv39gg6ou79Utl0YybiXiVzDg
         Z1iKFydIu8o3QROH7yGRQ/+WB/JpcsUfkjFkZOmA0CovVbh4fyJkm4bi7KRn826oYpeF
         /QF/LVqa0zPntfZXc3qsfsn0z/N9Dt3UxQNfEU1BTjPZIjytVyUPQYYAsFbbcVP0lTvM
         Ah6Psrs3GSj8fOgUyk2K1YuV7syAoIR8R9AKg+CkpxNMO8MA6t9ObXw0uPnGZsmugsv4
         WIJroGT4ieljEIDUKCwYhes8OkdmHspa/GFVkIvhSfP33BdpP/5rkooJBRLp0NmGk6GQ
         CIsg==
X-Gm-Message-State: AOAM530pYo2CgyJRsPhCmnvqJ014WCd6fgbRUHob5VmzEBXbtO2ReaGw
        vZWsc1Vtkxw0HvMNJ/q8hdcn/A==
X-Google-Smtp-Source: ABdhPJzGwhqRLF7ljL1K1LWE2mIBZkV+bq+I0efKmuEP/Q+ep+iiu20rSXJ2JKHR2EGsZYNdxNyZqA==
X-Received: by 2002:a5e:8903:: with SMTP id k3mr5759973ioj.36.1611704235161;
        Tue, 26 Jan 2021 15:37:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x16sm92244ila.50.2021.01.26.15.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:37:14 -0800 (PST)
Subject: Re: [PATCH 5.10 000/199] 5.10.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210125183216.245315437@linuxfoundation.org>
 <c5de2e29-dba1-a49e-33ef-08d71d572479@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fca352ef-fceb-93ea-439b-a3eb96c857bc@linuxfoundation.org>
Date:   Tue, 26 Jan 2021 16:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c5de2e29-dba1-a49e-33ef-08d71d572479@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 4:34 PM, Shuah Khan wrote:
> On 1/25/21 11:37 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.10.11 release.
>> There are 199 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 27 Jan 2021 18:31:44 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.11-rc1.gz 
>>
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-5.10.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compiled and booted on my test system. No dmesg regressions.
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Please ignore this. I tested rc2.

thanks,
-- Shuah

