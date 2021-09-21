Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099784134F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhIUOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhIUOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:05:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:04:21 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h9so22769041ile.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBfmWO8YuHksDLM0tZii9fOthBDpexUuMKCylGu88Cw=;
        b=EHWeL1VMJ/v0SHwQlZV/FP0kMr9RauCFK81LrN190g6hbeMK6qEq8f4CFTfRv6uJuy
         bg2snEvcsMYDVnI+39v3QOajGPsWX1kxzQifuLHuxYZs1D9zX7pl7gwEd26xSthGts9j
         dut0xFNloWL2FBrHQBmz0H/W8+ltBxHV8SmXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBfmWO8YuHksDLM0tZii9fOthBDpexUuMKCylGu88Cw=;
        b=GAEhaX2tFb+CYEwJ5xCqOBgvfVP7ppCZs6Q8OftX1xxjhZsLQJ71qxLC0NTDoOBenk
         mRF+FCmDToW81s+Jpnf2oAFTQg/lQlrN7x68YFXrT8jGBe2TUKnx0fExY5nUsGRu3UQ/
         3sHuRSBvRZBO+VkLpTRtsv0qnsXDPGsh4zmdSjcgAHE2FFRD0FBkMluSDpMGIYdQCmbP
         eMgBCFh05XVdnWNBuy0XNQlyGLbZjrd4+FJOKDwXUiex7kuV/6NATIQfKbY3LEAfTctl
         c1aN15CGE79t4EpS4Ukj2gR0SOI9PenkiA3QgbAFus8QEGyle2HIC0TiX5TCE57Ugcrg
         q2Yg==
X-Gm-Message-State: AOAM532BuHvyieCvTjohYX+JdxmBstNWLfXbZV4xSTD/HP8dhA2g8i1I
        MsysmOW8Gfn2Zlc/rKv1+g2Q7w==
X-Google-Smtp-Source: ABdhPJwDZOKXXkc2LfAl7W3Xs7JKt3pUECGqbtWXsGxtUfr/lL+S3U5ITF72sGHxthGSciZ7S5ztoA==
X-Received: by 2002:a92:c888:: with SMTP id w8mr21524545ilo.188.1632233060550;
        Tue, 21 Sep 2021 07:04:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w1sm10581557ilj.55.2021.09.21.07.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 07:04:20 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/168] 5.14.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210920163921.633181900@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <29059709-73e2-ac7f-7045-fc1e922b3632@linuxfoundation.org>
Date:   Tue, 21 Sep 2021 08:04:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210920163921.633181900@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 10:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.7 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Sep 2021 16:38:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.7-rc1.gz
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

