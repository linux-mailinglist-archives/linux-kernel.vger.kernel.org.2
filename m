Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD6402F61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbhIGUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhIGUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:06:47 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE443C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:05:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id x10so274629ilm.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qBeV/3OVpeBGqoC50W6WyV/Bm/mvFYoJ4MmFvZCO8nQ=;
        b=V3OZERQ7Iaruu0XIKpcZqON5EAPtH4KYFTa7rEhUEp8ixXqsDJEtcDEB3z9/EXE+F9
         zBE4ktNYiOqFT7acLIw1mz+WwcaPJ7TMKeAltOam7FdPoWonV0rhKGPypTVMPazrlMq6
         X3ngHxfEN4EHE57hKFnPsyzOqJmVS3BeOvmmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qBeV/3OVpeBGqoC50W6WyV/Bm/mvFYoJ4MmFvZCO8nQ=;
        b=G/xLQOhsbUuaLWRxjmJB7JLZAdG7x4zhWJeGdA2EbElAZYcD49MqR1Nr8bu8Gj0bR8
         80gyHJDM+lq7dJdPsEdy5crTB6HZ96u32OQjuYUyZD+e16ANBRgXtJU1yis2m6V6XNet
         HjGdYKxFw4xNUWB+c/n63S+HcAOxOPY8sBb3I1xA1Cetn8ru9HzE+akzfqQorM0fT7HZ
         MqhBSZGNwHvuuVZloLNafVGKBX1z84YeEI49ls2TX2X0I+pa54edAxcCszTUiuGsmOcL
         WuS2OUUo5TI4KQbi6sxgQDL+VbaYTlcbK9X9iku9+29uFmFLzensRcW8JZO39s14kifa
         tLsw==
X-Gm-Message-State: AOAM531ulLDTXoMaS90fR//kO+lnYzV9nQR3iglPmSrXHAQM4YW6ywU2
        A0SOPWNven/ZrEE2GMh7Jn0ZbQ==
X-Google-Smtp-Source: ABdhPJzgWaSM/EHxvlWBSzY+jZR2X/KwdW76ujEZfr8UVOQJ6v8iRdP84LNEnpfIcspW7drE+x/iCQ==
X-Received: by 2002:a05:6e02:f03:: with SMTP id x3mr13623361ilj.315.1631045140169;
        Tue, 07 Sep 2021 13:05:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g14sm63699ila.28.2021.09.07.13.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:05:38 -0700 (PDT)
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210907141307.1437816-1-elver@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <69f98dbd-e754-c34a-72cf-a62c858bcd2f@linuxfoundation.org>
Date:   Tue, 7 Sep 2021 14:05:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 8:13 AM, Marco Elver wrote:
> Shuah Khan reported [1]:
> 
>   | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
>   | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>   | it tries to allocate memory attempting to acquire spinlock in page
>   | allocation code while holding workqueue pool raw_spinlock.
>   |
>   | There are several instances of this problem when block layer tries
>   | to __queue_work(). Call trace from one of these instances is below:
>   |
>   |     kblockd_mod_delayed_work_on()
>   |       mod_delayed_work_on()
>   |         __queue_delayed_work()
>   |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>   |             insert_work()
>   |               kasan_record_aux_stack()
>   |                 kasan_save_stack()
>   |                   stack_depot_save()
>   |                     alloc_pages()
>   |                       __alloc_pages()
>   |                         get_page_from_freelist()
>   |                           rm_queue()
>   |                             rm_queue_pcplist()
>   |                               local_lock_irqsave(&pagesets.lock, flags);
>   |                               [ BUG: Invalid wait context triggered ]
> 
> [1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
> 
> PROVE_RAW_LOCK_NESTING is pointing out that (on RT kernels) the locking
> rules are being violated. More generally, memory is being allocated from
> a non-preemptive context (raw_spin_lock'd c-s) where it is not allowed.
> 
> To properly fix this, we must prevent stackdepot from replenishing its
> "stack slab" pool if memory allocations cannot be done in the current
> context: it's a bug to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> non-preemptive contexts, including raw_spin_locks (see gfp.h and
> ab00db216c9c7).
> 
> The only downside is that saving a stack trace may fail if: stackdepot
> runs out of space AND the same stack trace has not been recorded before.
> I expect this to be unlikely, and a simple experiment (boot the kernel)
> didn't result in any failure to record stack trace from insert_work().
> 
> The series includes a few minor fixes to stackdepot that I noticed in
> preparing the series. It then introduces __stack_depot_save(), which
> exposes the option to force stackdepot to not allocate any memory.
> Finally, KASAN is changed to use the new stackdepot interface and
> provide kasan_record_aux_stack_noalloc(), which is then used by
> workqueue code.
> 
> Marco Elver (6):
>    lib/stackdepot: include gfp.h
>    lib/stackdepot: remove unused function argument
>    lib/stackdepot: introduce __stack_depot_save()
>    kasan: common: provide can_alloc in kasan_save_stack()
>    kasan: generic: introduce kasan_record_aux_stack_noalloc()
>    workqueue, kasan: avoid alloc_pages() when recording stack
> 
>   include/linux/kasan.h      |  2 ++
>   include/linux/stackdepot.h |  6 +++++
>   kernel/workqueue.c         |  2 +-
>   lib/stackdepot.c           | 51 ++++++++++++++++++++++++++++++--------
>   mm/kasan/common.c          |  6 ++---
>   mm/kasan/generic.c         | 14 +++++++++--
>   mm/kasan/kasan.h           |  2 +-
>   7 files changed, 65 insertions(+), 18 deletions(-)
> 

Thank you. Tested all the 6 patches in this series on Linux 5.14. This problem
exists in 5.13 and needs to be marked for both 5.14 and 5.13 stable releases.

Here is my

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
