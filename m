Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1F36809E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhDVMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbhDVMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3EC06138E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0VJsxcGuYW9Aw39Y+TXTqVTpJ/n+1T+DYSncBNIJyJc=; b=G6AsR6HihvuEYyL2vFLTebrN1x
        QfpZKXV0YLtGTlnr8jeuffjyXDDgr1Skq8LPXPnRb+muCwPLBrye8o13r6RMd6nq6DwYXxCvjEmWC
        fasthLHy5MHEl5ruXOyhXW9Ow6ShMX19ixiSlNRt4L6tBFIyR6tjeP8s8qNBnn1Lr1kbMO/VhBFpA
        2HtnSD8I9sSlAh8A+QEEEgNkcAgu7mRN9FKo5XDYtgveHHcDNpOEwlMUc6DOtdVbOJdqGt2TTV/1Z
        nkPGlasau2MsI2ib3+p0a7lfbI8/S7oPu/jOSojBXmAF3dYr9mWp6W0VXeIFFjgmNeBfE0w/3rSyw
        d2m+eniw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYYF-000I91-AS; Thu, 22 Apr 2021 12:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D2C53002B1;
        Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 24EBF2B7DA1F8; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422120459.447350175@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:04:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 00/19] sched: Core Scheduling
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,

This is an agressive fold of all the core-scheduling work so far. I've stripped
a whole bunch of tags along the way (hopefully not too many, please yell if you
feel I made a mistake), including tested-by. Please retest.

Changes since the last partial post is dropping all the cgroup stuff and
PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
the cgroup issue.

Since we're really rather late for the coming merge window, my plan was to
merge the lot right after the merge window.

Again, please test.

These patches should shortly be available in my queue.git.

---
 b/kernel/sched/core_sched.c                     |  229 ++++++
 b/tools/testing/selftests/sched/.gitignore      |    1 
 b/tools/testing/selftests/sched/Makefile        |   14 
 b/tools/testing/selftests/sched/config          |    1 
 b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
 include/linux/sched.h                           |   19 
 include/uapi/linux/prctl.h                      |    8 
 kernel/Kconfig.preempt                          |    6 
 kernel/fork.c                                   |    4 
 kernel/sched/Makefile                           |    1 
 kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
 kernel/sched/cpuacct.c                          |   12 
 kernel/sched/deadline.c                         |   38 -
 kernel/sched/debug.c                            |    4 
 kernel/sched/fair.c                             |  276 +++++--
 kernel/sched/idle.c                             |   13 
 kernel/sched/pelt.h                             |    2 
 kernel/sched/rt.c                               |   31 
 kernel/sched/sched.h                            |  393 ++++++++--
 kernel/sched/stop_task.c                        |   14 
 kernel/sched/topology.c                         |    4 
 kernel/sys.c                                    |    5 
 tools/include/uapi/linux/prctl.h                |    8 
 23 files changed, 2057 insertions(+), 222 deletions(-)

