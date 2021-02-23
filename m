Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C84322E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhBWPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:53:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBWPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:53:50 -0500
Date:   Tue, 23 Feb 2021 16:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614095586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdPkaGu/+ThstX9yrUETpgD9nTNh0tbgydH52n/sVWs=;
        b=N/vH6xnMkb4DfuaztniAXDqlJfcVpFYCDAsjAD2opYWKqCyG5g/m/20tTce9qK2kbxszQd
        NCt/3GZk35gI2ThFMMwaAAVcfQld0OcshiQI109A41fyig7jwOocCsi1zjDpCpOnXfPkHL
        RRYxMhItZSCPecVtbC3cRv5ilDLq31XKzR7rzY7lmFKX717hqwyrvhAmL6vjASfpAcvRZE
        8nXYynNzpjRIyHbM4DreVqO9KVfHeYfV5Rx5ZD5G6Dz061PDXvcJsJpBhNg4TN3e4UAD9F
        78Pnza7va73WjiTpzAHHuin/KeSXi+wOaLIMnik374BJaWmqWj7E2Z9ySEpJ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614095586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdPkaGu/+ThstX9yrUETpgD9nTNh0tbgydH52n/sVWs=;
        b=YVDtCKet8J0YZ6HqX0RFZLxdTox/nhP4cJ7xHZTWuZ1W+S8qk+gGVXMWEOBsTzL1P51k1d
        /gb5134UW3vqU7Bg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Beckius, Mikael" <mikael.beckius@windriver.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Sv: [PATCH] hrtimer: Interrupt storm on clock_settime
In-Reply-To: <PH0PR11MB4904A4830FED08F91CA97C04928B9@PH0PR11MB4904.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2102231638540.1861@somnus>
References: <20210128140208.30264-1-mikael.beckius@windriver.com> <87r1lu8qmx.fsf@nanos.tec.linutronix.de>  <PH0PR11MB4904A4830FED08F91CA97C04928B9@PH0PR11MB4904.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micke,

On Fri, 12 Feb 2021, Beckius, Mikael wrote:

> Thanks for the update and sorry for the late reply. After long-term
> testing of the patch, storm detection improved, it turns out that a
> similar problem can occur if hrtimer_interrupt runs during
> clock_settime. In this case it seems the offset can get updated and later
> read using hrtimer_update_base in hrtimer_interrupt before
> softirq_expires_next gets updated. As soon as softirq_expires_next gets
> updated by hrtimer_force_reprogram the storm ends. To fix this I made the
> below changes.
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -529,8 +529,10 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
>  			if (exclude)
>  				continue;
>  
> -			if (timer->is_soft)
> +			if (timer->is_soft) {
>  				cpu_base->softirq_next_timer = timer;
> +				cpu_base->softirq_expires_next = expires;
> +			}
>  			else
>  				cpu_base->next_timer = timer;
>  		}
> @@ -633,19 +635,6 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
>  	 */
>  	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
>  
> -	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
> -		/*
> -		 * When the softirq is activated, hrtimer has to be
> -		 * programmed with the first hard hrtimer because soft
> -		 * timer interrupt could occur too late.
> -		 */
> -		if (cpu_base->softirq_activated)
> -			expires_next = __hrtimer_get_next_event(cpu_base,
> -								HRTIMER_ACTIVE_HARD);
> -		else
> -			cpu_base->softirq_expires_next = expires_next;
> -	}
> -
>  	if (skip_equal && expires_next == cpu_base->expires_next)
>  		return;
>  
> --
> 

The proposed change breaks the reprogramming logic. To keep it working
cpu_base::*expires_next is only updated by hrtimer_reprogram() and
hrtimer_interrupt(). I will send you a patch for testing in reply to this
thread. The patch is compile tested only.

Thanks,

	Anna-Maria

