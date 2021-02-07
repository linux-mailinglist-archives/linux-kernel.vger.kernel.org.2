Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028C1312336
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBGJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:30:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD95C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 01:29:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so13358190wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UL89vnp+Ah7/ei61uQ/cC1UZ5VSPsshw07hBlWMQIhU=;
        b=lU7YfPFMZJCqtk6AnTii2fYNDezcQW7DfFPsoPbvXwew/AgP9bducx1IClkSLNQvoq
         NodCSkMritojUbrX/aBtF3o6G2OXAehvcNf+58LiAanO3AQBkb+n8Eqybu1Aq0m7hUiZ
         0Jlmc/gYmUTUKMQS1SoMER8pZCY+SAszaPzCTRZf0JpVCGdYHGCqoeiSxOH98CIzJUnY
         9NGgVrh4LQy878DNx2irmodSghFh7emf1mcPo+wkj3U7IHOJejacHNjf4xNWeo5r+lIM
         4mL/jSfq1jHhn0Gt0Kc9gdQ0XH2IunEgQzMVsxW1uz0zdNefY+xPOhwxbML9M4AKoIj+
         WFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UL89vnp+Ah7/ei61uQ/cC1UZ5VSPsshw07hBlWMQIhU=;
        b=m7naCbMFeovgKQKszD0QCqjqeQEaEFjh2Q1fPPu8Fxaq7jnIS6Xg1JopoWx6UZBEci
         NRvYpoehRElTi0GWzpz0m3nyD+YfL0UMuDb9S2NXNamHFGK/+HiOeAzEsfiMzN2whFMY
         1ED8KskjKEztJDk6PSFWwF9qa73a3pxvlyUSO0ksSFH4/Yc0t9LzMsB7wyDiWvaNEjc6
         +Pg8r/0/QqP+TQ+VhBEjknnlX3ismB7eHFwfbvyXh4fddUduZvkNENqcb6dYIsxKdoPc
         +aO7ncwXJAUBrXvXTopNilnLMfBmy9DFccQnzK9QCq6LWdWZEeFAFPVH6ngs+uTJT1iC
         ntmQ==
X-Gm-Message-State: AOAM530xaRsx0xJuCqpFk9bd3UoxdMX4GLC80RQuNMbzIZ3hEZqbgEhv
        8YzUKFn7Tvw1LRF2uOfDF7nIAA==
X-Google-Smtp-Source: ABdhPJzUVGbU/bEL9iOkuX699SCDThqbdIpM5atlgB62a/y3bFUZAjbzj3xUB59DqLqOj9TuILweyQ==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr14160049wrw.61.1612690187515;
        Sun, 07 Feb 2021 01:29:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c5af:e183:bc03:d8f5? ([2a01:e34:ed2f:f020:c5af:e183:bc03:d8f5])
        by smtp.googlemail.com with ESMTPSA id o18sm6762181wmp.19.2021.02.07.01.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 01:29:46 -0800 (PST)
Subject: Re: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile
 error with CPU_CK610
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
 <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org>
 <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org>
Date:   Sun, 7 Feb 2021 10:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2021 04:31, Guo Ren wrote:
> Hi Daniel,
> 
> On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/02/2021 08:46, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The timer-mp-csky.c only could support CPU_CK860 and it will
>>> compile error with CPU_CK610.
>>>
>>> It has been selected in arch/csky/Kconfig.
>>
>> It would be better if you fix the root cause of the compilation error.
> The timer-mp-csky.c has used specific instructions which only
> supported by CK860 and timer-mp-csky.c is only design for CK860.

I guess you are referring to mfcr() ?

> In arch/csky/Konfig we only select it with CK860.
>         select CSKY_MPINTC if CPU_CK860
>         select CSKY_MP_TIMER if CPU_CK860
> 
> So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
> drivers/clocksource/Kconfig.

The COMPILE_TEST option is there to let other architecture to compile
drivers and increase the compilation test coverage.

The proposed change just removes the driver from this coverage.

Ideally, it would be better to keep it with the COMPILE_TEST option, so
changes impacting all the drivers can be caught before submitting the
patches.

By just adding

#ifndef mfcr
#define mfcr(a) 0
#endif

shoud fix the compilation issue, no ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
