Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE93EBEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhHMX04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhHMX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:26:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE705C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:26:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b7so6346728iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxuiDhwFd5/1+OCBgqMGo92C3FHs10czCMmzZapYzHE=;
        b=Oj0N9cDZ9O9c8vzbLbDwgR4qGQFxbodUjWThHcbb6ddIA4Fys970KUpFCmEDd72NeT
         mn24Xh0mafXq823IQrAsYawniun0+AA6bi5twP7Fju1OTlnpDdutig81mfvANA8St99W
         hZWNMPALR/K3FyJ2fxnHeOm0sYA7M2YTNYNdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxuiDhwFd5/1+OCBgqMGo92C3FHs10czCMmzZapYzHE=;
        b=FFSXWGe8x3C/nuIFF9VdmsKKN5ll5wDLihL6XqIisBICCkeSqAUZHHu9z2GPC6KRsa
         aewYIUk6xXiBDMtzW052Ro8928r50lucG/D+mFOIO/QQsAxMvNGthoh9DLVE0JpCSKt3
         Hlopqc551rj7GYnzi+7+VkEaaDQ2hzIdagWAHh4bTjEd47tgzE91YxHqZwc4X+mW66Jk
         C472cqzChKU98iQo8xDkKwgeuccDDKCQryC5f6YNJvFxhG0NNKaGK3lm+cKdGLPk8uMa
         BX1D4nfGVk3FClmZrlLOFK7NCBRucbBo/Ru3ubHEiojLWmQU81/QXWJDJ4ua3hIBWzRO
         7yLw==
X-Gm-Message-State: AOAM531PiXmSyOgfoH7QklBx0kDyZ2GLwugy8Z+m6yxC6Dx7wdQazlw/
        U1ItedPu71aWHYuAj9kEg3hxPA==
X-Google-Smtp-Source: ABdhPJwUoQ3XBf4BUzo+IvppWotMbhMHpo5R+GLKF5XsXnL8TMWAY0ES7O8X8hJ2HMtdzD6g821tUg==
X-Received: by 2002:a02:caa1:: with SMTP id e1mr4456669jap.107.1628897186197;
        Fri, 13 Aug 2021 16:26:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p19sm986512ilj.58.2021.08.13.16.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:26:25 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/25] 4.4.281-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813150520.718161915@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d0a2bd6-3f9f-ccee-a442-855ba610f97c@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 17:26:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813150520.718161915@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 9:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.281 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.281-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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

