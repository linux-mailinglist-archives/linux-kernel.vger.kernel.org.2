Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D153549A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhDFA2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbhDFA2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:28:17 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B4EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 17:28:10 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so3281544ook.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JzpLMKTbOeJE6p7+W9TyCfrC+0vmtgBUtRYaKJT2xoA=;
        b=JATMXbIdPSmrbIrRAtVRJR9ru/DMuWtIL2+0iXfdbF/K02c2U7ICOEhcFypm+bOmsP
         YLPOyhCtDRma4EDp8cGzR2K6/luIPJt4NNfy5bYpCF/YX0Cg7JDJKjvTC3MvFj3pIMGd
         u/Jl6TqY+1yUKe4aAo5EHje79uusRAlO5jfgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzpLMKTbOeJE6p7+W9TyCfrC+0vmtgBUtRYaKJT2xoA=;
        b=IoywNW129sClqfe/fCHJ76xj9JCvuW2fv2jtYxGSMRfmIU6tp6UvEegL2X+J7hVtG0
         8bF9GldRXqkWBK/DcchNoDp7c55IVPMncM5eOVEXUYL07uRk4i0UjM2MmcXXVEZDcPK2
         hM1vS/uOIcXmDOlmgNpsDPDDY3XWJ13iy/U/pXD5JHrlInwrAk5LWtOk25/Pq7fufYq/
         UtZJq6ry4b/TgmYEvdJn17rseYwZSwaatNLkoQ2Z7y5JE/LNfIO9WSTkEID/kE1MPGZD
         w734LV0MulnKxp6vUwoVJTieeCEUkDA4ossDm0Za51htf/Ug43b6PhmhwBHEbV40w+xD
         Spfg==
X-Gm-Message-State: AOAM532XmbiELcrivvy4D6fmJeDHxe7thfZr+hlWW4RUNGgDgNIZ0oeX
        WDAftwlpWfKXsO/h43MkfgsAoA==
X-Google-Smtp-Source: ABdhPJy8ziWPab7tD37tM0DozKIAuP2lMu0Yt8bq79zPjWdN8HD8Q1k4cQHzMVLikYPu7Tnzoc0ofA==
X-Received: by 2002:a4a:e2c6:: with SMTP id l6mr24325950oot.31.1617668889806;
        Mon, 05 Apr 2021 17:28:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v23sm4340199ots.63.2021.04.05.17.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 17:28:09 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/56] 4.19.185-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210405085022.562176619@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <104a56e1-47be-d50a-5062-dcae411ae818@linuxfoundation.org>
Date:   Mon, 5 Apr 2021 18:28:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405085022.562176619@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.185 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Apr 2021 08:50:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.185-rc1.gz
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
