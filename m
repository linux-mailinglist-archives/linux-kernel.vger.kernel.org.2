Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22B457A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 01:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhKTAwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 19:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKTAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:52:44 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4FC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:49:42 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v23so14995069iom.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S+g0v4nXXOK0MWfZjm6/hhjRJWLJrzIf96gQAhnAovA=;
        b=HGY9MV7SejHX8U+PB+kd8CCcMrCg9rDTipcnKGvZu8b3WRZfOBkOzTgBERDWPrD3ST
         Z7qvThJKX3UdM5zuKqvEzz7A3HuBXlJQ2BQ2ZaQ9nC3/d5goEsSKMR9IZaoGkxHJFe+I
         W3AiFGm1R6oUbd1xk8t3bf/yJybItZyfGH5TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S+g0v4nXXOK0MWfZjm6/hhjRJWLJrzIf96gQAhnAovA=;
        b=mBdw9qYUOjL/NvNT9O9vyrtiegjsDb0BQgIQa7Ks2dJhmcCTO4WO3pyDZretyxqlku
         ZrsMdm3QQIx4DJ2o9Gu1l3ArqDtRQeBpb0SdYreZpxa7QknCbWuq7XxvnxrBws9EwIqm
         /aqVnngiq6aW1ZBVFp1kdFQzYFfofBzyLe2kMo++2v/mM5lhliDkjnZpjRmU7JNh119A
         xdvVdlWl5DosJ6uncrXINvhkHUnesB61FMDJ/iZ6dv9HmgAk4Es/2jhKkPF58oWTlb9/
         4L/QgI/HCS9zfdseAVEPa0rl5IgAyM9/hGxCODErbXPCjo29wLNqEUHMnk2P3nEtQOC5
         baWw==
X-Gm-Message-State: AOAM532bLrgpSQ+e4sWPJKyj4XZ76pqfG+flG1efFoeyTgol+Xbepr+8
        qB2YHOOs7EPyg7b73URJduPyCg==
X-Google-Smtp-Source: ABdhPJxRxUi2ITVf0qi3q+QpYQApI910VLbujBf6AFB/wWcCdQTH1KbdksjfW0gLGcgB/7gnsrwnEQ==
X-Received: by 2002:a5e:c807:: with SMTP id y7mr8797005iol.9.1637369381496;
        Fri, 19 Nov 2021 16:49:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j15sm893426ile.65.2021.11.19.16.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:49:41 -0800 (PST)
Subject: Re: [PATCH 5.10 00/21] 5.10.81-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211119171443.892729043@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <709b6d67-4919-33d0-e84c-f642e044b8c8@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 17:49:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211119171443.892729043@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/21 10:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.81 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 21 Nov 2021 17:14:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.81-rc1.gz
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
