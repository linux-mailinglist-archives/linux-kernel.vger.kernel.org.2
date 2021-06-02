Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B639897B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFBM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFBM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:28:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:26:27 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so2478601oiv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gRFrOxhK5JVhfCbw+4oIyaQBQcyhNynVII2qYDzieSY=;
        b=ptF5j9xxD8tqy6DdMXnMj0ROg4MY5LMTHs0YBaVVSjxBwZAnAuwyT/Ocuq+beZ30o6
         C16TTAUQpyCChCnYohMzHHI/JvOBsu5sPkyRSaTyrUPUUsG3pSPHdBQE4+NN0XmRDTY4
         YBugoxjth6LGy5UjNrP9zgcDHNMeLzl16aLkJSkz8dBAg3yugPTZKHghQLDg7M4RtJ6w
         BeCqW1bO+xN6sQVXk08KV7ALcqXst1caM9aqZQuRHDsi6LZAR+Jo57k22188QoemMZ7h
         h1dUAwK9qYpirrUs0iRXuAyYlA/Q5ouyCVRPTQPYJP6Thpb7q1uJN29S//i/Wu0fmYs2
         vxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gRFrOxhK5JVhfCbw+4oIyaQBQcyhNynVII2qYDzieSY=;
        b=jXDX4SoP2sMjN9+ekxj33planLi6D3DiqE6wng43q5FbHpI63fNA+8l7ZbiA1cP/Xt
         ZKLNFepw+/YYGDaLo/vomeS0LU2Ww2uFC5mB5huQBOZYc0TiAKODFsKCdFC4RuD5UReQ
         0nJEX4+JlGu5CVlSyP8YdVS3sClvY6EqKmT6N+TTmmIKQ4KyskKb4QtcyZRTjoS2SeVG
         aMOsb9DerbxJr6XI/lhuf6RX23LzQRqiFypXXR1vJWqJWn1pDngu5j+OmBOPG9o5gp7J
         fDuYR7C22pY+QPvwod7EWVGEgjQlylqH5JUhZMry0QmMrFp4rWUhSAGoBgG/8aTMVjvF
         mnLg==
X-Gm-Message-State: AOAM532+GrLrPyaH97lUCx3e7X/nYVMlQK+aFa0HXuOH7XiqWlFL86IM
        G4zJ/QVPn4SQw+X8OyaRfBM=
X-Google-Smtp-Source: ABdhPJx4wssqX3/Pi1rEu0CzCHZWMLMCUDY+zlF/Z9P2g4S1K172HWhYI5Bj7E30Sf+bqkSzXG+kKQ==
X-Received: by 2002:aca:75c7:: with SMTP id q190mr22186814oic.80.1622636787091;
        Wed, 02 Jun 2021 05:26:27 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id l1sm1473499oos.37.2021.06.02.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:26:26 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.co,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] sched: do active load balance on the new idle cpu
Date:   Wed,  2 Jun 2021 20:25:55 +0800
Message-Id: <20210602122555.10082-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We monitored our latency-sensitive RT tasks are randomly preempted by the
kthreads migration/n, which means to migrate tasks on CPUn to other new
idle CPU. The logical as follows,

  new idle CPU				CPU n
  (no task to run)              	(busy running)
  wakeup migration/n			(busy running)
  (idle)                        	migraion/n preempts current task
  run the migrated task			(busy running)

As the new idle CPU is going to be idle, we'd better move the migration
work on it instead of burdening the busy CPU. After this change, the
logic is,
 new idle CPU				CPU n
 (no task to run) 			(busy running)
 migrate task from CPU n		(busy running)
 run the migrated task			(busy running)

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..3e8b98b982ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9807,13 +9807,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
 
-			if (active_balance) {
-				stop_one_cpu_nowait(cpu_of(busiest),
-					active_load_balance_cpu_stop, busiest,
-					&busiest->active_balance_work);
-			}
+			if (active_balance)
+				active_load_balance_cpu_stop(busiest);
+
+			raw_spin_unlock_irqrestore(&busiest->lock, flags);
 		}
 	} else {
 		sd->nr_balance_failed = 0;
@@ -9923,7 +9921,6 @@ static int active_load_balance_cpu_stop(void *data)
 	struct task_struct *p = NULL;
 	struct rq_flags rf;
 
-	rq_lock_irq(busiest_rq, &rf);
 	/*
 	 * Between queueing the stop-work and running it is a hole in which
 	 * CPUs can become inactive. We should not move tasks from or to
@@ -9933,8 +9930,7 @@ static int active_load_balance_cpu_stop(void *data)
 		goto out_unlock;
 
 	/* Make sure the requested CPU hasn't gone down in the meantime: */
-	if (unlikely(busiest_cpu != smp_processor_id() ||
-		     !busiest_rq->active_balance))
+	if (unlikely(!busiest_rq->active_balance))
 		goto out_unlock;
 
 	/* Is there any task to move? */
@@ -9981,13 +9977,10 @@ static int active_load_balance_cpu_stop(void *data)
 	rcu_read_unlock();
 out_unlock:
 	busiest_rq->active_balance = 0;
-	rq_unlock(busiest_rq, &rf);
 
 	if (p)
 		attach_one_task(target_rq, p);
 
-	local_irq_enable();
-
 	return 0;
 }
 
-- 
2.17.1

