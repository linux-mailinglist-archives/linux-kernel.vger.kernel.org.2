Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055063DB0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhG3CAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhG3CAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:00:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B1C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:00:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t101-20020a25aaee0000b0290578c0c455b2so8653004ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PHzUTC+YKZvGYQHyUP/ROHYZ5igq5bXG6G/ZmTIvi/c=;
        b=rlj64RcHSw0+rdJUScZoli8M7tqyrEf3H2z3fAUbUpF0YUvWnLFP90dx2Jg8v5WCTd
         5fWWvBgeZbj3k3/buzKCHawwrONxaZV5hIeBR2KRTjn75NBUyz0IFklski2Rgac/tfzK
         spW11uTyoryVJVEHvDkg+xVPXcOt3mF3HsHGEoC0M9UB5iZKchJPGFIUn/EiJvzlni2R
         oPVEV6N+MXGTHdNVCVdMNfDoJ+y/RxIQEqmhtfILsAcGELHbBziwzTTvpdIBG2O5EjWP
         rvniykn/0elGRtnZ/mnPtrlvzd+W4sFhXNojTtJAJ9vMQazMlN0sLg0ZNln290q9wAni
         R+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PHzUTC+YKZvGYQHyUP/ROHYZ5igq5bXG6G/ZmTIvi/c=;
        b=Cd1kEWBxrI1eQpxc2CYWDgeLH7GMsYlyop442bwP7IkqijTEB8ldolb4483gynYyzw
         EaVxQf+WAFIoQK7TaiWitsCjiaD1CvKrAr1UphMavYRQ+ahqxM5StuXgzZXy7VBQHN3/
         EZSMxLb6+6HdZQ9XsJjd202c1uN3AYBNHoG/cjbWJW9qe5kTyIdT2znehFprE9qfW+wM
         WYhAsy4LV+fyXE0DPfP0w5RqiTI0qVBz7o2hD+IepHhMnz3/RU6S2R7Nlpv38xw6Jt5m
         0ieMEheZMWH+XRJzLxEUrLIfFygjVHQeK3ns/Kblh/YqLpz1z7kW9r5VsrKpEdnqO3a+
         q0WQ==
X-Gm-Message-State: AOAM531RemFsp+ISgFNNGyE+dXHS2uDtaXp+5LsALRbS7wunKRtYrlrc
        UAi4uz0ICPOhbegd4ee0CZQRwfr9XVw1
X-Google-Smtp-Source: ABdhPJwZJDVtJZrvoT8Eo08nhnZr04d4d82MS+5HTSwzvxDYgwj2FP+/rTy9drZfaFtXsKOq2V5wQgkr5awQ
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:363b:28db:fef9:14c6])
 (user=joshdon job=sendgmr) by 2002:a25:d683:: with SMTP id
 n125mr63242ybg.113.1627610440234; Thu, 29 Jul 2021 19:00:40 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:00:17 -0700
Message-Id: <20210730020019.1487127-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 0/2] SCHED_IDLE extensions
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains improvements/extensions for SCHED_IDLE.

The first patch of the series is the updated v2 of the previously mailed
patch to add cgroup support for SCHED_IDLE.

The second patch is a new patch to adjust some SCHED_IDLE semantics.

Josh Don (2):
  sched: cgroup SCHED_IDLE support
  sched: adjust SCHED_IDLE interactions

 kernel/sched/core.c  |  25 +++++
 kernel/sched/debug.c |   3 +
 kernel/sched/fair.c  | 229 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |   8 ++
 4 files changed, 234 insertions(+), 31 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

