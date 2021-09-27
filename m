Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1560841A374
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhI0W74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbhI0W7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:59:54 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C20C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:58:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s20so24896847ioa.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvsvAi/jhPABlYynYFZG6hTxrqcvhKe59dyAuq5vYKc=;
        b=ZFimGlDzTM9pp2sZW9Z4ytVISi99HaPEYdDbPEbkDmP9fGYn9lYhjI8ReTbK5bq0HR
         62jd7e/NhEBjhA+B52F2YmIz5ZqFzuwficRrjXFoacFFPTWUh3Ae7lrfMr/7Pc1PVjP1
         Mq19kLn+051Q1IY56FwWMNSGCXfoJrJ+k5iRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvsvAi/jhPABlYynYFZG6hTxrqcvhKe59dyAuq5vYKc=;
        b=sVpna3Ld95TbOtrdir+5W8WWWAWKv0WTcPd3Tdw31j3Zv2wBck9t+CcVXbWeUjzDju
         PmthncaCIRaUGrwh9uxkjALDzFlkXg9wHfMKgk9y+s+mByBEDClLdMMocAFesbo7wtRO
         nPqh+zANYJ4uJGfJ3GkHZppqr4MkCh1MRFPC30Rd5aR7R2ARCeXUidAOvvYPr8DnpnCI
         OVZijmJXprkRbkworhhxm3GTRx5mJxFepiFa11UP6/fJ+4G0/lP8MoU1bnxLY/9GFldp
         BSUBfJrF8UAVmvlk1DhdEnHRB3Uk8pC6hUoH/y2ZsjC+v5fGASohhaMyLBTD99RrG/jt
         G7Fg==
X-Gm-Message-State: AOAM532MDTnDb3WDO2xWA5sXPudw8cEB03pgobDKJQ3hwHGej911LWgj
        PoC5af8YOGivIP3PTwQdVSjtLA==
X-Google-Smtp-Source: ABdhPJwDAshJAtoPM812J4z4qTQKT6ohczyCXgEyxo+erXGoB7G7dX64hGCHuUVHyXbOYSI+LLo0cQ==
X-Received: by 2002:a02:a38f:: with SMTP id y15mr1960097jak.26.1632783495699;
        Mon, 27 Sep 2021 15:58:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d12sm626185ila.79.2021.09.27.15.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:58:15 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/162] 5.14.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210927170233.453060397@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0722f2b8-61ef-09c0-280b-572aa9267497@linuxfoundation.org>
Date:   Mon, 27 Sep 2021 16:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210927170233.453060397@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Sep 2021 17:02:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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
