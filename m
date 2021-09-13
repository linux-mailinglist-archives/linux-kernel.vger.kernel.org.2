Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D01409DED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbhIMUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhIMUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:09:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D5EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:08:05 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i13so11440031ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFNaJHQd7ucmOFeh4z1EzSjSBaD8pbTDNp0Gcn8+tks=;
        b=Dc/UY0z3rZUcF8AkAMmrTpBXyDBAbxa/TYXFW+SKnEqftpn9j6uo6j16XKnPb/krXs
         tAfgjZdeQzFN1YkFCg0263HHBZFvhPiX9JxxOw5+8JX2pXS1oD+NDO9JiZOMH+rT1AFv
         0PY3A4nsQsWgi78i5gYS94xu5t2rHjHRw/fGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFNaJHQd7ucmOFeh4z1EzSjSBaD8pbTDNp0Gcn8+tks=;
        b=ZAVqEvUAgM7BT0mqgKYot4LP55Z7GxtDJB+k2/gxB4GUoCmj1MOod7ou3q9A5xvp/a
         D7Hf996V/K0SMTRtV8KcTp2tX9hqoG9FzZ7stF0uB73oX6iX41orSwTofczep7yNsR5Y
         Lg/jzJac5fuS0UX4djxkUdoJmQIbJ/7tSxM9cB5gANoxQcv4tSFvo0V/QH+Ze6YSEsD6
         VIIr2rdmjRwmQxy1qmKOYiNt5Nkyih8lRjaCW81ugC2V3fGwYdqKnW5gA2MADQgENtXR
         jcAv7kbv0+uSoPi+kae9BHLBkv5ZHY4Gotx7lTwLYMJf/NXqYwh+0nJkRDqzICijA7Mz
         E6dw==
X-Gm-Message-State: AOAM5327JQRzvbOYnVp2tfST81JkKevQ7XKTBF8C8lEqCbZ184pe9NvZ
        TVoYOw94Gy4cmJ5Tqg/wC4Gjpw==
X-Google-Smtp-Source: ABdhPJywfY/f5S5FCa3BLwFDS/by0QdPIXSpfJV2c9oj0GlYRjjljJzFR7g9Z2pDXZiPCI6PPFXNsw==
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr9547637ila.30.1631563685070;
        Mon, 13 Sep 2021 13:08:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s7sm5209960ioc.42.2021.09.13.13.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:08:04 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/144] 5.4.146-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210913131047.974309396@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db85998f-a0b8-ff06-6c04-ace510d733f4@linuxfoundation.org>
Date:   Mon, 13 Sep 2021 14:08:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210913131047.974309396@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 7:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.146 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Sep 2021 13:10:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.146-rc1.gz
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

