Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAD36B4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhDZOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:34:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:34:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619447611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBYyB3vvIvb1Q8KHDK6dR5Vt10a2wbXY0WlsmB3n/YQ=;
        b=A5kWW7uU8iILvPl+ZvribH58/QsJxJD++jtP40Z0tF5SvHLnNm4dum+kI/hl/eBgOjo8x5
        Tv1EQnOqmPdAqr9neRQi7n79yepIWQ/EjLcfFFby+Ar0Qo8OlINB8G5DcBIfk1yZqRewbc
        7w3MPEaiT3XJR9G3HKd6QXBj1C2lujYpt7XmC4nQfZWry70ZRdpVa804/yPhsotQYfKff+
        9TvhZkWFjka6lU+BrDaAeCd9hmNTbQF/SMjV9BEjrYKphyzNMcPktcOJ+83NncYTN2hzE9
        E+QV63WhVyV4WmiUyKpwBLKU4L7yOfQZSQn7/Tnta/GuCpX1SQXUn8eiQ22pWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619447611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBYyB3vvIvb1Q8KHDK6dR5Vt10a2wbXY0WlsmB3n/YQ=;
        b=x/QCNcFD18eEKYa/a5m4++kPQHrMTLJBcKnYR5alcXAr5lzNjn3GJHClyWg2ovqyfNc2CP
        FbEVrsv9qn1/5zBQ==
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        "lkp\@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec -14.4% regression
In-Reply-To: <20210426140512.GA23119@shbuild999.sh.intel.com>
References: <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com> <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1> <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com> <20210422074126.GA85095@shbuild999.sh.intel.com> <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1> <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1> <20210423061115.GA62813@shbuild999.sh.intel.com> <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1> <20210424122920.GB85095@shbuild999.sh.intel.com> <87pmyhte2q.ffs@nanos.tec.linutronix.de> <20210426140512.GA23119@shbuild999.sh.intel.com>
Date:   Mon, 26 Apr 2021 16:33:31 +0200
Message-ID: <87fszdt8sk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 22:05, Feng Tang wrote:
> On Mon, Apr 26, 2021 at 08:39:25PM +0800, Thomas Gleixner wrote:
>> On Sat, Apr 24 2021 at 20:29, Feng Tang wrote:
>> > On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
>> > And I'm eager to know if there is any real case of an unreliable tsc
>> > on the 'large numbers' of x86 system which complies with our cpu feature
>> > check. And if there is, my 2/2 definitely should be dropped.   
>> 
>> Nothing prevents BIOS tinkerers from trying to be 'smart'. My most
>> recent encounter (3 month ago) was on a laptop where TSC drifted off on
>> CPU0 very slowly, but was caught due to the TSC_ADJUST check in idle.
>
> Thanks for sharing the info! So this laptop can still work with the
> tsc_adjust check and restore, without triggering the 'unstable' alarm.
>
> Why are those BIOSes playing the trick? Maybe some other OS has hard limit
> for SMI's maxim handling time, so they try to hide the time?

Years ago someone admitted that it was the attempt to hide the
(substantial) time wasted in SMIs from being detectable via tracing, but
obviously that backfired because TSC got out of sync.

Since then this has mostly vanished but for some reasons it's coming
back every now and then. Rarely, but it happens still.

>> I'm still thinking about a solution to avoid that extra timer and the
>> watchdog for these systems, but haven't found anything which I don't
>> hate with a passion yet.
>
> I see. So should I hold my two patches (tsc_adjust timer and tsc watchdog
> check lifting) for a while?

I have them on my list anyway, but yes we want to avoid the timer
because that's what the HPC / NOHZ full people are going to complain
about anyway.

Thanks,

        tglx
