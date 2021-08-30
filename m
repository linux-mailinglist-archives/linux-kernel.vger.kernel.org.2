Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FFE3FBAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhH3RdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhH3RdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:33:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4928C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:32:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u1so5155531plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epWKvD5razLbtGdMxCSBlYu5hXhP+qig9FZSIVuI3tE=;
        b=G+Q7gtX70nbZ/LBCjYyjOz1aV5GGQ1isjpzbr+PXzvtB2/4iP/j0NqnV7xwI/FumTm
         /iYzz8JW/fg5RDkv0PaLg8EyxQLmr/FK2ID0atZPyvp5oHA//X+4djFV61pgLqOuvCQI
         xRkh4CMy8ztoRmz37kcvRA4WYC3WcwAVud73mwcbZatUFKII3B/jExPr0STb+0qhdA5z
         rrxNFCnhFcr9HCKPoOFpGH8eJZtlbnzQe/2dLGaUDdR5+vqtdKh732ZZ9BCkX5gaS/3V
         XEj74L2ltpg1E9FOqxc7kbkZimyxdRCJrX59w5wuBhiXkti2sSRvaFk5CXqLqNQZmdop
         jS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=epWKvD5razLbtGdMxCSBlYu5hXhP+qig9FZSIVuI3tE=;
        b=MbCsMy5yQ4DfkbOoMumxSu2Hd5n/kVjxA+HyT1FLGzVIMKA2YdhLfeAbnsmP2qGUjQ
         p9F13KAW/bEF+/J5d/AIe0urdyAmp74KA6sfhmUurqMHlHG2B2vrj1MwLIMqMgiyL6yN
         FjqF2kUAcKxiGsO1RKmcvbjw3owYKmM5vf1XLdPA8LpBm5hnkcdHmeAsjZn/L04jiGo4
         B4QsKAkBSHsHv6cbwa7ArP3E7ZmZWcMx8ErMj6oUxJuLhkrGGq1VBRK1C/0VN0S6wQaL
         K3ln3w2V92tBsLzY4c+BSl2M5FdqhPnLWwq0Tmy5RHaE0ezm2lQTsBnlCoSYu//5K9v5
         LeQg==
X-Gm-Message-State: AOAM533UqjY37P5H7ZPAHi6pXggz8q052siVZtxUOgMiukQnIM5NxZc6
        IJ97odyZqX3P1nUfF5veUgN+jPk65UsRdA==
X-Google-Smtp-Source: ABdhPJyutONVOk+BjWisUL3/Xu58mBMWIUdp3+7cQncOldvlNCU1bCGJiTmJVJSJjOX0URjHmJq40g==
X-Received: by 2002:a17:90a:d187:: with SMTP id fu7mr213232pjb.106.1630344729218;
        Mon, 30 Aug 2021 10:32:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id y3sm10665124pge.44.2021.08.30.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:32:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Aug 2021 07:32:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 30, 2021 at 04:39:54PM +0200, Peter Zijlstra wrote:
> > When a new process is forked, cgroup_post_fork() associates it
> > with the cgroup of its parent. Therefore this commit move the
> > __set_task_cpu() and task_fork() that access some cgroup-related
> > fields(sched_task_group and cfs_rq) to sched_post_fork() and
> > call sched_post_fork() after cgroup_post_fork().

I think this would allow cgroup migrations to take place before
sched_post_fork() is run, which likely will break stuff. The right
thing to do likely is taking sched_task_group (and whatever other
fields) after cgroup_can_fork(), which fixates the cgroup memberships,
is run. For other controllers, operations like this would be performed
from cgroup_subsys->fork() callback but it's tricky for sched due to
autogroup.

> > Fixes: 8323f26ce342 ("sched: Fix race in task_group")
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> 
> Hmm, I think you're right. Did something recently chagne in cgroup land
> to make this more visible? This code hasn't changed in like 9 years.

I can't think of any remotely recent change either. I guess ppl just
don't try to migrate the parent while fork is in progress.

Thanks.

-- 
tejun
