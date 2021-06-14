Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9B3A6EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhFNT0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhFNT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:26:19 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:24:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so11920009oth.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GFM5CYTBc+j6NmnUaMqGZ4lOqRVHgsm/gOrMdNOdLU=;
        b=ij0CCxGhQ9p1nVufwFtIpCNhYMKYZf9TQw6E91/aO4VY11oQ/1QBEO889dDR9tdN0x
         EaM7OfmGQKKFqNmg7KepCGZYhC+vETtb2lMo2ep0y0VBIdMN2m47p7cdxMV207XRZZVf
         Rv6ZVOD9brZYNJxGKLLjFd9uBd64YmD0fKPSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GFM5CYTBc+j6NmnUaMqGZ4lOqRVHgsm/gOrMdNOdLU=;
        b=X7BSvRXNMl12XIaNgKomm3k9qEeC0qvU8YsZig2yayFUh50nHIhn3jJwLYJ+U4GfiH
         tIOTut+y6OB2VM77zbmw3ax3DJXKVOH3w/Eo7ospL/bGiDLwrmqIP+HGAzoZF6L7UjKp
         Kc1FXnKT9gp+ItFPoRDTt/G0YKqBeDrd2AgECbVxNhAI3FoH/IFM46GrbH9sk/mZhfRu
         RPUfiUa0DWGMltC9N/8GjWOFOMuxVSsLkMTpNbB+B9bxQXdCY5/oo0Npc3CY0aGH5vCi
         EUk9gmFc6RWFshfwvIGMRUqinNoj2c2mfxPiLj4J4JZtuZyidB/d/VR1YkRhN3FRv/v3
         9Jyg==
X-Gm-Message-State: AOAM532x/WMjoR1GWtCwNsq0V0cTKk2UNqXCh34MfRL4UIEyrC0Wbh4z
        2Apu+SvSbt7o5PmawIhUKWLMFQ==
X-Google-Smtp-Source: ABdhPJwuyXSWlWOdwA8rWoZZUB6YFHNzKhjT5P9C8v6MoQyKU/XVssPrYRe7lzCGGyQe9o2yj9qIeA==
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr14921028otq.321.1623698655620;
        Mon, 14 Jun 2021 12:24:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t21sm3464416otd.35.2021.06.14.12.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 12:24:15 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/34] 4.4.273-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210614102641.582612289@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dfe00795-556a-2b6d-e752-ab081eaf3492@linuxfoundation.org>
Date:   Mon, 14 Jun 2021 13:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614102641.582612289@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.273 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Jun 2021 10:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.273-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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

