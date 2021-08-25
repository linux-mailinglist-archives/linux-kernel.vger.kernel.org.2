Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3C3F7EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhHYWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhHYWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:35:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B257C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:34:57 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u25so1582607oiv.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VcwbgpFB5257a/tKAipZOB8IAHDgar0MdJDHoygDOow=;
        b=Yw10ev+ijpGPnZuuy5kfJtFGdzNp3uInUo7ZpQErkk/wEtfEcQec3oQc+JA89S5MUy
         N2VkRCaGKk9dKEHoyd9pbl8+6Db/tV1h+G0P9nnhm9i1radl2sVzWrSscaYKWEjQPIC9
         HKAUzl2rN6mhg1hXkNmKoui3xXpMm5Kt5x1ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VcwbgpFB5257a/tKAipZOB8IAHDgar0MdJDHoygDOow=;
        b=CtM8G/Sp4pJH37S07ijCanodZboogyS/AVAhojFZgswld3DMWxgb+zeg1Scy2rtG4v
         dH0LwmMFEkzXuEw/xPzEzcmxJTqLLS5QT1SVKXKiRi2vBAvEeW4+rkO5X9yiAQuQ9CzT
         zw/NcphowXwcVLTcNq/7GN/ReqqmCr5whpx/Yo4iSLucIhQ738ORb4pzGtw9dDv7nU5Q
         3VeWwT5tQaMyJLbuL0yHrB+g7XmmGT32hgxGklSi09bjZkx+b22xYBOQ/n+7lYC8tzcs
         47Kx2tbH3oZ6SA3SGi5aC3nR94dnkD6cHvnIsdz+yEauPvKY+iQJglNYGoYUSBQYfAiX
         CjdQ==
X-Gm-Message-State: AOAM532pFnL9iJXKveXJKLU7RpS6BaIQyWjFb3KT9mCemO/AY1D+fQFo
        yD36iyxXbJWO+h4o8f7seF3eYQ==
X-Google-Smtp-Source: ABdhPJwCPYpXVbwtH2YsEKHQAFLkiXeOygfreyIxe7l0h2/PmcvkgWnElRMJoSXm0Ezq79KrHHjshQ==
X-Received: by 2002:a05:6808:6d2:: with SMTP id m18mr240825oih.120.1629930896636;
        Wed, 25 Aug 2021 15:34:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j2sm272443oia.21.2021.08.25.15.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:34:56 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/127] 5.13.13-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824165607.709387-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1d26e6ba-29d1-15ce-093e-5cda076b76c7@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 16:34:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824165607.709387-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 10:54 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.13.13 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 26 Aug 2021 04:55:18 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.13.y&id2=v5.13.12
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
