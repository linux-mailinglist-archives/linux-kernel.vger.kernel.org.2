Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E127340EC50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhIPVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbhIPVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:19:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F68C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:17:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a15so9612694iot.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MWUcyqw5AT/F/awYSJpEeJfXjdt0WV6zdTs7NjwmRy8=;
        b=DT8efgUnz9IYDoApPgGfAyLuh3yRW/z0C1TlbT6IuhFdIcN+qvX5NYgVmKiSGEIwZl
         cV0hUEsocFutHKPjwruXHNVCa3SGYfG5wX4mDkmro+nPLuzb64HIzS5jH3W5bYZ+dwmi
         46X9YOHoa12ZuHMsT7frzqJ3Tp9ASwWO491DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MWUcyqw5AT/F/awYSJpEeJfXjdt0WV6zdTs7NjwmRy8=;
        b=W7Wq/xFR0svieJ8ZHcDJ1vPcHB75T0C4Dm6jLZk/JgBjupSPfY2J+/g1wUDUgrsTdy
         ESX7Zdf3GItlMO3AUrH/FqnohovsVKp4myxLZqPgitDOoSd29Om2BbF+gp9bSbUKo6lF
         G0wbaRqWHCasaUY6Le5U+//ya5uaJRIgywETQWMYtJaJhOiNHY53rwAyAofzWfed0A9A
         Sed44bHdtrTDNWlw+iJnbAlvP7GjYoRxUhmzk6WFxU899gfmheajZErZlbm8BhrYM5oE
         W8CB+bPeevx38zhKEgO6YLUDRxv/Q2fPlVTlaCOmXcS/l8JE4XKee3L93Lz1VBlU7eUN
         g4fQ==
X-Gm-Message-State: AOAM532zqUagIebQS5VfckZGMHcTTOkcNe15fnjxB8xGy0qjpFT54/8f
        P8udBKkHoiqvHRyVScAto30caA==
X-Google-Smtp-Source: ABdhPJyN0t3sAhpULyjo07fmq3MaAmduP5J7+Qhf3KOTOj6ZBqXjXTXzhG+/5sE7BaA2qFrO+RcAXg==
X-Received: by 2002:a5e:8e04:: with SMTP id a4mr5916454ion.56.1631827075652;
        Thu, 16 Sep 2021 14:17:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k14sm2350827ili.35.2021.09.16.14.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 14:17:55 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/380] 5.13.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210916155803.966362085@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c5062a4-58fd-4e7c-6d00-301637f2cd9b@linuxfoundation.org>
Date:   Thu, 16 Sep 2021 15:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210916155803.966362085@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 9:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.19 release.
> There are 380 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Sep 2021 15:57:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
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

