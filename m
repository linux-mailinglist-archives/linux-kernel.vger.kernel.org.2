Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B040B257
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhINO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhINO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:59:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74606C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:58:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631631488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMf9Du4AoXtMqUqsAhP420PXBDeadynwXJLGh2bwgKY=;
        b=IyK3iRLw+kk5pHxeHASPPHUKt5r/1oeO5oWCsIaGEdibD8T92YK9oSimc/F9jpB9m0sFeh
        no9wppPFN4Ax+hMW7v6/2JIXk/j9c+asnp0PvUYAWSKYEVpa6mqgYU4+lTGEOu0izaDIXm
        kkj4X/H4x9qUj5gNHcuUXzR7TyRSUBz9WZ+fEcgk0eTZeKDhTRIP4WxeIojBarEjvpA4tQ
        SmzIoJ6NPtinYEo8g4wml8T4tJ60m64sYNXQjEbH7eO40fGr2RQojmgD4jnNvV4o/P/+3K
        s4tmHZFTLGQWyEwLaIK95ehAuvuZ/MYFfaZS3eaYbAxG7Eu5rswcQhMuWaJwcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631631488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMf9Du4AoXtMqUqsAhP420PXBDeadynwXJLGh2bwgKY=;
        b=fspJLkoPc2zYxntrLtxuSZ2JQABiT1vZMrgdYjXqOzXvUjg5GbpzBwCVwbVOr9r8qt1De7
        IdurB+m6Od3HupBA==
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
In-Reply-To: <20210914123726.4219-1-hdanton@sina.com>
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com>
Date:   Tue, 14 Sep 2021 16:58:08 +0200
Message-ID: <87v933b3wf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 20:37, Hillf Danton wrote:

> On Mon, 13 Sep 2021 12:28:14 +0200 Thomas Gleixner wrote:
>>On Tue, Aug 31 2021 at 15:45, Hillf Danton wrote:
>>> On Mon, 30 Aug 2021 12:58:58 +0200 Dmitry Vyukov wrote:
>>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
>>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
>>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
>>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
>>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>>>
>>> Add debug info only to help kasan catch the timer running longer than 2 ticks.
>>>
>>> Is it anything in the right direction, tglx?
>>
>>Not really. As Dmitry pointed out this seems to be related to
>
> Thanks for taking a look.
>
>>mac80211_hwsim and if you look at the above stacktrace then how is
>>adding something to the timer wheel helpful?
>
> Given the stall was printed on CPU1 while the supposedly offending timer was
> expiring on CPU0, what was proposed is the lame debug info only for kasan to
> catch the timer red handed.
>
> It is more appreciated if the tglx dude would likely spend a couple of minutes
> giving us a lesson on the expertises needed for collecting evidence that any
> timer runs longer than two ticks. It helps beyond the extent of kasan.

That tglx dude already picked the relevant part of the stack trace (see
also above):

>>>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
>>>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
>>>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>>>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
>>>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
>>>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

and then asked the question how a timer wheel timer runtime check
helps. He just omitted the appendix "if the timer in question is a
hrtimer" as he assumed that this is pretty obvious from the stack trace.

Aside of that if the wireless timer callback runs in an endless loop,
what is a runtime detection of that in the hrtimer softirq invocation
helping to decode the problem if the stall detector catches it when it
hangs there?

Now that mac80211 hrtimer callback might actually be not the real
problem. It's certainly containing a bunch of loops, but I couldn't find
an endless loop there during a cursory inspection.

But that callback does rearm the hrtimer and that made me look at
hrtimer_run_queues() which might be the reason for the endless loop as
it only terminates when there is no timer to expire anymore.

Now what happens when the mac80211 callback rearms the timer so it
expires immediately again:

        hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
                        ns_to_ktime(bcn_int * NSEC_PER_USEC));

bcn is a user space controlled value. Now lets assume that bcn_int is <=1,
which would certainly cause the loop in hrtimer_run_queues() to keeping
looping forever.

That should be easy to verify by implementing a simple test which
reschedules a hrtimer from the callback with a expiry time close to now.

Not today as I'm about to head home to fire up the pizza oven.

Thanks,

        tglx
