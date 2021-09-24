Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAC417D47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbhIXVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhIXVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:53:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4272C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:52:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m11so14487061ioo.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uxl8bJ/3Ny5rHVB3QoRSdTbwwNLx/yHmt7JigcuSqEY=;
        b=dSRTAY16g4wc64n5zuh5VaQLKyoveBoNEXp81/cGslSvZ6WPwB8LKCR653Gj77L17b
         KR+lSfXfiIRHQ2iaNNLNofJtyKnqmBYsNHkXuX4wy3zAOGrKOUV0gpVNNY5TXYs4E1pL
         B7vVSGfvpAMFMiho5Av6FmMb590/kltPZa1xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uxl8bJ/3Ny5rHVB3QoRSdTbwwNLx/yHmt7JigcuSqEY=;
        b=mBkTYtkuQnk1NKp5HIIB6H4e0qTbQ8iQWTjHjkMJQW3hpnz1BTvP6StykF+NnBBX6V
         YnywGnAgh8Byo16ihawtoGZR+/SzN7BDJYi/t9Zwz1DqlaNumHKONkfnpebXL/0JhbL1
         RqL3ns+94FlyGtFK/rWZaQ++OXjl6Fth/YiiUC87dciOr07JcxqOSGe9VctP3C7OwsWY
         VlbfATAkX1GEUl9TUYeBfdnaAPcY1gwBgm+BMrPRVLKdTRR/vj5NShHDb1Ck5JzrXjjG
         luhOBivO02h5E8f3D9lh8oF2xSNNpjtkLoLK0qmdSKVD4TmZVPodHDPhfWCPDcTpFyjR
         9fmQ==
X-Gm-Message-State: AOAM531iTQRxQ1lD74A6WU3Mh2jDARqmrDyyiWTcE6oXcGeStG3gr6So
        UBxEK0bATxRcWOzvPKTSZCPf1g==
X-Google-Smtp-Source: ABdhPJwdQj+R7c6yh6/o4SovmGAA/+AR5zSXN3QLdfIO3Nc1ElB9Xu41KwdOUUUetlgq4X9z/K8Pmw==
X-Received: by 2002:a05:6638:2183:: with SMTP id s3mr11511421jaj.11.1632520337339;
        Fri, 24 Sep 2021 14:52:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x9sm4695173ilg.76.2021.09.24.14.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:52:16 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/100] 5.14.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210924124341.214446495@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec3bcfb2-2ea8-4724-7017-9bcc9659c53f@linuxfoundation.org>
Date:   Fri, 24 Sep 2021 15:52:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210924124341.214446495@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 6:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.8 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Sep 2021 12:43:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.8-rc1.gz
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


