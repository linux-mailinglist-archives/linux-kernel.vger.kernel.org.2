Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4434A38F6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEYAVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEYAVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:21:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E31C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:20:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o10so25617497ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rc05twnnQU9EMwzWIQJz/mVuYmnVjA7FmlxkXkyQRyo=;
        b=fIX6QB+WLc27QGMbENhYPamcDWEDxb5yQNX/JPjNyOAgfSXjIHdi1OXNwGvVgUdAEH
         Nd6lJ+6/Qm4BvYi+ubt5Xd+1xZmESgUKiReuiuFTirtKEGl3t+3aIIr/Mk9+fVBF2PCs
         LKH1AfhlZNpCqtvVK0hoi7g8Sej3YGLbEUgnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rc05twnnQU9EMwzWIQJz/mVuYmnVjA7FmlxkXkyQRyo=;
        b=s0CLg8HeVeXZbvKrnXX4G1sG5c6SMCAUpIufHwcoqIpk4XbW5CqxjsNr++81s+pa7e
         M3Ssp9Ssk5MEHS/k11GQIkJCZCU2LE5J3AKDznDJhDn4/YxPkgBahFapRZpM+PpE6zfg
         4l0mC4amT/uO165f68z2MCmQEf7NwIkIyZK8JIbhv0Xnz8IjqyH6UeG3GaC0B2kMC1iM
         0sWL7PnME9mPBydvXUqbfywNcoq1baJryZfGrQkz5SM7KJdjLufng7XypFtynVcpuQ8t
         MKgpZRuJqZFJWy6SZdMGX1yaLJPiVk4fqWOYyVK2MDWMAZXaRkz2MtBlJUbeCXlXOYpG
         pDuQ==
X-Gm-Message-State: AOAM531hOHu09Wmynshom0hjqEhiWHlAYYc6csH2YyhgQUPdRALHveHZ
        pjjiSwO7W6vsHyDQGPa8YtXQa6D072pJLw==
X-Google-Smtp-Source: ABdhPJxAXjYoHPz7PYK6HDvue6gWDKd0MYdOAF2uTA2RTke8Jce3RXiztjbPuf3FHU1jdgAK05PnNA==
X-Received: by 2002:a05:6e02:caf:: with SMTP id 15mr17539096ilg.3.1621902008144;
        Mon, 24 May 2021 17:20:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g20sm11755860iox.44.2021.05.24.17.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 17:20:07 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/31] 4.4.270-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210524152322.919918360@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <16a4a520-975f-c9c4-5003-710651374ac8@linuxfoundation.org>
Date:   Mon, 24 May 2021 18:20:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524152322.919918360@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 9:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.270 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 May 2021 15:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.270-rc1.gz
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

