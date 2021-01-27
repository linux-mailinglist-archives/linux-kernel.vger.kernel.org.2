Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46D030579F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhA0KAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhA0IsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:48:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 00:47:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so1029915wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 00:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGwXlHMaXT173PPtQ79fzLXztmdUly2hAj///m0uLCg=;
        b=SXE27hziJfU4EBynm15TM/u52B8UvFkNRSF+gnCKLb/HGMnMX6l7oDQkx0uu6o+VoV
         al7SPenpCQDpTSH3iIM6ZeIvQ6DxYFF4/PvbAePm2AC7/VtDIG8gwdBHQs63Lf1GMHAY
         2cY7PtAvItUM0cs2azR/ZkUJclB+Lq0au/26FNgiGQxFYSw5jAKzkuF0cwf9n5YmKX5m
         C3EYfkmi06Wq72JwGyeXuXj3C6j2W0JJDDWCI26a0lxNCBjDWxLxYs+H28gOppi9R2/u
         sh905FCskKV5SVa4GYZ6KHEZRaV31m6AmxhIsY2X6Dcw4qNUrMljBeLh9I7tXQASNDzH
         U43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGwXlHMaXT173PPtQ79fzLXztmdUly2hAj///m0uLCg=;
        b=tXm3j4Hb0AecRYaYKAWXtkn5aYwKBklFNg1JQpgWtdkXDT6OdyJVyKdTwe4BreWrDC
         qXuKxBiNzSw0Z5UfZfef3AAHLzKJOJB2Auf+wnYHMIWRwgr2FRkNMYgBMeg1PwEfFx11
         p2k58D7qjdgwGizIhq16Fay9TBp3p9UCBK5fZGrJ8EPZr1bwW7ZxcJYzy6Pn1aG3LyQW
         SFdPUfyjKO3/K5r7coFSDIjjM4WThmNuKffsqubirBZXhDjVDC6suLpRu5x2pSPWGFRJ
         zbdLBjCPFjVfaj6dA5it37sJSePt4uDnDZfUXMCiA6K2nndvenfO4Am6XoIbeIq4xpr7
         fjXA==
X-Gm-Message-State: AOAM532O2HnoM8lCxOIBkl1a0m6e8Mmk5txT1gXxgCSex6XowkvJeJrf
        jNE8wR9FThf4CsUKnVZWQwJJAg==
X-Google-Smtp-Source: ABdhPJxuhMeVdTk1V1OzkLPPzrSnWj5/KeHaXq3KQwTTyvrJzFK6e4xVEJmli2GGZtLJSpfZmbzvNw==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr9928487wra.370.1611737224262;
        Wed, 27 Jan 2021 00:47:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1cd8:ab51:e378:c21c? ([2a01:e34:ed2f:f020:1cd8:ab51:e378:c21c])
        by smtp.googlemail.com with ESMTPSA id j13sm1623902wmi.24.2021.01.27.00.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:47:03 -0800 (PST)
Subject: Re: [GIT PULL] timer drivers fixes for v5.11-rc5
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, trix@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
Message-ID: <7a90ec96-d8e5-e505-bd5a-38cc00892021@linaro.org>
Date:   Wed, 27 Jan 2021 09:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

just a gentle ping

On 20/01/2021 09:31, Daniel Lezcano wrote:
> 
> Hi Thomas,
> 
> please consider the following three fixes for the timer drivers.
> 
> Thanks
> 
>   -- Daniel
> 
> The following changes since commit e3fab2f3de081e98c50b7b4ace1b040161d95310:
> 
>   ntp: Fix RTC synchronization on 32-bit platforms (2021-01-12 21:13:01
> +0100)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/daniel.lezcano/linux.git
> tags/timers-v5.11-rc5
> 
> for you to fetch changes up to 7da390694afbaed8e0f05717a541dfaf1077ba51:
> 
>   clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
> defined (2021-01-18 22:28:59 +0100)
> 
> ----------------------------------------------------------------
> - Fix harmless warning with the ixp4xx when the TIMER_OF option is not
> selected (Arnd Bergmann)
> 
> - Make sure channel clock supply is enabled on sh_cmt (Geert Uytterhoeven)
> 
> - Fix compilation error when DEBUG is defined with the mxs_timer (Tom Rix)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       clocksource/drivers/ixp4xx: Select TIMER_OF when needed
> 
> Geert Uytterhoeven (1):
>       clocksource/drivers/sh_cmt: Make sure channel clock supply is enabled
> 
> Tom Rix (1):
>       clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
> defined
> 
>  arch/arm/mach-ixp4xx/Kconfig    |  1 -
>  drivers/clocksource/Kconfig     |  1 +
>  drivers/clocksource/mxs_timer.c |  5 +----
>  drivers/clocksource/sh_cmt.c    | 16 +++++++++++++---
>  4 files changed, 15 insertions(+), 8 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
