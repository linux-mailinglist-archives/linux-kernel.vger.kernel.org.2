Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4D32291A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBWKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:54:54 -0500
Received: from foss.arm.com ([217.140.110.172]:42674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhBWKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:53:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4786F31B;
        Tue, 23 Feb 2021 02:52:33 -0800 (PST)
Received: from [10.37.8.9] (unknown [10.37.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D57E3F70D;
        Tue, 23 Feb 2021 02:52:31 -0800 (PST)
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can read
 beyond buffer limits
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
 <20210212172128.GE7718@arm.com>
 <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
 <20210222175825.GE19604@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6111633c-3bbd-edfa-86a0-be580a9ebcc8@arm.com>
Date:   Tue, 23 Feb 2021 10:56:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222175825.GE19604@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/21 5:58 PM, Catalin Marinas wrote:
> That's because cpu_hotplug_lock is not a spinlock but a semaphore which
> implies sleeping. I don't think avoiding taking this semaphore
> altogether (as in the *_cpuslocked functions) is the correct workaround.
>

Thinking at it a second time I agree, it is not a good idea avoiding to take the
semaphore in this case.

> The mte_enable_kernel_async() function is called on each secondary CPU
> but we don't really need to attempt to toggle the static key on each of
> them as they all have the same configuration. Maybe do something like:
> 
> 	if (!static_branch_unlikely(&mte_async_mode)))
> 		static_branch_enable(&mte_async_mode);
> 
> so that it's only set on the boot CPU.
> 

This should work, maybe with a comment that if we plan to introduce runtime
switching in between async and sync in future we need to revisit our strategy.

> The alternative is to use a per-CPU mask/variable instead of static
> branches but it's probably too expensive for those functions that were
> meant to improve performance.
> 

I would not go for this approach because the reason why we introduced static
branches instead of having a normal variable saving the state was performances.

> We'll still have an issue with dynamically switching the async/sync mode
> at run-time. Luckily kasan doesn't do this now. The problem is that
> until the last CPU have been switched from async to sync, we can't
> toggle the static label. When switching from sync to async, we need
> to do it on the first CPU being switched.
> 

I totally agree on this point. In the case of runtime switching we might need
the rethink completely the strategy and depends a lot on what we want to allow
and what not. For the kernel I imagine we will need to expose something in sysfs
that affects all the cores and then maybe stop_machine() to propagate it to all
the cores. Do you think having some of the cores running in sync mode and some
in async is a viable solution?

Probably it is worth to discuss it further once we cross that bridge.

> So, I think currently we can set the mte_async_mode label to true in
> mte_enable_kernel_async(), with the 'if' check above. For
> mte_enable_kernel_sync(), don't bother with setting the key to false but
> place a WARN_ONCE if the mte_async_mode is true. We can revisit it if
> kasan ever gains this run-time switch mode.

Indeed, this should work for now.

-- 
Regards,
Vincenzo
