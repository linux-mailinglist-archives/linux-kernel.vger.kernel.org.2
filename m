Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1A43D4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhJ0VYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:24:19 -0400
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241252AbhJ0VXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:23:03 -0400
X-Greylist: delayed 2057 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 17:22:58 EDT
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 19RKhmKw001394
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 27 Oct 2021 13:43:54 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 19RKhUEV028289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 13:43:36 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 13:43:30 -0700
Received: from yow-pgortmak-d1.wrs.com (128.224.56.57) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 13:43:29 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 0/2] bind rcu offload (nohz_full/isolation) into cpuset
Date:   Wed, 27 Oct 2021 16:43:17 -0400
Message-ID: <20211027204319.22697-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the earlier pre-mainline RCU nocb patchsets had a temporary sysfs
knob in /sys/devices/system/cpu/cpu*/hotplug/nocb for testing[1].

That not-for-merge commit from Frederic said:

  This is only intended for those who want to test this patchset. The
  real interfaces will be cpuset/isolation and rcutorture.

We've had rcutorture as the one and only mainline user of nocb toggle
for a while now[2], and so I thought I'd take a crack at what Frederic
had in mind for cpuset with some code vs. asking 100 random questions.

Note that I intentionally didn't Cc any cgroup/cpuset people (yet),
since at this point this is only my guess on what things were to look
like based on a single sentence fragment.  So this is really early
"Not-for-Merge", but truly just RFC -- to start a conversation.

It won't be really useful until we adjust tick/housekeeping in addition
to nocb, but I think we can develop the interface in parallel to that?
And maybe use this to expand testing at the same time if it is layered
on top of those future work/patchsets?  I don't know...

We'll also have to look at corner cases - like whether we want to treat
the root cpuset differently; whether we want to sync boot arg values
with the cpuset's initial isol flag value, whether we un-isolate cores
when an isolation cpuset is rmdir/removed, etc etc.

But as a proof of concept, it "works" as can be seen in the 2nd commit.

Paul.
--

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?h=rcu/nocb&id=6abe8408307e
    part of https://lwn.net/Articles/820544/
            https://lwn.net/Articles/832031/   <------ v2
            https://lwn.net/Articles/835039/   <------ v3
            https://lwn.net/Articles/837128/   <------ v4

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d97b078182406


Paul Gortmaker (2):
  sched: isolation: cpu isolation handles for cpuset
  cpuset: add binding to CPU isolation

 include/linux/sched/isolation.h |  4 ++++
 kernel/cgroup/cpuset.c          | 42 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c        | 22 +++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.15.0

