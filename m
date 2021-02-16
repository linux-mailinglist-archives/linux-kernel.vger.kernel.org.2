Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3831D2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBPW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBPW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:29:31 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0237C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:28:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id g9so9677697ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MpgUK3AfXz378I992/6nYc0Lpif5TyD4Ntzc7/xwew=;
        b=B4ldjV2mbWT+qfpCBGe3YctOXdBcyMHxY/nOnOyDKbvOuHOnlH7HU/rsZw+vZ8Posh
         tMy6j25uf7wkeL515qtEut6XUoogTlisojY3o+zeU93Hqa7sZIpuVAZuShtJvWU0z4lO
         huj/u0Fj+Evj/+n/iei9PWV0fBjmsTOpqumAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MpgUK3AfXz378I992/6nYc0Lpif5TyD4Ntzc7/xwew=;
        b=knuLvoe9KsIzLDQVQVLlcvMP57mzwyS37wVoXpG8xvF9oyTb6JHzdIIzgWV2XXMxhc
         z6E+GEZL7p+IuLhSqmF4KbQ93+XxxOizwLsTcPuT9xg7i0PVqSmoqOcdXOm+z/vYN3kb
         OH30Ak8FoB0FDZELzz0jLG3FF1xEqM7lLnhKGK6Ti5yyeK8OMI8Jl57kZiUTNw2TmCtT
         7lsnPnKlml/ji0GPfwBRqMYVJMjKGKJ5IMwvVYjaeS9m+IxUPXwGLyF0mYUxs5RCGKuT
         wYNAlSpAjEH3h58GQT+un/y7LgUUIAaYdf0UzUMO3vPZIpTk6o9M7EN5z6q3U+8TfH2w
         PNhA==
X-Gm-Message-State: AOAM533uNLVXBOA11TYmBMAqS1yghVuOSFnxG2yaaGqX0i69lphMy3T3
        XP2PK2F9wOqbSl2RqZ+DXA7ZUg==
X-Google-Smtp-Source: ABdhPJzXeidkGxIkWFPM8lNU2Bbv6GGQwyKAvsGIjmwBz0HiUWjT0CQPvOLVMX/yKD3MuodxixQCEA==
X-Received: by 2002:a92:6d05:: with SMTP id i5mr16940038ilc.193.1613514530353;
        Tue, 16 Feb 2021 14:28:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z7sm168242iod.8.2021.02.16.14.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:28:49 -0800 (PST)
Subject: Re: [PATCH 5.10 000/104] 5.10.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210215152719.459796636@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <50004e24-516e-7c8a-d6ab-2befea7d7baa@linuxfoundation.org>
Date:   Tue, 16 Feb 2021 15:28:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210215152719.459796636@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 8:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.17 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Feb 2021 15:27:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.17-rc1.gz
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
