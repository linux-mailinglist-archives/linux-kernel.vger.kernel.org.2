Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED2936D589
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhD1KPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:15:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhD1KPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:15:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619604889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkABMUrVTIed7Pud/pAOG8Jsv0xIjFbTnk9egvEwBMI=;
        b=KpQv1InN6faOHKAL2CchKOUwht+Fha5LEV8LrjBreikUq9MiIR631sEGs1QKb6/ivK2Gqm
        niCHF878oI4rpNKo7heekExFFyG42bwtnQug3/LmO95RYdnBk5TIpyKkM6Xvc5/R3WOaIh
        V9JD0l6xW3V9wvpPJ6jI+91qmBUb1eJ6DOWK+Kgb9jMSfA5Ngy62Ar1/9Plr808HIwWzer
        aumStgiM2krWtt2Aw8YXDyseMnlIX+Mvnufb7ghOslIbLJxABcpwkGKYbU0LoqpIzhINCa
        smGJ/cCQz7knPQ7ndQ9O1ahmu6hFOrhtNKxTgQXhF7hRoMa07zkg2+spW+DYnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619604889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkABMUrVTIed7Pud/pAOG8Jsv0xIjFbTnk9egvEwBMI=;
        b=Jiguxh1vcFNG8UMGL0S4K6oJHuaUIpNTvsL3X6FIfeBtw8j5D9I0uYFXrPPzL+/YSKNRfC
        GMlWQmo5LuFougAw==
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org, zhengjun.xing@intel.com
Subject: Re: [clocksource]  8c30ace35d: WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
In-Reply-To: <20210428014819.GA965980@paulmck-ThinkPad-P17-Gen-1>
References: <20210427175027.GA945820@paulmck-ThinkPad-P17-Gen-1> <87y2d3mo2q.ffs@nanos.tec.linutronix.de> <20210428014819.GA965980@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 28 Apr 2021 12:14:49 +0200
Message-ID: <87czuen2au.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2021 at 18:48, Paul E. McKenney wrote:
> On Tue, Apr 27, 2021 at 11:09:49PM +0200, Thomas Gleixner wrote:
>> Paul,
>> 
>> On Tue, Apr 27 2021 at 10:50, Paul E. McKenney wrote:
>> > On Tue, Apr 27, 2021 at 06:37:46AM -0700, Paul E. McKenney wrote:
>> >> I suppose that I give it (say) 120 seconds instead of the current 60,
>> >> which might be the right thing to do, but it does feel like papering
>> >> over a very real initramfs problem.  Alternatively, I could provide a
>> >> boot parameter allowing those with slow systems to adjust as needed.
>> >
>> > OK, it turns out that there are systems for which boot times in excess
>> > of one minute are expected behavior.  They are a bit rare, though.
>> > So what I will do is keep the 60-second default, add a boot parameter,
>> > and also add a comment by the warning pointing out the boot parameter.
>> 
>> Oh, no. This starts to become yet another duct tape horror show.
>> 
>> I'm not at all against a more robust and resilent watchdog mechanism,
>> but having a dozen knobs to tune and heuristics which are doomed to fail
>> is not a solution at all.
>
> One problem is that I did the .max_drift patch backwards.  I tightened
> the skew requirements on all clocks except those specially marked, and
> I should have done the reverse.  With that change, all of the clocks
> except for clocksource_tsc would work (or as the case might be, fail to
> work) in exactly the same way that they do today, but still rejecting
> false-positive skew events due to NMIs, SMIs, vCPU preemption, and so on.
>
> Then patch v10 7/7 can go away completely, and patch 6/7 becomes much
> smaller (and gets renamed), for example, as shown below.
>
> Does that help?

No. Because the problem is on both ends. We have TSC early which has
inaccurate frequency and we have watchdogs which are inaccurate,
i.e. refined jiffies.

So the threshold has to take both into account.

Thanks,

        tglx
