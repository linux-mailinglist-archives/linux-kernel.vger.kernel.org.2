Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717BF3A6EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhFNT3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:29:10 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39771 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhFNT3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:29:07 -0400
Received: by mail-ot1-f42.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so11936991otu.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oO/DFsinHfrjOd9hhaHYq6LD/oHJkMh4L4js/wcq0QQ=;
        b=B7vA3xYHvbKYylvardbQujQscx4z1Q1lcZfd0AX8gtk/zb+EcwPvXP0vVK+FcoiMRX
         84M9DIGt1X9R0M80Eh6Diyln9yF2qa0oQvrG1feo+7IFlcj9cy8kgIXNDXIHrsXY+PRm
         xIjVGWzOACkt/ugkTkk87Us9gkUClEXXCV10c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oO/DFsinHfrjOd9hhaHYq6LD/oHJkMh4L4js/wcq0QQ=;
        b=dOWxh2BFpsVY+H4QfoVOS6CfYAqogbVdoYuIKMA9lkWVp6CzxYoUHBo9vqXZz95SAR
         A17NwWjI5NUVCAbT1Lst6xt43r0tefdzERay2IEWxHw58z8+7OMVbd0VhHxQcO0dYprD
         e/V/rFWYMEIYUzS1DucQ3PVWKWl7D0MOOELdlquvZ1roPKVWFPHsIIVbsXunrtfQjfG3
         FjODXOOzpzsQ7GUwfPeRdC5ZkbulHIf+qksJQ0/wIIgDhJTGpfbeA7nCqb4gPGqKjVs1
         wNAH1SWYvukpJ9xnyCNNudKCktXrg/F0FGUpLnCgnl3UssIEE8/p9V9Fitk+e9OoiLgd
         Lz6w==
X-Gm-Message-State: AOAM533BGviBSMJCO4Xs3AwGmHrKN8/gZkXp/y1jBCcJ3ZDBmjTBieaK
        O68zAxn3zlE+WC4GCeWqHnHo0A==
X-Google-Smtp-Source: ABdhPJxmXMhRNJRhhQ9L2vURQkong90t5A1f8V2Ry+nmiijSkixB2RkEXwFgs6N+ybBLfCj4bxF2Sw==
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr14589620otg.260.1623698764297;
        Mon, 14 Jun 2021 12:26:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u42sm2881205oiw.50.2021.06.14.12.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 12:26:03 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/84] 5.4.126-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210614102646.341387537@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <40674f5e-a08e-b447-1020-2dccbd6ccbd7@linuxfoundation.org>
Date:   Mon, 14 Jun 2021 13:26:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614102646.341387537@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.126 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Jun 2021 10:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.126-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
