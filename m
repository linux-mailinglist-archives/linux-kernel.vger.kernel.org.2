Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1890D3CF0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhGTAHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhGSXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:50:21 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D987C061793
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:28:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so22773840oiv.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vZ8NjLoSgDSn8ltcT7clHGhNAnF8/t8ejSaR9tzW7M=;
        b=XfAqn13t1F3Pf7Zhcg1U3lCLbkBF03PFNySpddQs1rOzI/m3QlSTFLeFmslLrYvqjY
         bZ5w0nzDS4AV1ukxqy449y5fqxQ5+G8mHfzTuVvW419bE9Op44tWSJxRDbOGudQzhN84
         FFqEP6CmPmLh8F3q4Shy/vKXWHgEzoXpHlrro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vZ8NjLoSgDSn8ltcT7clHGhNAnF8/t8ejSaR9tzW7M=;
        b=GDOKCNBNWUfoDgNIrLV+FJpv5dlJPUAILHcLgXBOg1bjpDeNBnG9QLUadDSKQky1Mv
         QkBzVyo8W/G1eyVjnb6s2Go54Qd1Ny83ybY4feqmsbFwc4S2dgrFcBKgK8lmpazSp+nZ
         LToS0ZmOLXl/ovdlKTLJDcVqqDI3+CwixzFFmxguBn639R1rEMGxMhkOzsE/Ji/RR6Lp
         Wc/mLj8yWouDJ1C8+XJHTBSpeFn2HnVktbiu6Uuh6a6ORcFtnzoAt4CrFayV7juwKfJb
         9KC6asnRH6lnxll21IsNzm39sinb8zZHWJerk4+6J9ETAaMGu3vWJRxENRKUe5HXRekr
         p95A==
X-Gm-Message-State: AOAM533uJR5sCToynklDTXtSQqBH5k+Hogg9SwnsNxNfJ0ZJ10gXz+R/
        MmVwwDxXZa6csWbNL8trPK1Taw==
X-Google-Smtp-Source: ABdhPJxg6JeRkJXocXIvD6d9i2tk7Njxa1NN1LRGQjk4cDBLUs77uR40VEm7W7FLoGgkLPod60QoTQ==
X-Received: by 2002:aca:1206:: with SMTP id 6mr12821195ois.148.1626740898466;
        Mon, 19 Jul 2021 17:28:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m129sm4067704oif.15.2021.07.19.17.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:28:18 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/349] 5.13.4-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719184345.989046417@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6b200fc5-10de-4ef1-e16d-02055d32d573@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:28:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719184345.989046417@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 12:44 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.4 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 18:42:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
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
