Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67811413648
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhIUPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhIUPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:36:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D99C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:34:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b6so23221982ilv.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LgS90YfL2o736jYRsUsNNIgckQ5JWc7O96G7L/BGZjc=;
        b=S/z9zLurpISRrOkX8myoL7ElRssRsdsiangCaSEUSJeuwJlNS+0UX+8HVsxSIUm7e8
         VHL8UsSghj7c+gGUO7af20kzLdqgE+TSSuP6noZg8osA+dRsDVJ6xJmV8mnaG9hBkLD4
         n5d8obmt/c0WEWaFbFCwbs0R0HMpyD44zUTRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LgS90YfL2o736jYRsUsNNIgckQ5JWc7O96G7L/BGZjc=;
        b=CV9Rn88HuOtqs8fgFK6lePZ7cCanKPVtqTydqJeNhtIjuLCtVpXq00rklb6/lorMqM
         HrKJiHQ7jHnkLseoFlXZYPS+4KP0QrUZ5aezoZB5ZMBXbo325tNnqOJAwf8uZpquu93c
         a6ikbPi1U02CwwuwG8KV9KCNo+yBeDolf8epz0AbDG36VQtyYtEGZVlZUw3rsZxjbos7
         hfWXmpRoP4er/HqlDuuoB/n71iEdjdhKrXbm1dFlNfMToXdffe7vJ2BcuYP836GI9G90
         jfDNJq3zvBhUnLtimqjEBE7NKMBVorEG+ciRd1TwC/282FChVH/8IPEv1PmHzasAAoWw
         O9Xw==
X-Gm-Message-State: AOAM530t4o2ndgRLwZKTiQFIzlnCbYp/xm0i4OrNcVDgWYNhrNkXuzaL
        2xSRA1mAyWu0BzIVlhatEUo4Hw==
X-Google-Smtp-Source: ABdhPJxT5BPyUVQ+dawuwLKKg3zgJKIAsKxkZzDActBJNIpV5bSvT3AHqR8YGj86wZXzq/I89P8lEA==
X-Received: by 2002:a92:c8c7:: with SMTP id c7mr22299510ilq.62.1632238477062;
        Tue, 21 Sep 2021 08:34:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b12sm9162448ioj.55.2021.09.21.08.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:34:36 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/175] 4.9.283-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210920163918.068823680@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4c19a05-7932-7ea9-a485-2176432c8874@linuxfoundation.org>
Date:   Tue, 21 Sep 2021 09:34:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210920163918.068823680@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 10:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.283 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Sep 2021 16:38:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.283-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
