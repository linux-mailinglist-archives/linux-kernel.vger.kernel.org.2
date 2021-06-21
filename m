Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94B3AE94B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:45:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F32C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:43:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q190so27359703qkd.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+LmD+kQYl9KWjs3WNslIqBoSlOPQuU2PMBDArJmqyA=;
        b=VdvIKab7G0jo2Iatm0bZKpo6b5x9q7TuenDRzg4xMBROXbo7dXHRMAuHUNRT4X5X49
         MP5OCswylFTAdaGoRmn3zYkews7eHfimEYiWYETJTNlt40I+FhRNAsvY7O5doUZ967WK
         h5ODAJyX62fcITASLyuvxRVuhB5feJLwagG0dX2Lkt03GOAA1ScLgmAMdl5ItYFe8toY
         ffnSrMcZVU+XsUA9iQhYsHnUYCb6oaD/SheagejDd4E1gyk8Zi8VyKoWhLNkxzA9QZ+g
         UM8K/vDk8w4o5lGofyMjWvP+q0IqKupZNlK9R/Bul046zsn2cll3BhqdCSOOUzYcAfF/
         0C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+LmD+kQYl9KWjs3WNslIqBoSlOPQuU2PMBDArJmqyA=;
        b=hz+y0HHyEyeOmk/cZctjRLSEqse8GUfUeZliHl5yo2afFrLzZDqvIQzmdzp1SAQmpU
         1h/OYE9osXr43+uUccRRxXPTmDHnnSYfp6lAA/jbY/t9uKOPF5e6mTLTh89WC9hKhaeJ
         O3ZU8ClS1Bv/CblZkfLeLLYKlVfG5/ZVPYWtfpp3LxHVhoz7yTKw9U518ZYxHE+9Q24W
         XWvZYJ01iQXwFkA9VxgkAcvNt8Gsa6THiwZXzROckRAL3M+3myXnvkJBuyyq07+40118
         vgWzsvYT/9Ncn/QtOLzUC3N0/pWtOXKp6KDsw1UayMt7kMxfDMBP3aFkSJEObOo/ZGk9
         7SeA==
X-Gm-Message-State: AOAM531XIXrw3uh5DF6uPodLHnFh1CA1NJVqumvwWPVq5ls6xILILMB6
        WShu8kIPU/XIaEZjT2V5Nqvv3MCerwX7m6cL0DDeT5d7ll3OzQ+WnfI=
X-Google-Smtp-Source: ABdhPJwfM0Hs1tHizl/QHRu2PUDcX/oBgvfaGVKpMS7oF13qGoYd12AouIA0LqBDOFXoR82/abxpkAcqAhub6+rGmYg=
X-Received: by 2002:ae9:dd06:: with SMTP id r6mr23422853qkf.74.1624279382697;
 Mon, 21 Jun 2021 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com> <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
In-Reply-To: <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 21 Jun 2021 14:42:23 +0200
Message-ID: <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Odin Ugedal <odin@uged.al>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Did some more research, and it looks like this is what happens:

$ tree /sys/fs/cgroup/ltp/ -d --charset=ascii
/sys/fs/cgroup/ltp/
|-- drain
`-- test-6851
    `-- level2
        |-- level3a
        |   |-- worker1
        |   `-- worker2
        `-- level3b
            `-- worker3

Timeline (ish):
- worker3 gets throttled
- level3b is decayed, since it has no more load
- level2 get throttled
- worker3 get unthrottled
- level2 get unthrottled
  - worker3 is added to list
  - level3b is not added to list, since nr_running==0 and is decayed


The attached diff (based on
https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/)
fixes the issue for me. Not the most elegant solution, but the
simplest one as of now, and to show what is wrong.

Any thoughts Vincent?

Thanks
Odin


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfaa6e1f6067..aa32e9c29efd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -376,7 +376,8 @@ static inline bool list_add_leaf_cfs_rq(struct
cfs_rq *cfs_rq)
        return false;
 }

-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+/* Returns 1 if cfs_rq was present in the list and removed */
+static inline bool list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
        if (cfs_rq->on_list) {
                struct rq *rq = rq_of(cfs_rq);
@@ -393,7 +394,9 @@ static inline void list_del_leaf_cfs_rq(struct
cfs_rq *cfs_rq)

                list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
                cfs_rq->on_list = 0;
+               return 1;
        }
+       return 0;
 }

 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
@@ -3298,24 +3301,6 @@ static inline void cfs_rq_util_change(struct
cfs_rq *cfs_rq, int flags)

 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-       if (cfs_rq->load.weight)
-               return false;
-
-       if (cfs_rq->avg.load_sum)
-               return false;
-
-       if (cfs_rq->avg.util_sum)
-               return false;
-
-       if (cfs_rq->avg.runnable_sum)
-               return false;
-
-       return true;
-}
-
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
@@ -4109,11 +4094,6 @@ static inline void update_misfit_status(struct
task_struct *p, struct rq *rq)

 #else /* CONFIG_SMP */

-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-       return true;
-}
-
 #define UPDATE_TG      0x0
 #define SKIP_AGE_LOAD  0x0
 #define DO_ATTACH      0x0
@@ -4771,10 +4751,11 @@ static int tg_unthrottle_up(struct task_group
*tg, void *data)
        if (!cfs_rq->throttle_count) {
                cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
                                             cfs_rq->throttled_clock_task;
-
-               /* Add cfs_rq with load or one or more already running
entities to the list */
-               if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
+               if (cfs_rq->insert_on_unthrottle) {
                        list_add_leaf_cfs_rq(cfs_rq);
+                       if (tg->parent)
+
tg->parent->cfs_rq[cpu_of(rq)]->insert_on_unthrottle = true;
+                       }
        }

        return 0;
@@ -4788,7 +4769,7 @@ static int tg_throttle_down(struct task_group
*tg, void *data)
        /* group is entering throttled state, stop time */
        if (!cfs_rq->throttle_count) {
                cfs_rq->throttled_clock_task = rq_clock_task(rq);
-               list_del_leaf_cfs_rq(cfs_rq);
+               cfs_rq->insert_on_unthrottle = list_del_leaf_cfs_rq(cfs_rq);
        }
        cfs_rq->throttle_count++;

@@ -8019,6 +8000,23 @@ static bool __update_blocked_others(struct rq
*rq, bool *done)

 #ifdef CONFIG_FAIR_GROUP_SCHED

+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+       if (cfs_rq->load.weight)
+               return false;
+
+       if (cfs_rq->avg.load_sum)
+               return false;
+
+       if (cfs_rq->avg.util_sum)
+               return false;
+
+       if (cfs_rq->avg.runnable_sum)
+               return false;
+
+       return true;
+}
+
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
        struct cfs_rq *cfs_rq, *pos;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..12a707d99ee6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -602,6 +602,7 @@ struct cfs_rq {
        u64                     throttled_clock_task_time;
        int                     throttled;
        int                     throttle_count;
+       int                     insert_on_unthrottle;
        struct list_head        throttled_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
