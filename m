Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD24073C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhIJXSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhIJXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:18:35 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2CBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:17:23 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h29so3695382ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2bOFYVri+7dNEsH0agXpR+H57IFuUcEjKkT870ukqg=;
        b=fxJ8iJ+qzYRxDY9l4vsL2HmgAYnXWKNx8xoMMKbsDZZ7UcBpTsRjYqv/65btWGCOk3
         qnivqEfMC8Es7d3Bye1Ipjm8qcRMiabEKUZNyJlEFeN3wcQ7bUYDNYlRJGo2PR/gEsKT
         lVxyQEGTnN7A/rPR9+WJTeWkxNOMLHNBU5ghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2bOFYVri+7dNEsH0agXpR+H57IFuUcEjKkT870ukqg=;
        b=65W8Cc+wyndtCk56oaZxMhCmlA+fsNdZqfCb7QipS86C65IG061AQSQOz3bo0NUxzJ
         msiRbUOuaENfc8Izw/yP4WbITLey3Q+JVVsQNC2bb71gJNUaXQWwmNXtfTfKWWn7vn1I
         3I34aQE3Ai5uPXPmiBJP2UxrYc4HwhXgIVvc/SSB3zKVKWaVDP+qI0X5rdGMAeMjT96k
         jM65boEDPb6tWe9xHAv0QY/gjBS3D8dtBlGlFIsgiI1Lf6tHThpTbpjWaQAqi48uVQNX
         V2ouVxsAdP+vsiFLExz4OpYut5wEV26xQL4wYPRk/j0uxtUpgN0PULJAJgP8WP9M7Ts/
         Mh2Q==
X-Gm-Message-State: AOAM532q82hSu9MzcQyVK5Jr4CBRrNP7BRe/Sfh2oTuoU942Ht7dyvfo
        YDGughXKDnoo027oDO5qYgoXPg==
X-Google-Smtp-Source: ABdhPJxDGQ6RGDxG/Rw1bI/mjr0Kb7/zhACF/b2p0lwxMnGkUONmMuh64iqLKgrasi13iY8fGyaepQ==
X-Received: by 2002:a92:cb12:: with SMTP id s18mr90295ilo.32.1631315843265;
        Fri, 10 Sep 2021 16:17:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c23sm68921ioi.31.2021.09.10.16.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 16:17:22 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/26] 5.10.64-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210910122916.253646001@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6478613-acd2-e0c1-0789-3bdd73708513@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 17:17:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210910122916.253646001@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 6:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.64 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Sep 2021 12:29:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
