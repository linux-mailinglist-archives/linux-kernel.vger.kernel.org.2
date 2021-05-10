Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF76377F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhEJJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:29:05 -0400
Received: from foss.arm.com ([217.140.110.172]:50128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91936106F;
        Mon, 10 May 2021 02:27:59 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43EC3F73B;
        Mon, 10 May 2021 02:27:57 -0700 (PDT)
Date:   Mon, 10 May 2021 10:27:51 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
Message-ID: <20210510092751.GA36522@e120877-lin.cambridge.arm.com>
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
 <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
 <20210507153827.GA176408@e120877-lin.cambridge.arm.com>
 <c265d9ab-f06f-692f-df43-464bf4f2ea68@arm.com>
 <20210507171438.GA326455@e120877-lin.cambridge.arm.com>
 <CAB8ipk_VF0iD-4Lp73UsPYwz9wOawro5ZfyZihFU4Pu3_ehZjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk_VF0iD-4Lp73UsPYwz9wOawro5ZfyZihFU4Pu3_ehZjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > >  static inline unsigned long task_util_est(struct task_struct *p)
> > > @@ -4002,7 +4002,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >        * Reset EWMA on utilization increases, the moving average is used only
> > >        * to smooth utilization decreases.
> > >        */
> >
> > Needs to be updated to add:
> >
> >         last_enqueued_diff = ue.enqueued & ~UTIL_AVG_UNCHANGED;
> 
> The flag had been cleared before, otherwise would return earlier, so
> there is no need to clear this flag again.

Indeed, my bad. All good then.

-- 
Vincent
