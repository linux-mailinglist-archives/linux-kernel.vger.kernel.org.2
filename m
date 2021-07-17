Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F383CBFFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhGQALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhGQALr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:11:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A28C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:08:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p186so12586788iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dUb54UrVcbu5tBycS3M8ujVJeIkqFc0yucW9HL/N7+U=;
        b=R83g5H4D8mMnudncr+P3tFuSev7gRGFz7OtKmeNxWoFt7pMQ66URm9ctZKt7Bbfq4v
         bfsPMH5+5XarUPBgjLnIT2Ikfx2IqzY1stSjgaIKJoJZiWXHvXcnnB2yurcyFkqbGIot
         q+3OWSUHIRf+45raBE8wp5Y+dc5y+zyqgPESU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dUb54UrVcbu5tBycS3M8ujVJeIkqFc0yucW9HL/N7+U=;
        b=U8+l++X09KttTRAb5jAxGBeguqBjmpzQPJA+3qSGKsY6oQRJuqFDW6zcj1adpxc5ci
         VO31Zed23GZIB6ACc3HH80X8RUIhbHwG/R1OqwXcpJEjFgfPM0G+Say4rNMPgmCb5xwj
         G6SlKwEoWh5gJvbdA6WywDHjEJn4UMlqLobsbb1XGyrcFGF/VMtLlkyTj6wBle0O1ycL
         kX1erJ9pZBjDnsQiAe9PihOoMW/qjrv2V8o1l45n11GQz4/UlUSCucK3J3U83s+onVo2
         DCBm9eoE3xKcaX5AkFrK3tSdxrV9/t5twvEJp8pBFWEig/Pf+gBpJwFO6+nzcKnLLvVo
         VX3A==
X-Gm-Message-State: AOAM532OFQ+veXAUVu9jh61CCLJIorGDr2hxzbKzPoBoTF60VbyDJvqr
        wsQIoxf75S0bstkSkKMeUD3Epw==
X-Google-Smtp-Source: ABdhPJwAzYAq7CSpDb31R/IzHJduPOhOE6MfvR+Up1HecNYQta6Fz2I4adFbNAt1BPwCVY34RumfDQ==
X-Received: by 2002:a5d:9b9a:: with SMTP id r26mr9366523iom.34.1626480530287;
        Fri, 16 Jul 2021 17:08:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w10sm5497435ilo.17.2021.07.16.17.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 17:08:49 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/212] 5.10.51-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210716182126.028243738@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae451309-6d3a-06b4-f1fd-88d282816dc2@linuxfoundation.org>
Date:   Fri, 16 Jul 2021 18:08:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210716182126.028243738@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/21 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.51 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Jul 2021 18:16:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.51-rc2.gz
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
