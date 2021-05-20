Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB40F38B91F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhETVqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhETVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:46:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:45:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a8so10024901ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LnUmueg3J+StpKMddrYkoOb/CHGMRiZzsQ5msb+e3PU=;
        b=Ax4qZynTxoiH8h4bP4NV3AVV0lGHv4eMphxH2bIU6Rt+oFjwHFm/TJFLzRtkIwkl6K
         5Ttl+Jik9iKabakQ60uo92091WOuG6Wf7Q6erSSKDWyk+c3X9Uah74ipu8HaCqaaUsVa
         mKrtBqM7vpO9DVJzYYc0Gl9LEIPvL1LckAG8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnUmueg3J+StpKMddrYkoOb/CHGMRiZzsQ5msb+e3PU=;
        b=JhH1ZB3pJc2bwQtKQ+5OYCqeS/Yxutt6NX6eyawrebxWY58T8kDy9vWLYKLa+jJMKp
         w7c/g4wjFh7DmuEYxOC+9tMdM0/1/uK5Lk5et8Ye2157fPOFiUyMMIzSFJenobz5nZ0w
         FEgdU2tpK50Chm6QKxIjIYsH7woz8WYp0M8+X/S4oBi50i8jwduZy5dFdZ4kStFcOML1
         h7rkV6RmOJbT95TIyLVRuCyilpfaCBXC+wT5aB48ilIvFUlxoh80BF1be/T1e4OeAArn
         0xW7qXIOFMPVpjk7h/mQiKK/DZ636ra5/sKVIwGY08AnmGADYsw2KHUYz9DwWYC6vHqq
         1hLQ==
X-Gm-Message-State: AOAM532UEegeVQLIxFaQ5lxG/PUgCK+xXBCUQ0I8nXSL8N5rxfjP4r7e
        9KjCaw7TU8uSvvmnMMf8iRutWA==
X-Google-Smtp-Source: ABdhPJyvvQSH2NWhbxebIjoZS85j0e7LscNh9WPpu99Ad3+dn+12zvxQ+A2T/OVdbrtnpnqvYVJ9jA==
X-Received: by 2002:a02:a505:: with SMTP id e5mr3948096jam.10.1621547106805;
        Thu, 20 May 2021 14:45:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p10sm4244673ios.2.2021.05.20.14.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:45:06 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/240] 4.9.269-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210520092108.587553970@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b2fb1e2-a92f-e674-1aa9-38c9e70bcd4f@linuxfoundation.org>
Date:   Thu, 20 May 2021 15:45:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520092108.587553970@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 3:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.269 release.
> There are 240 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 09:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.269-rc1.gz
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
