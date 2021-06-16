Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF523AA059
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhFPPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhFPPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:49:54 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8EC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:42:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id u20so2236775qtx.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VcvqdSpEQ34uTXYj+4Ak9Aa1k5XX+6zoeA60p4+f560=;
        b=L9l2Xmn/Zmuh3vUPr4X5KegJDosYDxivbQSVAWtKt4vKkTUT6DXZCrx2uT72zokCaX
         onSBXT6yHMtfoQs9SoidLA0BL7fXHaKi09CSGOxntmzQORevv4jv/E7zMBY//b0rZO8m
         miiAYcHBuEzu+D1TILnTQa/P5xy20YibWAicaQZhWHXhTQBiOBjYzWINIkj09Dc1nLcM
         hGEcBZgcQqXoFrIzOUTsuawyQ/mCTJeg7wGpO8gy1fCCG2b2lNJjSWG0GJrJ9+1p4DP/
         RMRzoUWhaxZWX/utCyny/4I7wk+26q0TgbkZCCBBEjATXwzYvQf1WjAzolD59Jyrv+Ss
         nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VcvqdSpEQ34uTXYj+4Ak9Aa1k5XX+6zoeA60p4+f560=;
        b=Yat3SYcHlIfwlqGUwCM1tChxd8YkwCkNk1T75dVP357ywYIjdQwZhX4fhZuE6MqcZT
         Edcz8RxyIVZczCU+VpCD0IlW6AU7cWf5H2nvomWUcyUBtJD0DRZWjAb3ILyo6WrSqL9y
         HRyJodF6WNc2dniCYc03m7Eiw4JhZOjzWIMXkgwXH88FWaGyWaWV04Nj7MPSjrxelLRw
         g4AEHL7Vh0t6DSGPX7gXGXbIfCGX+0MeVQ/kZI1YoU61AOivfIzoDIFOu2NINti06Wu2
         w91Y3kLeHaYEuP8cO4pqJdNo7P6yS4sTSd5UxD11mHBIsZ+Xmy1la1tYjR3vVjWCp7Tw
         tS2A==
X-Gm-Message-State: AOAM5318GEAiyWAS3WicBNxPauTEKOsmDUrQzbPj/xLdvtC2o/B1LTcy
        ObkhCwqNKBToLEef9kw9voY=
X-Google-Smtp-Source: ABdhPJw7N3Z6DBK9abk24oUBsZbdsFKF+azbDYxxsjzFISp2KfdXNzCgjnjcRTFEWdjq6aOY1egX2Q==
X-Received: by 2002:ac8:12c7:: with SMTP id b7mr449124qtj.243.1623858126645;
        Wed, 16 Jun 2021 08:42:06 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id u18sm1398350qta.38.2021.06.16.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:42:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 11:42:05 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YMobzbLecaFYuLtq@slm.duckdns.org>
References: <20210608231132.32012-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608231132.32012-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 08, 2021 at 04:11:32PM -0700, Josh Don wrote:
> This extends SCHED_IDLE to cgroups.
> 
> Interface: cgroup/cpu.idle.
>  0: default behavior
>  1: SCHED_IDLE
> 
> Extending SCHED_IDLE to cgroups means that we incorporate the existing
> aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
> descendant threads towards the idle_h_nr_running count of all of its
> ancestor cgroups. Thus, sched_idle_rq() will work properly.
> Additionally, SCHED_IDLE cgroups are configured with minimum weight.
> 
> There are two key differences between the per-task and per-cgroup
> SCHED_IDLE interface:
> 
> - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
> maintain their relative weights. The entity that is "idle" is the
> cgroup, not the tasks themselves.
> 
> - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
> decision is not made by comparing the current task with the woken task,
> but rather by comparing their matching sched_entity.
> 
> A typical use-case for this is a user that creates an idle and a
> non-idle subtree. The non-idle subtree will dominate competition vs
> the idle subtree, but the idle subtree will still be high priority
> vs other users on the system. The latter is accomplished via comparing
> matching sched_entity in the waken preemption path (this could also be
> improved by making the sched_idle_rq() decision dependent on the
> perspective of a specific task).

A high-level problem that I see with the proposal is that this would bake
the current recursive implementation into the interface. The semantics of
the currently exposed interface, at least the weight based part, is abstract
and doesn't necessarily dictate how the scheduling is actually performed.
Adding this would mean that we're now codifying the current behavior of
fully nested scheduling into the interface.

There are several practical challenges with the current implementation
caused by the full nesting - e.g. nesting levels are expensive for context
switch heavy applicaitons often going over >1% per level, and heuristics
which assume global queue may behave unexpectedly - ie. we can create
conditions where things like idle-wakeup boost behave very differently
depending on whether tasks are inside a cgroup or not even when the eventual
relative weights and past usages are similar.

Can you please give more details on why this is beneficial? Is the benefit
mostly around making configuration easy or are there actual scheduling
behaviors that you can't achieve otherwise?

Thanks.

-- 
tejun
