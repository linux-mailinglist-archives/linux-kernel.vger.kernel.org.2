Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CD435E58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhJUJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:54:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhJUJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:54:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 43E951FDAB;
        Thu, 21 Oct 2021 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KdzeFJeckjZ6yg7SNE2atCwcXrvZ+9D6Kkun4PyhMw=;
        b=OLL+l1PTXYcqexoy527+i4/+9ZBLzkPHE8c0zz9Xn3+AVE0RuppEGbyCLcqHIanO16oaHi
        cgbdj++h604NBNAJ2iawRw4jlQiyg5T0NbJZ/dnO/S03hxsQjwn06gWj+3qBBhewHZpW68
        j+Ozi4Mn9hBzQjOwIzXf8JiMXulFEJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KdzeFJeckjZ6yg7SNE2atCwcXrvZ+9D6Kkun4PyhMw=;
        b=KL7NCxZ1SqsZIVX62AdPwebp6z7XSG46MTENM8dxX4ziacOCrCxq1H6RDO5hOJ+Wpwur54
        SGT3h+nqRLRN5fBg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 54B03A3B87;
        Thu, 21 Oct 2021 09:52:21 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:52:19 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
Message-ID: <20211021095219.GG3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:35:32PM +0200, Vincent Guittot wrote:
> This patchset updates newidle lb cost tracking and early abort:
> 
> The time spent running update_blocked_averages is now accounted in the 1st
> sched_domain level. This time can be significant and move the cost of
> newidle lb above the avg_idle time.
> 
> The decay of max_newidle_lb_cost is modified to start only when the field
> has not been updated for a while. Recent update will not be decayed
> immediatlybut only after a while.
> 
> The condition of an avg_idle lower than sysctl_sched_migration_cost has
> been removed as the 500us value is quite large and prevent opportunity to
> pull task on the newly idle CPU for at least 1st domain levels.
> 
> Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> following results:
>        min    avg   max
> SMT:   1us   33us  273us - this one includes the update of blocked load
> MC:    7us   49us  398us
> NUMA: 10us   45us  158us
> 
> 
> Some results for hackbench -l $LOOPS -g $group :
> group      tip/sched/core     + this patchset
> 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> 

I read the patches earlier but had queued tests and waiting on the results
before Acking. The hackbench results were not bad, not a universal win,
but wins more than it loses with small decreaseds in system CPU usage.

Most other results showed small gains or losses, nothing overly dramatic
and mostly within the noise.

-- 
Mel Gorman
SUSE Labs
