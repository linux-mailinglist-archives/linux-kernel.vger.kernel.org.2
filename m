Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7F342E08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCTPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhCTPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC304C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T6ts3lUqEqANqquwyBrmLYEq2ggW88CY7TmJE3kNSqc=; b=r/UZPiE/RloFVMEZ2GWlauPmDj
        07214o3v7iVSpRi9+/F2MQ38s4s0be9uVZGBCBFyF19wnwpBG75t1rnmpZB8fGymwEFxLMjddVb0A
        CFp5RnImpkWdovh0ppCFYQ8hJ9Fsf6x60nL4KrXhQxhreuO+xUx4JWLhpCAo8FgciGLqSzal6MFUc
        9GohQkBKEcNC3jLUfCdXKfoRUSGhRDOQaZ88CXIgoKvs5sKhuG/jOBHXo/Z6QQwC2O1KA7ksEnQKe
        6dQiKMDbjQ15QOCFTfbnvu9q5VIyXPn6ey9g2GtU+VGGh3xjM5sn0Z3NoBztynnq1M680a0eLKwNH
        5mKYhNrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNdst-00601U-Nn; Sat, 20 Mar 2021 15:51:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B5159864FF; Sat, 20 Mar 2021 16:51:27 +0100 (CET)
Date:   Sat, 20 Mar 2021 16:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/6] sched: prctl() cookie manipulation for core
 scheduling.
Message-ID: <20210320155127.GA4746@worktop.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319203253.3352417-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:32:50PM -0400, Joel Fernandes (Google) wrote:

>  include/linux/sched.h            |   7 ++
>  include/linux/sched/task.h       |   4 +-
>  include/uapi/linux/prctl.h       |   7 ++
>  kernel/sched/core.c              |  11 +-
>  kernel/sched/coretag.c           | 197 +++++++++++++++++++++++++++++--
>  kernel/sched/sched.h             |   2 +
>  kernel/sys.c                     |   7 ++
>  tools/include/uapi/linux/prctl.h |   7 ++
>  8 files changed, 230 insertions(+), 12 deletions(-)
> 

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2e3024a6f6e1..a62e8ad5ce58 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4654,11 +4654,17 @@ unsigned long nr_iowait(void)
>   * sched_exec - execve() is a valuable balancing opportunity, because at
>   * this point the task has the smallest effective memory and cache footprint.
>   */
> -void sched_exec(void)
> +int sched_exec(void)
>  {
>  	struct task_struct *p = current;
>  	unsigned long flags;
>  	int dest_cpu;
> +	int ret;
> +
> +	/* this may change what tasks current can share a core with */
> +	ret = sched_core_exec();
> +	if (ret)
> +		return ret;

Did the hunk for fs/exec.c go missing?
