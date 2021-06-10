Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91C3A2C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFJMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:55:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhFJMzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:55:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6309C106F;
        Thu, 10 Jun 2021 05:53:56 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4FA3F73D;
        Thu, 10 Jun 2021 05:53:53 -0700 (PDT)
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20210608231132.32012-1-joshdon@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
Date:   Thu, 10 Jun 2021 14:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608231132.32012-1-joshdon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 09/06/2021 01:11, Josh Don wrote:

[...]

>  static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
> @@ -10306,6 +10318,12 @@ static struct cftype cpu_files[] = {
>  		.read_s64 = cpu_weight_nice_read_s64,
>  		.write_s64 = cpu_weight_nice_write_s64,
>  	},
> +	{
> +		.name = "idle",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_s64 = cpu_idle_read_s64,
> +		.write_s64 = cpu_idle_write_s64,
> +	},

Any reason why this should only work on cgroup-v2?

struct cftype cpu_legacy_files[] vs. cpu_files[]

[...]

> @@ -11340,10 +11408,14 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  
>  static DEFINE_MUTEX(shares_mutex);
>  
> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +#define IDLE_WEIGHT sched_prio_to_weight[ARRAY_SIZE(sched_prio_to_weight) - 1]

Why not 3 ? Like for tasks (WEIGHT_IDLEPRIO)?

[...]
