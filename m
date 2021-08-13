Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E83EBEAC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhHMXYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhHMXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:24:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0711C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b7so6342052iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyZUcBfWF6PoMIJPooi/V+LA3ogjtAPFsQuwVQ3eycw=;
        b=ZNjl7gib25/EieybKgIlvymWyw37O3a+Mid8w3j0WDoWrGlOikHetLnM/hl/bGJ80N
         prI6426u1zs7R8XjN22I04fzRZLil0rKdf0VgNDfIqPrXypvmxv7frAecnDMVg6TgYI8
         y0mOkApTIxgQLnhctzVumqzo2MmQW7/FUBfVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyZUcBfWF6PoMIJPooi/V+LA3ogjtAPFsQuwVQ3eycw=;
        b=Lj/HR0KGfbk1V0Oh1oyAuMgH4JPWYRQ6VMs/xxKgtxZIm5j4/CoJhCHfvnszBBXmFs
         nX2p7koFEMvkrIe/sed16AF6sME/g9U146Y8wJHWH2uFzHIlIYZ160YK7NVaqYk/siOr
         ZLAEj+eHDqdJ3iYXADTL9jWfisRhhU25AjMfXDBUTR1F8zvmEeA6ISPcenfCF4Gs86st
         yKr1EUfShttcgu2tOpYbLmgoQsGbNoCzClc73HylEM79fM2UrBA8GhUQiuqfaMt5qwXK
         Xl2DJQxAZhkzZp2qT/8gYH0xkSrA5Wur5od/hC8N0Cnhc9Y+95ZI1OMaPwAvWG5ljWWy
         9a+Q==
X-Gm-Message-State: AOAM5339rvQSoSq91PtAS3M96CDrNPujMNcMs+RsmrZoU6JukWvhcGLr
        F5AinCVT1+W6lOApICEmK+Hlag==
X-Google-Smtp-Source: ABdhPJy+gqaOPCSgMA49GF61FKKQRRfZp8Otd+QiSk5/VSUE0PpFIBjbnMPZoMKbVwBXPMxj5ducQg==
X-Received: by 2002:a5e:da04:: with SMTP id x4mr3785578ioj.199.1628897059341;
        Fri, 13 Aug 2021 16:24:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm1538956ilh.60.2021.08.13.16.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:24:19 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/19] 5.10.59-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813150522.623322501@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de13f7e5-0be6-208f-cbf5-780ba3396956@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 17:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813150522.623322501@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 9:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.59 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.59-rc1.gz
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
