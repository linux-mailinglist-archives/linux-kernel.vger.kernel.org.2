Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929A342E456
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhJNWmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhJNWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:42:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AAC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:40:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d125so5626593iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bUJW6mWNZsq7AbnvEc13poBE3jo34vMBWFaHLCoyD3g=;
        b=PMmhwxyPcx2PLNO/9PLKsNNYZMJC7xGOH+syQiZiuMrKEHofPnIeNe4yeTmdovc3yP
         dLFma9CYE4B5zwpZCSnjKJTRiKSzRosuF+hitAS0KgxPmPU0UjDYVmZbrR+E3O6PZyL0
         8IXIEpx5QCMIqhUSHgseWfeo9aKPQKM2McOJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bUJW6mWNZsq7AbnvEc13poBE3jo34vMBWFaHLCoyD3g=;
        b=ysPn+F7PRskCoDcCLZDedSTf7p9DCNs5na8F5up/NyltYb+BnlbQWCvgRbGO4vAmds
         vPT9xlNAJZ7dl4N103AIJlLIkHQ2KPCppuxZTSkosG179/gzBuT4hFwGT57GKZkLpOUk
         7VSGkvMsXMbNbDQM5nvIS4n2zWjiFp32zsaOB71zLVBp5IQT44D4F9gcjLEdH/MP0Jc0
         Yg0NjDUN8hJAM+C4Mz4YpB7FImCZ+7eZ+8T4MrJ9Fva8yghdo3R3DdBDQZV0PqmrvTnf
         kkDWyFypvKw61MW4np93kSYE1vMza8M5l73LavD6lqMLPXGtXt4QijSmRPSBe45dKAOJ
         7qig==
X-Gm-Message-State: AOAM532AvwVFmJR1fvECmu9c8dB1n7jHvYiwFn5TOS/MQNXf8JCpF4xc
        bCQ/L7RicU2GLLy4iMtptuUs9Q==
X-Google-Smtp-Source: ABdhPJyIb96vo/2OdR+l9cIGePZny/XvASNOm5df4YE1fiVo0IbecV0VcGrESWgj/hSxsL2DFz2O9w==
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr1341390iov.42.1634251231511;
        Thu, 14 Oct 2021 15:40:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g13sm1903836ilc.54.2021.10.14.15.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:40:31 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/18] 4.4.289-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145206.330102860@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <28323110-b4c8-b457-8a45-84b5aa02df52@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:40:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145206.330102860@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.289 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.289-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
