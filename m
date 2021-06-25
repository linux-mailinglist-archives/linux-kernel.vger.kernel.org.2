Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAF43B3E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFYISB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFYISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D15C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rm+JBREWSoPp+eGQlwLQzs0H9esWidtlooHK2hgns4w=; b=XldmmK2DLpgAF4FpYtgEttHm7+
        YRsBDRNgJe4edQWG2iUNJh30O0fy019MerrqhWk7VWSMl7DpV4mG2VbStMkjbW6dvl+sDr0BpqVT3
        D8Mpkjuh24vGupzRwG/sAahuJ9x3IYBvBX4V6gVbmypY/7zPK/1CA6v9aiu0Kv7J/FCdfrABkOiK0
        EdqY8P82TLKTiEV9iHmz0mSR1MYHJglAzwMmMK8v7DWxs8Ab7rKqpavtm6cWV6uy39/OIP7vufCs7
        vHe/sCjOcXpCBgmPlE+TOdSfjWxnbQZtGh7mPlc5j1AwymXm5eARnH6me+TS0zG1QDMRqzUFglug8
        3557h4QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwgzG-00HS0n-3c; Fri, 25 Jun 2021 08:14:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2682300252;
        Fri, 25 Jun 2021 10:14:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EC2020171CE8; Fri, 25 Jun 2021 10:14:53 +0200 (CEST)
Date:   Fri, 25 Jun 2021 10:14:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNWQfZfMNyEsiKTb@hirez.programming.kicks-ass.net>
References: <20210608231132.32012-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608231132.32012-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 04:11:32PM -0700, Josh Don wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8ab69d01dab4..a82f5d3b85d3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10234,6 +10234,18 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
>  
>  	return sched_group_set_shares(css_tg(css), scale_load(weight));
>  }
> +
> +static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
> +			       struct cftype *cft)
> +{
> +	return css_tg(css)->idle;
> +}
> +
> +static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
> +				struct cftype *cft, s64 idle)
> +{
> +	return sched_group_set_idle(css_tg(css), idle);
> +}
>  #endif
>  
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
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	{

You should probably also make cpu_weight_*write_?64() return -EINVAL when
IDLE. Similar to how SCHED_IDLE doesn't do nice.

