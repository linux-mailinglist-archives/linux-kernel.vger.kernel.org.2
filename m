Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F02334A45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCJV7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCJV65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:58:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:57 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 81so19632475iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ou8t2644clBJEFCW8xgVuPgTcW8tsILaR00wXEKb658=;
        b=T0lqgYv8sRA4rVC80yotgtAVVlztll+UQ43Zoo16CGQXp4HC8IgW+/+MxSE4heVjjr
         q3zEsAEG44nJ9ZdbOJZ/wKwdPHCjViazptKJM8Kx09EpxPDpsJW23LSAXOaoDn2CN+vK
         yIUlLWkzXuH9Qr6K76PZv/QRx7xWlPCeSbdQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ou8t2644clBJEFCW8xgVuPgTcW8tsILaR00wXEKb658=;
        b=YGJXn23NWadmFybICiw8LU+iPABdl6iHGFRxaipN2eu7YgsbM67dc5od4E52cQkhFp
         cOfXhjObQKmg2zCPmfmDBp0eas/fQ89sXQroUxy4kA6Z1LoLwqblRDgyRczPD0pNZ/Be
         Lk3bNc5Z69eXqkNTyiW7Th+9UpG/S1Ypq7pEaySpLVeeQULvY3bAYekJifTskVigki+b
         SiiYQQQ75stca5xTmir04wICZGo/zHw5Z3e28YWPaxNKY6t3QvphdehzFUmsmP1xiGtw
         A5EAIxiESDhJfxctX0EURtKVBFDLwRvzcHgCD6MXrgvcfK5Vc5UzbmeuES7ghiRae1jy
         U0zA==
X-Gm-Message-State: AOAM531F2uwHIfDx92JlFCT9zYKwSxKz492uW+mu6Erm8kguVlLqIRyp
        IsEJ0bbuCcP1uGhVI8Aq8pSwkg==
X-Google-Smtp-Source: ABdhPJxfxh5cM3jQ4efUr+mJ/67fqF77BKs9szq61w4mUtQb1fOMAYvHL1ZxOsXS+ruJKhpgY1s8gg==
X-Received: by 2002:a5d:9e47:: with SMTP id i7mr4026297ioi.104.1615413536364;
        Wed, 10 Mar 2021 13:58:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a14sm292226ilj.39.2021.03.10.13.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 13:58:56 -0800 (PST)
Subject: Re: [PATCH 5.10 00/47] 5.10.23-rc2 review
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210310182834.696191666@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c40e2e70-5907-19d4-c917-9dd835d0747f@linuxfoundation.org>
Date:   Wed, 10 Mar 2021 14:58:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210310182834.696191666@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 11:29 AM, gregkh@linuxfoundation.org wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is the start of the stable review cycle for the 5.10.23 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Mar 2021 18:28:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.23-rc2.gz
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
