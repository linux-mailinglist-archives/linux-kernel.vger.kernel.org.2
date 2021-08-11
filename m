Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2B3E9ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhHKWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhHKWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:22:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:21:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so2513369otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfDybUoZkjjGqd8k6LH06LBo3s0QPbePcL0eLlXyFyM=;
        b=begOlsIv9ct8iYJvgzso9OvpwsHCMi1CqC5Il080u6aT8w0GCoaxto66GXPPXWGRO3
         y1azccZOtVcaQhmjRZwZD6uRZyQAxQQe8LGMTUrFqaZMQxzZFarrlbr1GJG64TifPApn
         BPg+90VRNH/9o96V5F9UMZABUGW/p8rx35i1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfDybUoZkjjGqd8k6LH06LBo3s0QPbePcL0eLlXyFyM=;
        b=lDjmlhUx91ke/KXrN5c6TlKpcdiZpWdeDh00S3hn6AsjK7l7kK1sLZx5crQYokosY1
         z9SWuHiA/5gqBWxz969mBS8VvyjeSvbNrrGl4XTSmxAAagQBeTM5v1vGOBF49G1CKFRo
         CzdKKZ2QziEN/OgNcSlS9H/Ib66jUIUCTGYzhgqDI7r11zqiPiaA/d4bTrlwyhWpj+p1
         VY6ziHoGxliV8mGuGZxRAEQk+8MPnpkYWyz8sgE/EAxp8w++SZSj5+0fzAavUEy4bkgM
         b+njFdr+UiVIzjzpQ8f0L3ZH9Ru5vcdC79bW8Fsu5Uo0HH6zikaVTX4gJzSMe9efi0AR
         Yfug==
X-Gm-Message-State: AOAM531RYrd9FuLVxsMJuk70+avr6AQWqdnAqLBTMUzHjZwV1QCz4yvT
        Gq20mSmW+WFlaSRFnVz66n1Fwg==
X-Google-Smtp-Source: ABdhPJwABhwYgn5L74nZ1C04xrTRcKoDIJqrwwXxXflUpISq1xSU6jsakyriMEK8xvU4j03V68L2kw==
X-Received: by 2002:a9d:5603:: with SMTP id e3mr927990oti.178.1628720517421;
        Wed, 11 Aug 2021 15:21:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l9sm196548otr.34.2021.08.11.15.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:21:57 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/85] 5.4.140-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210810172948.192298392@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dae9ef08-52be-f208-483c-13abd30c6f21@linuxfoundation.org>
Date:   Wed, 11 Aug 2021 16:21:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210810172948.192298392@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.140 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Aug 2021 17:29:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
