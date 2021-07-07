Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59A3BE63E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhGGKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGGKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA55C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:16:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625652975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yI5gUfx6XT+UMHg1mPkzTcXOlYkcjXyjWq3ym/V5c7Q=;
        b=Op1D2K+IaC/UG/R85rlWC5uqa41yvoR1oiqi4dC2E0ZAmvmg8iid42iDFYIFVhENYGEbaU
        hLgeZzi9f1pNyDv/lOuAw9dGmZ/roAElXQZ5VY6yBf0jI5SV/XSxHLbFF7IRzwGklNNZsL
        oPWeSWYX+FcSXvYAdw/YpULhYB1IWPexpoJX9Qx/1x4cjUATLnFhk6pGBjueQ3DfAxl6Qz
        2PO6VCVXce2tgODKUcxiXdu1708c7j+RDYWW8DilQ2cqswespk8a1H2ccrWDtJYcbunuWW
        ePuotkWq44gNvB9iEdlPoijERKboHIjXobFer69MAJzZS8NCxBsJgFTy8g5bBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625652975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yI5gUfx6XT+UMHg1mPkzTcXOlYkcjXyjWq3ym/V5c7Q=;
        b=dUDBVcyfKGYQKdORiBKlWQ83Z1RgEIm1W9TdMaFG1/NZsejqSw3oLp3Iklxt02BuyGTzIf
        6UehoU/xBA41ePDQ==
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1] Add info log when user enables NOHZ in commandline but NOHZ is not possible
In-Reply-To: <20210627072833.2199463-1-ani@anisinha.ca>
References: <20210627072833.2199463-1-ani@anisinha.ca>
Date:   Wed, 07 Jul 2021 12:16:15 +0200
Message-ID: <87zguypgy8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ani,

On Sun, Jun 27 2021 at 12:58, Ani Sinha wrote:

same comment vs. Subject, 'this patch' and 'we'

> @@ -930,6 +930,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  {
>  #ifdef CONFIG_NO_HZ_FULL
>  	int cpu = smp_processor_id();
> +	static bool no_tick_warned;
>  
>  	if (!tick_nohz_full_cpu(cpu))
>  		return;
> @@ -937,10 +938,24 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
>  		return;
>  
> -	if (can_stop_full_tick(cpu, ts))
> +	if (can_stop_full_tick(cpu, ts)) {
>  		tick_nohz_stop_sched_tick(ts, cpu);
> -	else if (ts->tick_stopped)
> -		tick_nohz_restart_sched_tick(ts, ktime_get());
> +		if (no_tick_warned) {
> +			pr_info("NO_HZ_FULL is now enabled in the system.\n");
> +			no_tick_warned = false;
> +		}
> +	} else {
> +		/*
> +		 * Don't allow the user to think they can get
> +		 * full NO_HZ with this machine.
> +		 */
> +		if (!no_tick_warned && tick_nohz_full_running) {
> +			pr_info("NO_HZ_FULL has been disabled in the system.");
> +			no_tick_warned = true;
> +		}

So this is going to emit this message everytime the NOHZ state of a CPU
changes, which is an easy to trigger dmesg flooding from unpriviledged
user space.

Also the message is misleading because this is a per CPU condition and
not a system wide condition.

Thanks,

        tglx
