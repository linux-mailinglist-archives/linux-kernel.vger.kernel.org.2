Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7140A136
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350225AbhIMXDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349505AbhIMXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:03:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31169C0613E1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:01:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so10844019pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ByPuq+LeUn8ajxlQIinCBSXF06/h7ABjg6kuKNApf6k=;
        b=n6y92KCDHfObkxZIBa9K4tmYOiN+FMqSthewJ6gMcCUZGHUxYOSFQOB8XQLGF7rbcN
         gFpBVTs/TJkPUypDOt4TFOicuGEDknhjNr9KpuXihbkU6CXymLlSMpI47zD8AmxtrdA+
         kcSFACjsKn4qzSW9Vr/cPVzPHxUiVjgsoPJLTjbPb3rveL6hVtSrTswAj2KaHudu1bZn
         BuZhMOw4YHQLi3X8ypvF3CXVtYliGR93wE0Opx5H09rayPXz9GUshxJq0DRPhxUmyZc+
         oHtQpwCruzVIwboYdmIhpmMRhO63hIg8k0CqVQ48yI+z5FfD/Igzux2u8I6AZHCKz1o7
         Osfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ByPuq+LeUn8ajxlQIinCBSXF06/h7ABjg6kuKNApf6k=;
        b=nhDEpsGJbFL4yb94xp6/2Jhr3aOfO3Q/Jd8XKwG6Rursq676g+vHBqDiMaWFYrUSZO
         Ey9p89QQScrTfMRCwPUp25rf4KzOkblIWNwvk5sBtm2BZ7V6kEzVqlcpQWOlwScSOK/i
         3u29TIq3nbMhhdiGYubL0+5fm7u+X6Tk3epXKzKi+Q28d2MShyPvCbYnRmpYQIc2u4ex
         SDRMoX/BXGTL0PpQWQL0ofKTmIVj0Q2voN2dBS2rOviBz92KW5Ta9xLdxF0iM40tszH/
         M1hxYl0L8g9NoBNwCDz0Kbj8iM6SYCiaHny5ex/f1Q1/Ys8xb1Dz1y8A1aHsT/N4SQlz
         LxEg==
X-Gm-Message-State: AOAM5332Stv1AUufLLQoj2DN6xi2BYPy/WgHb2NVbt1kd9izyYzU38Vy
        IBr5F4kgOIJJGS/ikviPG2I=
X-Google-Smtp-Source: ABdhPJxE2iAY+zDHkrTCmXnqNW98tZsP/1jX4MBJp3y26nzhGD0A9Bs0G/bUOgNhBVVtG0RIh1AVCA==
X-Received: by 2002:a65:64d7:: with SMTP id t23mr12842733pgv.237.1631574085626;
        Mon, 13 Sep 2021 16:01:25 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u12sm7803903pjx.31.2021.09.13.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 16:01:25 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
Date:   Tue, 14 Sep 2021 08:01:22 +0900
In-Reply-To: <20210903121950.2284-1-thunder.leizhen@huawei.com> (Zhen Lei's
        message of "Fri, 3 Sep 2021 20:19:50 +0800")
Message-ID: <87o88w84hp.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

Zhen Lei <thunder.leizhen@huawei.com> writes:

> Commit 582f95835a8f ("arm64: entry: convert el0_sync to C") converted lots
> of functions from assembly to C, this greatly improves readability. But
> el0_svc()/el0_svc_compat() is in response to system call requests from
> user mode and may be in the hot path.
>
> Although the SVC is in the first case of the switch statement in C, the
> compiler optimizes the switch statement as a whole, and does not give SVC
> a small boost.
>
> Use "likely()" to help SVC directly invoke its handler after a simple
> judgment to avoid entering the switch table lookup process.
>
> After:
> 0000000000000ff0 <el0t_64_sync_handler>:
>      ff0:       d503245f        bti     c
>      ff4:       d503233f        paciasp
>      ff8:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>      ffc:       910003fd        mov     x29, sp
>     1000:       d5385201        mrs     x1, esr_el1
>     1004:       531a7c22        lsr     w2, w1, #26
>     1008:       f100545f        cmp     x2, #0x15
>     100c:       540000a1        b.ne    1020 <el0t_64_sync_handler+0x30>
>     1010:       97fffe14        bl      860 <el0_svc>
>     1014:       a8c17bfd        ldp     x29, x30, [sp], #16
>     1018:       d50323bf        autiasp
>     101c:       d65f03c0        ret
>     1020:       f100705f        cmp     x2, #0x1c
>
> Execute "./lat_syscall null" on my board (BogoMIPS : 200.00), it can save
> about 10ns.
>
> Before:
> Simple syscall: 0.2365 microseconds
> Simple syscall: 0.2354 microseconds
> Simple syscall: 0.2339 microseconds
>
> After:
> Simple syscall: 0.2255 microseconds
> Simple syscall: 0.2254 microseconds
> Simple syscall: 0.2256 microseconds

I was curious about the impact of the patch on other
micro-architectures. Following are the results from using the patch
applied to v5.14 on A72 and A53 on a RK399.

For the A72 -
Before:
Simple syscall: 0.4311 microseconds
Simple syscall: 0.4311 microseconds
Simple syscall: 0.4313 microseconds

After:
Simple syscall: 0.4249 microseconds
Simple syscall: 0.4248 microseconds
Simple syscall: 0.4248 microseconds

For the A53 -
Before:
Simple syscall: 0.4130 microseconds
Simple syscall: 0.4128 microseconds
Simple syscall: 0.4124 microseconds

After:
Simple syscall: 0.4031 microseconds
Simple syscall: 0.4078 microseconds
Simple syscall: 0.4030 microseconds

Although there is a small benefit, they are not as big as on your board
/ micro-architecture.

Were you able to see any impact on real workloads?

I imagine that other code paths in the sync handler would also benefit
from similar special casing - did you try any others. Page fault
handling came to mind.

Overall, I feel a little uneasy about the special casing introduced here
but at the same time see that it does benefit certain workloads.

One more comment below.

>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/entry-common.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe77b..062eb5a895ec6f3 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -607,11 +607,14 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
>  asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	unsigned long ec = ESR_ELx_EC(esr);
>  
> -	switch (ESR_ELx_EC(esr)) {
> -	case ESR_ELx_EC_SVC64:
> +	if (likely(ec == ESR_ELx_EC_SVC64)) {
>  		el0_svc(regs);
> -		break;
> +		return;
> +	}
> +
> +	switch (ec) {
>  	case ESR_ELx_EC_DABT_LOW:
>  		el0_da(regs, esr);
>  		break;

Please include a big fat comment on why SVC (or any other patch) is
being separated out of the switch case - both here and below.

Thanks,
Punit

> @@ -730,11 +733,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	unsigned long ec = ESR_ELx_EC(esr);
>  
> -	switch (ESR_ELx_EC(esr)) {
> -	case ESR_ELx_EC_SVC32:
> +	if (likely(ec == ESR_ELx_EC_SVC32)) {
>  		el0_svc_compat(regs);
> -		break;
> +		return;
> +	}
> +
> +	switch (ec) {
>  	case ESR_ELx_EC_DABT_LOW:
>  		el0_da(regs, esr);
>  		break;
