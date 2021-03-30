Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5371A34DD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhC3B2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhC3B2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:28:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F1DC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:28:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id t14so12829464ilu.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4fT9GDDnemAhHBqdK9yrAIrxFWXoWZ0aF4SGoPq204=;
        b=ZOUH7LtBeLP94znfKH2DHVk6PLBiGAM0aI/fkeBHkjvPme7bcehISmJ20IxDhuONPV
         xD2DYmxaG8/1ImDsrC29712MyFaWHV+ufXVIZfdXbOo4UZTD1pav86I6+QDYG0xwPq9T
         qPP+boxxQE+ek8qFbrzJMcQs9j1lADMqqV9ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4fT9GDDnemAhHBqdK9yrAIrxFWXoWZ0aF4SGoPq204=;
        b=gL4ofxjyMv3YNKMe0TjnmiHpySDIHlViXoIUhPbgW1EvNK0jnqoOP+BFOhQMazd+xc
         GbwSTj93NrWB5+nC4swPCbzeLOLwheg8S2m7eLW88pCj+x29EEjuglgf4XRixd3dGYwL
         gahGN9KehhrSMYID8exm1ysHpSsxsUcZz4wR227lU5/WU0U7Zrm79Dj3AvcxMzwwzjmQ
         oShVCZPUZmRvxCO+nhy6Xp2g/CKEvV/Z+Fv8Bv8u2512C81N4xkq9HdS1tPa9c3tCLHZ
         eAZIa8H6ExhSRqCaCU+SWyXPUts/LsmdxjK+4+uvVPQULqQwAgMLz2HvZ36VaK0Tpjvt
         6rug==
X-Gm-Message-State: AOAM533ZHT462Ko1gYIPnnfELwZSveusfXchJEkjyS8mIf33RefmnYJY
        XriGsQ0JTZZfImG8liHYqXjecw==
X-Google-Smtp-Source: ABdhPJwCMjSRvbi6xRWgTWRXMiy0E3QL3DIxWkXOJxJQJQmIgXfcTCgyAUjZ/pxXePHCtLzBrS2b+A==
X-Received: by 2002:a92:4b08:: with SMTP id m8mr20439823ilg.140.1617067700451;
        Mon, 29 Mar 2021 18:28:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l6sm10413952iln.45.2021.03.29.18.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 18:28:20 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/33] 4.4.264-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210329075605.290845195@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e5edeb4-bea1-e4ce-3b2d-da0f000462e1@linuxfoundation.org>
Date:   Mon, 29 Mar 2021 19:28:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329075605.290845195@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 1:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.264 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Mar 2021 07:55:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.264-rc1.gz
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
