Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EAC3F7EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhHYWiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhHYWiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:38:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:37:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso987688otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MHOsNp/Hfo3pJmwpbDXaaMZDHfazyUIne/aGLJBlAg8=;
        b=NRLQFafXPKX1ofRcOxpR3N9rdfCRHLXRUhrp2xfESH9c9kC98wZvGSYnYdq0ZH1r03
         NF51WZERL1HG8y4ccA5HIVxCZYJLIg+9m1sj6Zr7DSKIY5oumcH6vD2D1UA2IzqKQHJy
         2Sz0GJUgPXiTZgdhlJS3W9ClkP1JXw7CH7+II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MHOsNp/Hfo3pJmwpbDXaaMZDHfazyUIne/aGLJBlAg8=;
        b=ecr7B91xUVX8NE1lYRONlY/Prm9B9g5xn0ZhOia3pndnbSZkYc0AWtbABmwa2XZKsd
         yE8fUpxT1HRC+73IAArnb5QliPWpT1oi3LNsWazeYEu+uCv80dVgcMx67KmDBttkK9QN
         Jt/nmlzkHFYAdg9asEkHPKsS3n+uxoXT5p6MYbydXqUOiXbQM+fKbPjTXy/gXHniG82V
         3R1oCz5Xcr0cavkX8gmJ2qiQw2eZNpfuKXV9Vf4Snl7Bd+YYCkIzRQHoR0m6SNgSHYiG
         MQRHqYSM8rQLThIgrNkggATKVwDd+leuUQ5c1a/LCpqE9xlZI45A2rfV5KzqffG8SK2R
         jHRA==
X-Gm-Message-State: AOAM531LfMJt4uvABQYMStHtyW/l4hfGAI5apENo0iYkIE5T0mH4p9Gg
        YQU8pRknDfWZddmbmyG7X7s+EA==
X-Google-Smtp-Source: ABdhPJzh1ERGwtf+75Ned2Oo4eEIfFnD8JGM1Wsq3y6z+8Qk8bAmt/HOgKgKD7ZR1Su5VX7tFGi0ZA==
X-Received: by 2002:a9d:6347:: with SMTP id y7mr580413otk.241.1629931038759;
        Wed, 25 Aug 2021 15:37:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n17sm225020otl.32.2021.08.25.15.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:37:18 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/43] 4.9.281-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824170614.710813-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c595594-8771-8d3d-bf53-fe27455448eb@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 16:37:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824170614.710813-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:05 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 4.9.281 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 26 Aug 2021 05:06:11 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.9.y&id2=v4.9.280
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
