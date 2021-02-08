Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BD3133A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhBHNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhBHNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:46:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8932C06121D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujKmkzTGj+GO4qA+coEao+2xEy5/H8aiDMABhkJNmp4=; b=M9nx2DhqblldW46zwomm3P9Zsn
        zAwnx1jw780kjmOwvoOWlhl0pKFNzWKKJG+VfHHgaCYHtHUQdpLoi2V2ciYz50DPTMSEW4D5X9jxU
        PaXVvrMPPBCjxrjyd6kSwJ+pYlPYa7ySFUuPdxF3jNmcgdKi+lz1oevHajbLtq6lymw1/tXI986sp
        baFa3P7KyaAXETHS4ZmcZ7uSf1PgcgfNutsIqRybDpiAGlR1HUlz8GL3bxCJtMYFSzKBjC3D/yr/+
        XOu0r8hqalEsYETiPyy9hhV76e2bMitrO/8ccSGtn+bdanGEI58B8KjDzB6r5QmCV95JntQajiKN8
        Uamu3clQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l96p9-0000Bt-6S; Mon, 08 Feb 2021 13:43:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7379E3060AE;
        Mon,  8 Feb 2021 14:43:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3880E20D8A019; Mon,  8 Feb 2021 14:43:27 +0100 (CET)
Date:   Mon, 8 Feb 2021 14:43:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/deadline: Reduce rq lock contention in
 dl_add_task_root_domain()
Message-ID: <YCE//6RaVyPzWO4W@hirez.programming.kicks-ass.net>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:35:42AM +0100, Dietmar Eggemann wrote:
> dl_add_task_root_domain() is called during sched domain rebuild:
> 
>   rebuild_sched_domains_locked()
>     partition_and_rebuild_sched_domains()
>       rebuild_root_domains()
>          for all top_cpuset descendants:
>            update_tasks_root_domain()
>              for all tasks of cpuset:
>                dl_add_task_root_domain()
> 
> Change it so that only the task pi lock is taken to check if the task
> has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
> rq lock as well to be able to safely de-reference root domain's DL
> bandwidth structure.
> 
> Most of the tasks will have another policy (namely SCHED_NORMAL) and
> can now bail without taking the rq lock.
> 
> One thing to note here: Even in case that there aren't any DL user
> tasks, a slow frequency switching system with cpufreq gov schedutil has
> a DL task (sugov) per frequency domain running which participates in DL
> bandwidth management.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
