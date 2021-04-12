Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A135D0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbhDLSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhDLSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:54:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02420C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:54:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618253643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAzEGo3aaehx8yEr/KawXpm/qjYhVl0K/d9ohZfM2wc=;
        b=uHseNqYrXL8DnXDI4eJ9mS6iMXae1Ba7IJZfiPL13WnmYswLe2aaIa4gGuPqhDhNgms/r9
        a9obqZ/Lb7LUjTIkzefPicG4grnci5ZAKXRwygneNAhxk7u+7ebjh6xr6hv1nEZQj6CVor
        Y5g7WErMcTDXPpeuIyd3EN3Ucx2wBqDEZNuHoAdlazfNZ+FmuKPjvwYCB7LmfWDLSpPXY4
        4tORsDMcZ9wBk3mvR0PmhFcxRcQT8DaToiOjpRvVaOpvaPaL7oGyaRbjdMuIVFs50h+u7f
        jJcHwElAfxdWa+csj3RlcFDJLTYxqdq5qV5E3qMxW9Ql69TbwDPtA+w/exuPZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618253643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAzEGo3aaehx8yEr/KawXpm/qjYhVl0K/d9ohZfM2wc=;
        b=0ECjvhqt90UTCIeHxiSuds8I+np5h3m8LUdyAHg3SAh4i3neGZofQyBVEPQi36eTAl7Un0
        qTAGUeZPraEC8cCA==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-3-paulmck@kernel.org> <87blam4iqe.ffs@nanos.tec.linutronix.de> <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1> <878s5p2jqv.ffs@nanos.tec.linutronix.de> <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1> <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1> <87k0p71whr.ffs@nanos.tec.linutronix.de> <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 12 Apr 2021 20:54:03 +0200
Message-ID: <87y2dnz644.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Mon, Apr 12 2021 at 11:20, Paul E. McKenney wrote:
> On Mon, Apr 12, 2021 at 03:08:16PM +0200, Thomas Gleixner wrote:
>> The reason for irqsave is again historical AFAICT and nobody bothered to
>> clean it up. spin_lock_bh() should be sufficient to serialize against
>> the watchdog timer, though I haven't looked at all possible scenarios.
>
> Though if BH is disabled, there is not so much advantage to
> invoking it from __clocksource_watchdog_kthread().  Might as
> well just invoke it directly from clocksource_watchdog().
>
>> > 2.	Invoke clocksource_verify_percpu() from its original
>> > 	location in clocksource_watchdog(), just before the call to
>> > 	__clocksource_unstable().  This relies on the fact that
>> > 	clocksource_watchdog() acquires watchdog_lock without
>> > 	disabling interrupts.
>> 
>> That should be fine, but this might cause the softirq to 'run' for a
>> very long time which is not pretty either.
>> 
>> Aside of that, do we really need to check _all_ online CPUs? What you
>> are trying to figure out is whether the wreckage is CPU local or global,
>> right?
>> 
>> Wouldn't a shirt-sleeve approach of just querying _one_ CPU be good
>> enough? Either the other CPU has the same wreckage, then it's global or
>> it hasn't which points to a per CPU local issue.
>> 
>> Sure it does not catch the case where a subset (>1) of all CPUs is
>> affected, but I'm not seing how that really buys us anything.
>
> Good point!  My thought is to randomly pick eight CPUs to keep the
> duration reasonable while having a good chance of hitting "interesting"
> CPU choices in multicore and multisocket systems.
>
> However, if a hard-to-reproduce problem occurred, it would be good to take
> the hit and scan all the CPUs.  Additionally, there are some workloads
> for which the switch from TSC to HPET is fatal anyway due to increased
> overhead.  For these workloads, the full CPU scan is no additional pain.
>
> So I am thinking in terms of a default that probes eight randomly selected
> CPUs without worrying about duplicates (as in there would be some chance
> that fewer CPUs would actually be probed), but with a boot-time flag
> that does all CPUs.  I would add the (default) random selection as a
> separate patch.

You can't do without making it complex, right? Keep it simple is not an
option for a RCU hacker it seems :)

> I will send a new series out later today, Pacific Time.

Can you do me a favour and send it standalone and not as yet another
reply to this existing thread maze. A trivial lore link to the previous
version gives enough context.

Thanks,

        tglx
 
