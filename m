Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6D38B919
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhETVpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhETVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:44:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F33C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:43:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t11so18090860iol.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRSw2I7XDnnc5ITtr5YLMCGw8zw6dxZ7JSv8THbsa1o=;
        b=SekyqvHWjEeagJMU9CjiHKrfnzbRgsvYETe7YwZWOXnMVVR7nfWLYSYmo79c4yhP71
         FqYMi+lSsiGNcqqunxu1OvMzUtfV6yzWpDiQxPI+dv+0K2XUIRtnhcSGCZjsuChwd+DI
         cQLWUfsjVp0o4xiJWq1Z3fXG/gDQlJme1igTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRSw2I7XDnnc5ITtr5YLMCGw8zw6dxZ7JSv8THbsa1o=;
        b=GTyQs4zopB5FCaRS9q92Ofo2MfSPZse38UNRDbvGwnNokxsvtYVUd2MqXP6DdWZ2bG
         +Rpr/9rpYlLMBDAW+7AtZwBBq+LkV94vqCQ4O9KCHj9RCpWB3C6Dt7gzpSKrc3JPkyUa
         q7llSvwWyskZz9ElbrIuWJBI9oGcmr6I7r3knO5ay9qtEaopIluOkFg+C9epKABVmKxf
         Nh0z+vIbNMcN70RO7I4sApCCFck9FpoWRoA+NQ8yQ7rnhZHyTRdPKfe8mgT7yWYM4Xyt
         Siv9Hw+D3mw2Vdf2C62EtUCsgChpRrOzVis+Q7ifGutVmpuMdydYUne3qm3iQ3bwCFJa
         NDvg==
X-Gm-Message-State: AOAM532RnDw3gkuVKZSXvzcvdkli4v46Napc+7HoWhFol8x6hHaRffX7
        4XrQEng+jEuNOFkp9WQ+3zJWlw==
X-Google-Smtp-Source: ABdhPJxGvT/EsOD0HmbS4hnpNFM1zzIhEPA9EvHYU5J5gord3MtgGFhPzmWxWpX0cAcbyfobZ/vzqQ==
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr6553422ios.141.1621547017029;
        Thu, 20 May 2021 14:43:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n12sm4217249ile.0.2021.05.20.14.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:43:36 -0700 (PDT)
Subject: Re: [PATCH 5.12 00/43] 5.12.6-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210520152254.218537944@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e67e6529-628f-ee75-16e1-c9b577adbc89@linuxfoundation.org>
Date:   Thu, 20 May 2021 15:43:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520152254.218537944@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 9:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.6 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 15:22:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.6-rc2.gz
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
