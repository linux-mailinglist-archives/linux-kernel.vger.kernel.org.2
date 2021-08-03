Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54353DF6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhHCVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhHCVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:22:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF6C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 14:22:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628025726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJRSVrCVV9BJn0guTOFRICYAFTQ9mtIKzIspYsyrA9I=;
        b=ls5MLLSUdit0X6EnNUaK7K5QqWuKWISsJF8mHM7mAsrBf5a989ErpzjZJGMTwpVOohM6nM
        mtE3KXGcqkc/y6PA9IfAgxmTui9eKTKUbQZpZj2wbNhG/tm3TUrMo1IH9rFnTGdHn5BzDS
        t8VfBSvFpJt7cMe0T/1SQI1hOWf1frtIJDycqTfP+jALi9FbAAPCSTONb0/MOrlr+7p83v
        tsXvdp0JlOj6lRtvQywwiKQP9AwvUPzDDfnVl0e6k47ak6mtGZwGPskMiFf4dP8acBvTuM
        dk8Jx8KjGV/D55z6IKZq+iNIqXZ/KvjvEHWROJPMbmzw8utT96vOXER9AmH6QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628025726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJRSVrCVV9BJn0guTOFRICYAFTQ9mtIKzIspYsyrA9I=;
        b=RKmwXUPWUWXBCz8NdwMSn9qe39Bit2DgCCn9pqQDL64tP7OmOicIho9Zp6+QVEW7xGZ0ud
        uTkLrnkUdm4S+mBg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on RT
In-Reply-To: <20210803112051.GC8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <20210803112051.GC8057@worktop.programming.kicks-ass.net>
Date:   Tue, 03 Aug 2021 23:22:05 +0200
Message-ID: <87lf5i2phe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2021 at 13:20, Peter Zijlstra wrote:
> On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
>> +	/*
>> +	 * We were woken prior to requeue by a timeout or a signal.
>> +	 * Unqueue the futex_q and determine which it was.
>> +	 */
>> +	plist_del(&q->list, &hb->chain);
>> +	hb_waiters_dec(hb);
>> +
>> +	/* Handle spurious wakeups gracefully */
>> +	ret = -EWOULDBLOCK;
>> +	if (timeout && !timeout->task)
>> +		ret = -ETIMEDOUT;
>> +	else if (signal_pending(current))
>> +		ret = -ERESTARTNOINTR;
>>  	return ret;
>>  }
>
> AFAICT this change is a separate cleanup, possible because the only
> callsite already does that match_futex() test before calling this.

No. It's possible because the state machine guarantees that. The
match_futex() in the calling function is unrelated.

> I think it might be worth splitting out, just to reduce the complexity
> of this patch.

Yes, I did by moving the match_futex() test to the call site as a
preparatory change for this one.

Thanks,

        tglx
