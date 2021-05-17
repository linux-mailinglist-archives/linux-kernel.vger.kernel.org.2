Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80767386B20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhEQUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhEQUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:18:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5DAC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:17:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o21so7095683iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8HyGemKs4eEqxDzXuXCclgZuAut0JyAGM7DAttE2sLk=;
        b=cXZKOGGaJBwezYNaT8zvk2xsF4l76PcEIamrpbiiTEQF3hb3JRd4hRsep61uCSrr6V
         bK8JUfXAyllB2Tth1ueYEs1Jsvj4VRBWdiu4DDK8dFoq7hgxqSkNwaV4JO4WwO0tSzYL
         KRY1qxTRjqBxY1RM9GDJar3IKuhxpc7hrhkFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8HyGemKs4eEqxDzXuXCclgZuAut0JyAGM7DAttE2sLk=;
        b=LiWZM0n4v9psRe8OjekRVHT1akfQn5NaOkrkb1dq9GJSyfsPwYthLWxRNtabMmCJYM
         8Fc2J3poTGvrTYB/37uqsNhR4Y6krPYCOfDAvJDIvEsqAQgcAYz7w71hDN/BqBl+dWXO
         ge5ilAAuVFZoCTBRTi2WShlnafBVSitZWtoWPVKO5oaF3NslDCoBH08LI3jSQncNSdjR
         aoqAkjOXwE9obNVFWuvgVxqyvM1dZJQRfGakWT/WLvsWA3sSehmqrIeXv9xW8Vwm9laJ
         9Pqw4rFMjsOJb7nRTXUcGUOzBYU22nmhc+67/tUVolnO7ny8JW+PXwdJ5MFwzr7m8sUO
         WGvw==
X-Gm-Message-State: AOAM532OoeufPhO6duWrK9libuh3tZqz0niQ7KEj7pdg4SewE+/9H3S6
        xF9ZodlLXWfkSAb4xQRGnr/nOQ==
X-Google-Smtp-Source: ABdhPJywmuYJRSKJPwoHjIN7feuUpshrrR3XsS78qnUwEX7d3uv/hjvpZxYA3vt+g+5lEFcf6ysFHw==
X-Received: by 2002:a05:6638:344e:: with SMTP id q14mr1752477jav.47.1621282645778;
        Mon, 17 May 2021 13:17:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o18sm1839469ilq.9.2021.05.17.13.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 13:17:25 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/329] 5.11.22-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210517140302.043055203@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8a0aa39c-ba14-81e4-cd0f-bfa7b801c59c@linuxfoundation.org>
Date:   Mon, 17 May 2021 14:17:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517140302.043055203@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 7:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.22 release.
> There are 329 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 May 2021 14:02:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
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
