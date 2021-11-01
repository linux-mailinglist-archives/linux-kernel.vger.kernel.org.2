Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2C442293
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKAVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhKAVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:25:28 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F1C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:22:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k1so4572490ilo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5UczJ5cPsBUNmZ39JdlZ2zCexG7vaUHD9ua6j59cLvc=;
        b=ZtpivkdUt8cjVtM/ZF7fES9VUvnooqFI9yu8ZVfhhSWIxXtPlwgDSKSel+vpYvKXjb
         WDFvWG7w2suH1JrdZGVCnkao3ks0jg9Tm0Xblmcj7eTSNt7erma5ceeQhAnlvIs/tTOJ
         9NUmG9U3IP+3bv9Jt6d1IrhYnKol7mViDWBQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5UczJ5cPsBUNmZ39JdlZ2zCexG7vaUHD9ua6j59cLvc=;
        b=cNw+rQty7Wnf7CnoACbnIGMJW4/VsqWqqQXKJZYlKEZdGExUcOCOCs+kNU30ou4R3t
         G7yUi+NlBqiISM57xZoG9sbDFL1FvWAjPibT0p7eHGFyGH+HIiBokq4J1P8OfO2CInCP
         VSughUUMcRDgahrLmnZ07gd6oUrR/ICAcxa2IRtq++Mg/rwvMSP4z4KUsFOot66tKmec
         RsXu4dZV5k22JHQCiX3V0tDd214jaHGPI3tAZS/fRqiFTtKJijELlv2cvOvRprC1dPMa
         kmVBZv66+lIeG7C48UYqQuvMoN8mznAL0sF/Yc1dGBjHTmyhS8j1VUI/Zpw4IGuRlb6l
         S0qA==
X-Gm-Message-State: AOAM533UzVSjeZ5q0gJ2to3nX5Pek2PdWFAbNZQuOPiNc8V1nNXMrIsw
        VntnUQjl1UQVp8JaSgM3o0KHAQ==
X-Google-Smtp-Source: ABdhPJzyyZCOzWhG9y+2/XfJtDw+u39R9nMwUwdwxKQWEhU9COy19cum3Cdycw0ydNxZIjpQFVLt9w==
X-Received: by 2002:a05:6e02:1bed:: with SMTP id y13mr3215202ilv.279.1635801774440;
        Mon, 01 Nov 2021 14:22:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a20sm8689527ila.22.2021.11.01.14.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:22:54 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/20] 4.9.289-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211101082444.133899096@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d274a5f9-3077-11e9-8b76-5ba118f32085@linuxfoundation.org>
Date:   Mon, 1 Nov 2021 15:22:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211101082444.133899096@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 3:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.289 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Nov 2021 08:24:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.289-rc1.gz
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
