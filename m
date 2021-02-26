Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5D325BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBZCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhBZCZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:25:00 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9ABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:24:19 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i18so6760412ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bSwPBgYWrX1t8PvpRAiY8sEs2R5CFx/xK13GgwFJYkI=;
        b=N4Qk35pr7esoEA7JFHtA+sAzcSjPoPmiN9V1k240d0dr1+1IrSOPPCCiZRo9GLXABm
         cBKyPHeY9LoPkxf1cGuVtcUqV6Gu59oEWScDbQOa+dzSagZXVfrdkK0uUb2FW01ydj9I
         2MamwFtHfxLdNNOigkAFvq9FnMCdBY/tb/bCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSwPBgYWrX1t8PvpRAiY8sEs2R5CFx/xK13GgwFJYkI=;
        b=f4AuGU3Q7F3OCYr1xXgVGLRVkNGmKNAVgvjAOpA4vWXiyI5MLJetq1/o4Ti6z/yfd8
         VuLVRtqvzIpWqO10i32glvLXYewVkcibBMpkvj8GhQf/du28oR5BXtwzJxlvB4ANZQ/K
         lN6A0uOEWdJXirJraAa3kLIJF4TxJ+6H4pNpeAPS9WOvBa9tjbu510Iv+Jqo9wd9LqdG
         XzsSUrq9xT8mfZ5k08KxySqI+FKOjesoCydRoJBgYsOyxI3ful9MEKlIJEgrYwAoU6hA
         O9CIbUKK+0GTr16bIkd67B97NItZ6QIJvpX+lfSODVzreuf+8Fe5NePmncSrH3cQSVQh
         Y2Qg==
X-Gm-Message-State: AOAM532f05iHmhOK7oD6BPztROyA+1WRs7BjsckaHzuqxj9B8r/j3k+Q
        bksWr9IdgGGYSxajQvUsFURqHQ==
X-Google-Smtp-Source: ABdhPJzko9LTVlFTArRNo/SBYyV9WiPuAmPVkpSJi8Uqw90Ik/5olkEjjLvOxI6UTvZgOjI3wnbzDg==
X-Received: by 2002:a05:6e02:1a49:: with SMTP id u9mr592216ilv.140.1614306259317;
        Thu, 25 Feb 2021 18:24:19 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u14sm3959497ilv.0.2021.02.25.18.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 18:24:18 -0800 (PST)
Subject: Re: [PATCH 5.11 00/12] 5.11.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210225092515.015261674@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5f94d678-89f6-ed24-3ab9-a7d109dedf84@linuxfoundation.org>
Date:   Thu, 25 Feb 2021 19:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225092515.015261674@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.2 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Feb 2021 09:25:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
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

