Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43F03E9AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhHKWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:21:52 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E27AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:21:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so5256035oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hl+cowkcsqz9pS2qQfdEeFQsOzDImHAlBOUF6NAHZN0=;
        b=JU0U/pOG4BhbMfsSqf/MaL1Bf8RUPJHCXLOKj4458RaFceH5G8bbIpSBzfN+DfqdxJ
         qm4KYaB4QBXnt9QI/+NhIsz37NW9zHcXKue0cCjxq+1kLv3JOnwuM/u7Zo4MikmPOVRN
         NxBQZSsFIFvCemJ9JIiEkBWNmKchCa+ZUi0h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hl+cowkcsqz9pS2qQfdEeFQsOzDImHAlBOUF6NAHZN0=;
        b=Q7cIfUL+Uw2NtfCdE/V2EDujcqAZvrB+rraTx8usF6khXE6I7b6qHPCoA5azs8YLaP
         mfQWvUumfKt2sH+p12HEKqzb8mq/ZfNTfmMHFVMGko+QEz0FcRQ6rfPGNpGZZzGQDeLP
         g9NyWi8VG1cX9DI0Sw6EHHWuW4TZm/0LORzDvcedk/nrp0yzRuT8PUcjnp0s+d3t+YrB
         c5p0oLNMUVf8GN2pjwS2878lPTPEJx9r5ZvIofNsYSwlaiYy4U9jdJtCUkL4fGy/XG7C
         W+bkMamzd69DYO3fcE7Sv/z+POAIRBSRqc6pqskJyxNZnik5RDJqf6I7iB2+6X/AsXq1
         8Xvg==
X-Gm-Message-State: AOAM531zQbtOZxmWGke1tVMItm8zIADc6NmN4WngvBttQ8r3ZYsNsX0Q
        0c9ibIAvjDRbsGe92yG1lb8wJA==
X-Google-Smtp-Source: ABdhPJzEStZR2W+DelQd8ribGe9t8M9kR5JxayyFiItHU1nHdd8YwKpRAG2gifEeGm+Fco/2hsGJHA==
X-Received: by 2002:a9d:4817:: with SMTP id c23mr995709otf.98.1628720487456;
        Wed, 11 Aug 2021 15:21:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w9sm125541ooe.15.2021.08.11.15.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:21:27 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/135] 5.10.58-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210810172955.660225700@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e010bd66-43fd-bc01-243d-e94f095e58a0@linuxfoundation.org>
Date:   Wed, 11 Aug 2021 16:21:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210810172955.660225700@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 11:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.58 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Aug 2021 17:29:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.58-rc1.gz
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

