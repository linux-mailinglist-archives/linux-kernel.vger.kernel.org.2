Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B133305030
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhA0Dsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389577AbhA0AFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:05:54 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B3CC061A2E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:34:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e7so41848ili.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zib3hAneJNs9BQgwmcNOajlGeO7H9kxS77lhi3666Q=;
        b=QSxx24xF7iJVPqjblzQzmKN5CEViZlJ5oCN6qklloVlq5mjZIYNvW1Vd7jZrxP9ZOi
         LIpvT/mWtZ5q5/TdyeUFfMpxqvsZW+tE+V6E2c4C92fO5GDvNfb92mexUlXXYapYSlSB
         iuSgUHWbBi/STQBlWIOXwZ9SRUa15FpjXYe08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zib3hAneJNs9BQgwmcNOajlGeO7H9kxS77lhi3666Q=;
        b=NkdY5bXjh+29TZwf2GdMfv7ZA7/UeiB3Hz9v79wIyH2BpMctvlbEDFdmdkvwFFEhBQ
         SHJcBOyaDlqiLMYFmusGTZFjDxd6GIOwGPR8C9vmolDoIJUS5Y/9bh9rIJy5PPppGRPz
         eAP6H9Nob8/4m1H9+yzwqWDy52SGNMtgQUMtj4JvRHEWHMmW5x6cOi/GHcQPKAOKL4kZ
         1vgQCCUGuxLQ38e+GcB7zin8aUfPSKePWMne+oiqyttrWnV92K9jPxqr9+qRHatGXjP8
         9KdTrAQyJsKOczc9PDBVwOIDypwzZMdyYlRcLQXV8iAPeWBQS2eF71Ez5LyG5wQDM+uu
         ZXhg==
X-Gm-Message-State: AOAM531eekIS1wfPKvpq3L79QSBFp4ymh7JzKShW0M7yiZx24DYowlg+
        0oaCU5Ha3/KLGbJrt9OFrLjrqQ==
X-Google-Smtp-Source: ABdhPJwWG4SBiQ1h64sg/mo89B/hCHgUFmD4Q3SjgKqQeMlLq1V4mW5zc+nw6i7qVZvkHECMgXfYhA==
X-Received: by 2002:a05:6e02:e94:: with SMTP id t20mr6688099ilj.10.1611704062266;
        Tue, 26 Jan 2021 15:34:22 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b2sm208219iot.4.2021.01.26.15.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:34:21 -0800 (PST)
Subject: Re: [PATCH 5.10 000/199] 5.10.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210125183216.245315437@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5de2e29-dba1-a49e-33ef-08d71d572479@linuxfoundation.org>
Date:   Tue, 26 Jan 2021 16:34:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210125183216.245315437@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 11:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.11 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 27 Jan 2021 18:31:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.11-rc1.gz
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

