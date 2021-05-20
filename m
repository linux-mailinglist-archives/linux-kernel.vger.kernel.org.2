Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358F038B921
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhETVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhETVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:46:59 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D0C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:45:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e17so5602858iol.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Daj+hGDzGHo5mFVFLJ6Pkp+BkOPzCNqWifFuzK7tIyE=;
        b=aywLcjQtZqnWg1eULyO4hd8235yOpUtWBp3J20oLI38n8dESa2EJImS3MizhqsPcap
         AOo1btwfODmCLcoYd/Z3R29y1pqBqrkXELXT4XKDT4B64Eoz0HEVrAlvAwhNERgPynRT
         mLOL7EQ3UWbQ+eF+NhcxRoqHCHlNpUTdoRA1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Daj+hGDzGHo5mFVFLJ6Pkp+BkOPzCNqWifFuzK7tIyE=;
        b=df92sFWYarg2nz5xjVrprSL6emPiJFEIuE4+3Wc5F5gD3imOwKveVqs3VLj9GaKNN6
         a7fSpM/NoM4zydsHa4YFS+zs/Kki8d5cqsHwrZSDmNWiVfwtkJfhr7l2YFF8Q8zpKC0J
         3L+UO6GKJJoMztJoE3b0fMRRtNF+AyEhSuVYJAW0Mjz868t1XvW5pBSkHR5uSerdrxEJ
         xMSxSY8SowDnYFu8nTPgKXztvmfzvYSZsF5/nkcsP+qqJHF2pRb31GwFY3z/hWrdyrVI
         obo0L0X7ez7HOSG2dsLUf6Oe2YaRTkwN+EhDP/6+UPMaayPxG1wzyDSQlkpi3WR6kyLc
         ZjZQ==
X-Gm-Message-State: AOAM531oRncwXRzthmFyPzLQrJMLPwP3YlHeaSo7YQ8dPPzaL11GRPL9
        ISTfyE3G39LTV3jka0sxDa9jQg==
X-Google-Smtp-Source: ABdhPJzrgAI1yG4HhxHEvAWdP/kPQPm8ILgwYTvG/GvSFxSFx0GoZhRvXTe9SP2S4BB2FaoZUg9LAA==
X-Received: by 2002:a05:6638:13cc:: with SMTP id i12mr8775647jaj.20.1621547137030;
        Thu, 20 May 2021 14:45:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j15sm4102971ilc.53.2021.05.20.14.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:45:36 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/425] 4.19.191-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210520092131.308959589@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fa1c764c-1d1c-99bb-e52c-86455d37479a@linuxfoundation.org>
Date:   Thu, 20 May 2021 15:45:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520092131.308959589@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 3:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.191 release.
> There are 425 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 09:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.191-rc1.gz
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
