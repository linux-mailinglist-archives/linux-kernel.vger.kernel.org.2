Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A33EBEAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhHMXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhHMXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:23:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3BC0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:23:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id t13so1870904ioj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5J57T3dmZ8ILbY+iMplV5fsHhs7iRWuEDY+4joOqmog=;
        b=UBMjTXgcsVJOqgJiaqg4RWy5jvKOhMpTNxU39L1eWlkOYbTY5MvF86myp8KptFDBw4
         tkZRWg3gEomPEH4/vUAGrUzpfxcSuSjhJoGAL3JGlaQJjZdfpwVziYEpWIkU0E69iYAW
         xm0CPEUPiUMa2geUWFbHbqVkQUmvlX27XAtD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5J57T3dmZ8ILbY+iMplV5fsHhs7iRWuEDY+4joOqmog=;
        b=mQPgtvl9xbbNSdB2gMprzP1NWPp1tGQ2fWPcsp3neeEAgGDzP/ugrlqF0pMzdIiS/i
         a4bcbxsVh8zGkDw69rJMwDaaWBZod7VJP1eQXNYSpAQHxItneUN/nqPXdghDttpONqUA
         H6Sx78ZfO3jL4KyDWB06nXSu99X1Ya0ylPBs1ysJFB6ezCbhNXveMYC4f/vVHHYFz3xR
         DIexotulslI65z3fvRd0Y6/Z2mm/0kBT59Kx+Iy+erwA00evXwfaln8+uNtRPCtaG+lo
         bSuFoa0wYcb0vGe7Izt1tjleYNLn130aJX00Jc7U6YHmbh/PkjzoDNBU6aSSokS2zUzR
         ugiA==
X-Gm-Message-State: AOAM533fXaGZN3a5ZpMGekuYFiVCDDrPADcOz7u+WTufSZ6j5IOCf1jm
        LqECxYg8bECMK/uv5bSae/5V6g==
X-Google-Smtp-Source: ABdhPJzkPJvxqUZERW+rxo2hUEds5YJ/30NnVZ5aJ3Jqf5CY3/6mCinLF5DoNAbe+n7rOpuwqFhVjA==
X-Received: by 2002:a6b:6319:: with SMTP id p25mr3880383iog.100.1628896985962;
        Fri, 13 Aug 2021 16:23:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u13sm1569428iot.29.2021.08.13.16.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:23:05 -0700 (PDT)
Subject: Re: [PATCH 5.13 0/8] 5.13.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813150520.090373732@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ecf70c95-f15f-19d7-757e-6cda334528a6@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 17:23:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813150520.090373732@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 9:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.11 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
