Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062EB3241A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhBXQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbhBXPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:54:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE53C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1GQftM3uWmRhOrMJBKJCWIWOXHtZNY7YdAOBVUtpyO4=; b=vNzvwGSTnIQWojyLlnIhoVVEJC
        xSpv45Z+hXUdbYesOGmtSnIyuLYs8xZLQGSq7EkblncBvNXl8uxcWiKl3x2cZrvtEc+TLIHTM+Fz7
        owl6ghZSztNZYzsbeLFnY3+4xoqMqvTqxR9+OEa5mvGTakNI06+97lHoQCUtD7n/4WPGwRLeUWS9n
        kuVth3XqHgB0J3K9iS0w62E3q+wWTuH2bX9ieu+pK8NlgKzAiOOOYYti4eRo7BxoFUNsxz5Lx6uh6
        CKE9Db7X4Eppt4tXr6tWqGkwp1Dd/EdMFB/fgVjlxV5Br8AGB2y7n9akbb+gbHauDt8kq8/JZ50KK
        mkUcL87Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEwUA-00016l-JL; Wed, 24 Feb 2021 15:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2172C301A32;
        Wed, 24 Feb 2021 16:53:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1009F206D9577; Wed, 24 Feb 2021 16:53:54 +0100 (CET)
Date:   Wed, 24 Feb 2021 16:53:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com,
        fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
Message-ID: <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 02:30:00PM +0100, Vincent Guittot wrote:
> Joel reported long preempt and irq off sequence in newidle_balance because
> of a large number of CPU cgroups in use and having to be updated. This
> patchset moves the update outside newidle_imblance. This enables to early
> abort during the updates in case of pending irq as an example.
> 
> Instead of kicking a normal ILB that will wakes up CPU which is already
> idle, patch 6 triggers the update of statistics in the idle thread of
> the CPU before selecting and entering an idle state.

I'm confused... update_blocked_averages(), which calls
__update_blocked_fair(), which is the one doing the cgroup iteration
thing, runs with rq->lock held, and thus will have IRQs disabled any
which way around we turn this thing.

Or is the problem that we called nohz_idle_balance(), which does
update_nohz_stats() -> update_blocked_averages() for evey NOHZ cpu from
newidle balance, such that we get NR_NOHZ_CPUS * NR_CGROUPS IRQ latency?
Which is now reduced to just NR_CGROUPS ?
