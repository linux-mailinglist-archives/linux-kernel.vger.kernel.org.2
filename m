Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B344539A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhKPTAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbhKPTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:00:32 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC873C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:57:34 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so3285689iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wkicvFroc/CWZ3IT5Ry/Wv+1FLXS/fbYciW3fKfQfi8=;
        b=d42YWLd4LMaVbHNejciKU9PEgE5eqWj0YPtCAYUzmTvJG4cR640tEkLCeZdbXdWOlZ
         WUZyrrevrksZ6ycnHIg+P27mmGkAOxDRpfbmYex9YH+ETxbnlk8m4uS2UG6m6efrbtYe
         NVY2Cvy9HhbVU89LrNtDLRaE8AkjyCRY4HTXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wkicvFroc/CWZ3IT5Ry/Wv+1FLXS/fbYciW3fKfQfi8=;
        b=YZBzFviSXGpRYcIvXnm7DA5nNDwtmEVEu+4cZ4OQD1Up1FbBacouXqwLyf7iDpqxZw
         dIBXIcteH730ouCnjeT+exw7md7cXS5fM3oyf48lLtLHKG90NE72kLomRy7JUVc+YTfK
         x5i3YjJLmGbTf9RZ3GjrATFgZoVvNag2n1yA7TbI+TkaDqlrtUVpt9yyLoNsobNM/9mq
         2Wh0JCDnBA/PVKPmXrrhj3jjo4a+hOaQJvNDgqjZ11efvVJfBwRYuxqzMkloG7f7OYoQ
         ZxNs4ERTO/m2pBhoi6Vc+sE4Yvk8U4gIT8USW9g9cM+Tpusv88ID/JhdmJZYdK41eS/c
         4N2g==
X-Gm-Message-State: AOAM5308ZF1SYI9fAjZhWibqWZ6mjgK/TWDW917x6WRBZ4bu3BxusuAk
        /chF7Eg9SOJpaZNNKefchpUUZQ==
X-Google-Smtp-Source: ABdhPJweYnC3apWIUEzjXyZ5UI8+8xf7FK0BvAy6OSZsN26cuBNG5YPKg44BfWTuYH3IPWovlns2vQ==
X-Received: by 2002:a5d:9d9b:: with SMTP id ay27mr6495896iob.133.1637089054140;
        Tue, 16 Nov 2021 10:57:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u4sm12888097ilv.81.2021.11.16.10.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 10:57:33 -0800 (PST)
Subject: Re: [PATCH 5.14 000/857] 5.14.19-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211116142622.081299270@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <861eb040-df42-ff44-77d2-e1dfc704f2b0@linuxfoundation.org>
Date:   Tue, 16 Nov 2021 11:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211116142622.081299270@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 8:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.19 release.
> There are 857 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Nov 2021 14:24:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.19-rc2.gz
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
