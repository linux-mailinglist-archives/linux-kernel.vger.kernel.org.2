Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11673FE4D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhIAVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhIAVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:21:40 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25085C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:20:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m11so975505ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N79fYJiYSZTJUmZYzo5WK8cisS6TsyEKo5lMANzIV9s=;
        b=XsrzmZ5VdkJqVstqoXVGLaX/dx7uhm7oM9BKlo97gvg8OKzJLslPwfOC4ohq9u2q3s
         1jlR7xGqRog0C1/PGK309Mc2e2O5J+lc2xu6u5f1BxTCV0pZ5M9EDRJEV+2ZAg1WM4J/
         ZVtp1k2rCCriPcWA4dBY1+cCVyBapSzs/w+QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N79fYJiYSZTJUmZYzo5WK8cisS6TsyEKo5lMANzIV9s=;
        b=lGP7XjzQpS8EuZEXgyr2X22EVUB+3RVeLDrvoca2L9lko/TjJau9ISU0fKLB5ZYeq4
         Ekho5B9CVYi0+JNWlU19t0V8KKuw9wDO0XDnbMYwn2e1SPMmcd2Bxo1fw8F1F/vK6Hgo
         s1+wK0Sa+WeMfzPXJ5NDXExhEMZQxijcO//zhYaLBOjvMH8C2bKQ6i47zBwUKdXqXaOt
         JPsPmVhS4P5zcy0EIuUsDA5PfzsxlO/WZPP6Be6fl/VgDFXWOlznmSg6eVeCezFL9Gxn
         Y0UmlQaQDyRxSJSCI/lupfuOrnfGkpSZjOk61bDJFilh3macqofkIvranaKoKZSJ3mVY
         spqQ==
X-Gm-Message-State: AOAM531DZ3uUB+T8DpZu+fITtlj/NnotzH53Y0XpgUze9UCJaGjCU6QY
        UH0DdNpsbuXSgo81pbz3nb+tZQ==
X-Google-Smtp-Source: ABdhPJy0BCtNNGghErJ+1bFPRIWyFNAJXh5RW9ZF92K6oWLxDneenvhjU2CQaVri09xBx5ZqbybbZA==
X-Received: by 2002:a6b:f114:: with SMTP id e20mr1310214iog.41.1630531241599;
        Wed, 01 Sep 2021 14:20:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p15sm425672ilc.12.2021.09.01.14.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:20:41 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/11] 5.14.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210901122249.520249736@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43013c63-db97-454e-10ce-ec4731bd1895@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 15:20:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210901122249.520249736@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 6:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Sep 2021 12:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
