Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A136334A51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhCJWAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhCJWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:00:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:09 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id g27so19683506iox.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dm/C6XQ32zAZrLyNDRsfaU+O/spR8lL3llpiTvdmEm4=;
        b=Rei+kDchY650JNAD/uHdfIUeifbLHjwrLn/0oN9rum0G3Cf1/L9zRHMPIMpvOgSUOB
         S8PGoPeTvEF/YXTDuihv7R/BU8vimxyMnlJjM17qo7Zi/UG9TvMT2AmONvTmtzjkv5Iz
         cOpsOLzAl++tmycjLijeIdVoO0jN5RE6rfsOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dm/C6XQ32zAZrLyNDRsfaU+O/spR8lL3llpiTvdmEm4=;
        b=lkFu4PC4WG0nWgmpmXWpAbb7WLEqDM5PhIKzjn8FEPv0d76GarcEmt7Ikiz/XzGMrA
         VzLgLZXw9dOvddmWnWQwIj2ZyqSJjXoFEP5X/AEAFh+grwjvMopQXyVWsKENmNCZPhpr
         PE3YIZ3A+69g8uEweIypBNyps/HHBm1ZE15WjUt990VzWTY8bAwhSFY7e2w9YFy6itew
         gwVem3pfyY/52Q6XKi1j5kjH5F0mes92Wm8Glqc3U/8/MzQdVgtbVbse0r1XvRIMeWcP
         zllK8SAgiPxHT+vHErR8uL6vzYf/al/NC3z5wcNSJ94AGfeCC/w7YEcNrbqRHildIFD5
         kqOQ==
X-Gm-Message-State: AOAM530AxhrASJ5Si8ysGjOZz3twrbpSLkciNcWnrXHNPvuZ1WnYMYPp
        8LzBh+AT0vPGwg2YTG6xkuYHaw==
X-Google-Smtp-Source: ABdhPJx6hr8hFj10U9L/ZvYXEVo7Oh3s3837pFjDs6dF7Yjdh5sck97bZABMjahmpXn6/jNhOlVWRQ==
X-Received: by 2002:a5d:9285:: with SMTP id s5mr3966188iom.139.1615413608845;
        Wed, 10 Mar 2021 14:00:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b9sm390260ioz.49.2021.03.10.14.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 14:00:08 -0800 (PST)
Subject: Re: [PATCH 5.4 00/24] 5.4.105-rc1 review
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210310132320.550932445@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a541f05c-60c6-1d9d-87f9-762599fa6295@linuxfoundation.org>
Date:   Wed, 10 Mar 2021 15:00:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210310132320.550932445@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 6:24 AM, gregkh@linuxfoundation.org wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is the start of the stable review cycle for the 5.4.105 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Mar 2021 13:23:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

