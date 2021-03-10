Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62570334A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhCJWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhCJWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:00:44 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943ABC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:44 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 81so19637437iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7c7n+CulAUyPLHgHE9w2Ws2ZzK8EomTpRlYGMyiY3es=;
        b=Ocb+HXBjLtFfD61wgB8hmJks2bObzrIYHP7bydYtzTTO2Q2Cspp7hJ1nv7vNEKLfJ7
         25jI2DNkSd1b6LeqYetahccN9fvPuJ5OA6aRxgxmPC7SDKbqI43qz50xKRdcnMjoelzO
         56LD/N343RX3KUgg4XVtWYrf7o7OG6UQ1bFpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7c7n+CulAUyPLHgHE9w2Ws2ZzK8EomTpRlYGMyiY3es=;
        b=t2v7OF2wi4FTpOe60TvbnF8FyYfLCJ3f9g+K25ihNqX46Ju9cw3IkvNWa0S4BE3D4o
         9POmxB4IyBRTO/cCcSyiC/4PZ1yFGcbljshfyQXIYWX679qRvbGmGDx+OE3aymfQgrXO
         FEnJgY07GFW2A+hJTh+g3Gt5Mr5hIKkl5AdCLA5RGZBjWB8pQINGNZtS/SLT7KHn6os/
         l0c1hhBmUG67XUyEOg45qBV28SBaTwQM/kITxbukz3zxREfrQd0eSwkO+8KrXKtpVGKX
         RfmDBm7KC8/aB+2A4Ek+8ozbLm9WtUqXvcdkrQLw0A5LbbXYIyLo2PIqCsbUG2M+1lH/
         YDQg==
X-Gm-Message-State: AOAM533KNyyJAzu4kuUnYn3zV9TQn6yZ0fk2j5T9xNBrqU/vPkufVpF3
        c0PrKqEFGq2MWUniUhWCXX8v4g==
X-Google-Smtp-Source: ABdhPJwivgRLg5IvNTnwJAXdxwgUN6QKPu6VTt9krfNJNmGariPEUxdkodgOZ1Qa7+gKm7z8A0T66Q==
X-Received: by 2002:a05:6638:102f:: with SMTP id n15mr635732jan.28.1615413644139;
        Wed, 10 Mar 2021 14:00:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x24sm402761iob.28.2021.03.10.14.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 14:00:43 -0800 (PST)
Subject: Re: [PATCH 4.9 00/11] 4.9.261-rc1 review
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210310132320.393957501@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <00e93ddb-1469-9ffb-43ab-a3c351412c35@linuxfoundation.org>
Date:   Wed, 10 Mar 2021 15:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210310132320.393957501@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 6:24 AM, gregkh@linuxfoundation.org wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is the start of the stable review cycle for the 4.9.261 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Mar 2021 13:23:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.261-rc1.gz
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
