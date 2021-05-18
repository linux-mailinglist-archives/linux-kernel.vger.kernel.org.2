Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92E53882E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhERWyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhERWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:54:00 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB01C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:52:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o10so9594544ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VdPjVFOepKKLAHhlVWJTnEps7ts8Ggqk33oXCvH8Qg0=;
        b=AAwtOtwStpGspCRYoj+ALBWv3GyGzkeiS+ET5st1TlwPGsovdZinbqUeJAhw4Dsecb
         rRpj7Rz1855dWmXVztYSJkLOqyjmNC8/sAOOcXLThDlbj79veqyj8WrgQ4Sq4qVxJ5TB
         zaMbYIwO7Fm+swT/um0BtYGbugWQiV9x7eHzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VdPjVFOepKKLAHhlVWJTnEps7ts8Ggqk33oXCvH8Qg0=;
        b=UOBmOjT0IP2afG/Z1PtVS9TeoLATGarmNTogK/WrJNGFyqAfgIMlV+z2YhuGhlQ2Zo
         MdNYhWEnKtx+NGSiPXgw+PPfAvhI3T50eqE/7SZk/a+vO80LZ4ZmujJ1quO2LPpq0iwr
         vF4zYG7sckSonPVonW3AVi8yi8dwku93oTskKrIPyNsiHX0sgnaqM+YrAWlXOwwxwsWd
         d+Ef2LiL4etpqGTwb18X4317r52pX7iVCR4aU5bWmI/r3pMT8oiReCl7eFSjIUOUf7GW
         qs8tLRHxXc2/jMaQGY5BVCoafK3uiChlgLFHxqH0h41CM4YYaVfWy3pjUtnZ9PFPNKld
         uVyA==
X-Gm-Message-State: AOAM531zUO8+yXLsM2m5yjwjs+WEsybwOPc07bcCyhjh+JRtxz6mWlFL
        J3yTrBpINvTAUYvy3Wc079bLZg==
X-Google-Smtp-Source: ABdhPJzD+XDOKCOMiSTOscv3E+3Dq3ehEhKKYFtKkh9GujzXAT7mk/k5c/QA/A6SP56Up7k1mbi6ew==
X-Received: by 2002:a05:6e02:b29:: with SMTP id e9mr6741205ilu.175.1621378359942;
        Tue, 18 May 2021 15:52:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z3sm9725671ioe.40.2021.05.18.15.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 15:52:39 -0700 (PDT)
Subject: Re: [PATCH 5.12 000/363] 5.12.5-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210518135831.445321364@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <529be936-3c74-94ff-e1a4-016d6c68ba38@linuxfoundation.org>
Date:   Tue, 18 May 2021 16:52:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518135831.445321364@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 7:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.5 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 May 2021 13:57:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
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

