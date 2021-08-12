Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494CB3EA931
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhHLRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhHLRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:12:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:11:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628788315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4G/CDaKl4xD5/KukuYOsU/+e61W8kEpp2VUM1xeZ+U=;
        b=SU+yPaIm8pao6osRILEewSy983GXgWJ8cju0IrgA7RhDtWvoUTowU7Xd4M5hErXEdsRVx+
        fuYv46CEh/bmST0biZnPnnzBwrQ4aKFXXl4WN7gNKvHOp6N78RCrkmFZqg1XQ/cGXqaPGt
        FdiUug1Br+1rrLE9n/NMICy/4ZwBxjHfyOPbOtstUG7cbD1Wmlb45pPysYiM4peRTRmrpO
        MhkZ+7hYdSNGm2hLrao4Ir0i3iSJ0LLcRPPmWO5ZYLkRhAFVmgFu1V8oIZtwSCB83l3beF
        Ngxb99RovepDXmGkVfLtPoIYBjd5+fTXHJ+2rKYUMSAc+8uJS1UeBByfNn/9LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628788315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4G/CDaKl4xD5/KukuYOsU/+e61W8kEpp2VUM1xeZ+U=;
        b=rmIbcCPhV9thsl05FgEWEnq/rkMdqDNm8OUnjMKiUpD+d7j6ECd67Ys0mDfoo+Nqh31M7K
        9CFyE34Lra/Me1Bg==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v5.15
In-Reply-To: <20210812163753.GW4126399@paulmck-ThinkPad-P17-Gen-1>
References: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
 <87czqiixml.ffs@tglx>
 <20210812163753.GW4126399@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 12 Aug 2021 19:11:55 +0200
Message-ID: <87mtpmh9k4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2021 at 09:37, Paul E. McKenney wrote:

> On Thu, Aug 12, 2021 at 03:46:42PM +0200, Thomas Gleixner wrote:
>> On Wed, Aug 11 2021 at 17:01, Paul E. McKenney wrote:
>> > This pull request contains a single change that prevents clocksource
>> > watchdog testing on systems with HZ < 100, thus preventing the integer
>> > underflow that can occur on leisurely HZed systems.  This has been
>> > posted to LKML:
>> >
>> > https://lore.kernel.org/lkml/20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1/
>> 
>> So with HZ < 100 .mult overflows, but why not simply adjusting the
>> mult, shift value to be
>> 
>>       .mult	= TICK_NSEC,
>>       .shift	= 0,
>> 
>> which is effectively the same as
>> 
>>       .mult	= TICK_NSEC << 8,
>>       .shift	= 8,
>> 
>> Hmm?
>
> Another option would be for me to be less lazy and to move this code:
>
> 	/* Since jiffies uses a simple TICK_NSEC multiplier
> 	 * conversion, the .shift value could be zero. However
> 	 * this would make NTP adjustments impossible as they are
> 	 * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
> 	 * shift both the nominator and denominator the same
> 	 * amount, and give ntp adjustments in units of 1/2^8
> 	 *
> 	 * The value 8 is somewhat carefully chosen, as anything
> 	 * larger can result in overflows. TICK_NSEC grows as HZ
> 	 * shrinks, so values greater than 8 overflow 32bits when
> 	 * HZ=100.
> 	 */
> 	#if HZ < 34
> 	#define JIFFIES_SHIFT	6
> 	#elif HZ < 67
> 	#define JIFFIES_SHIFT	7
> 	#else
> 	#define JIFFIES_SHIFT	8
> 	#endif
>
> from kernel/time/jiffies.c to include/linux/clocksource.h.

No need to expose this globaly.

  kernel/time/tick-internal.h or kernel/time/jiffies.h

Thanks,

        tglx
