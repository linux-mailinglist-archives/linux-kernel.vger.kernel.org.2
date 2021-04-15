Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E988C36159B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhDOWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbhDOWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:43:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F482C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:43:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a9so15002992ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0tI5L/D34Q2ZWrMz3JeV3QKLJpGA+xUCY3jKLj8HysQ=;
        b=eYejQBpoO8+kXeMS/IENZtAda0+0AEwU3ZUjpflywb6D5e3FF5Y8ujV7uPhiUCqTSP
         Z4xWMU2SYz+c76hImgVO1N/DPP1ICwQbCDaxHssT/ZZeDXZ/nE6TozvX3Jk4KJxahz4b
         xjC4OZBSTdoJwVXvUQaKpMDONIofx/CjvO9xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0tI5L/D34Q2ZWrMz3JeV3QKLJpGA+xUCY3jKLj8HysQ=;
        b=jK60nWjjJ0NyUErhyZfkTESG+YyP+xj16mT6zv0cV+ISsMCyXMJe6Bb/vjF87CysKb
         4sd+tyFZ8rHsL7VbgMd4mjsLOAysfFRheSF40675j5CuZrl4o4y+WwJtGx5lFQgt5yyr
         UTS3WWz/Y1OdK+GNVMIDKNp5UPOHKWuJHZVE6WBHoE3YK0gcLIJ11qz2dycKFbpIEjaz
         mPVXoifQbAyt5VwSdmF8/oqTZzHlezZsJUNbm6/Mn2WSVPllYs0AYuUakRdl2RZY/UtX
         wyvVWfCJmJbcVRwCP32dBw7EslWJqs6v3jFH67WM8/mMg0vXDiat9vlZcr7VH3QbK3jz
         +9Hw==
X-Gm-Message-State: AOAM532Hju23dAd0j5WcEqMNwzjP1D2RIqoiE6ITct6qIyCw9hPSf4HC
        ocA2CKa9zYoPsNr0NiwxAJt/fw==
X-Google-Smtp-Source: ABdhPJzvvYXLxiBhPcnnxuEVTVADYANteLzTF/zt4Wg5uS6kUXNLk4PW6DZgONKYqPciZ8GzRf8z5w==
X-Received: by 2002:a5e:c908:: with SMTP id z8mr1153617iol.136.1618526594129;
        Thu, 15 Apr 2021 15:43:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e6sm1823123ilr.81.2021.04.15.15.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 15:43:13 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/13] 4.19.188-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210415144411.596695196@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a9ec9314-e8df-010d-27f8-e331743c7cda@linuxfoundation.org>
Date:   Thu, 15 Apr 2021 16:43:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415144411.596695196@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 8:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.188 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Apr 2021 14:44:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.188-rc1.gz
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
