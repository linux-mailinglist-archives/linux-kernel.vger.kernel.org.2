Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A83749D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEEVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhEEVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:05:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CEC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:04:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id p6so2365190qtk.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xG/XRIBOsojsF+JhtxGeLrSZDjLEWjEpnR/E1+kZdOk=;
        b=K36Y8TTdw9lVfi0yRDet6GlddaVEDvg3IFYh1TVjrZv5+JisTwpC1jefSWcKWcQz2L
         7E9thydxW/yh+VSAyMBPrF+TLnnxjRc8ohjliXGXvGKDaFk+6Go7RA13pf7T57h6LO8F
         91xYXJye+p+jIYPHMCnT+Jz7SvOs22d7Vnnmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xG/XRIBOsojsF+JhtxGeLrSZDjLEWjEpnR/E1+kZdOk=;
        b=ode+RmYpXnxauEkfAU3PxBYOpxBP/wxpmJ1lyOJmRH0pN02gw5KTlo8e3/kN/zv/MC
         LIaBuCRGUPu/8iA/YfoG3fGoXTkXVqHLGKBcNb5NWzEKVXNBbjCtBU2sTuvda8OXTa6a
         8iOVCIX2Bw6DbI3QvNC/FDqM8QCRAbL0DL0ojPsHCJRVzhAbNRyqtaYLVkaXahVqigoK
         a7n+LM9K+l3jc4sYqLPGWQOAqlV4QQQNJglYd0F722N6ujDfOS31aEdufWWd0Mzf4REK
         okuG++YWXzJAMZoPaPVT5DGavX9oRTFW71ksBy9sILQz6MNEfmkXunZpQiMy1ISCsjO8
         7J0A==
X-Gm-Message-State: AOAM532QjgemV1shnKoWn/Tha2CCLAIV6PuqBzpkU4GsCv2uPGr1wczu
        me/AVsFehIVAJwBkoEyPcO9hHw==
X-Google-Smtp-Source: ABdhPJzSi3CQFVg+8/27Z+S4SXg0bhNnsa19khGcvzLdNjM5eTADdnn6NWbALc7PMkzxuwMUWjhmBA==
X-Received: by 2002:aed:2043:: with SMTP id 61mr577556qta.308.1620248687067;
        Wed, 05 May 2021 14:04:47 -0700 (PDT)
Received: from [192.168.151.33] (50-232-25-43-static.hfc.comcastbusiness.net. [50.232.25.43])
        by smtp.gmail.com with ESMTPSA id y8sm395066qtn.61.2021.05.05.14.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 14:04:46 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/29] 5.10.35-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210505112326.195493232@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31d2060d-8a9e-eedf-d4c2-3003141fd532@linuxfoundation.org>
Date:   Wed, 5 May 2021 17:04:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505112326.195493232@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 8:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.35 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 May 2021 11:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.35-rc1.gz
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


