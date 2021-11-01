Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046A44228D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhKAVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhKAVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:25:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D9C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:22:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q127so22198377iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nGW8nl21iI5LDzOTUwXlXYNhT6V+ZOAoH43lRn2DH9I=;
        b=DyEW1hB1z+iWsJGw5oP6yG70uEMcyZNuiNAKTfa32NL/1r8R1dvFJS8OSZzsg3QKWk
         DwrHxNPE2ey7Pi/xV3pzHDyrZT3gEU+9F8k989CHvPA8P6P/5xa980dY0wK8FaxcCEsB
         QB2B/CKrSxtkkG2MjWeWlL+CfLFFpTqRIAUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nGW8nl21iI5LDzOTUwXlXYNhT6V+ZOAoH43lRn2DH9I=;
        b=ii5+H8kmSlW5LR89dvTGLYTp54BOjPzYHJGynksLnKlRWrURI0qUD7QA3Cqyh2OVid
         HiTxPSnBnaP/a8ps1ranWjg447kWZogwPTxF3M00F37ErT8KAh6h6X6wA7NpXadFu9fx
         Wz0prjQDKcdFxyYiEUNDHUtZd6MphmJAN8UO2kmPGyMqQ5m1JQK2EWNt5GKtFCt9Qb+T
         03CsM7OW/pgfp/qklBrsIQ1GjUCWIrvMRsjzIL2+lNsNW7OrGleP2shQHehgHoRnQ4mD
         kjZutB9wnyv3thULdSdxKM6nmSCa/Q4qH8CG5AZVTE8bxtT8z2slwQqaSQhVk8OZyqgE
         Jtng==
X-Gm-Message-State: AOAM5325hSEzq9nfUMR3nSECKxRy3EqS+uLHBJMlusHolBopmjyFxbyl
        kHa2ddun9m2HJFsi8WMGoyfpSg==
X-Google-Smtp-Source: ABdhPJzy9VMCNLIr3nrcUAhhUxmL3DXGH2CL6HSc/3ZRakAeySDy95CmOd8xM2ewlMNj1fXYdXClaQ==
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr23265827ior.152.1635801748779;
        Mon, 01 Nov 2021 14:22:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm9257535ilv.67.2021.11.01.14.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:22:28 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/35] 4.19.215-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211101114224.924071362@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <432420a0-ef1d-0363-5717-d7a744d2846f@linuxfoundation.org>
Date:   Mon, 1 Nov 2021 15:22:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211101114224.924071362@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 5:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.215 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Nov 2021 11:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.215-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
