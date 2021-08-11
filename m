Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313043E9AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhHKWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:22:45 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B7C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:22:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y18so7011371oiv.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HbOCL8hggztIRnMEXo7ZFaqYUA40MuqyhWLwnY70QeE=;
        b=LcTXlc6ZkGeUEl4MHITuRo1q4VaVKkRPrRAWq91WNIgIp0S+M5y735EX7Eoe4baOdr
         ZMfTFilq9S/TEtR4N1RSbhzTmMN6+b8Pw13evbJKi+pkL17w/9cM6Kp8A93N0M5Q0fzx
         6L+a3WFEaywRoNiKvOTklBsbL7/uZTcHPr7fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbOCL8hggztIRnMEXo7ZFaqYUA40MuqyhWLwnY70QeE=;
        b=SgOujiA8mDJBB7bfHVF4XcVxDCwO6WNOtoE94yfud8L09puhVeSqvhCn9QlvJrfxeF
         70NOoIO+kbf16DfXYz2mBEcPp5496cAnJRFq3nnucl3yvyn9HSHR+1aEiWxGlfutnsqM
         nTS3qJ9gjsfgUwzJ0zx1LtOsGSQYP71rU8FHUYVJY3gRoETDwl4NwP34m7r2tngx7hsE
         lr276V4le9uiCaSrt6Up/KPWw3RV+JPIQjFtZWjD/pDKHhY4YgoC7/NBEcTLC6bpjl6Z
         Y/hy3EWccFKLw5qVYrf/kKqH0mzA8/t3TTtm6GcAyZ5VwrnB91U6lMWcqrr/kpgS0i/0
         WUxw==
X-Gm-Message-State: AOAM530p82SlRmjQnMRqvgQWYKNMfBWaFBbj4ldm+4dAnQYY/wBJkIt5
        t3SeFysHYcpdMkXmjNfn8Y9CdQ==
X-Google-Smtp-Source: ABdhPJyzGEF1019Zm/zq2rdMWVxts7KfOQQIwKHw4pjX4lB3w2I+cKd23LYAqEqM7e3Ogg5cYOkLwQ==
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr9137944oif.39.1628720541080;
        Wed, 11 Aug 2021 15:22:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 68sm189532otj.57.2021.08.11.15.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:22:20 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/54] 4.19.203-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210810172944.179901509@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <87c3491b-cc86-0b0d-e675-46b2d0c91959@linuxfoundation.org>
Date:   Wed, 11 Aug 2021 16:22:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210810172944.179901509@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.203 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Aug 2021 17:29:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.203-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
