Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB99B3B80FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhF3Kzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhF3Kzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:55:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4881C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:53:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so2535949edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=phWV8K90CXrPsrHLce31W/FX6mLFmzQWYJOzoTqeWaU=;
        b=F/5UR3eoz5d0Y9Ll4UEatYbV85Rt6W/fPwYB+hSg7rfkwGs948zvmnBYM4+xzMLRQq
         FVKnhnXRdRHlJi8iQNa04AS9j5nYqgOJ/VpgediBsLNLjIEei2xAiwyMDcbktotAykNE
         54SRCCqr//fA5+1twhvntlneOptLCgA7Dex6lDf/jDmS6J/f/XcV+wtkYovGxGrtMJG6
         jOGJol67km91do8uDfBDd22b0RGahnQQHn700NrafYg7K/zudUlJmYBLmz0U8Almk2/Y
         WiqR+kf79fIn8uVsY4cC90zhZnA4k2NtTlxi4kM+oRDzMUjPUZ5RtskQNIhlB9NADayr
         KuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=phWV8K90CXrPsrHLce31W/FX6mLFmzQWYJOzoTqeWaU=;
        b=Iez5SrnSFQfFHij3IOEp0ohQQUq7b9Ksbxq0+eIl2OHdVMbv7GC6GUiO4tqhJfaHXR
         UxefCAYefN0K33qpTA8I6E9aHYeF66evLbP7xi3DNANnuwPa2jqM53vtYAmrHJD7hI/1
         pPIDpSLjV6gvyb5yQ/VgKLtmmSdBQzXOxn+tgMeJf1frRkEcDefKqV9+FcEfubWLVCBG
         1CG6ItuH3xSJdqKUxve6ArkkA3eCZZ1xFxVE92j4lMZqpuxcx+V7HibNl+XeREIwuTYs
         7sn4sEP9fEMlS/AqmnTmVr0qeys6ovpGU2OHMvjxg7mtAYvnBkv7NmnH47nzDP7wZGyn
         Ja/g==
X-Gm-Message-State: AOAM530cZUy4D6syJ+8msG50D+PwpdcIArcn9wlrB2U9RYihdAlbLsvs
        VBkjBuPBbB/ILE8iObK1rrE=
X-Google-Smtp-Source: ABdhPJwEdzzFXI0GcGTN4LEdScMbLtwhWcIt2cKdTjwB+ENOsN7suQ2ktJDGlW1iB0UdoiZur7RlCw==
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr46484184edy.146.1625050392356;
        Wed, 30 Jun 2021 03:53:12 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id hw6sm4123938ejc.37.2021.06.30.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:53:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 30 Jun 2021 12:53:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes for v5.14
Message-ID: <YNxNFX+ID+6Hqmqj@gmail.com>
References: <YNlxcCpk4shGcPrU@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlxcCpk4shGcPrU@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-30

   # HEAD: a22a5cb81e20657194fde6c835e07d28c4dfddbe Merge branch 'sched/core' into sched/urgent, to pick up fix

- Fix a small inconsistency (bug) in load tracking, caught by a
  new warning that several people reported.

- Flip CONFIG_SCHED_CORE to default-disabled, and update the
  Kconfig help text.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      sched/core: Disable CONFIG_SCHED_CORE by default

Odin Ugedal (1):
      sched/fair: Ensure _sum and _avg values stay consistent


 kernel/Kconfig.preempt | 6 +++---
 kernel/sched/fair.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c4147b9a8..5876e30c5740 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
@@ -115,7 +114,8 @@ config SCHED_CORE
 	   - mitigation of some (not all) SMT side channels;
 	   - limiting SMT interference to improve determinism and/or performance.
 
-	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
-	  unused there should be no impact on performance.
+	  SCHED_CORE is default disabled. When it is enabled and unused,
+	  which is the likely usage by Linux distributions, there should
+	  be no measurable impact on performance.
 
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a3e61a88acc..45edf61eed73 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3657,15 +3657,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
+		sa->load_sum = sa->load_avg * divider;
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
+		sa->util_sum = sa->util_avg * divider;
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
+		sa->runnable_sum = sa->runnable_avg * divider;
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we

