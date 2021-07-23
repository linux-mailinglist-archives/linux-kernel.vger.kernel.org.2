Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A533D3CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhGWPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhGWPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:14:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD426C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:55:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q6so2274399oiw.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLcJ6bn51jThAKxoDCYpx6oLwVsRRf9KRCMxlyUDhR8=;
        b=GXN00ktEiOJgI3bJLby0Yxh/oRfelw7Q81ujxHwhEa/ls4Ts2F1nApgVX0xn+FAfGB
         Pd2BG2Va95BaS53tH5nmy6nQkQgn2TvPUotk+QZ9TDe5kqXfU7V+T6P3Ch//xIoBdYwC
         2kCXeKluZn1jJiDP8DTPV0JjFHqwSphnDcAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLcJ6bn51jThAKxoDCYpx6oLwVsRRf9KRCMxlyUDhR8=;
        b=AxGOu8I/Rohvd4p70CwSBO90khOFMMDb2kXUhNz2cZxlwcSYwzou2VsIbN7EYzBFB4
         nHyIaRgGGuIMD8iPlR+6/wCdklkExY3DRYeQ4xlyFlVjOh97IamctJ0KFtXpCyMWkxAG
         Oci/5tFAAdQfwZT9ZyOz71hfxHo/rO1cyqI0yb5beX4datzeHKrMXhUmPiwlbX3KEZP4
         N0fULWQUa6dNiYT9D6StGfvlcuBKXFlhNcMUGuU1c7mzObeI32TvkKlDPVVlwMsPXDLB
         Fis7s6Il+Tw/mn9Y4UgfZa8F+ePtwmeLl9cpOWYkguDGcx/iSJVyy8dBcCj6E4pAXUCX
         Eo9g==
X-Gm-Message-State: AOAM5313vkiT78l+TFyE2AxZ1hcSE6LCgKZzSKkt3k74+JyPmA3v/d//
        lDPPozwYF5YxN7qpZHV6xcZqMA==
X-Google-Smtp-Source: ABdhPJy0zDwrJFmO2vPtNQKVtWxqRxeW95vdcE5f/LO8c8ZcKR3VynznebvfrnIM4juBTlB3FutBCw==
X-Received: by 2002:a54:4690:: with SMTP id k16mr3467119oic.49.1627055705788;
        Fri, 23 Jul 2021 08:55:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k7sm5401284otn.60.2021.07.23.08.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 08:55:05 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/123] 5.10.53-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210722184939.163840701@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <03289731-3f8c-afe8-a351-0241516b687e@linuxfoundation.org>
Date:   Fri, 23 Jul 2021 09:55:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210722184939.163840701@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/21 12:50 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.53 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 24 Jul 2021 18:49:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.53-rc2.gz
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

