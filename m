Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF57417D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhIXVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245112AbhIXVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:54:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF0C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:52:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x2so12016634ilm.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6ArZpTsrLDrh6XO37lt5RplIOb7A0rU8JiEj3EUCmg=;
        b=Ch2+LOSQabF5NgyjGxM95FloZO+LZaEuDwO4esyC4NyKS4TG+s72p/LVYsZj1umqjm
         YO0M+JCw+5cNlYit6V7kfzZC3piHuxXZPj7rlQMuBApmI2Z+efCjJCTl4YGG9NxzRUKd
         m8oxotiOrAw5O8ICHjQniQpSjoq9Aab089nqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6ArZpTsrLDrh6XO37lt5RplIOb7A0rU8JiEj3EUCmg=;
        b=qdvOk9SKdNXKYVxZ51ofUV8+esmnGyskb1E9kdn8OITvKG8hTdEFFAf8azSjtOMo+f
         F2MQpdSetEcQ0ZdBYpRnX061rl1aZ8tgAPgjVatO1p1qy1GckaU/GvDKOXXSULkHTd9r
         rK56pKWm2J6b4I81JcJqZpes7i3XzxTKbddORHhGXcTQYyE2EPtSthwLuMIh+LN6urXk
         dhKUEgSeiJlLT4sc2e9qHmCYNvdXtw2qAAhi6iy6eXAxFspbQFgTXlmfqRXIn5rUnYN1
         MWN84cS77IpuglEwQK5rr8J2gplb+S2kwX3tx96bNljIM88ukYHHic+CA0qFrfY6DySZ
         Sj+g==
X-Gm-Message-State: AOAM531XxuN9QqL4Ukq7K+xZJ5KCSI4IXKAiniI7dEN/p7YPKJaxefvc
        o8zHc3N7Pi4oeE6WC/gfyH5obg==
X-Google-Smtp-Source: ABdhPJxZQhFlsVBQJX9/vqWOlqaurr1wS7Sr9FcbqhB5bJKKG30PmoJsdSxf4cMAb0mp61dDtRFYYA==
X-Received: by 2002:a05:6e02:1ba4:: with SMTP id n4mr9745301ili.225.1632520365336;
        Fri, 24 Sep 2021 14:52:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j14sm1566177ilu.74.2021.09.24.14.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:52:44 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/63] 5.10.69-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210924124334.228235870@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9805653a-f44e-116c-24da-f344c58d5cb5@linuxfoundation.org>
Date:   Fri, 24 Sep 2021 15:52:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210924124334.228235870@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 6:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.69 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Sep 2021 12:43:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.69-rc1.gz
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
