Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A844328B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhJRVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhJRVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:02:20 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71167C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:00:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so5914858ilo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9iDEH9s3SYN/2o6Dnyml+lF+spW3V7+dMTflhdwzT/0=;
        b=XGMt+nzu3r08/4TODpwfqaneqSX0imp6YLnZ6AeC+kR1RI5t5brbJHcReNvSoi6zrh
         G9E/yxbtNC6QeULfDyKxgPPBoWe+wzTGlWAeoOfzcSFczdv8mKNz+m5VL6BM4LXY7gWD
         qBs7EGPc2zgOKWa896xqbtOOZtd12gZVXG0Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9iDEH9s3SYN/2o6Dnyml+lF+spW3V7+dMTflhdwzT/0=;
        b=m/L5YHo5orGlxSPrPvV58nZwLUGkFlkbtLyy4dO/vPVELK2xp/+mgSjuqhvIlsTTtZ
         CCkMh8gsxh8cLRjh6klqbXtUJUD+CQQAQhdZhjqmWxvMe25rJBGJr0KQe7XLtO3qwE2I
         5Ac75ml6+dvnwKPHkf2/0i4Ze01xiLXI27CytUcPZmZ3kx3j4xOWfCfujuwyeOMv1r1N
         8GVznm36PXx1AhqNDdU9V7Qdv3mH1f7MX31vc8laTBdzE81/lLE3aUwp/982OgyYHWwT
         OUrrVDIrxKLdfuWkLN/PBlgkf0gzmBWfXiUAS5+5qrK9e8ZjUcGaWKSJbM3KecVgI9DF
         WQuQ==
X-Gm-Message-State: AOAM5300mdWhy1Mb2sBZZyvDjG65IDZCr9Z7B0x6HICYiKKhxe+4H0yJ
        fX22yI9fv9nFN77aoCSGPTbKkg==
X-Google-Smtp-Source: ABdhPJxKOCqMloSr3C8jzamHG8vjypbw04fZ9QJFgp34lwiEMITkxR0ecuZ9a/3T8eXOE3cOWtSDiA==
X-Received: by 2002:a05:6e02:1a05:: with SMTP id s5mr15447645ild.164.1634590807885;
        Mon, 18 Oct 2021 14:00:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i18sm8153830ila.32.2021.10.18.14.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 14:00:07 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/50] 4.19.213-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211018132326.529486647@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9584fca6-afda-ed4b-6a95-deefbabb80f9@linuxfoundation.org>
Date:   Mon, 18 Oct 2021 15:00:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211018132326.529486647@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 7:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.213 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Oct 2021 13:23:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.213-rc1.gz
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
