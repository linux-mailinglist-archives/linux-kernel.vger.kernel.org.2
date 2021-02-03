Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE130D0DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhBCBdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhBCBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:32:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C3C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FpAGtackMWEK1uTNTUP6msdkodxiPqYKgySXOgF1/uc=; b=KK7OgtjiVR5HtJaPhlw1Ok8OeH
        OTMJjiCS/n+mcCxJjwyN0655vYjigCT8yL2R/9/cKCgt/LERPLB69f3NVZoMzZtqDwTlBxRKJs7P0
        8VAXKjrYizl4EkeyaZVYb240JSMvkJ+s4YHNR9OmGmISN5w7/rVSPt3zN+EM3VflrzMaeZN2Pn7DV
        IX1BbcQJILN+jA1mIjncDqVzDWDEwSNw/d4e+hcHxE8do6SEHVoPcyTt84dqkocApcySbbJ+V2kb5
        XUyurechMYu2gVyQTOpxxcrrWb1SUEDPeQP/XWcXXVUPNKGvac4Xath4fs8bpt53yaNagMJ7SP5Wl
        EOHxQKpQ==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l771V-0001MK-Sy; Wed, 03 Feb 2021 01:32:02 +0000
Subject: Re: [PATCH clocksource 4/5] clocksource: Provide a module parameter
 to fuzz per-CPU clock checking
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        ak@linux.intel.com, clm@fb.com
References: <20210202170437.GA23593@paulmck-ThinkPad-P72>
 <20210202170635.24839-4-paulmck@kernel.org>
 <5badf6e2-4600-4fe9-6b45-d0de94ad718b@infradead.org>
 <20210203005020.GI2743@paulmck-ThinkPad-P72>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b878262a-4c98-91bd-eb88-456a869dc9e1@infradead.org>
Date:   Tue, 2 Feb 2021 17:31:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203005020.GI2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 4:50 PM, Paul E. McKenney wrote:
> On Tue, Feb 02, 2021 at 11:51:02AM -0800, Randy Dunlap wrote:
>> On 2/2/21 9:06 AM, paulmck@kernel.org wrote:
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>
>>> Code that checks for clock desynchronization must itself be tested, so
>>> this commit creates a new clocksource.inject_delay_shift_percpu= kernel
>>> boot parameter that adds or subtracts a large value from the check read,
>>> using the specified bit of the CPU ID to determine whether to add or
>>> to subtract.
>>>
>>> Cc: John Stultz <john.stultz@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Mark Rutland <Mark.Rutland@arm.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Reported-by: Chris Mason <clm@fb.com>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>>>  kernel/time/clocksource.c                       | 10 +++++++++-
>>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 9965266..f561e94 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -593,6 +593,15 @@
>>>  			times the value specified for inject_delay_freq
>>>  			of consecutive non-delays.
>>>  
>>> +	clocksource.inject_delay_shift_percpu= [KNL]
>>> +			Shift count to obtain bit from CPU number to
>>> +			determine whether to shift the time of the per-CPU
>>> +			clock under test ahead or behind.  For example,
>>
>> It's a good think that you give an example -- it helps a little bit.
>> That sentence above needs to be rewritten...
> 
> That is a bit obscure, now that you mention it.
> 
>>> +			setting this to the value four will result in
>>> +			alternating groups of 16 CPUs shifting ahead and
>>> +			the rest of the CPUs shifting behind.  The default
>>> +			value of -1 disable this type of error injection.
>>
>> 			            disables
> 
> Good eyes!
> 
> So how about like this?

Much better, thanks.

> 	clocksource.inject_delay_shift_percpu= [KNL]
> 			Clocksource delay injection partitions the CPUs
> 			into two sets, one whose clocks are moved ahead
> 			and the other whose clocks are moved behind.
> 			This kernel parameter selects the CPU-number
> 			bit that determines which of these two sets the
> 			corresponding CPU is placed into.  For example,
> 			setting this parameter to the value four will

I know that in "writing," "four" should be written out as you have it,
but IMO using "4" here would be much better.  FWIW.

> 			result in the first set containing alternating
> 			groups of 16 CPUs whose clocks are moved ahead,
> 			while the second set will contain the rest of
> 			the CPUs, whose clocks are moved behind.
> 
> 			The default value of -1 disables this type of
> 			error injection.
> 
> 							Thanx, Paul
> 
>>> +
>>>  	clocksource.max_read_retries= [KNL]
>>>  			Number of clocksource_watchdog() retries due to
>>>  			external delays before the clock will be marked


thanks!
-- 
~Randy

