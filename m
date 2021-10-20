Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55443427A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTAMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhJTAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:12:07 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1746C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:09:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s3so20337487ild.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MLnFGF3xAwmNtTsEsffubAjr7Lw5wtxPxpItXOrwi5U=;
        b=WXtQCpvJZL78iexON8efaT9RpTv+mLYDmQitcRzEkXlAawABdAN+4TCbgbgQrGYErI
         P/jd8gQTX5gVQxxIwe2idgFJJ74tG32kuILHEfyXElpIlOf6dSaIs45op+HYDleNL4kr
         HsvD7QB32pptAW7tXY910ofLYo7Lg2rxK81SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLnFGF3xAwmNtTsEsffubAjr7Lw5wtxPxpItXOrwi5U=;
        b=XPIRsUeJdIPB/Pm/TGyk1Zs6OAJr9w7IgkEXZcAqXbrYUJ15c3NLulSqdyCgRhm2Dg
         RKyS9/vCnhpJ4M4jlrsFmhxFX96za3HZKlyNmvU9eqfgiRlUBvcP3AZc2akGHgywOUDF
         cY3otv1WA6oicE6ej0RpxVSdVBYHn9BeZqB2etSPfEOElVGgYA4goO8CGuwF0Je5C5l/
         ZTl5JXSdZdkc+62T4KEpQN/a7JrIQAccF7dPuzvSvhqZqBU4QfUtF34OcZUpxvm9qq3U
         k06OUiWq2hFh7vn39Eph5iMSATE9c0da9OsYXZUu6vM8nS2W35shhA0tenG3fDIOgy1J
         rXSw==
X-Gm-Message-State: AOAM533eWf21W0OYt4m8RbLO3mPF3D8IWiMg1O5juvvldJgqOJO3WEVu
        KTazx+S9+jSa9jwtY206PqaypA==
X-Google-Smtp-Source: ABdhPJyCvN/jGaZ3H1C6sUx54Y+74zmu9n7NtFc0nB1+1FnQ7pj1JWdNRYYXyz5z0aOqgXs/vCJQAg==
X-Received: by 2002:a05:6e02:8ad:: with SMTP id a13mr21363389ilt.136.1634688592110;
        Tue, 19 Oct 2021 17:09:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id ay5sm309470iob.46.2021.10.19.17.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 17:09:51 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/151] 5.14.14-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211019061402.629202866@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3487da41-6401-06a1-4cc4-829e4145fd32@linuxfoundation.org>
Date:   Tue, 19 Oct 2021 18:09:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211019061402.629202866@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/21 12:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.14 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Oct 2021 06:13:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.14-rc2.gz
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

