Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21E3386B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhEQUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbhEQUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:19:10 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26386C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:17:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e10so5526723ilu.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CwD4y1y6ZmmQgCWMkhQ2mNcw+6vntFWMR8ap8F4woBw=;
        b=eGGyXg48mtiBBjHZtokhLrXBXaQZvvtYYp/M6VLKf91duNqTYzmCGP8dcv7ylcuP+R
         g8oNf/1344CZ9BW4SnIM4pgBU1CqvjXzIHy7ciN4gHKw2Auh3luObYcZUi3tCkR25df4
         ZEnhP9WAfi2ASF8MuB+aHvs9sacSNBQdBrrFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CwD4y1y6ZmmQgCWMkhQ2mNcw+6vntFWMR8ap8F4woBw=;
        b=hjChz4lFUqIo+9wUflavauYfn4svV9VBoUYjz+OD+2J7Qwm0M7se6mmKKNXYoVGS+1
         Zz90fu3tILu5U7VL40fxuhTfRxG2qI/DwvrFS9gjFT5CdAFIUSvm9Sv/wBApW429lpUP
         OjU4DYAcv2BJyNZsGZV9kdO2H1YuQj6kCWv2+pUFAOu/ru47iG/5RY/vigGsZVKRbD6a
         i0zpQMamFDGlra6j2q9avhcVP7yMD3srJ+y8PiOJdk2bP6t3+7n3x9gnpqLWQcuDx/Y5
         2TppCcsJ6dWsDN34V2skO8EtvyeywiQ0ZEkjvx8BaX6cZhdrenhtFU8QsuMaOXCE7jGC
         TUqQ==
X-Gm-Message-State: AOAM532beAqINhFSGxPfsnJOzLrut2ZbX5LMNmZND43JxOoxmTZMWL+Y
        BBDxF14j7dVRBYLMBKMtDbI/iA==
X-Google-Smtp-Source: ABdhPJzijBI5xGC0VLtRUdsij4/OMJJqKoKYVmGJCywwqnTqI7X9tzlXhreJxj++tA3jyit55AnBEg==
X-Received: by 2002:a05:6e02:6c8:: with SMTP id p8mr1163628ils.83.1621282673636;
        Mon, 17 May 2021 13:17:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f20sm8124836iob.46.2021.05.17.13.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 13:17:53 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/289] 5.10.38-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210517140305.140529752@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c9a0ae49-c56e-8d49-5c64-d4b30239b239@linuxfoundation.org>
Date:   Mon, 17 May 2021 14:17:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517140305.140529752@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 7:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.38 release.
> There are 289 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 May 2021 14:02:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.38-rc1.gz
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
