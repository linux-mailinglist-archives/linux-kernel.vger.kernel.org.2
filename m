Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D43BDF76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGFWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:46:47 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 15:44:07 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k6so442670ilo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BfXcL7huu5M2SLxozu50mak+1t631nohpB9hTGnfHZg=;
        b=I+/jY/Vk8K1384CAuY0qbG5FUveKWBqhN2IUMCRD7dzJfCtTNjahYWDg6A+60UIDT6
         6Mtmfj/NpWbm/pCGmZWT0CdUjc8AOzOMndVgsD+Z1ittWzo3Otjpu4XvDYG+vuX66r8B
         NjzqXAacq8AwtRrDV7WMDZuVkxYEGZF4V6U8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfXcL7huu5M2SLxozu50mak+1t631nohpB9hTGnfHZg=;
        b=aPoMrj53FhWDyrc8T+KuNHEURiBfD1H9iVDs2jqZ2WUuJjwf9fjIdQCEbc+PZWVYaS
         mOj0ew0j9IWuF0k/9pawAJCUV7vZRs+LIl/wgCtUbTs939iFZ5wBAtSYL3DwRy5X6qt1
         bDOQ5JE7xd0OLVGpQkcGwU5z7YKI8mI0FWb1zFoxcAl2ieB1lRcB8Cnr+9Z88pyC3zTZ
         Pu11HBbqnsDQqz3iks3e/2Wg+PRg7hi3ELm4N+S9HlAMqY8eOHTDE+O4eq5k7msJTevq
         KAeE5KuwLMrwoNMyPYxhaUQ3X+LMuz8vtAWrW45E4r+AGbDehmNYjUyeimL4I6KEcUCo
         ax5g==
X-Gm-Message-State: AOAM533zOM5gpLj1M2PSQsXtWyfeUtHddGYNmrmsoj8TeV2xu5YSNQ8R
        vU3tHYUzBS4UKcjU+sM1+qsaUA==
X-Google-Smtp-Source: ABdhPJwmjJwaAGZxWB8A/HAmyvL57E6r7M6K6qUNZvFtCD4XeneukmP98O+ICOswN5B8qtjhmjv8RA==
X-Received: by 2002:a92:ac06:: with SMTP id r6mr15447597ilh.74.1625611447073;
        Tue, 06 Jul 2021 15:44:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q6sm9206853ilt.41.2021.07.06.15.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:44:06 -0700 (PDT)
Subject: Re: [PATCH 5.12 0/7] 5.12.15-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210705105934.1513188-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4d001b78-a369-d7dd-0b5f-1d2992742864@linuxfoundation.org>
Date:   Tue, 6 Jul 2021 16:44:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705105934.1513188-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 4:59 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.12.15 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Jul 2021 10:59:20 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.12.y&id2=v5.12.14
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


