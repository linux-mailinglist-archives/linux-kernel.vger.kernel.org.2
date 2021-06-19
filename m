Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178A3AD88F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhFSIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 04:04:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9041C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 01:02:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624089751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWvtqV3TeC0Tm9I9yeacEOChKZjCO9EBxWKvJ6avhNw=;
        b=WN+yU7SZfehMCpp5CyrAKTgEbZFRLGsjXfQxUkoAWyInqm8DsQeQC3MJN4gp55taVfAGfD
        /ligzhR/EAcTO/c2XIPhOBptyhO2BuP7vciH8pZi+c3rITz3VqLWJ5+Up3l/+qmX1+kmMt
        7KZ5kJqmOeVOlMFl0Dm9KteOkfiSkbYPlJbklD29gq5JBr5Z66t06WP763Lyw53kTfG7eZ
        TW6lhAY2Ww8p5g6I+u460VQjXpUyImf88ZQAKkXnH+28P+DoRE4U8ruDWCI7qjbx67+CuN
        Pw1/NKIG7PaiqdE7+eaQbmt258y/rHM2IJ9aHFpmSy/4XoLFt+oIQYM+LWSF/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624089751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWvtqV3TeC0Tm9I9yeacEOChKZjCO9EBxWKvJ6avhNw=;
        b=WiVq9cJx5k1pZtlSGE6et5TvC+8fnv6Midr36zeiiKVwvhBDR1JF1LMHA209djPQ6B6m+2
        gbaiYj3m29HHyEBg==
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] Add missing kernel log when enabling NO_HZ_FULL is not possible
In-Reply-To: <20210611103937.827565-1-ani@anisinha.ca>
References: <20210611103937.827565-1-ani@anisinha.ca>
Date:   Sat, 19 Jun 2021 10:02:30 +0200
Message-ID: <878s36e0yx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ani,

On Fri, Jun 11 2021 at 16:09, Ani Sinha wrote:
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 828b091501ca..a82480c036e2 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -937,10 +937,18 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
>  		return;
>  
> -	if (can_stop_full_tick(cpu, ts))
> +	if (can_stop_full_tick(cpu, ts)) {
>  		tick_nohz_stop_sched_tick(ts, cpu);
> -	else if (ts->tick_stopped)
> -		tick_nohz_restart_sched_tick(ts, ktime_get());
> +	} else {
> +		/*
> +		 * Don't allow the user to think they can get
> +		 * full NO_HZ with this machine.
> +		 */
> +		WARN_ONCE(tick_nohz_full_running,
> +			  "NO_HZ_FULL will not work with current sched clock");

How is that warning useful and even remotely correct?

can_stop_full_tick() has 4 x 5 == 20 ways to return false and the
smaller portion of them is related to sched clock.

Thanks,

        tglx
