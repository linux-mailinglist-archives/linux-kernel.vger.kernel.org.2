Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3741030DEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhBCPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhBCPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:43:26 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61D9C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:42:45 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n14so11868196iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBQd45ip2Boz2QFdOpTv3VGGS2wFZeIIj7zuMGEVdB0=;
        b=JEy3G0cIgNtIfjmRsWiLmewQ9r5FNRfwOOdvF3xsYowa0hgjyQlQECAKuCvLm03++I
         3aTZXRoE4obLSsqY29q4smgvsrAULQgsnRHtvTb1r/wCzOkMLFemvDXd1a7QsvrTG6sb
         D5JvVJIFaziHxPjWRRdwDDdoNJvx9rd31NFQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBQd45ip2Boz2QFdOpTv3VGGS2wFZeIIj7zuMGEVdB0=;
        b=VZzeAtN5r5EoWWTfMCiUC5E15UxojeUmKkod2xZNgrFvFNUdJX6MAFsUig+HEgCeZX
         WX/6Lbi4TtLFoPPNV9WMKeyGR22o9VJgopbR4PBZKZm/xcZVAijZRUmicJ2TBwl4cOiG
         Eqdm4DPAtmMXP4iB3wHBLYyTA7bZ8ms5GHIUjxVA7ZognDr/0hL7/octBCuPiKkTrbIb
         9lOp5daMOvdkIY9mFLWBhL+RRzR3qragCaQDovijiBFN7FzisyRCWn2FbOQmfr0kzQqP
         pVAqXB/9uQ4BnrOm4MNmtICu+f5XfuJAEIpLKKcXgNlJw1wVQ80pitRIWbdkm0Ht1k0w
         TjXg==
X-Gm-Message-State: AOAM5324oPv3DnIfE71x9Hc50tHlPN9ujOmMDezdSU6I5rO50ZVu8txT
        NZVnOjd03VZAWqhnEWtUjAia4g==
X-Google-Smtp-Source: ABdhPJyg+XImOv6R3DdE/oEPhBNKUg4MoMEj0ZzQGF3FC0qh+xI2pGHo7QccjcEWohxfewYpROML5Q==
X-Received: by 2002:a5d:8456:: with SMTP id w22mr2960621ior.77.1612366965362;
        Wed, 03 Feb 2021 07:42:45 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f15sm1144615ilj.23.2021.02.03.07.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:42:44 -0800 (PST)
Subject: Re: [PATCH 4.9 00/32] 4.9.255-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210202132942.035179752@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c1b348db-daf7-06b7-358c-4651c79f89e3@linuxfoundation.org>
Date:   Wed, 3 Feb 2021 08:42:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202132942.035179752@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 6:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.255 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Feb 2021 13:29:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.255-rc1.gz
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

