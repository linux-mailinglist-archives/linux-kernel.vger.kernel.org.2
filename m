Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3680363142
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhDQQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:51:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35914 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhDQQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:51:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618678269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHFXeGeB1Nk5jAgFZcyB5X1ecx9JoHUIaZELA0L/4f0=;
        b=LG8UaleyeUrauZhgFf+XBK2TYirPlCOGnwzhIA7HwRq6h2pWxwz829+x0HzBT27UQZunJH
        IApRZqEhWG5MSxgI+spfQ4QXjJBQYUyqsBMEXHaSluCZnSuOCCsP9NUApT8/1gIl0nuCnM
        zQQTfTpjvS7sGXnNAhIc//k0V75UJALatBfxgqw35jNXBmvYuVqo9dug0tZcs3wB6oxMGR
        9RCLF3ZePVx21Wolfsmdvyxj4CSgJfvO0OYhCeWyvsZpGcJmmAS4q/zmUIqUeNWb3SVnX7
        ipBApw1qnBSYMCIVdld4Tmn1NoyYl/bJC+BiuN5C4Oj4DOgs4QijmcUq98uypQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618678269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHFXeGeB1Nk5jAgFZcyB5X1ecx9JoHUIaZELA0L/4f0=;
        b=nLWYl9mO+WHo7N8mTVq45amwkdyV59XhO18vq6fw5rj1f0t/CY8Xbx0i8PbKBgAggC29+j
        E8vQUBP4tLGbKeBg==
To:     Peter Xu <peterx@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v5] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <87pmysswtj.ffs@nanos.tec.linutronix.de>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet> <87lf9q4lue.ffs@nanos.tec.linutronix.de> <20210413170431.GA16190@fuller.cnet> <20210415153935.GA69750@fuller.cnet> <87im4nv0fh.ffs@nanos.tec.linutronix.de> <20210415204017.GA111847@fuller.cnet> <20210416160023.GA6187@fuller.cnet> <20210416171321.GU4440@xz-x1> <87pmysswtj.ffs@nanos.tec.linutronix.de>
Date:   Sat, 17 Apr 2021 18:51:08 +0200
Message-ID: <87mttwsvlv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17 2021 at 18:24, Thomas Gleixner wrote:
> On Fri, Apr 16 2021 at 13:13, Peter Xu wrote:
>> On Fri, Apr 16, 2021 at 01:00:23PM -0300, Marcelo Tosatti wrote:
>>>  
>>> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
>>> +			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
>>> +			 (1U << HRTIMER_BASE_TAI) |		\
>>> +			 (1U << HRTIMER_BASE_TAI_SOFT))
>>> +
>>> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
>>> +{
>>> +	if (cpu_base->softirq_activated)
>>> +		return true;
>>
>> A pure question on whether this check is needed...
>>
>> Here even if softirq_activated==1 (as softirq is going to happen), as long as
>> (cpu_base->active_bases & CLOCK_SET_BASES)==0, shouldn't it already mean that
>> "yes indeed clock was set, but no need to kick this cpu as no relevant timer"?
>> As that question seems to be orthogonal to whether a softirq is going to
>> trigger on that cpu.
>
> That's correct and it's not any different from firing the IPI because in
> both cases the update happens with the base lock of the CPU in question
> held. And if there are no active timers in any of the affected bases,
> then there is no need to reevaluate the next expiry because the offset
> update does not affect any armed timers. It just makes sure that the
> next enqueu of a timer on such a base will see the the correct offset.
>
> I'll just zap it.

But the whole thing is still wrong in two aspects:

    1) BOOTTIME can be one of the affected clocks when sleep time
       (suspended time) is injected because that uses the same mechanism.

       Sorry for missing that earlier when I asked to remove it, but
       that's trivial to fix by adding the BOOTTIME base back.

    2) What's worse is that on resume this might break because that
       mechanism is also used to enforce the reprogramming of the clock
       event devices and there we cannot be selective on clock bases.

       I need to dig deeper into that because suspend/resume has changed
       a lot over time, so this might be just a historical leftover. But
       without proper analysis we might end up with subtle and hard to
       debug wreckage.

Thanks,

        tglx
