Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3963F7EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhHYWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhHYWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:37:43 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F0EC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:36:57 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id s21-20020a4ae495000000b0028e499b5921so278023oov.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M2aZX3TC9GGdOKjZL/h6zHfZIU58Dq7i+vHq70pNozk=;
        b=Qm9pn6insLZfdz+ObgYWhjw/lPlg+FY/1Y6mE/clQ0N8OS5wtJ9rGNI9b2Ti3TWrC+
         BIi/ZdlTQ3nrViJ+DXUqML8HX2GybGw1HoIdYo8vQOPgwokJT4Hy7Rnte63xq7Ie1mAF
         HgJQ59MFTSW2NpMyRPwD1u5lmrvyfXooQTIZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2aZX3TC9GGdOKjZL/h6zHfZIU58Dq7i+vHq70pNozk=;
        b=l4YltwQ+czgTRV7got7etFuOo7QnpBB9/UuOc7748Y/0YgaVKFgZ/VoNHzETl+p7PX
         oTHAjPHAfoLmlh4Vqws3RNHTXXBNgwHUz5C5zrdBLdr14AEED2zyUH63phaaN5vaWgRZ
         /jXKIPs3rpHDhLVmI3fLWNVgRZoxtV4e0cVwn9TCAcy7uYjlN5uETsWxxxVU+99UFo2U
         IgMpJY2asVSWSxnqC79vmlxXlqeU/qGzqRyZciMaumNhrk696ModUqBwsPEc+a/RFHH2
         6Yi7A7LGvsou4QsPyF2959LHjJLkbJ6eub5QD/leBH00RhlyvBsrQ5TbkzXIt8JMLMnT
         3PiQ==
X-Gm-Message-State: AOAM530z+2WZIHomed5MAILMGLN3bge8wpnfXzTK3oIBfuAHg3FERW6w
        e58I1LyT2b1uqJSLLpV8ESO5VQ==
X-Google-Smtp-Source: ABdhPJxAset5nbsfIWG2/zupplYBLZlEAnvX5W7ZCWIOZVG4ukgR9cNuf7YTOEI6ynBpPxpI/0UGsw==
X-Received: by 2002:a4a:a552:: with SMTP id s18mr506353oom.1.1629931017080;
        Wed, 25 Aug 2021 15:36:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b11sm237517ooi.0.2021.08.25.15.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:36:56 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/84] 4.19.205-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824170250.710392-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dbb944ad-268d-0b44-a163-4bd35547663b@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 16:36:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824170250.710392-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:01 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 4.19.205 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 26 Aug 2021 05:02:47 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.204
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
