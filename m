Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA624427289
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhJHUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243219AbhJHUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:49:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7662BC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:47:53 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so13123828otv.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GtwT1rQHEgYwqcxPi6l15m6JEL8j0ymwX20loHsrAro=;
        b=UeZkW9HVB3+MWkiktseabHpXDmWswS0JrDgmr5j6XPFWbcg7BcuaE49WoUcwJI4BFi
         seHYL+e3aQiLp1quIBLh6SmKqP7i5wd2M1X4MR1VTeFIXQGtGMv1mbyEMVuKcOiRQDxy
         tLA8GCv5lqny8GdqBQy+PSjd1ISdzyGxsbJF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GtwT1rQHEgYwqcxPi6l15m6JEL8j0ymwX20loHsrAro=;
        b=56hmypCr5qc7Mz2dxNW879eYNJ8VEekarw3BoK3Hi6obrephq9qAgFRJeH5ocHl1jN
         TSdBODdIWp86Ij9+PXPfsqLizwQlQSgKgQ5JbHjDv4TqJ0wtpDJcxSjq+jwlMHa3AIrh
         SFc3sJZj0O1/O56oQLl/t3ZCRZ/gmmbd2tEdpxXw5sElC+PWGSMPZ+AvmngSdR71r4ga
         IC4HgLSsk3li94slpaH0mfYvGHsvU5SALSMD4Jeyt6IIahbTGV5nDR3CNuiyH33IFTQm
         ZzT3pUtcRvj5YfVZdQ4LBpo/iy1cuEV91CyF/+pL67D5dEgRpNCrzkiw6+kAqs2/66hG
         HT2w==
X-Gm-Message-State: AOAM530f2tjteeTJMM0LJiqAmBOKVbi/rFsMYjH4jvD92uBlW77AS34N
        dd3PBSSUriWhjbJ9DdoIZJMKLQ==
X-Google-Smtp-Source: ABdhPJxlAz3bo/EbjcKUpppN6y8wp8VYHRFWIb0eV9zb7Vk8weVZ/3yJf3VuzzhmeccVdOWulNe4mw==
X-Received: by 2002:a05:6830:2397:: with SMTP id l23mr490324ots.333.1633726072860;
        Fri, 08 Oct 2021 13:47:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w141sm119753oif.20.2021.10.08.13.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 13:47:52 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/16] 5.4.152-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211008112715.444305067@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f40006be-9d62-f1bc-947c-418a37547918@linuxfoundation.org>
Date:   Fri, 8 Oct 2021 14:47:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211008112715.444305067@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 5:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.152 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 10 Oct 2021 11:27:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.152-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
