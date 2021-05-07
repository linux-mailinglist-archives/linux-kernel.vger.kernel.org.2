Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E80376829
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhEGPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:39:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhEGPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:39:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D464811B3;
        Fri,  7 May 2021 08:38:34 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329933F73B;
        Fri,  7 May 2021 08:38:33 -0700 (PDT)
Date:   Fri, 7 May 2021 16:38:28 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        xuewyan@foxmail.com
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
Message-ID: <20210507153827.GA176408@e120877-lin.cambridge.arm.com>
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
 <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 03:36:47PM +0200, Dietmar Eggemann wrote:
> On 07/05/2021 14:35, Vincent Donnefort wrote:
> > On Fri, May 07, 2021 at 07:20:31PM +0800, Xuewen Yan wrote:
> >> From: Xuewen Yan <xuewen.yan@unisoc.com>
> >>
> >> Last_enqueued_diff's meaning: "diff = util_est.enqueued(p) - task_util(p)".
> >> When calculating last_enqueued_diff, we add UTIL_AVG_UNCHANGED flag, which
> >> is the LSB, for task_util, but don't add the flag for util_est.enqueued.
> >> However the enqueued's flag had been cleared when the task util changed.
> >> As a result, we add +1 to the diff, this is therefore reducing slightly
> >> UTIL_EST_MARGIN.
> > 
> > Unless I miss something it actually depends on the situation, doesn't it?
> > 
> > if ue.enqueued > task_util(), we remove 1 from the diff => UTIL_EST_MARGIN + 1
> > 
> > if ue.enqueued < task_util(), we add 1 to the diff => UTIL_EST_MARGIN -1
> 
> I get:
> 
> ue.enqueued & UTIL_AVG_UNCHANGED = 0
> 
> last_enqueued_diff = ue.enqueued_old                    -  ue.enqueued_new
> 
> last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED) - (task_util(p) | UTIL_AVG_UNCHANGED)
> 
>                                    ^^^^^^^^^^^^^^^^^^^^
>                                    added by patch
> 
> 
> ue.enqueued_old didn't have the flag, otherwise would return earlier
> 
> task_util(p) could have the LSB set but we just set it to make sure it's set
> 
> So last_enqueued_diff is 1 larger.

But we take the abs() of last_enqueued_diff.

If we consider the following examples:

   enqueued_old = 5, enqueued_new = 9
   diff = 5 - (9 + 1) => 5 - 10 => -5

   enqueued_old = 9, enqueued_new = 5
   diff = 9 - (5 + 1) => 9 - 6 => 3

In both cases the delta is supposed to be 4. But in the first case we end-up
with 5. In the second, we end-up with 3. That's why I meant the effect on the
diff depends on who's greater, ue.enqueued or task_util().

> 
> But UTIL_EST_MARGIN stays `SCHED_CAPACITY_SCALE / 100` ?
> 
> Did I miss something here?

But the only purpose of the diff is the comparison against the margin. So
+/-1 in the diff ends-up being the same as doing the opposite for the margin.

All in all, the missing flag ends-up by modifying UTIL_EST_MARGIN by -1 or +1.

-- 
Vincent
