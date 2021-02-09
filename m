Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AED315A91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhBJAE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhBIUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:37:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D5C0698CB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 12:26:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b3so23642680wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTD7IFCF48qtHTJsY6kfEhXXsGhoaPhe67DMMK3vyls=;
        b=GuZHVNfyPKDcJvFWmPCNGhi6aJ9BHNQ0tQbhdcW2yDnmIOwBmNyOVrpfmDi4xdGeL9
         xZWd98EojMGEnEpxrgMjoEMmHzOYt7JsMHPjmaGQ/L2yLDi1g3o2/HtLMaZu81fJTlyc
         Xx9gzXXTIE3nsSNY5ilht/xxXiuU3O9V70oVD8qqN5UeZYsAOznfLSQ//luKrMnh23Si
         AdfKf1s/eTnqGtpe230BkOT0e7YsmXnPxoZK7nf0oKX4hLLRprej09+InJhuys4Hbsle
         oCjOsjm/n3k9ti7zkXJR/NTAWgUoGSBUOdcdzNLkQEC0RXnlno+hvnTovpTSG9PCsCSQ
         OnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTD7IFCF48qtHTJsY6kfEhXXsGhoaPhe67DMMK3vyls=;
        b=sqJQfpOVGB5k3hMAtVktXkADERuOBxcseX8hIhB2Yb7B1QiCp173V3gnsO5t5+r1+K
         f/wzI421hNnqsbMTN3F7D+ThYnTc6FZyn5Vza5a4JivNOlIe5lseBC3qW/Dn19hJGowi
         O6H1msTnjE8I1FY0U09lSHCMi1uWX24azctscEzZFHNuNIrI26QwwciSecG6oGjriAWk
         +ZnOwhlNVdcDkQJuWwCSGh11IX0g1k8hXDjj4jIdPt6RaV6QsxbB/BeVjFG6zkrB7tht
         QV3mcL+w/5aBNYdCdIBM8RQkXwT/nbADwFv1QFbFb9gM/y2ExmoWkBQbvLUz+rA9H9py
         pBzQ==
X-Gm-Message-State: AOAM532z7FqTqZlOG9z5xZLnKGkaj4R7wax8/7h9osmtWt0iTE7alPkq
        dejfr6BQdCVrMvkYp0iEtuZisQ==
X-Google-Smtp-Source: ABdhPJyBG7M88wR9vLHlTuEvxIPwXyFP/WaFjIzf3BFzPGrZolU5OZou5/NrzNBfq1q4F5wz1JTwyw==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr27161973wrl.421.1612902402205;
        Tue, 09 Feb 2021 12:26:42 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4cbf:512d:a355:e705? ([2a01:e34:ed2f:f020:4cbf:512d:a355:e705])
        by smtp.googlemail.com with ESMTPSA id k6sm40978153wro.27.2021.02.09.12.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 12:26:41 -0800 (PST)
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
 <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org>
 <CAJF2gTQG-o5MRtdwc8ogJhGLGsj5AWR1ja26wiGU=wrLL8X2Zw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a2f43b21-2e56-040f-b658-ccafa3b5fdc4@linaro.org>
Date:   Tue, 9 Feb 2021 21:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQG-o5MRtdwc8ogJhGLGsj5AWR1ja26wiGU=wrLL8X2Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 17:02, Guo Ren wrote:
> Hi Daniel,
> 
> On Sun, Feb 7, 2021 at 5:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 07/02/2021 04:31, Guo Ren wrote:
>>> Hi Daniel,
>>>
>>> On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 04/02/2021 08:46, guoren@kernel.org wrote:
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> The timer-mp-csky.c only could support CPU_CK860 and it will
>>>>> compile error with CPU_CK610.
>>>>>
>>>>> It has been selected in arch/csky/Kconfig.
>>>>
>>>> It would be better if you fix the root cause of the compilation error.
>>> The timer-mp-csky.c has used specific instructions which only
>>> supported by CK860 and timer-mp-csky.c is only design for CK860.
>>
>> I guess you are referring to mfcr() ?
>>
>>> In arch/csky/Konfig we only select it with CK860.
>>>         select CSKY_MPINTC if CPU_CK860
>>>         select CSKY_MP_TIMER if CPU_CK860
>>>
>>> So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
>>> drivers/clocksource/Kconfig.
>>
>> The COMPILE_TEST option is there to let other architecture to compile
>> drivers and increase the compilation test coverage.
>>
>> The proposed change just removes the driver from this coverage.
> When we compile the csky arch with C860, it will be selected.
> 
>>
>> Ideally, it would be better to keep it with the COMPILE_TEST option, so
>> changes impacting all the drivers can be caught before submitting the
>> patches.
>>
>> By just adding
>>
>> #ifndef mfcr
>> #define mfcr(a) 0
>> #endif
> 
> 610 couldn't support CSKY_MP_TIMER and it's only for 860. So it's not
> a coding skill issue.

I think there is a misunderstanding.

When I want to compile on x64 all the timer drivers, I do enable
COMPILE_TEST, then the strings appear and the drivers can be selected.

If the COMPILE_TEST is not enabled, the string does not appear, it is
not possible to enable/disable it and the platform must enable it from
the aforementioned arch/csky/Konfig.

Actually, the timer drivers policy is : drivers can not be enabled from
the drivers/clocksource/Kconfig, it is up to the platform Kconfig to
select them. The exception is when the COMPILE_TEST option is set for
testing purpose.

The timer must compile on any other archs and the stubs for the platform
specific calls must be provided.

Did I miss something with your changes ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
