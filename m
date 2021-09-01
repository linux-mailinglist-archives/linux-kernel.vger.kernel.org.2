Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2743F3FE4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbhIAVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbhIAVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:25:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:24:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q3so1003682iot.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KVHwA2KixMqiinETiQgUCi6HjG0rN2ckNdMtGKh8sns=;
        b=eT0caCRAy0Ixp1t50we0NEhiyrObsn0s5EUHHgO28+TD9ew18e0L9K8LjD+kCYbr+o
         glmlRJWicKzZiGasqlcSnkMrw36VlSKHiYq1j9fc351PltDgqNdBP5IyKVoBHV8xeLZO
         OE3i8b1QrpqxkUt0l41Lc6MwnOgB89PsMgqUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KVHwA2KixMqiinETiQgUCi6HjG0rN2ckNdMtGKh8sns=;
        b=IADhkPVMSaxoeP7gglHooPeN/4A3GvrEDk5iLpEcSHCN0n2QWnb9+ayyZVwqVPWpxZ
         6P2AMnpc7zr2Tx3fHeup1F1qWgNosBD8VMw842zV5RXdah8i1mR0LtglUVR2wlKXgp5j
         E/msLu0NeD0R+D3RAu/+eqLFwH7wK+zwCxxQFS5vKlmY8RW2Ml3BNypOiTV7SE0ADqTb
         GiLaphxYhm8pR+uZ9+vIKzlLmPx6cADHsVxGPlDZgt04vZDZx+jhBRluVE8e5ROCKrwb
         3JNaUYlVf2JBAl5/K1ArH1swuZMIh95RbYHaCM4qnbZ+9XDrqsGOlP+nxVMOQuQTKRhk
         xPiQ==
X-Gm-Message-State: AOAM532EFszexut7ere5/rSGUMS0KljxGVZ0zYbCvUNzURax5e+fb3O4
        kPZjOCU+wNbkx1gY+mbacYCnEQ==
X-Google-Smtp-Source: ABdhPJxIX9wkiwKn61Us3kB1Iu44/9tNUZQQZ769NE02Qv5xq9eEKntWmZ0f6yD2UEBwzj4LDpljQQ==
X-Received: by 2002:a5e:d60e:: with SMTP id w14mr1307596iom.135.1630531447378;
        Wed, 01 Sep 2021 14:24:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b16sm373287ila.1.2021.09.01.14.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:24:06 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/16] 4.9.282-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210901122248.920548099@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0f925541-fa81-2fb8-ec9d-8aaa33035f3a@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 15:24:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210901122248.920548099@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 6:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.282 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Sep 2021 12:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.282-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
