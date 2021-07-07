Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B693BE678
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhGGKqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhGGKqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:46:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A697C61C99;
        Wed,  7 Jul 2021 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625654636;
        bh=v/Id4xESUyVn7Okazo3/CpOE9/KzPJJ/ubAqgJSHNVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUrNlD26Mo/6gf8K9+HTJEKFhaupnbQ1PtnmcoSrUK7gqJXzmyQefbHDeFDw3Nkry
         tKURG69432uWPoJEWfV/+QUuDL+Sm/qKB0gVVN8vabMu3gvilTxG7/bls7btf3QRi/
         NHs+JmFt0pyvSTQMyUZ/gYIHUfBGtv0eTRb2PQo/PXG0YO6CY7dayvP9x2aBIaSemx
         Iea4YH6oKrd7A2szHKMTrpHGbGiznjcYzxRQJXPvCaw0SfoN8/y2iXPz6g8UlgNDAF
         eR9rQ9saUaw7gxNMpsoEwiegPF5+xHegmUqabsyXLKNTz7XYAOrRMLZLcKR/gQAdKa
         h1pWacd94A5sg==
Date:   Wed, 7 Jul 2021 12:43:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1] Add info log when user enables NOHZ in commandline
 but NOHZ is not possible
Message-ID: <20210707104353.GA115752@lothringen>
References: <20210627072833.2199463-1-ani@anisinha.ca>
 <87zguypgy8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zguypgy8.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 12:16:15PM +0200, Thomas Gleixner wrote:
> Ani,
> 
> On Sun, Jun 27 2021 at 12:58, Ani Sinha wrote:
> 
> same comment vs. Subject, 'this patch' and 'we'
> 
> > @@ -930,6 +930,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
> >  {
> >  #ifdef CONFIG_NO_HZ_FULL
> >  	int cpu = smp_processor_id();
> > +	static bool no_tick_warned;
> >  
> >  	if (!tick_nohz_full_cpu(cpu))
> >  		return;
> > @@ -937,10 +938,24 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
> >  	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
> >  		return;
> >  
> > -	if (can_stop_full_tick(cpu, ts))
> > +	if (can_stop_full_tick(cpu, ts)) {
> >  		tick_nohz_stop_sched_tick(ts, cpu);
> > -	else if (ts->tick_stopped)
> > -		tick_nohz_restart_sched_tick(ts, ktime_get());
> > +		if (no_tick_warned) {
> > +			pr_info("NO_HZ_FULL is now enabled in the system.\n");
> > +			no_tick_warned = false;
> > +		}
> > +	} else {
> > +		/*
> > +		 * Don't allow the user to think they can get
> > +		 * full NO_HZ with this machine.
> > +		 */
> > +		if (!no_tick_warned && tick_nohz_full_running) {
> > +			pr_info("NO_HZ_FULL has been disabled in the system.");
> > +			no_tick_warned = true;
> > +		}
> 
> So this is going to emit this message everytime the NOHZ state of a CPU
> changes, which is an easy to trigger dmesg flooding from unpriviledged
> user space.
> 
> Also the message is misleading because this is a per CPU condition and
> not a system wide condition.

IIUC, the clock can be marked unstable anytime before or after nohz_full
is initialized.

So we can do two things:

* If tick_nohz_init() is called after the clock has been marked unstable,
  just don't initialize nohz_full.

* If the clock is marked unstable after tick_nohz_init(), issue a pr_warn()
  from __clear_sched_clock_stable().

Thanks.
