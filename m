Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7630DE6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhBCPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbhBCPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:38:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D25C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:38:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n2so25698693iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bZZmEPvNTfU0BVG+jBmAm8JPmiQFYSTc32EUjaMFKg=;
        b=ZsBdY0nR3PYMB25vo6O9ApIlBqSa1wM5meBOVTDYHTkZPAJaOBKrZEh7RNwP56Th9D
         eyWtqt6ndPGRew9ZJPu9zZONUEMPIz95zcxU/fSDKPagiupZdesh9rtrOijOFM0+iVZP
         aNhCyiWTWgMKZ+rMyGVTaStM1bY6g0wtXdzpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bZZmEPvNTfU0BVG+jBmAm8JPmiQFYSTc32EUjaMFKg=;
        b=HF3Fa7aDRJ4RyOMKMy5h0QTAGPHCyVZQOgidabz+5co4Q6ICR4vbDeKmqKZmd6wJaF
         wr+4h1hHE8q1uqhQSVeX1hhmLrlssj4tAWjGKHKiScVLbxnPJtGZ9fioz+1CAWQx341Y
         f4VJd3Fl62SSP+ebjho6qBti9tTFUMlU+3aBJpIHHVLqu5Nm1eAFYk8ZeE8Mx11Wyxx+
         YmWtVS2qBWwVZyyGoBazgBDadHbjTjAwDRTRaXeGYD8Cmn7H5BPkJkCDImfBnV8vun+l
         u89P99eB5gEB6oryIki3zSMmUBSjZ3OW+kAAQ/OVfycEyHnmusO7l1BAh0+XWkBFIM3W
         1j/g==
X-Gm-Message-State: AOAM533MCt2CgP2Hhida4+vlyOwfGfjql8GiPg65/n6Wlwyl1PoP1Q6M
        IVKm6TfGF96VtcddZnOmD9HWYw==
X-Google-Smtp-Source: ABdhPJwoPbCxedwOlwGyc514eM7uCPDE5LnkMLsJSkybhZC/z0KF09qlB/cnMexhDuLwYDbjBYFIqg==
X-Received: by 2002:a5d:8ac8:: with SMTP id e8mr2959345iot.163.1612366691241;
        Wed, 03 Feb 2021 07:38:11 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i5sm1125074ilk.85.2021.02.03.07.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:38:10 -0800 (PST)
Subject: Re: [PATCH 5.10 000/142] 5.10.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210202132957.692094111@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d4f37799-496c-1571-d4c4-86daf34c24b5@linuxfoundation.org>
Date:   Wed, 3 Feb 2021 08:38:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202132957.692094111@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 6:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.13 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Feb 2021 13:29:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.13-rc1.gz
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

