Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B853C67ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhGMBQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhGMBQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:16:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809D2C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:13:15 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso20813204oty.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGfvyw9ns++LEn4wxvGIcDCtX4HWl+qHFVB4LAvbNrM=;
        b=Fvyn++v0dJvozOdfIaKfxT+eBx7sZFzQ9+DbmGbnpa+hhWb0K8GR5eERRqgkR9FkTO
         ia7YDYYLDtnq0XezYtbfhMAMfvZnmw2184bEFLAU5lCiHhxOPNLPtQlg93YZMZ76gw42
         lOJKoC1SI9fzf43JsmzCzOaooBDDBc9/oKWSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGfvyw9ns++LEn4wxvGIcDCtX4HWl+qHFVB4LAvbNrM=;
        b=auxAMmIFk4bqAExpW5ksd/TutvlwkpejRtPg0Vzf5s6mza1BR1mVl2lO0Yv9WvLrHD
         lnQ1fLFOqWQa3th5t4FNDY8EFsLbNq1Lhw5WCtIN4pnoDf53GVur2oRG17VsujVVnxXH
         KEpO4OzhU8Li11qiJ8NjBkMm0dcOFpSHIr55mo5Op5g2ai7R6D+3isjRcP0NSqotLmrl
         hpFk178EZCh5EKRaTJ/27WZ0hSUUjZUxoSLSWtpNBR71IWmRq6GqwNl2kKoIJNvkXMJh
         MYLYKVacpAFLolSDDY90zv1mvDrhgHaqnjNgN/2jSsgy3zJTkeIldEUBhad66o7ORdGs
         vPsg==
X-Gm-Message-State: AOAM530IHBtwJY08p06ACOB7Hmokv4yzgEeslKT2Bx8b+ViBwvgbPdEF
        p9HaO9dMvQHd3JBeaiWZjgj70g==
X-Google-Smtp-Source: ABdhPJyaybOH3bVje/QV+ZvtQGY/k5Kvs2G+RlaPU0QmTMPvRv+2rWxaNeKg4t4CJVQKPAfj3LPEWQ==
X-Received: by 2002:a9d:1464:: with SMTP id h91mr1377515oth.237.1626138794800;
        Mon, 12 Jul 2021 18:13:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l17sm106736ota.20.2021.07.12.18.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 18:13:14 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/598] 5.10.50-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210712184832.376480168@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1443cc44-34c6-48e0-2053-9b4ab09a2c6c@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 19:13:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210712184832.376480168@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 12:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.50 release.
> There are 598 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jul 2021 18:45:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.50-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
