Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9603F720E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhHYJl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:41:27 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34606 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235365AbhHYJl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:41:26 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 05:41:25 EDT
Received: by gentwo.de (Postfix, from userid 1001)
        id C21F2B0021C; Wed, 25 Aug 2021 11:30:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C16DDB00125;
        Wed, 25 Aug 2021 11:30:43 +0200 (CEST)
Date:   Wed, 25 Aug 2021 11:30:43 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 8/8] mm: vmstat_refresh: avoid queueing work item if
 cpu stats are clean
In-Reply-To: <20210824152646.948424573@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2108251121260.317297@gentwo.de>
References: <20210824152423.300346181@fuller.cnet> <20210824152646.948424573@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021, Marcelo Tosatti wrote:

> It is not necessary to queue work item to run refresh_vm_stats
> on a remote CPU if that CPU has no dirty stats and no per-CPU
> allocations for remote nodes.

The issue in the past was whether the effort to check is adding overhead
that is comparable to run refresh_vm_stats. YMMV.

> This fixes sosreport hang (which uses vmstat_refresh) with
> spinning SCHED_FIFO process.

Ughhh.. SCHED_FIFO is evil....

>  #ifdef CONFIG_PROC_FS
> +static bool need_drain_remote_zones(int cpu)

Well this is not related to vm stats but per cpu pages of the page
allocator. Maybe call this need_drain_remote_pcp or something?

> @@ -1860,8 +1885,12 @@ int vmstat_refresh(struct ctl_table *tab
>  		   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	long val;
> -	int err;
> -	int i;
> +	int i, cpu;
> +	struct work_struct __percpu *works;
> +
> +	works = alloc_percpu(struct work_struct);

Do malloc instead? Using the percpu allocator frequently in a function to
allocator temporary variables can cause needless fragmentation there. The
percpu allocator does not have the frag management features of the slab
allocators.

