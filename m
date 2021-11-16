Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD14528FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhKPEJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbhKPEIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:08:15 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A0CC1F6BDB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:53:31 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l19so18601736ilk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJxlPDTyPBy+ivM6NbsIP1P7/etUjwtMnUuEk/NmFz4=;
        b=bgtjihmji32U2GPsLIJGr/ciJjG4A7ICXoeT6BRq2fx84UQMZR8rLUN0WhQyJm+yBm
         7srArl+8BnoSPCeBmh60ENMcU1/OIhiyrQ38R3wqMYYjyDqZJFTBBDkJBdWIze3Rb49b
         phVMPrr0hTg/1Z/ofGP0dGZYe/pVVnIsXo/TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJxlPDTyPBy+ivM6NbsIP1P7/etUjwtMnUuEk/NmFz4=;
        b=RI1NNLrEhq7ueqNKA+/YsTAtY8VdTAnu/JT2NfJblNdmx+SSVU/qox/vLgNNeCrvx/
         n1HvAAKB0FedZVKy4YU5OytdqYapvT7iQWpZNDidHM5a1k/0eFuCGrXPjDaGdQtFllJi
         PTa4a9YZB005rSQp9a18YNbVL1BrvdgEJkBKJMgiT6Epgq3KY/SplJ/GuXgThOxWxaAo
         NRqrL1weLhFhyAwcPgNf1Vd+IFccY+cm4oU9qvw1PhVHkjkfCieFK5RcHzY10j4h5ASl
         y4V97Q1R+eAcQNFfiH6HtRBX0lGhmv/UojFGz0Uq3uGeW1+eekGrCpE713ramFWD+U7Z
         TgGA==
X-Gm-Message-State: AOAM530gbIDgu91Ev06AHPxsGEyAfBrLP+UKnDfL7Eg6mg3/LRg+aZbU
        UDOijXcP2aokBRF65t5izp5rdb/dgy+3Ow==
X-Google-Smtp-Source: ABdhPJzJ1xVCDpPXzNreuWxYi+6WQBaDxUrgB5kTgDRt515BNqhluGeZRm1Q2jUWeNI7PmXSs4Kaew==
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr2061536ilh.26.1637024011239;
        Mon, 15 Nov 2021 16:53:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o10sm11467634ilu.49.2021.11.15.16.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 16:53:30 -0800 (PST)
Subject: Re: [PATCH 5.14 000/849] 5.14.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211115165419.961798833@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d61c2a4d-944e-ac71-2aa2-5d739fe4c4d4@linuxfoundation.org>
Date:   Mon, 15 Nov 2021 17:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211115165419.961798833@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 9:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.19 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Nov 2021 16:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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

