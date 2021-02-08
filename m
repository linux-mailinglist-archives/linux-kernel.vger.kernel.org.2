Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80F31414A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhBHVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhBHUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:01:51 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8DC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:01:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f6so16349125ioz.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2cHwYrSDu6d9T0ggDQwxfsH0y4RYpWUkI2F5iUQkfY8=;
        b=H95o/sV2OPA384Pkciu6Ulbv8vDUPrXmmoMbxSRlv3EAz0kPDbPJdNI2KAt6VALw2n
         SCqRiqrj+qbt2m0q2U+UcojSqTlMdR9/yZTLJl5MoKqcWwf2RLklPIRYOUAvIGGoE49F
         rppt9UK/xvbW8/20n7SRQJ2+yowMH6fPzAGkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2cHwYrSDu6d9T0ggDQwxfsH0y4RYpWUkI2F5iUQkfY8=;
        b=IZORcyYvzKciyC+8hNtmdutJ6sdUXGfXCrKqpbWVmlvRinR+OFUjUoKrFp++aeclQ+
         /uBVFXsg+gl23eEy1wG/9z3HS9UhwKYEONMOwIOJNoG9QbYAE+M5usWzRwmv2HLLp5A7
         PWkHiNorhGTRG9dDtBU4WgOL63YSP/1LOSN6m9MFqKH0zsziYC2YaWaT8gw4QT/sfs+H
         cacCVocdK0+djA5+lZXJ0QETRId8mkiDqbu/rna1SQlss/ayoF4wXLLuHZzeTe28pmHY
         y8/oBykc3vmIRb6Z1frdOwwTC2mWkwzuovmnJOGarUe7vp27ov8/jrb4R3Haz+jr73HJ
         SRUg==
X-Gm-Message-State: AOAM532OoQeDVmHXtyy7hvb6ITMYkefF3bV/g0bMcPNmIyR+4oDcfJu1
        //BW43X74kFo/dlyD1GGhC5+Qg==
X-Google-Smtp-Source: ABdhPJzQDrXmakrKiHzK8eviLx+WrgmDi1Cw+y5trhq6TtSjdfL//pp4W4CrudlSciq2aAUXGFcDug==
X-Received: by 2002:a5d:9252:: with SMTP id e18mr17142320iol.146.1612814470667;
        Mon, 08 Feb 2021 12:01:10 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm9056419iob.10.2021.02.08.12.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 12:01:10 -0800 (PST)
Subject: Re: [PATCH 5.10 000/120] 5.10.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210208145818.395353822@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e17d7d91-a7e5-48c4-a182-276cc5338cdd@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 13:01:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208145818.395353822@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 7:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.15 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.15-rc1.gz
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
