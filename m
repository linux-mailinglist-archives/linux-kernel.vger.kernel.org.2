Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44987427275
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhJHUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhJHUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:47:30 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7651C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:45:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id a3so15292965oid.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kExSLxFCzGRNQT0A8GUDahEcKucmfYYxMh1vk9rQ3Eg=;
        b=FzNYbXbGfibE4o+SyCtHXlB0Kzl+lRGE+7RTBdNUAc1wsdG5kVFnBrEvns1smX4GPv
         3/XgJiWB5d9hhwHToycmkj+rM6sZK9XD9CrFUJKp9cwXceWtOQZL4sDoTUsyFFSGd17Y
         BsYACqQ8JGD3bcEf/iAQaw3D7OkZ4bQCOI2og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kExSLxFCzGRNQT0A8GUDahEcKucmfYYxMh1vk9rQ3Eg=;
        b=zo6vp/EZMAcNaTvOL1j2W9iGkj9c4YD9vORH3SkBqp6v/FXOcwnY5Dfi88knIMyZIC
         3cjU0QW1g0P5WuVUA3ROP31EAaZQdfVfr5tpbc7j+6c/OeXLFRCrzwzS8Uqy6bTOrEUC
         hs5Lisnsw7K/diieEtCFU9wOFJLFgtevyaKa9LB74LICP3whvuq2RgfLMsY0hoCUH+vc
         6xVI3RVLotReH0XVDnmpWN+S9d7fod52sg3HruZBoju3ZFateatYyAksyXB920GmJ/Bi
         iYjLU9XsXq5b7tOm9gImv87xF3Ytyrxw9TcJ3TsWxoxax/LfIcFoL1s3X6do/oOpleli
         ankw==
X-Gm-Message-State: AOAM533z3tOK5Le35H3Sem3+94ByKV8mNpgjf/oTuNoRQJDWoknbUN96
        GMZfxRU5shFKocxPb5PJ8JLXKg==
X-Google-Smtp-Source: ABdhPJx+vERtutZ2HAWH36HX0c6r9TCGotwvWB/6KVAaLC2CYakDOeo2/AhvMRqoMW82jLUymU/m1w==
X-Received: by 2002:aca:b3c3:: with SMTP id c186mr14623719oif.100.1633725934018;
        Fri, 08 Oct 2021 13:45:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a13sm109080oiy.9.2021.10.08.13.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 13:45:33 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/48] 5.14.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211008112720.008415452@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <26a66ea7-89e7-9734-773a-b53a6dcccafe@linuxfoundation.org>
Date:   Fri, 8 Oct 2021 14:45:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211008112720.008415452@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 5:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.11 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 10 Oct 2021 11:27:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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

