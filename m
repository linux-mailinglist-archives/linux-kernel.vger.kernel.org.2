Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2032333E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhBWV1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBWV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:27:17 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:26:37 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i18so2711398ilq.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6wYF0cAAipyZEHwxIeMa1va8HYwX5oJvBF/44Lk5PqY=;
        b=F4E+yagVdbi5bCp5T6abCaycG9c4L9Dmy5zsLDGwa20NcTefWbhTRGJCbvO5aTgK3g
         ngzE645eLVoP11DdSIBMxFqWwtkB+zRg2PIqldXco5eNKsaLafYjyal2sxdLAN1nDtjj
         9fK6Rz4odJdtwKxCel4AaoP62setC+vF3nzVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6wYF0cAAipyZEHwxIeMa1va8HYwX5oJvBF/44Lk5PqY=;
        b=UAuYuQgqa/76CuDb2vL3MUOlRlLxFg7MIC8OmqOyUprjvkEXNgXTSlQqYc9vj1bi8f
         mJxgJlHSOF4WtDj9WiBzd4Hz/DeJqxnlXY8xQ9EiaLieroDVjzK/TjCrN1mWDtoej1s0
         6mxSnKt/NvnpNCxBGO/5QTd+qqyqOZCM08duc1A8rbMbTkfcaXpziIvdLF60Bg1WYRr1
         cDo7DL9QTa82SyyemrOmDLjS68fjREmlfXEPGcckd/b2xfpcJZZ3syvlQ4gk7wjtN+NS
         PLAci1TY7rmUN75LXvwyR+sVa0bZCCl/71n7p+CWEgz/xtQdAdHx/HxGbUe+P9cOOaFK
         8CAg==
X-Gm-Message-State: AOAM533BtoJcsRsK8WD04HeaytV1ckoB2RM9Hli1zLMOnvvhO8nZfHSr
        20C4AyOcXW55ebC3S/7yDSYqvw==
X-Google-Smtp-Source: ABdhPJyrzFejlm0o/ywmHHE99aaROGMJjAcEyAcmvvnpuEIZ0MEChvxcwjqeFeHzT/9DwuJ7m9L6fQ==
X-Received: by 2002:a92:c78e:: with SMTP id c14mr10323676ilk.212.1614115596729;
        Tue, 23 Feb 2021 13:26:36 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l21sm51166ios.9.2021.02.23.13.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 13:26:36 -0800 (PST)
Subject: Re: [PATCH 4.4 00/35] 4.4.258-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210222121013.581198717@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4050d3e-491a-e9da-eb10-58a76940a1e2@linuxfoundation.org>
Date:   Tue, 23 Feb 2021 14:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210222121013.581198717@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 5:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.258 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Feb 2021 12:07:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.258-rc1.gz
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

