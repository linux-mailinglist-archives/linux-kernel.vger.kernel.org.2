Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C016409DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347926AbhIMUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbhIMUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:08:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F2C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:06:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a22so13764435iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MU+FvJRJIulfzxHOjUSMBlT/q6DPnOKEzzmpcnq3JZg=;
        b=ZiSLk7ucFYoAk65tmS29vb6CZPRGheT9xE0xDDT8A7Ox2SyqJ5y/Mu0BXE4hrxDnto
         dWqJ92lGbidcj5mhQTZXJql/3uaDIaYXsmCNBFYq3xVMCRmne8QOkNQ4it6lB/JwtT9Q
         oLJqCHHbTZbxTMSn7M3jpjQJgysIWcHzIJgmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MU+FvJRJIulfzxHOjUSMBlT/q6DPnOKEzzmpcnq3JZg=;
        b=113ox2WnCBZjSNJbQS5x8DNwD+6YrJLPwZYsgpDP38B+8mqaICZCk6ZvZUOYgZCaeD
         QR7MTjX3+fAetqVWVWcMc37GkAnsycCmvUlHf+TF24SnVHN4R8EE0Po1RKYJ3BA1EMQZ
         sktlbiZbS+WEg7zw5lqRK2Jc7p7t4bQZzY682BWJd1+mUMVptKlPcHzsLoGGA0ihtwPl
         RVpURnKxh9Tolf8VK+eawDVk+NKHW+9CKXC7kxYNkzCMhQPIR/ckHcoCAElElySZBz36
         xuvQJeXFsIdjByVfc5utEiYuiYDI7OLIBMJXeuFDwEsM7/mGNY2fmmLS8xijk3zK246s
         tQ2A==
X-Gm-Message-State: AOAM531SpUv0wVW5CWB1LJmbI/cDTfdamkeFah/3Y32Jtjcpa0JNSUoS
        xAxbvbuOLcchVGX5RgqkDIxRJg==
X-Google-Smtp-Source: ABdhPJwwKK3Rd+25SCwnQQfKHvjl7uBtGna5clNkk2d+W6HRzrRAsqfHjxJOGnJpFplsxhvMN04oaQ==
X-Received: by 2002:a6b:fd1a:: with SMTP id c26mr10227675ioi.57.1631563608071;
        Mon, 13 Sep 2021 13:06:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e13sm5244154iod.36.2021.09.13.13.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:06:47 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/334] 5.14.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210913131113.390368911@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <777fc79c-0afe-a118-1397-bd9a22c18a3d@linuxfoundation.org>
Date:   Mon, 13 Sep 2021 14:06:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210913131113.390368911@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 7:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.4 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Sep 2021 13:10:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.4-rc1.gz
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
