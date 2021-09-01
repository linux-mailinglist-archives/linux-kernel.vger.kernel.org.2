Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910DD3FE046
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhIAQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhIAQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:46:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF75FC061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:45:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so21726pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=slQt02h+v0Y1d8KFH4MaSa6jVs6HUzntmYtRQdF8C+c=;
        b=jqjKBhDPnv+JDyRFmWl4T081fgpYMsYGZazU5KY8dwwbqVpKoBzz8118lU4QTPiHcB
         2NCEjELlMEpmX0fPKhaVIgY0jFd+vx3ICOyceRFXgv8DinnRCVdc+jWtMx+t+iZI0NR2
         GdfbIuBp0cW72HtvcyMyE3xPWar28IroD/Dz4skdyZjmWqjsr3FkZVIKAggXxIYJHawu
         QHsAiaTk7wzn3AtAWqWrQCTMNMxGEN+Xoy93unePsuzaU8Rmc7yEqXCGhx4GCKFPt7z5
         eft4hz1v5G02hBjvHwYWNI+o75kaIPZz5Op1cwATuknBNnyPaAh0z7nFloqrlPxhPina
         0S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=slQt02h+v0Y1d8KFH4MaSa6jVs6HUzntmYtRQdF8C+c=;
        b=HT8V2tr82gXqaay76gCYghTwjf62f3tVh8beFRMIpbSZOt2dXkilM6r/frSILRyxsK
         rZ9wWaEsmInzvGaxu9XwlIFJy7s/Sa90PAupDFPmTqkEW6P2/unZIqVlSpbcE+fYWUEl
         uPfokl9nD2AlWKSUd49GiKE10BOHb/cwICDYXZLTtjCDGKZpZu8odacHsW+QA8UutPjW
         sBWYCVmcMKuLeRhYhFHxGlgQy6G2ggttPHM48/l9tCmXOG+/ZzUcZa8ajtkgh9UHoq43
         ZCIUaxuQL2oACpL6jt/AdbjekzZSqBJTm+M5P7qP0R5hiD5tgdxj2nII/s47leDQua8J
         fF9A==
X-Gm-Message-State: AOAM530ew50YnwIHzrqrE95deQUsMTcghY8WLbm0jxk9o4FQloX+Sy8C
        qjdsTPlJhjFiliDK9wwWns4=
X-Google-Smtp-Source: ABdhPJxthNiqBbEElWPYzBqAYiWsrNPpmThGtBJUflOH6wOKGz8IOxf0A40Y67PzR6OJTtJjHEsHBg==
X-Received: by 2002:a62:aa15:0:b0:3fb:9dd6:a95f with SMTP id e21-20020a62aa15000000b003fb9dd6a95fmr291008pff.76.1630514708168;
        Wed, 01 Sep 2021 09:45:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l22sm40377pjz.54.2021.09.01.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:45:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Sep 2021 06:45:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YS+uEmQRmQqAbkmG@slm.duckdns.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
 <YS60T2bfLpxb6SUY@slm.duckdns.org>
 <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 01, 2021 at 03:43:00PM +0800, Zhang Qiao wrote:
> 在 2021/9/1 6:59, Tejun Heo 写道:
> > On Tue, Aug 31, 2021 at 03:58:42PM +0800, Zhang Qiao wrote:
> >>> I think this would allow cgroup migrations to take place before
> >>> sched_post_fork() is run, which likely will break stuff. The right
> 
> cgroup migrations? Do you mean child process set its cgroups at
> cgroup_subsys->fork()?

As soon as cgroup_post_fork() is complete, userspace can try moving the
process to a different cgroup which can get confusing for sched_post_fork.

> > Between cgroup_can_fork() and cgroup_post_fork(), the cgroup membership and
> > thus sched_task_group can't change, so if the child sets it to the parent's
> > inbetween, the sched_task_group can't go away.
> 
> so the child just need to update its sched_task_group after cgroup_can_fork(),
> then call sched_fork(), is it right?

Yeah, the bug here is that a field which is dependent on cgroup membership
is being read before the cgroup membership is fixated.

Thanks.

-- 
tejun
