Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A33FE4E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbhIAV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhIAV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:27:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C07C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:26:09 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g9so965954ioq.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M6c0a/s/pNn9nCeafbz28quuNSf7y/ENS0PCg/rtqkg=;
        b=dcbMK0Ier0fkGk1CE+o3C0VDmOLrO+L9mRK+dOf4ZWw1JmV5mQo8gqMlGSheQMmrr0
         E9jUZQuxAFk9rSefoIQFsX3Mk1muzOWctG2KGryCtFfAleD1XxKbVqEXs/xbpGnlcok3
         IOILvLHNFsrb7wIYh1TgfeWYpmhStI4QV0B9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M6c0a/s/pNn9nCeafbz28quuNSf7y/ENS0PCg/rtqkg=;
        b=R1ck40Lva6MBkCnJYrAzBWKSfrDIr9aPUYjRAsWwyJvMZdcVm8k0RAvG7Au9sIl+hK
         Bfj/rZRTfLhUlabyo0MMhy4TyphI5YwJKFw0JOnNGD+588F+Te56FGfUkHOoqmuIgM9V
         Z+RcP1zn5frBSpdsLGtMKop7qjihJaWZZJNi0/wujbp16EkTsYdtEuf87vVohiKv3aFp
         wahra6vTWXyGGAZNG23oUXwPOXsGELhi4zCnFkEO9xnDl73i603kjO4ecQGXCFYXiqtE
         bY/AIi6jnhQRUhtnybrhyqEvHOjCJjDs2NPjtTkNcw1GYFROLMKQkoK01e+DQYfY5NYY
         QdbA==
X-Gm-Message-State: AOAM530+/BG4F3HWnmSw8oy8R949g3VxEHI/9ygYAaPFNfQ5iFfgdfB/
        wa8YZFcDyjuL605tNn1oI3HBiA==
X-Google-Smtp-Source: ABdhPJyFGk8egW//o0XdoRbM9ui+xiAyDWu7qtbptUSeM7KPalDCw0R7cSqr22d2OEtR3D+nbVVthg==
X-Received: by 2002:a5d:8715:: with SMTP id u21mr1313780iom.1.1630531569298;
        Wed, 01 Sep 2021 14:26:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r8sm417512iov.39.2021.09.01.14.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:26:08 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/10] 4.4.283-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210901122248.051808371@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4101d7a-2eec-3262-784c-e406313d82c5@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 15:26:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210901122248.051808371@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 6:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.283 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Sep 2021 12:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.283-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

