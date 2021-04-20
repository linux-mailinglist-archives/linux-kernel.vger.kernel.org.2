Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C1364EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhDTAIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhDTAIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:08:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8566CC061763
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:07:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c15so30669229ilj.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fr+9CTykaM/VL1Pe5BL6Otoo2ID4/MAwuwsj/VFWyKE=;
        b=QzvtW03L4VhifiBiiZgKkLXiZfGbORbhhM4HS1ajyEJN8vfROU+Kc+9cbALUkeop/Z
         Y4jM8NFL3G6YQp0ifsStxfgEe0aomdHdxiJvXkEmI505R2QLZV0Lhjj8i726geXH4Dl1
         FTceB5TYwrHBx/ZORgDKsStQqKbqooyjv7L0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fr+9CTykaM/VL1Pe5BL6Otoo2ID4/MAwuwsj/VFWyKE=;
        b=dJZHM6bwiGgg/8XY/dZXFg7dP6RTRZj/TKDubi1BDZu+Af3U5f3Fo+y9IgYo5eLmvr
         WD7Vd4S7vaoTiANr2DV3Erc5nac9SglxofglJIDcgbHyUOIQaoD+yi0/L7V9ocloeQS3
         EeaRlNZ1OjfJEMKHNQJOnMngPXoMWHjfYzp6T6HGDd8vxJ13unkWPjihRM3jUSjMedw+
         /Dl7pVCezEemMXTSJUEPXFzc6mWbi2EAZSRlpB4um+uN42qCh4sWe8/WI5F6QsbyaooQ
         ybWdrBp28zokfV/VcHTnSSdz6tsa0obZ/Dkra6HUd+5MALd6fuAQIE26ZvUkSj2t+h8U
         AIFA==
X-Gm-Message-State: AOAM530gx3CF64irzYI7syEhkVwnGiTqcAyiFfmDULkRTGrQv+0QsZnA
        0EpSPy6ibPUS13DvQ9zuAKwQBQ==
X-Google-Smtp-Source: ABdhPJyDRSHmn5UxUmErGat0/57ZFxC5L9ci7ArlCHRv/tJbZNZfvhedR3Gi6VCxhDo9jYYBYkTxew==
X-Received: by 2002:a92:cc02:: with SMTP id s2mr19015901ilp.101.1618877250050;
        Mon, 19 Apr 2021 17:07:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h7sm7850690ilo.31.2021.04.19.17.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 17:07:29 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/122] 5.11.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210419130530.166331793@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5139e8e8-0b11-bf0f-24fa-a19f669d8283@linuxfoundation.org>
Date:   Mon, 19 Apr 2021 18:07:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210419130530.166331793@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 7:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.16 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Apr 2021 13:05:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
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
