Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82B44DA42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhKKQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhKKQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:23:21 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63204C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:20:32 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m9so7674603iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0W6G1UOKLiVk/uulG3jqtzFnzz9ZwgwPEbQZHyhcfg=;
        b=QReSc04RD00zcTqdyAeWunQZQRfWnzJkUL762nQwBnDomBSzNH6vpQs35Ilua0kmmp
         9vNJH1ugDashDZ44QsBIBAEZGTjG2QELjkWzhnh3GLPLVRhq2RR4U63VT48Bt3j51HcY
         8H4uBq6xKQ4KaB7TS1zLTX8CoqwT6uY1rFo8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0W6G1UOKLiVk/uulG3jqtzFnzz9ZwgwPEbQZHyhcfg=;
        b=WEbT37C0Acy8bNJfFqlWCiiEaPCARDsOdAH8+3uXKJih3Qc1CXvFFgJq8S/puCThlN
         EfmDniAKMkfVM6LnEX61W/1ZJiUohY1A4GGVxV65/+Rf1iCFmUnLmcWqK6xEkDO/cmuh
         t4IQrqkGz3rVjEjF5GQznbb9Fm1NILBAVbWHo7Gl01VM7gINoP3/WsFK3zRNPKM4DRtI
         vW9GzDPQqaYv1+6RNoIisSQkdb8hIjjoTRsVFE+T8vFziNJ4hck5zNz4Xf0gc5TuH/08
         wxa3X7sa9AE01EDESgwmTZAezQ5c8eqqixJ+JDHCtM6w3dExhKn6L6nPxS9Y4r4LetyX
         XLPQ==
X-Gm-Message-State: AOAM530FzJif+Y7QaJ2nRN9X7NE2F/ZHhEZ6LP86gvxPq5hsSxO9KFt9
        TwI5uywTS+LfXWHuXWB07Ahamw==
X-Google-Smtp-Source: ABdhPJwm8KY930iocnfzXrIO6dNfqxVfdG7CQRARwIF1LCsptS+/NB4tMtOpzUyQPF2o+q1iw2Ix+w==
X-Received: by 2002:a02:9609:: with SMTP id c9mr6406487jai.118.1636647631747;
        Thu, 11 Nov 2021 08:20:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g11sm2297295ile.30.2021.11.11.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 08:20:31 -0800 (PST)
Subject: Re: [PATCH 5.10 00/21] 5.10.79-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211110182002.964190708@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aaa666ca-0b1f-9576-015a-7501aa4ff1d0@linuxfoundation.org>
Date:   Thu, 11 Nov 2021 09:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211110182002.964190708@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 11:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.79 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Nov 2021 18:19:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system.

dmesg regressions. It took a very long time in trying to start
Journal services and finally timed out. Pervious boot was on
5.14.18-rc1 both boot and shutdown were clean.

> systemd[1]: systemd-journald.service: Failed with result 'timeout'.
> systemd[1]: Failed to start Journal Service.
> systemd[1]: systemd-journald.service: Consumed 3min 490ms CPU time.
> systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 6.
> systemd[1]: Stopped Journal Service.
> systemd[1]: systemd-journald.service: Consumed 3min 490ms CPU time.
> systemd[1]: Starting Journal Service...
> systemd-journald[913]: File /run/log/journal/351d6659a0b4490baeff8ad3c4704a35/system.journal corrupted or uncleanly shut down, renaming and replacing.
> systemd[1]: Started Journal Service.


Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
