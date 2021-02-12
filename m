Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE131A285
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBLQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhBLQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:18:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:18:15 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s24so9843569iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2LZ2JaQGrStcFPmdPLSkbc7x+nqthytQJYv/ohBxW8=;
        b=B9Oxk6EjBufHySCTAL4rqDWk3dHlnY0/IQ9n68VOwFvyUQ1AaFMOU0N7ANp0aj/hv4
         OSCntK8fi1ed5BePtgJKx+bZBE2kTxHnIKXtzgnQAulzNH2d7SPlCLOSrqvL80hnuzzx
         FD9NVqb1YlK44s7hyq7wjdP4np/oo5lT9VHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2LZ2JaQGrStcFPmdPLSkbc7x+nqthytQJYv/ohBxW8=;
        b=Y1kMd/I66kDYY2I0tzxe25Fx0zFDwBA9QLyVWiphkBW8ltp1F5/mTGvYTagUMHISSz
         Zj0gJlF050HWGGIydT2n8XmOMU2uo5LyQRZHXCO0AuobW2elMu8MwkHUlxabXr4EIe4B
         yNvQ3nvFPAQUknvk+0V9ms5UaAXROOPRBOCIsm9RoQ81c4/NaeF/0vcMQjjgjuuo7NEG
         68sPWIIgYS9JHQ5V+2G0g/n99H4/5uuvtQus1+G+mt/pte+5TXf1NGrorN/zZa8XcT/2
         cefbIOdZ2MkczrKzlC1gGm5NwbiVsLhJHGw43M3mb2s4E2g+pfU5/e0O82XtU8o4qQRo
         RMVg==
X-Gm-Message-State: AOAM533vwnv8wFRbmazC722CJRdC57Jp3ztUBYowkV3LDJtHReYKb1rh
        +mIQ81T7rPK6t1lf9H6wW9rjnQ==
X-Google-Smtp-Source: ABdhPJyctmuCRH85pEab1OjO6hTweFz0csHEsBUWAyBJyTzNRYeZb7NwnecEnEE8vAaens0TUI5x7g==
X-Received: by 2002:a5d:9f15:: with SMTP id q21mr2707128iot.132.1613146694746;
        Fri, 12 Feb 2021 08:18:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e15sm4266591iog.24.2021.02.12.08.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 08:18:14 -0800 (PST)
Subject: Re: [PATCH 4.19 00/24] 4.19.176-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210211150147.743660073@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4fc13ff8-5cc0-01be-569f-439375817ada@linuxfoundation.org>
Date:   Fri, 12 Feb 2021 09:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210211150147.743660073@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 8:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.176 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Feb 2021 15:01:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.176-rc1.gz
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
