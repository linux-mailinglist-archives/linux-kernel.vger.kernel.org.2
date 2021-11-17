Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512B3454B71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhKQQ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232779AbhKQQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:57:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F1B561BFB;
        Wed, 17 Nov 2021 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637168066;
        bh=dg9zhVNHN1R/RjF64bghFhclSKy5zbJoew+7s3pcIJk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SSHQkb9bq1rOz4UcLDo1NKPxXrtg2PqzDyM86D/TnPa8Ah7vdWWKIM45HdMfFZhA6
         0lqjJovSHyXqEcmYF7RaVfU1/946Tzg3xwAuceZaisrIzxRsAsO6rIeQ47/7nk+YwT
         KILTYcjFoaMPbZ/LlEB+Uo+oPr6DTLIzKgRnva4fMIkxuAdah7aK4rHrfnR0Q4bWSC
         FQwEk7iMT0bxg24ou5Nj6iC9QTDzt/HuV2Q96MBWVorZDbORN7ar333g/ZJzQjJruU
         dLTuuE/Au0iu1IyFdbeMv16jp1fTzFJuB5TXvCzjiNgI/20E9CmViCCvXvj7qzVUWo
         ixP2Kjg5QMoWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CA925C04B0; Wed, 17 Nov 2021 08:54:26 -0800 (PST)
Date:   Wed, 17 Nov 2021 08:54:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 0/4] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211117165426.GG641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211116234426.837799-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116234426.837799-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 06:44:22PM -0500, Waiman Long wrote:
> It was found that when an x86 system was being stressed by running
> various different benchmark suites, the clocksource watchdog might
> occasionally mark TSC as unstable and fall back to hpet which will
> have a signficant impact on system performance.
> 
> The current watchdog clocksource skew threshold of 50us is found to be
> insufficient. So it is changed back to 100us before commit 2e27e793e280
> ("clocksource: Reduce clocksource-skew threshold") in patch 1. This
> patch also skip the current clock skew check if the consecutive watchdog
> read-back delay contributes a major portion of the total delay. On a
> 1-socket 64-thread test system, it was actually found that in one the
> test sample, the hpet-tsc-hpet delay was 95263ns, while the corresponding
> hpet-hpet delay was 94425ns. So the majority of the delay is caused by
> the hpet read.
> 
> Patch 2 reduces the default clocksource_watchdog() retries to 2 as
> suggested by Paul.
> 
> Patch 3 implements dynamic readjustment of the new internal
> watchdog_max_skew variable in case the current value causes excessive
> skipping of clock skew checks. The following reproducer provided by
> Feng Tang was used to cause the test skipping:
> 
>   sudo stress-ng --timeout 30 --times --verify --metrics-brief --ioport <n>
> 
> where <n> is the number of cpus in the system.
> 
> A sample watchdog_max_skew readjustment output was:
> 
> [  197.771144] clocksource: timekeeping watchdog on CPU8: hpet wd-wd read-back delay of 92539ns
> [  197.789589] clocksource: wd-tsc-wd read-back delay of 90933ns, clock-skew test skipped!
> [  197.807145] clocksource: timekeeping watchdog on CPU8: watchdog_max_skew increased to 185078ns
> 
> To avoid excessive increase of watchdog_max_skew, a limit of
> 10*WATCHDOG_MAX_SKEW is used over which the watchdog itself will be
> mark unstable and a new watchdog will be selected if possible.
> 
> To exercise the code, WATCHDOG_MAX_SKEW was reduced to 10us. After
> skipping 10 checks, the watchdog then fell back to acpi_pm. However
> the corresponding consecutive watchdog delay was still about the same
> leading to ping-ponging between hpet and acpi_pm becoming the watchdog.
> 
> Patch 4 adds a Kconfig option to allow kernel builder to control the
> actual WATCHDOG_MAX_SKEW threshold to be used.

A few questions:

1.	Once you have all the patches in place, is the increase in
	WATCHDOG_MAX_SKEW from 50us to 100us necessary?

2.	The reason for having cs->uncertainty_margin set to
	2*WATCHDOG_MAX_SKEW was to allow for worst-case skew from both
	the previous and the current reading.  Are you sure that
	dropping back to WATCHDOG_MAX_SKEW avoids false positives?

3.	In patch 3/4, shouldn't clock_skew_skip be a field in the
	clocksource structure rather than a global?  If a system had
	multiple clocks being checked, wouldn't having this as a field
	make things more predictable?  Or am I missing something subtle
	here?

4.	These are intended to replace this commit in -rcu, correct?

	9d5739316f36 ("clocksource: Forgive repeated long-latency watchdog clocksource reads")

	But not this commit, correct?

	5444fb39fd49 ("torture: Test splatting for delay-ridden clocksources")

And would you like me to queue these, or would you rather send them
separately?  (Either way works for me, just please let me know.)

							Thanx, Paul

> Waiman Long (4):
>   clocksource: Avoid accidental unstable marking of clocksources
>   clocksource: Reduce the default clocksource_watchdog() retries to 2
>   clocksource: Dynamically increase watchdog_max_skew
>   clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> 
>  .../admin-guide/kernel-parameters.txt         |   4 +-
>  kernel/time/Kconfig                           |   9 ++
>  kernel/time/clocksource.c                     | 121 +++++++++++++++---
>  3 files changed, 114 insertions(+), 20 deletions(-)
> 
> -- 
> 2.27.0
> 
