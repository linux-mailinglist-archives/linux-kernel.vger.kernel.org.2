Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE50D35AC12
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhDJJAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhDJJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:00:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E955C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:00:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618045225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+/GW+doMP+ZUoby3IgRk5oiBZHG2e9j2Ouuhj75vmE=;
        b=k0jKk2kHNeV8oDnCdBXd5LA3IAFCNPTj0VVB0Hgha1HlEejrKT1ucvRkgAdQvtV9t+c/fu
        EIiEOhyqk7IudE1N1ajWuvF84a1ERNm+36Gg92IHnrCLZIUy+t70wBafHzuewI/UXhx31l
        /YloGduqTfrSqL9JN2wvt9fBI+umeC5Ng+LShg3JzCNQ3fwtWZ25PlOzEB5X7+LkxvLW/q
        DBwBDoClrWs3LQaywrA2fweB5VAVuI/FgNwwwUy23udmh6v39GnJ+mziOx87z0oUzFX3fF
        JWVzgqC3MBNpWNA2OFo6flNE0MjWRD3biCy7m3i8YIv7XfPWiPD463J7S2kN1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618045225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+/GW+doMP+ZUoby3IgRk5oiBZHG2e9j2Ouuhj75vmE=;
        b=TYtzMsud4cCoYOq3feJbje1n12AjX0IKzGtpCvf7zAa3sVtU12SotY9Bx6vdJsnOeE06bY
        BX17l/swPmXL5zBw==
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210402224906.3912-3-paulmck@kernel.org>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-3-paulmck@kernel.org>
Date:   Sat, 10 Apr 2021 11:00:25 +0200
Message-ID: <87blam4iqe.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2021 at 15:49, paulmck wrote:
>
> +static void clocksource_verify_percpu_wq(struct work_struct *unused)
> +{
> +	int cpu;
> +	struct clocksource *cs;
> +	int64_t cs_nsec;
> +	u64 csnow_begin;
> +	u64 csnow_end;
> +	u64 delta;

Please use reverse fir tree ordering and stick variables of the same
type together:

	u64 csnow_begin, csnow_end, delta;
	struct clocksource *cs;
	s64 cs_nsec;
        int cpu;
> +
> +	cs = smp_load_acquire(&clocksource_verify_work_cs); // pairs with release

Please don't use tail comments. They are a horrible distraction.

> +	if (WARN_ON_ONCE(!cs))
> +		return;
> +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
> +		cs->name, smp_processor_id());
> +	cpumask_clear(&cpus_ahead);
> +	cpumask_clear(&cpus_behind);
> +	csnow_begin = cs->read(cs);

So this is invoked via work and the actual clocksource change is done
via work too. Once the clocksource is not longer actively used for
timekeeping it can go away. What's guaranteeing that this runs prior to
the clocksource change and 'cs' is valid throughout this function?

> +	queue_work(system_highpri_wq, &clocksource_verify_work);

This does not guarantee anything. So why does this need an extra work
function which is scheduled seperately?

Thanks,

        tglx
