Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B7356A41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351524AbhDGKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:48:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351480AbhDGKq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:46:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B18CF1FB;
        Wed,  7 Apr 2021 03:46:38 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AEEA3F694;
        Wed,  7 Apr 2021 03:46:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: Re: [PATCH 7/9] sched,debug: Convert sysctl sched_domains to debugfs
In-Reply-To: <20210326103935.264012208@infradead.org>
References: <20210326103352.603456266@infradead.org> <20210326103935.264012208@infradead.org>
Date:   Wed, 07 Apr 2021 11:46:32 +0100
Message-ID: <87czv6nzhz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/21 11:33, Peter Zijlstra wrote:
> Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/debug.c    |  255 ++++++++++--------------------------------------
>  kernel/sched/sched.h    |    2
>  kernel/sched/topology.c |    1
>  3 files changed, 59 insertions(+), 199 deletions(-)
>

I do very much like to see a simple pair of seq_puts() replacing the
mess I put in there!

One comment below.

> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> +void register_sched_domain_sysctl(void)
> +{
> +	int cpu, i;
>
>       if (!cpumask_available(sd_sysctl_cpus)) {
>               if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>                       return;
> -	}
> -
> -	if (!init_done) {
> -		init_done = true;
> -		/* init to possible to not have holes in @cpu_entries */
>               cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>       }
>
> -	for_each_cpu(i, sd_sysctl_cpus) {
> -		struct ctl_table *e = cpu_idx[i];
> +	if (!sd_dentry)
> +		sd_dentry = debugfs_create_dir("domains", debugfs_sched);
>
> -		if (e->child)
> -			sd_free_ctl_entry(&e->child);
> +	for_each_cpu(cpu, sd_sysctl_cpus) {
> +		struct sched_domain *sd;
> +		struct dentry *d_cpu;
> +		char buf[32];
> +
> +		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> +		debugfs_remove(debugfs_lookup(buf, sd_dentry));
> +		d_cpu = debugfs_create_dir(buf, sd_dentry);
> +
> +		i = 0;
> +		for_each_domain(cpu, sd) {
> +			struct dentry *d_sd;
>
> -		if (!e->procname) {
> -			snprintf(buf, 32, "cpu%d", i);
> -			e->procname = kstrdup(buf, GFP_KERNEL);
> -		}
> -		e->mode = 0555;
> -		e->child = sd_alloc_ctl_cpu_table(i);
> +			snprintf(buf, sizeof(buf), "domain%d", i);
> +			d_sd = debugfs_create_dir(buf, d_cpu);
>
> -		__cpumask_clear_cpu(i, sd_sysctl_cpus);

That seems to be the only place we cleared a CPU in that cpumask, and I
don't see its replacement, which would go against:

  bbdacdfed2f5 ("sched/debug: Optimize sched_domain sysctl generation")

With my very limited understanding of debugfs and sysctl, it seems that
before we would have some stuff saved in sd_ctl_table and free/reinit just
the bits we needed. With debugfs_remove(), I think we wipe everything
clean, or did I read that wrong?
