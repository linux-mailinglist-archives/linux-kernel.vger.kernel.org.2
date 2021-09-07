Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60EF402F69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbhIGUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhIGUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:08:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0ACC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:07:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g9so81216ioq.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5iHx13QiJ9FmYs9Km/Jd+rwidFqCEp0Wg4GaD8IYr1Q=;
        b=BUrR2RYiBH4EYSIU1Gy1/LgpE17M1MdA3xpKlkESoPYK7tnyW/ZDZ83uvlbHBvh5tj
         228/J+Ta7SZwsTc4NXpRvkFpsBv3zLlbiIbj7vMevM+sWdOLiHBPovpZMqGs1qUYVbJ/
         0W3BcQ91ynfcVGl9MJGKQd4r7ZucfcUhsp2a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iHx13QiJ9FmYs9Km/Jd+rwidFqCEp0Wg4GaD8IYr1Q=;
        b=SfhwhPiC0oPQg0MP6HiEkAnSXVKQrCXy7WIIB9q4jy+d/xg7jUk1wELAXSaIrGgNdn
         BODs98U6leO2JZUtAHfbFf3t6iM/mSjokewSGYCTHzQtcRVnWuFcufdNy785P+HoWe6f
         v8F19O+qhly3MiHUBG3b9s4UaUiOqqsE7UEwGftG+wGaGlV9+NSE5WTz0Q89tAa6nkO0
         wIJxS5ff2i1m2R2/Rpva7RuEvb8sjkOrNjrlpDIih3RVysOYwzoh78m3nt87kzsXwyeR
         s3rplRY9nUTcFdJeSGN2rAFPJdNAkAjiEXV1ul8K3P+7ro/muoO7iaLhbyvzlN6n4hbp
         FOSQ==
X-Gm-Message-State: AOAM532a1DUIrH9cTXzMDcr+LX6aFSlSCSrBjFm2MFy8a75i1f8hHz/t
        eEziiKCqoIeIbeT65W7amJGv5A==
X-Google-Smtp-Source: ABdhPJylUA2Vxs76U7jRVgrmB+og7YtoF8ojFZCEfuvH/O826WYjijBxrY8CJYRFg507rNE2/YofPg==
X-Received: by 2002:a02:7710:: with SMTP id g16mr75515jac.148.1631045250191;
        Tue, 07 Sep 2021 13:07:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b19sm41660ile.88.2021.09.07.13.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:07:29 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/29] 5.10.63-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210906125449.756437409@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b28f973d-a5d0-7771-bff8-9de130122062@linuxfoundation.org>
Date:   Tue, 7 Sep 2021 14:07:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210906125449.756437409@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 6:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.63 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Sep 2021 12:54:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.63-rc1.gz
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
