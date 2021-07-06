Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379563BDF72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGFWqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:46:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C828C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 15:43:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o8so397555ilf.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3z8HBALDhOfGLffR7q59/CWkLOtZ+J0gnG3EuaIOkM0=;
        b=GZ97IW5VEu5PGuRXf66jMXZdDUN8UDxtI3QG3ZDWv3+3YGOyjKhY0dz94bkPOFMgLx
         dXgjU1PqN99cB3U01SYSw/spjzhpVoI/HfvVu2k2ZmgdYLyaDLb8CNqZUwHilSsAYotH
         FTNARhah/1j4VgjbG0eKnN+z8sUPFjZZS/aww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3z8HBALDhOfGLffR7q59/CWkLOtZ+J0gnG3EuaIOkM0=;
        b=PaMt+E+ru6mbgduTQPwSj+9gcGJYGv2OQk+6i80kUkEkSV6pY/FZn6n/ydfohopOmF
         34HRGN23j8p7YIFpsKodIP8+uDMMBnmNzCPOksgwPLoXeEr4oZARE6Um+8OLMYuyWv+T
         ZfjtIUPcUVjpSubtusa12c7dZaMfp7iIHFat7Hq87gtxyLdceVWJPb2xD/escDJuxx3w
         kNp40qgtVDslBOc45SK1xxSjv8oT+54IxUTUIW5OW2B2GJAhtspp3Vy7HrzS8LLBGH7R
         otFMKEilwhFx4Z2biiGLzUQLs1fb3h/b7ojOtGmmvw4ohNCkkocPnkh93zUPcieLTUyh
         G6Dg==
X-Gm-Message-State: AOAM530M2EemHdlBITemyodPzs9n5pWJ2S25vYOG9OW6rlFvsA+I4/3D
        u6aZun5bPff5GHuU18ovJ9iiSQ==
X-Google-Smtp-Source: ABdhPJybywlT0BdzN0NtmHN1lET+td4hMM6XIkIfXgfEgICRaXnHvSFKs8/uksqZHPmj3URtqDtUGw==
X-Received: by 2002:a92:c703:: with SMTP id a3mr16022097ilp.118.1625611411484;
        Tue, 06 Jul 2021 15:43:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l8sm9292699iok.26.2021.07.06.15.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:43:31 -0700 (PDT)
Subject: Re: [PATCH 5.13 0/2] 5.13.1-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210705105656.1512997-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41c9c1e8-f151-a8c4-2681-f8700aa6a9a5@linuxfoundation.org>
Date:   Tue, 6 Jul 2021 16:43:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705105656.1512997-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 4:56 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.13.1 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Jul 2021 10:49:46 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.13.y&id2=v5.13
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

