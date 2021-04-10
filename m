Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972F35ABC0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhDJHxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:53:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:53:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618041193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTrlIINQDxzKaJaoX5kqDJxTIH9GFxc/xXfriRQ1wYk=;
        b=Dxp5chLUxb8Oo2mJnBxNh5709aOIfnrnQwiw9PmFv0mcLN8gfIOfQ6bjOJ7CqRCjlDhrug
        YMgZ3yC2KXgxKVOdm9DYXvEQqsapGLDv0BwyX4w2KvAfgaJHsxbIPbhH5kICd4twxVjk4x
        RuciTRJ9NMj+B7MfyYywS34k0aYncF4K6ZlUg6p7e2DpJvhtJMggaicJwEWCLceMtzrlah
        f9js7z1NFrnv6OiU4wQ2ywoCDVyXVoCxNP9sM8tFx8JyxC9A6vRcfWtonqIs3LUbIOcZqq
        1jSi5claN47saboM5Ynbh5DLgQx7RcENG8HKqi9+b7c1PbFh7pwNscXUuHSTGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618041193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTrlIINQDxzKaJaoX5kqDJxTIH9GFxc/xXfriRQ1wYk=;
        b=nVWQ5rhqrjHEoGV0Y+1mCYqhKaSkLXE7E6TI8Eyw5K+7xQqA/KnO2gPzrfl8Tm/YZLjrQ3
        5aDXXgn1x45PQiDw==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210409165146.GA40118@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet>
Date:   Sat, 10 Apr 2021 09:53:13 +0200
Message-ID: <87lf9q4lue.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09 2021 at 13:51, Marcelo Tosatti wrote:
> On Fri, Apr 09, 2021 at 04:15:13PM +0200, Thomas Gleixner wrote:
>> On Wed, Apr 07 2021 at 10:53, Marcelo Tosatti wrote:
>> ---> fail because that newly started timer is on the old offset.
>
> CPU0								CPU1
>
>
> clock_was_set()
> 							Case-1: CPU-1 grabs base->lock before CPU-0:
> 							CPU-0 sees active_mask[CPU1] and IPIs.
>
> 							base = lock_hrtimer_base(timer, &flags);
>         						if (__hrtimer_start_range_ns(timer, tim, ...
>                 						hrtimer_reprogram(timer, true);
>
>         						unlock_hrtimer_base(timer, &flags);
>
>
> raw_spin_lock_irqsave(&cpu_base->lock, flags);
> if (need_reprogram_timer(cpu_base))
>         cpumask_set_cpu(cpu, mask);
> else
>         hrtimer_update_base(cpu_base);
> raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
>
> 							Case-2: CPU-1 grabs base->lock after CPU-0:
> 							CPU-0 will have updated the offsets remotely.
>
> 							base = lock_hrtimer_base(timer, &flags);
>         						if (__hrtimer_start_range_ns(timer, tim, ...
>                 						hrtimer_reprogram(timer, true);
>
>         						unlock_hrtimer_base(timer, &flags);
>
>
> No?

Yeah, you're right. I misread the loop logic.

Can we please make that unconditional independent of nohz full. There is
no reason to special case it.

Thanks,

        tglx
