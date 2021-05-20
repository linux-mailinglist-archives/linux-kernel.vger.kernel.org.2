Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8A38B924
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhETVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhETVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:47:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1654C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:46:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h15so13729359ilr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnrfhMqe8IMYSiIhRflaM6cLg99z377tkPoGbvreho4=;
        b=AbD3QJ3nOom2wGUMMvLCZFn8zMx7mvFkqQwPz2fDn/OKtr+0fhtjfCFD9AA7qbfs+3
         KzeqFeMWVV2dJ2daEqb3jJ6s/TS7qY5mNN/RmPRTxl3kr6o4fGe+Xy79l99Yh5f7Urnk
         v0WoPp0qKYAf6xqtc2+F3Km2rGug9DmGrVynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnrfhMqe8IMYSiIhRflaM6cLg99z377tkPoGbvreho4=;
        b=JNNQClFy0LaPSIHYkU1rSyqsOvH5jOPEbL4LKQyuwTnO9CgMzxASdrp/EwpJaAjFkW
         obOm9A1LfqZ86rJ/7UqbFcPtu785zTgZs6IkZP4+6BstcrV22eMUnJRoim93h2/OOibW
         Yuf3e20HNl7jMniGq5bJ8/OAkynNGKmc7JtsSk6XauM+yn1gQF+RDTeR6U8A2tb/SobP
         L+40HTSWGpcjuqhljQJjibHsoAg+Sfm5wmdep921vxK5khEXawl0bJJUf80ZkeuR2rZm
         1jCBSoA+zsCjQTUmwvYyhlMyWjfuqCgRgnHRsOhBVtAicKGxuQo+dtCC98C9ydeLNekM
         vbsA==
X-Gm-Message-State: AOAM533QsX2Grc5BGaK8KAJ+3wJxf0BjSTQS6oWQp+d65q+kv07AAutr
        eOKpGy9rJ51WykOOEVKS3BuNyA==
X-Google-Smtp-Source: ABdhPJwYudELQHmXOjjtK8KREFc8BXc14uO/VDThdZR8oYy4VvDrwiYm++3qioK4faVrGoYjvs7rZw==
X-Received: by 2002:a92:cda4:: with SMTP id g4mr7243793ild.47.1621547176361;
        Thu, 20 May 2021 14:46:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h16sm4118357ilr.56.2021.05.20.14.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:46:16 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/190] 4.4.269-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210520092102.149300807@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <69671a85-ccdc-0ce7-9f5d-3afb31c5035d@linuxfoundation.org>
Date:   Thu, 20 May 2021 15:46:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520092102.149300807@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 3:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.269 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 09:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.269-rc1.gz
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
