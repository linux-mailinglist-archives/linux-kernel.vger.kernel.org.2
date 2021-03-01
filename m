Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086BA329FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574643AbhCBDsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbhCAV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:26:35 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C23C061356
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:25:17 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p16so19427034ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKNRQK94wrkC3801gx1zFuH+0ChmFwS1qkLSfCdGLA4=;
        b=dZJAmssh+qj9SCTyxDVIXpThHMLQt47GA2ATA4WbmUG6gGluJJqqxtgPjRuGzkc+9k
         IP/rX3ZU5zYU4Gz+ukOm5q/ObRbrsAkt1H/NqvEuN4GLxzjEuBpN7ti17W9i2WDugszo
         bKICi0MSBlfePq7JiSxJL5eav6NODx6kc2ekY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKNRQK94wrkC3801gx1zFuH+0ChmFwS1qkLSfCdGLA4=;
        b=c4WMuFppR8q2rBKdSxYkTSmVA0O3nttDyLRbWAi3mklqvWPGZB4cI8WhC3rtkgMcOW
         4vcHiw//V+EKJnwKezqDb1EWTey0sW0VKTgWiI9M1CMm4azMVXSuYDpP5j3ZnTiSWPf4
         tXi3LmnEh0r0IT+3/ghRQeRJ4/fMG/R7lPTDEFpr2GLDFIiUV/nhdqjFSkTpF4swCq6L
         rbthNTKXu+eIlZor5d9IymOxe6y/kx/CROepPVk/7GEB3m7VBzchwwugyoCoqStSMzZ9
         qvhUb+nSszU5+cStR4gPRx1wdJxo8GtPULrS97l0lC8VHQVaChXXS6RRQQSxOZLqJpLZ
         Prnw==
X-Gm-Message-State: AOAM532WnDN0tzSoSruwk1CY/OAREbx44XJ2JORZC06f5JBPsX2MCkH/
        uRpb4sCUk/Sid3bb1WTHYfhB3Q==
X-Google-Smtp-Source: ABdhPJxnEDTfsHEkOeQGwqLNTVxq1F2U/uInfwLR5/MNGTf1NJYhcCwYT9BFwD+70tpDLT86pXPHPw==
X-Received: by 2002:a05:6602:2348:: with SMTP id r8mr15554731iot.77.1614633917428;
        Mon, 01 Mar 2021 13:25:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm9649275ilj.86.2021.03.01.13.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:25:17 -0800 (PST)
Subject: Re: [PATCH 5.11 000/774] 5.11.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210301193729.179652916@linuxfoundation.org>
 <664d3da1-9961-1a02-3f22-3f01fc7948b3@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <959e7456-f7f2-2d0b-0154-d3978191d3a3@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 14:25:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <664d3da1-9961-1a02-3f22-3f01fc7948b3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 2:23 PM, Shuah Khan wrote:
> On 3/1/21 12:38 PM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.11.3 release.
>> There are 774 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 03 Mar 2021 19:35:23 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.3-rc2.gz 
>>
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-5.11.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compiled and booted on my test system. No dmesg regressions.
> 

Just a note that the drm issues are sorted out and it is all good.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
