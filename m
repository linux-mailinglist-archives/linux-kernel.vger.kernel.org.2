Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A43B10DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWAAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFWAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:00:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B37C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:58:05 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w1so1290631oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RmipAmOn4dFo13X7TIOaez3PL8Zy1f7IqUA+zl075H8=;
        b=hCXPbwDO3S4aC9We9uHHPlDq1mx31D5964KHXiMB1MpGg2RjxqCfmDG0aFKSxscdnr
         8tQpPDWfSP9NhIpjXEnv26T3Gn91OtGCV9lYmv5jSPHibG3fFLuJpYhJMiAX/Z/kLIOL
         NoO3cV4P4pp4g69tcr8+d9Zpi2e3n9uUncFZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmipAmOn4dFo13X7TIOaez3PL8Zy1f7IqUA+zl075H8=;
        b=ChPoIAHExNbXTrwqddLwJuSDTHFhxXrLDWwiT/hsegFKtMEftPd4ur7Hhyf/WodlDc
         fHcQCwpRJBVLgPINiT86oJMUdE5542TvbMwvpdxcE0yQBikmyeklXNm8erJA0kkF2sPA
         pmOQT6VWOMn/SxuQCJtxgRL5XwKTh0oo5ZsjMAomd89sb6+tC4jSKgwNSIKg9AttFoYU
         9h+zFPZFyMs6RtAvsaOmDmAG2WR9dKP/DcfSVBcZOjXMDxd57MNhl7e4G9YxTVZqtL62
         /unq8DB5qISZKRkPvCPOBh+bQ/uD7SoO76nd5zkjhJMruJUn/C9Uc+8nCUfeJd0/EWDM
         HkRA==
X-Gm-Message-State: AOAM532H3vKSWbRIAm3sD0UEtyZBd4OusCw5NuAg5T/akLX/nd3A7Ikw
        bfTmJKGpN7SL/9Pnfh99+FU0xQ==
X-Google-Smtp-Source: ABdhPJycSGNgB5ca7a/uXeFM9eKo8FIDGqkLipas8fxfng3/5bBRc3QzEot4tZm1XU1qEFOQK3HKRA==
X-Received: by 2002:aca:170a:: with SMTP id j10mr1048263oii.23.1624406284938;
        Tue, 22 Jun 2021 16:58:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 59sm188281oto.3.2021.06.22.16.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 16:58:04 -0700 (PDT)
Subject: Re: [PATCH 5.12 000/178] 5.12.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210621154921.212599475@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e1e2114f-f5ef-4441-ce82-a0c2fa1a89df@linuxfoundation.org>
Date:   Tue, 22 Jun 2021 17:58:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621154921.212599475@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 10:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.13 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Jun 2021 15:48:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
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
