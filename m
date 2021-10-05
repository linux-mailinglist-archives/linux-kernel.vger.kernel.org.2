Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A65422FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJESYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhJESY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:24:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB8C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:22:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 134so8246iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zGr1lvewn2dwwmC+6Cawi0eIfDv5t7HI2kW4tXuA51I=;
        b=Zl2GGBWFngpvktw9x9VIv+5Nq+KRCe6f6rg1uMNYpb6AjPZj6FB4qk++NtPc5OOIQg
         o7Dd6sSxswLdo1XgeWg2OSxv0KMJuWbxpToc25q8WQ/pz6DDbzczU6f/lMwxPzGBbtS4
         A8Q+pFHBuTTExk7RGrklAevS9xZS4aigrcXr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGr1lvewn2dwwmC+6Cawi0eIfDv5t7HI2kW4tXuA51I=;
        b=27+DIYMnpOQjGTBD0H3xXQ0L0aU/w+OOTDQtYNRmFKUQF8P9B0UxBC+HhlPsup0k8p
         +4bxiYkuA6qgt5KiwGjlZWH2U01Im7MVjsIQtjNb/CftdM1zGpA5SAw2OA7SANGuMpIe
         QJF735cePigXsM0/PzDAdZiErMdFemPTL9ZEnr4LFCnDuR/yi1/v4OCEEV6yTBhys79H
         r6zhAu1SI6C4x1yPeDdOqhmvyasyERBoxN11LmBpxXv+oDaIzrCpMyS0AZ2eXmnza6XG
         JV4C40umJ17MLrQuOayjd6WXT113pgtN1nizH1nX5o/IVh6CWEFwglQh9wFwuFDlO3jZ
         DxdA==
X-Gm-Message-State: AOAM532/ZDW5yagIjsr+e9Rmw7mVlsu8w+wh/YBJbC4ODTNKrbvOhYEc
        aBlX5tJrsPdTZ+Ac0VhwpCq4XA==
X-Google-Smtp-Source: ABdhPJwQxvpJ95sDQsG6MORuhxY2i9pwkdDfswsqnMxINDr+V9V/qseyfZzDMFPtMHgGBem7h26UhQ==
X-Received: by 2002:a02:2b08:: with SMTP id h8mr3962827jaa.137.1633458157549;
        Tue, 05 Oct 2021 11:22:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r19sm11243160iot.0.2021.10.05.11.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:22:35 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/53] 5.4.151-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005083256.183739807@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1ff2a74b-d664-0a42-1737-9d7ba7bf21df@linuxfoundation.org>
Date:   Tue, 5 Oct 2021 12:22:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211005083256.183739807@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 2:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.151 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.151-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

