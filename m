Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D60329FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574938AbhCBDvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbhCAVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:46:36 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE6C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:45:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n14so19485249iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=foYQv/l8h3Pxdd58QVRj6n8oxvA/TYgNyXI2JEnMceE=;
        b=ZSl2EXLNv882UZ4Gv8lMv0HNKO6yIIdRSbz+jp7xJnw/hbe40jPXbpI2S9s5uBdG1B
         MLX49BQtyNn4TlMN8rwb4LYK9nWMyn3zMQf0EHZwbcID8jkak4VFwIlgz5s3lHaHRRXe
         480JK1fxh2tCsqgL2a1+WdbzuBnbrL8oYj3GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=foYQv/l8h3Pxdd58QVRj6n8oxvA/TYgNyXI2JEnMceE=;
        b=e9vVz0SXnEn3x3iHJvXtIYStTww87smzk0xKMsJpf+telnJAW0jqULZ/nLHatG70qV
         KbSqI4IlFID/IDjuVHSWh/uvtnRtDEMPG+gtIPXVOPgeeEfsrdP2T9Hv50iwF+mzfIov
         wt4yj58E9ukfYy4kd6Qr1ovJ67CiE/OfGnMiPrP0rdUoQUceeDvYNl9kVZgvMeQK7hNZ
         JMWl1LmbKeUXFiBG1oNmGCu0f8XNPHkiG+0Rpqbat9T46e36vZjoLe6NnTCqdq3ZX9Rg
         NMRLXU7Dqy6DBd332MK/VAycZaU1Zzr8oaOe33OfpyR64dHQ6cpOOTfvWRDR1rnV3bqq
         GrEA==
X-Gm-Message-State: AOAM531w7AgyBP4eLi1PBuMXIdWb0bx//lliRzAED07sPN/Ta6tOxLql
        dk1JVhvuElDUF/XbeS3DIPbxFg==
X-Google-Smtp-Source: ABdhPJy2WaFcZIcnys0b64fiUzWD5ZMjcVRM/PieSLz5M6RG5ZQZpP/UzXJGiGNcGt+dC9/fLTtaPA==
X-Received: by 2002:a05:6602:2486:: with SMTP id g6mr15329461ioe.134.1614635155825;
        Mon, 01 Mar 2021 13:45:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k23sm10778531ior.12.2021.03.01.13.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:45:55 -0800 (PST)
Subject: Re: [PATCH 4.4 00/93] 4.4.259-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210301161006.881950696@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c3cef57-e9ba-40fe-f002-d74bcb07984f@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 14:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301161006.881950696@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 9:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.259 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Mar 2021 16:09:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.259-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
