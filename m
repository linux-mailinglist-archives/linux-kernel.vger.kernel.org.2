Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7127F44B984
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhKJAGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:06:51 -0500
Received: from foss.arm.com ([217.140.110.172]:40968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhKJAGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:06:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D7AED1;
        Tue,  9 Nov 2021 16:04:02 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B77AE3F800;
        Tue,  9 Nov 2021 16:04:01 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <20211109102502.GA288354@lothringen>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <20211109102502.GA288354@lothringen>
Date:   Wed, 10 Nov 2021 00:03:56 +0000
Message-ID: <87k0hgswpf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/21 11:25, Frederic Weisbecker wrote:
> On Fri, Nov 05, 2021 at 10:40:35AM +0000, Valentin Schneider wrote:
>> @@ -75,17 +86,6 @@ config PREEMPT_RT
>>
>>  endchoice
>>
>> -config PREEMPT_NONE
>> -	bool
>> -
>> -config PREEMPT_VOLUNTARY
>> -	bool
>> -
>> -config PREEMPT
>> -	bool
>> -	select PREEMPTION
>> -	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>> -
>>  config PREEMPT_COUNT
>>         bool
>
> This must be breaking cond_resched() and might_resched() definitions.
>
> Since CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY and CONFIG_PREEMPT aren't too widely
> spread around within ifdefferies, you can:
>
> 1) Rename CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_NONE_STATIC
>    Rename CONFIG_PREEMPT_VOLUNTARY to CONFIG_PREEMPT_VOLUNTARY_STATIC
>    Rename CONFIG_PREEMPT to CONFIG_PREEMPT_STATIC
>
> 2) Keep the old CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY,
>    CONFIG_PREEMPT around for compatibility and make them select their
>    corresponding BEHAVIOUR entries.
>

Damn, I was too zealous on my inbox clearing and skipped that one, sorry!
(and ofc in the meantime Mike and I went down separate rabbit holes).

The old CONFIG_PREEMPT* would have to remain somewhere in the menu entry
(e.g. "legacy" preemption mode selection?), but other than that it seems to
work with this kind of structure:

choice
        prompt "Preemption Model"
        default PREEMPT_BEHAVIOUR if PREEMPT
        default PREEMPT_VOLUNTARY_BEHAVIOUR if PREEMPT_VOLUNTARY
        default PREEMPT_NONE_BEHAVIOUR

This however doesn't solve Mike's concern wrt deselecting PREEMPT_RT to
flip PREEMPT_DYNAMIC and vice versa...


> Thanks.
>
