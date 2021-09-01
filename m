Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7E3FE4CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbhIAVUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhIAVUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:20:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C005C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:19:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a15so996846iot.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBl5KyYxmymArz1v9Zu208FCFTMjGimXM/0rAbgK/ls=;
        b=JS+W40vx7ipL5TVrIk/KxSSBkk5fvM6qSAhZJmEH/1yLUs+y2Wq8djBug7B6D9a3WO
         oYORVFzDUHdMR9CPcRnJc+uNfrl2ePcyNrt7Zu8Rc7ABrFcGS+ZwAr+0P4EvlhAf77Pp
         7caQiKfF6fH64ZS1v+xSvFxq4xLrYD/6xGLL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBl5KyYxmymArz1v9Zu208FCFTMjGimXM/0rAbgK/ls=;
        b=ikDENKBL7WnSQJJ53y2lzJdB7pUiyQYUkhgl5Xu97lDsrLThvKc7dGJGVzxClWZg2m
         +xS6GJdEsj3a8H7pAcJ1GtV2oqi34dHZc1zES8Z+zc11RIF5Hgay5rduoRxYGDBDztza
         Jci/lxSx9YKJUI14fEYyG+5qRdBem8UrP78NyCN0ww3IHEOu403QfVoTk9/8m2hsLszl
         U9BdiSKP3OwEa6jYqLWb9AUUpjlRk3ZmGZsatbOzArvuP0IhWVqgu1yoQGF4DyX47XsJ
         doV1SKPf4nnvJ8gPrVwtQch3B1Idm51zqAnxXSjGmlE8QNjUtoqZP5TXEj55ZV8jEest
         OEJw==
X-Gm-Message-State: AOAM531lmDemF8LRgQAy1vsgsD0RKT7KcQFnTWFQQuPhueiegR8KM+/A
        HkWPiiXH7upP1Kplgd3wq9tuRg==
X-Google-Smtp-Source: ABdhPJzXdnGu5l5PSxe8aBcKgtLrqvPde6s4WJOcH4MPc1yTKjaZu37up2v5pBvhypLLteMwOIscdQ==
X-Received: by 2002:a02:958e:: with SMTP id b14mr1366487jai.123.1630531179873;
        Wed, 01 Sep 2021 14:19:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g13sm404213ile.68.2021.09.01.14.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:19:39 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/113] 5.13.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210901122301.984263453@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8d0fe05f-72cf-f4e1-00bd-c44801fd60fe@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 15:19:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210901122301.984263453@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 6:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.14 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Sep 2021 12:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
