Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B343141E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhBHVdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhBHUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:44:04 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD18C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:43:19 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n201so16426486iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQbsD/l1cW53TzZqIiD6lhA89rJilHrW3RY1uwKWz5g=;
        b=UMzul0jHYRvkxmLph1tNt7pUI1OyDIBdDUQmCcsBzOw3KejTWGjXu018P7r8q5MP1W
         6lMK0I0MqV1AGmnmNnnOC5eVWVSHAxZjZ4rJ+RyMeusL3y0SnKgKiqPGlRI3NS7dQ/+D
         MvRw2aWiCe0r2h4vnUZoMVDzzKlHNBSNGAK3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQbsD/l1cW53TzZqIiD6lhA89rJilHrW3RY1uwKWz5g=;
        b=MKTuFrDjnC3eVe0E7HQwdGGKhXBmjMY/gzTwb1zzwphveezodp6PjyiYEeyRTalml4
         jkV/vGGl6tMTXhH+/Jz2Q1JP3hkP2+/8ipeo6QJ2YPTHAE/Oa6B8AALI4mT5Uy8T2ybP
         PIjhskL6NQa2St7bTlId+cfeDebebV7XCKrIbc763D90qX56up8kCZawkHfhkXn1ziLb
         /QJXQzLLHzj0H1xc/8E0Zp78pwF7AJRCa8yxZLFxVTq55VQlYEEVZRlPg5faiLnPwrCD
         j2zsbqb2D6YeCaNaOw1yjQtPqdmMl6HwRyeLgEZUr3DUzisGwsoNvrpvotRTD2P3YMqu
         Sm4A==
X-Gm-Message-State: AOAM531xmoMckXBIj4oXqlUGMC8W7C47g6Ii4inVQYpdIh+JB8HA/+Ef
        XpzI+YGRa/d8LSBjysdWEmn8RA==
X-Google-Smtp-Source: ABdhPJzMrO+dE2vHcs+fNrZzpM+bCtrcEgdw4ictUMXK7eRUtgJA4cHZC8dbAw1Umkz0KtcgK73pmw==
X-Received: by 2002:a5d:9e56:: with SMTP id i22mr6297390ioi.43.1612816999148;
        Mon, 08 Feb 2021 12:43:19 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b13sm9441088iln.77.2021.02.08.12.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 12:43:18 -0800 (PST)
Subject: Re: [PATCH 4.9 00/43] 4.9.257-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210208145806.281758651@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0907aa44-5f8a-ca2d-5c4c-58638afb8e82@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 13:43:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208145806.281758651@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 8:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.257 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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

