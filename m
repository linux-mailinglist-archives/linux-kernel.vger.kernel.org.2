Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81035D4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhDMBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhDMBdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:33:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A8C061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:33:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v123so8596325ioe.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zSwk+CCEogc630LEHl5RvzQDUBmzTV2qxrYb9cB3Hk=;
        b=B24q9wJST01FRsZsarkzCP1lwZwRPEPqExf6Hu+l/Kd+8WaisnQaG2zYdisMujlv6p
         iEBaVOeXwEFVP1jH7Rg21zTxYBAQmOie3LIGcikrH3h5CbA4X2ZraHhvETVDtiEs+oTz
         05OaRttzVMbn9jULtSrdCOCB1AHayAtbKOGrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zSwk+CCEogc630LEHl5RvzQDUBmzTV2qxrYb9cB3Hk=;
        b=piAnj2Q0/9s7v5KCB4VhdReOHx2ERkISoOgCex3WYhWdWdF8SJK8INpLEftx3/yIFJ
         4JZE/ipbt6D8+HInQJG+JIuiyHMLIhGHqnwLeC3GWty9UqWfkBMHIL4Wf5QaK1EQpsmk
         jLMYglKHdEh3qFGUarSDlu7s4W7XPhJUJUDYn0e8PuCfQvmqRLm8rB5aDjgpD8qvB7+T
         PfaUqdpjGeq695wQvxHY2qM4ubXMWU9PVh4RiEyweg42OtI1gDohmZsb2V663otZwKHh
         lZISD8kAaZkIruDkOzFLCgXvS2giOkHT71LtjBxi6ONTFzQuS2j8xKPxDPWsSIL39+4d
         BC0A==
X-Gm-Message-State: AOAM532oiUYDJOwQ6/tPcMoQJq19aK19cDij6M+1VIUMwNQJSownbM3R
        89JtaVUtC2H64YK1zNQy4DeTZA==
X-Google-Smtp-Source: ABdhPJyTolXxo/bbblE34HUnjb7BH2KP2F7vK26sDVYh2nVRsnaWeDarYtarehVPQTIQI1b3deRutg==
X-Received: by 2002:a02:272d:: with SMTP id g45mr31833069jaa.117.1618277610753;
        Mon, 12 Apr 2021 18:33:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z12sm6369144ilb.18.2021.04.12.18.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:33:30 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/210] 5.11.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210412084016.009884719@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bd74f887-f858-e69e-86e1-6104cf95a4ca@linuxfoundation.org>
Date:   Mon, 12 Apr 2021 19:33:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412084016.009884719@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 2:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.14 release.
> There are 210 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Apr 2021 08:39:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.14-rc1.gz
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
