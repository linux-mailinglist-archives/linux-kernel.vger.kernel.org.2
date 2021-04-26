Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEC36BC53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhDZXsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhDZXsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:48:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:47:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g125so3467799iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N1+iUjpt+DqfIQDqoAZUROb2PFGSGx7v6tjWvb6+dwI=;
        b=igVYFsShZh/AhNP6P10pgFaI6MMt09jJf+YhkQYzhBdx9ecSTUsepPwozgLXyQpszU
         5bg0rxNa7EfuuZHjuGPs2msscgwfnS7x5ERpXgBert5KB3Yr3BQz9KA3N+WDz7WM+XgR
         0RBZ8FaQE5KsmTB+WdLhOGnD/NRQOmZKFR+gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N1+iUjpt+DqfIQDqoAZUROb2PFGSGx7v6tjWvb6+dwI=;
        b=WT/JqUyR/f07angtlPdPFkV9RNW8MQl5dDMw11ZcuHvyQxLIDyEvk8YrdvuxYXCZuN
         AlrBqd0tR/w7hCwx2JMQRraOi3/XvqWA3+pdVKDxJQ6Lm0DhoCK0Ojm6Jrv2JJ1dlwEH
         mGzXzmA+0IcXBtgwGwQyzxiq5mLVGIN9QINOiQnM2LzDKyK7MERSrzUhPVL4hIZDUdtB
         kg8srX1j36ZD74r9XiAMjsV0faXKQQ6cEzXO7Hh7n7Z+E0n5PyhLu7ElpOjWIGSA0cnu
         nH7vVb2sTsTgBMOUlwQWI7+FcLmcwp6XvOKooJYSWHxZ1A55B4u6pUAUvTTGtPbjNygt
         uE4Q==
X-Gm-Message-State: AOAM532JjuTS0E6+xq2s0JnsffAfvHQkUG0kDEiLEfDjQbrmiQanVaJr
        5mk1Dttl/Se4qWBYz8sflWuNWA==
X-Google-Smtp-Source: ABdhPJzzg5+PEH5nVFyTjJIYORnWOxYRq7VXwRWtouwh8VcL5mAz8TZqWpVja8OdoT2J/c23X9wI4A==
X-Received: by 2002:a6b:14c4:: with SMTP id 187mr16770938iou.134.1619480846176;
        Mon, 26 Apr 2021 16:47:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q5sm8159606iop.17.2021.04.26.16.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 16:47:25 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/57] 4.19.189-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210426072820.568997499@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b32f1a3-4518-59e9-7a40-5012cc1b6412@linuxfoundation.org>
Date:   Mon, 26 Apr 2021 17:47:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426072820.568997499@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 1:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.189 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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


