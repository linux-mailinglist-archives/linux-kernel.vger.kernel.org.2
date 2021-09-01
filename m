Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57173FE4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbhIAVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbhIAVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:22:20 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF5C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:21:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n24so948535ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WjMX3sAefCe80N+qSokMg9lBnvOOtzWIhXf3B5Jmf1E=;
        b=eftIRH+hiZut0uWcQsBQe29E/pYdL0jYkDqrAN5VdIRkxdd3lEIdT27PQ0iNiuj3yX
         vkBzyAf63axGWKgPG1w1/YEowpPZakc3+qTk7ipAIfH50CZatEfuWmCSU743RrEr18y+
         CAbxyTeZjaWxTrjYO7R/XEFd4Utlwu5tzPofs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjMX3sAefCe80N+qSokMg9lBnvOOtzWIhXf3B5Jmf1E=;
        b=IXxn19EkVvGvX2P38VMswndNBemICmPCT1+U5viz0rAEFP3moftqZ9sKu/Z/OfRYUM
         pd47E07dm1RP7KUyXp6E6vIklaN53c8uVO55Nhe6tsH74oI8URSigRnrzViRQhLwzyCE
         Br0OmwxwzpHW+HGitLj2i1MNM0BB1BAMXZq9GiR1e0FKpTcv7Qy4R+BZdLDYq1PWI75Y
         bF3vbqkBVpI9uPHLGhvDZQkFpidrN8Fk/FtvhOzWgDRQBpzXOe0RfELSWgmDeIOpp0kh
         LnTnjtEKApDumJQLnQc58ubLtsSbkvNqhcMvi46nQjVyd8HyzjXKfKxrsfIvKWmcaCmr
         eiIA==
X-Gm-Message-State: AOAM531VmYT4eUvzYD+bgANpxON6UWtSniUm6glX4PKcCHyJVNO0xIyk
        sONdYN1Hojmy/d7A00u5ZwJnlA==
X-Google-Smtp-Source: ABdhPJym2W9A6J7JN7hbKQ4BzmF0DNvKG6cvtaXd+61I6Vjb3sGHguaoQjJydDyeF/UWyjzzXDh2cg==
X-Received: by 2002:a5e:8e04:: with SMTP id a4mr1349288ion.56.1630531282427;
        Wed, 01 Sep 2021 14:21:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x12sm401646ilm.56.2021.09.01.14.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:21:22 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/103] 5.10.62-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210901122300.503008474@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a8f5c6ed-256c-9dde-a0a9-df1b80691d7b@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 15:21:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210901122300.503008474@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 6:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.62 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Sep 2021 12:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.62-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
