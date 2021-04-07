Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA2356A42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbhDGKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:48:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351495AbhDGKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77DC4106F;
        Wed,  7 Apr 2021 03:46:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4533F694;
        Wed,  7 Apr 2021 03:46:45 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: Re: [PATCH 4/9] sched: Move SCHED_DEBUG to debugfs
In-Reply-To: <20210326103935.025550243@infradead.org>
References: <20210326103352.603456266@infradead.org> <20210326103935.025550243@infradead.org>
Date:   Wed, 07 Apr 2021 11:46:43 +0100
Message-ID: <87blaqnzho.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/21 11:33, Peter Zijlstra wrote:
>  __read_mostly bool sched_debug_enabled;
>  
> +struct dentry *debugfs_sched;
> +
>  static __init int sched_init_debug(void)
>  {
> -	debugfs_create_file("sched_features", 0644, NULL, NULL,
> -			&sched_feat_fops);
> +	struct dentry __maybe_unused *numa;
> +
> +	debugfs_sched = debugfs_create_dir("sched", NULL);
> +
> +	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
> +	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
> +

Could we kill this too? I'm probably biased because I've spent some amount
of time banging my head at topology problems, but this two-tiered debugging
setup (KCONFIG + cmdline or post-boot write) has always irked me.

I can't find the threads in a hurry, but ISTR justifications for keeping
this around were:
- Most distros have CONFIG_SCHED_DEBUG=y because knobs and ponies
- Topology debug prints are "too verbose"
- NUMA distance matrix processing gets slower

If we make it so distros stop / don't need to select CONFIG_SCHED_DEBUG,
then I don't think the above really stands anymore (also, sched_init_numa()
now has the same complexity regardless of sched_debug), and we could keep
everything under CONFIG_SCHED_DEBUG.
