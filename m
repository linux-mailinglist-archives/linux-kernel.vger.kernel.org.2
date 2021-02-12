Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A731A561
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhBLT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhBLT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:29:02 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:28:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e24so360472ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPMtzLnlt4VsMWUnR2fTirOhyXKhGfmXdJkhsBcAKOQ=;
        b=EwWZA0XKqw7csZDrwBHuPEWnLeZQ+hSSFszis8NThmD4ltreQi2+ivAO/wH6tZHOjm
         usSovTFTSlxL2y8TB+QYUd392rzy1DIFVIlXbklf/BOqrA8h2I9VYPveCKxL3mH69Bf2
         SRPq4FRezzABvtrawtXOke1Mo0rUCyf4GiJMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPMtzLnlt4VsMWUnR2fTirOhyXKhGfmXdJkhsBcAKOQ=;
        b=RsmTRw2pBE5c2jEPmsUs0Bn94MM4LqkbZ+OSVoddJPxGhlwPjvdDCxyOat6VuWGfJk
         ETz1U061XX5A2UGCTUL6WViGLceNnXQG9WY6Tzs+Yt5me1LQbnt/qv8gjDFFfFXL79kd
         1sC/InP2oyoNgBs4Io/1dET0f5bZLGUQdvR1NxuaYuzJ8msebbxZakhmXKgpC0tpwdNt
         AzxTwcN5lLsCPiuwgLVGvbPak0lQu/CnfId2koQd/yLJHoPXL83HYKlGjK7sL4VjQf7v
         dz/jl7V6YMzXg4NYHR7ZHVXSlIw1mQ7uI668lH6MN9VWZCqSxG/mQkXiQvRSNVqNBT8C
         unxg==
X-Gm-Message-State: AOAM531bpqstHvhIS1v79d3a4QBOeCCwA6VejufiS5aJTEjOsfvYh28K
        ttSCps9Ff8lY+D6fS7MiGusqnzA1upUSLA==
X-Google-Smtp-Source: ABdhPJw35/TKYlCUoEmdwHVAMMSCsLA9Pz21NfjqOum67K9ijGXbIOEo5b1kt03S+tAd4+jeWY9/0g==
X-Received: by 2002:a05:6602:3283:: with SMTP id d3mr3304506ioz.53.1613158102081;
        Fri, 12 Feb 2021 11:28:22 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w8sm4808988ilu.1.2021.02.12.11.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 11:28:21 -0800 (PST)
Subject: Re: [PATCH 4.19 00/27] 4.19.176-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210212074240.963766197@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <32820f45-329d-35f4-7e37-62a433947722@linuxfoundation.org>
Date:   Fri, 12 Feb 2021 12:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212074240.963766197@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 12:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.176 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 14 Feb 2021 07:42:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.176-rc2.gz
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

