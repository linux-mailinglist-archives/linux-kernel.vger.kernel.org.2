Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559143CD659
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhGSNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239523AbhGSNeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3776A610F7;
        Mon, 19 Jul 2021 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626704082;
        bh=ookbA+FJuWU4YrtkmeJnfaixLuo6C5hpoUjpurIo/F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UW5iH6GZ3N8V86drZ2nZJsmzU04m+FWNWoJ6SA+xk4Vllz3d9zYxMdE/2xWnHN7U/
         VI90iBfHueoZJz46xWfLJrIpuXi/cmGysEJ1SGoERJfeDa0xhH2EM7rxqcsdhFFcKp
         2CsDh/mX+knpPCeZcuDf38gRXCvNQlrTO58Z7xsAEz3Q89lV2m8lW5ivLVWQpurfyL
         nZkkji6+2XMOfy7IotdTWF8VW3OpzGMvIVVZoAMvCBaqa6sRB3AJ22BFwV30kRFPIY
         ESqjRnpa5RmZHkyHgNpdGRJFlPJsTiWj4PH/PMSpY3cvZ1aLNhzcJdqCTbcp7qgb6n
         SxYtbwJUK7feA==
Date:   Mon, 19 Jul 2021 16:14:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>
Subject: Re: [patch 1/5] sched: isolation: introduce
 quiesce_on_exit_to_usermode isolcpu flags
Message-ID: <20210719141440.GE116346@lothringen>
References: <20210714204205.245522189@fuller.cnet>
 <20210714204233.648529431@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714204233.648529431@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:42:06PM -0300, Marcelo Tosatti wrote:
> Add a new isolcpus flag "quiesce_on_exit_to_usermode" to enable
> quiescing of deferred actions on return to userspace.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-2.6-vmstat-update/include/linux/sched/isolation.h
> ===================================================================
> --- linux-2.6-vmstat-update.orig/include/linux/sched/isolation.h
> +++ linux-2.6-vmstat-update/include/linux/sched/isolation.h
> Index: linux-2.6-vmstat-update/Documentation/admin-guide/kernel-parameters.txt
> ===================================================================
> --- linux-2.6-vmstat-update.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-2.6-vmstat-update/Documentation/admin-guide/kernel-parameters.txt
> @@ -2124,6 +2124,43 @@
>  
>  			The format of <cpu-list> is described above.
>  
> +                         quiesce_on_exit_to_usermode
> +
> +			  This flag allows userspace to take preventive measures to
> +			  avoid deferred actions and create a OS noise free environment for
> +			  the application, by quiescing such activities on
> +			  return from syscalls (that is, perform the necessary
> +			  background work on return to userspace, rather than allowing
> +			  it to happen when userspace is executing, in the form of
> +			  an interruption to the application).
> +
> +			  There might be a performance degradation from using this,
> +			  on systemcall heavy workloads, for the isolated CPUs.
> +			  This option is intended to be used by specialized workloads.
> +
> +			  It should be deprecated in favour of a prctl() interface
> +			  to enable this mode (which allows the quiescing to take
> +			  place only on select sections of userspace execution, namely
> +			  the latency sensitive loops).

So I don't believe in that. If boot parameters were deprecatable, isolcpus would
have been removed already. And now that it's here we have to support it forever
and even fight for keeping it usable with modern interfaces like cpuset.

Besides, such (very costly) quiescence on kernel exit should be only useful on
specific sections of a workload. No need to kill the performance everywhere.

It's a new feature, not a fix, so let's introduce a proper prctl() interface
once and for all. We can't postpone that step forever.

Thanks.

> +
> +			  Note: one of the preventive measures this option
> +			  enables is the following.
> +
> +			  Page counters are maintained in per-CPU counters to
> +			  improve performance. When a CPU modifies a page counter,
> +			  this modification is kept in the per-CPU counter.
> +			  Certain activities require a global count, which
> +			  involves requesting each CPU to flush its local counters
> +			  to the global VM counters.
> +			  This flush is implemented via a workqueue item, which
> +			  requires scheduling the workqueue task on isolated CPUs.
> +
> +			  To avoid this interruption, quiesce_on_exit_to_usermode
> +			  syncs the page counters on each return from system calls.
> +			  To ensure the application returns to userspace
> +			  with no modified per-CPU counters, its necessary to
> +			  use mlockall() in addition to this isolcpus flag.
> +
>  	iucv=		[HW,NET]
>  
>  	ivrs_ioapic	[HW,X86-64]
> 
> 
