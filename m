Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9526638B91A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhETVpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhETVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:45:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:43:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k132so4528289iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1A1p8wxcqgkCGRzgXg9Z3bfKxbw/WkU2sJz0crshkMo=;
        b=R+i31MfFD5/De76av2drW60fwsQF3hYf9xkxtv1DIDnttM1q7HGBmq6DfvbO7A+Sjj
         y6mFeQWh02jKo4zv/VM/wCf5XZAPSHDFy0Q1RvGo7nZfo7RK1hGNob+hbStvdlGBt33C
         a1rFQNndFuHnmiNuuYa48xLdrIQg4PHiyhKgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1A1p8wxcqgkCGRzgXg9Z3bfKxbw/WkU2sJz0crshkMo=;
        b=tb7HeC/W9/Cv9D7NZ1w00GvoM7vZYXhNxqW0C1R1lN8NzSFJ6RiKTlTaVEDLPtHQLz
         8doJB9sgNgu76GlzytMbQD4frTdfmc2ze2bpxN2mDiV47pl3hfRy/XwifKv/aXa/5gSy
         qYeKv54xj46oMyzEO28XN7rwUZrDuVG1rj40ENydhOiwBPk56BB48P5lVIiIjDbl8ldd
         zgbQ0fZd7P5GXYj6RubtwSRVQAxElZmuEgi5ds4DRYoaR+g+Nv50qQqdx0OncL9Wr5IM
         Pb9KNIhOCnNhJsuTIIZhwt/mcqS0O27xRtKzFVzwVxOgNa+q8JpghiMuGYfzYOjWXZOZ
         NZpQ==
X-Gm-Message-State: AOAM5332YpuHzkTveTkc0tqTb6Tl9O8elOGTSsXSsVY7oCB2fjakaIt5
        CFKzlZtCkKf4OWkQQwCdPeVG8g==
X-Google-Smtp-Source: ABdhPJzVBE+iOJ9hND8REK5+FiKRlk5816BqVFJIMhHjKO4FY4Pw7AyzhzP/Z3azwnAdNc1eJ4QEyg==
X-Received: by 2002:a6b:8e04:: with SMTP id q4mr7797963iod.54.1621547039022;
        Thu, 20 May 2021 14:43:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f11sm4620527iov.9.2021.05.20.14.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:43:58 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/45] 5.10.39-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210520152240.517446848@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6c505aa0-8cad-2084-8e54-8d229d050931@linuxfoundation.org>
Date:   Thu, 20 May 2021 15:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520152240.517446848@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 9:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.39 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 15:22:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.39-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
