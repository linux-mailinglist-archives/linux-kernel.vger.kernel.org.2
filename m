Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722F24217EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhJDTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhJDTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:52:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65577C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:50:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 24so23173556oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l0YyUFW67xdcwjdhxWAF7I5vX+NfYoLuX7Xnchqhptc=;
        b=Kfcs6aCvCVGKuRaBRYsUKU8ST17y0tK1hAkWzfCzjmE6duLZz9KSmc44l3aDCkgmpL
         6aPcKaqm4PysXv1myHvbvOxD6eYdEpf1RPm0tGK/wr5xlvaTTU6oApj+qrV7AxtspdP+
         Z8+fAxWrRvEY6Vld55NbQnRZRMr5XX2xHCECU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0YyUFW67xdcwjdhxWAF7I5vX+NfYoLuX7Xnchqhptc=;
        b=DtH8UQXl+i8e6rRJoKAdBURriKHPMRMxdojcSHKHVcG0sT8OTKc9Z3G1u69L1+6Fsz
         Kz16Le8cZfdwsu2c6MoyxnrEP5s8jidWg7Ixa5Reswg64QtmZss7VVVH7j+kt7Q6yDto
         OQKFKhv6qWjnH44qf2Hh8hGMMBttY72ZXz/ZbukNETOSJ1w+j+Cmtzdg7JRJLk3myTul
         gGpiC/YzKTTO6zou1Qj1hLDVvIAZqie3zMMCvYmbutWsFHoX7p0rv5jXNFSaaYJpQmkd
         GHjUeVUIRiBn/9KnNhUc4qlh62elNH4FDovHAPUsewlAPBvp2GLUYEpYwWUCXKiZ08dc
         z7UA==
X-Gm-Message-State: AOAM530FFQyNzLRNLFat7KlJHLMhvmHAuB5pOMLYqwhvW5je3gnE2Chp
        w8ElQelLKhVHDyhlAA4I21N+LQ==
X-Google-Smtp-Source: ABdhPJzQnebHJ+A82NT4H93ArZfrBUR3nbETl7AicwkgBatnhD11MmIyEiw7jv/hecz3Wy7uCYWI1g==
X-Received: by 2002:aca:a852:: with SMTP id r79mr14389135oie.66.1633377049825;
        Mon, 04 Oct 2021 12:50:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b19sm3082184otk.75.2021.10.04.12.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 12:50:49 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/41] 4.4.286-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211004125026.597501645@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d8db5caa-b51d-391d-1d63-986005c433e2@linuxfoundation.org>
Date:   Mon, 4 Oct 2021 13:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211004125026.597501645@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 6:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.286 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Oct 2021 12:50:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.286-rc1.gz
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
