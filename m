Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C2405879
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhIIOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbhIIOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:03:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E23C066426
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:00:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d17so901641plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=ZyboCNpRKmt5JAGuC0MIfoTudI4GGu+5XsEDI/iZI/k=;
        b=heUheBnqCJS87W1YfFuV3bopChXvsZsJyAslanU5R2faeilg2Y2QfyPeSgQXo2nCcR
         r1t2MnJDEUBWM8yiYsD6zqF5vVuM4Tnyuvh3nX0xk64YWJomDzDas3M/eZNOV/9EDb9Z
         7RzD+8XVelmSNGrGwWu2c4f4WjqMYjxGzZzEx8fGXikL9rTLw+t4mXI2jSkCYdIWL1xV
         7iFX5Bc36oaEJbDLwaTALZm3DRJV6RacT+gba+z2y7kPKdFTTpeLJzMhm9CqwIpncCEk
         Y/iRNR8QPp5dme85wCCbTWN0rJExoJhUyOIvImZPwByI1/ffHp3YF2wZn5NqXvGrkv0M
         kLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZyboCNpRKmt5JAGuC0MIfoTudI4GGu+5XsEDI/iZI/k=;
        b=uq/eS3DRWxN89DQZNbhWWxSM70m8JDa4/lHquiK6OT36EtcO1Z3GD1hNMDn51IAdMs
         vzeuBkqANFmpVa0kMgCnp86aObwJfQVIXHMiR3FDNFRXzIuKcJTWNnPsscF0td6d3cYV
         3Y3b5Ih7PcWlVWo08P/LpNczVAcHTlIXi1kw9NC9mMAQmDmL6oCP4CCtq2EPkJtHzrhW
         XMQNKXJsejtojx3HLPHOcYJmDFTxwDG11EHs9eZdBUaR//cmqCx2jnb6PPJ++tfe/t1J
         gqmY6C4L1ZPNVUhsou0jCi92lIr8wSrywE/16L+jCyAhqCmKD6QPgUokVu/fUHa+VSF1
         pQeg==
X-Gm-Message-State: AOAM5336snLBf0N/pSYYvcQogmucLni9NY4GXLBhD8jsvlxHa8gKf7Ur
        qaYCl51mzzdZpsGnFW7oYJKFzlNDnic=
X-Google-Smtp-Source: ABdhPJxbKK2BNr2HMUEo+ueZywAbPmd5BYIETKPzzMZ6FI1d+MKB+9k3K2jFd6Ak8DLepc5aKG9BsA==
X-Received: by 2002:a17:902:a3c1:b0:13a:47a:1c5a with SMTP id q1-20020a170902a3c100b0013a047a1c5amr2412858plb.13.1631188841846;
        Thu, 09 Sep 2021 05:00:41 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c9sm2370123pgq.58.2021.09.09.05.00.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:00:41 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: [RFC PATCH] psi : calc psi memstall time more precisely
Date:   Thu,  9 Sep 2021 20:00:24 +0800
Message-Id: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

psi's memstall time is counted as simple as exit - entry so far, which ignore
the task's off cpu time. Fix it by calc the percentage of off time via task and
rq's util and runq load.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/sched/psi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..6812c7e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -182,6 +182,8 @@ struct psi_group psi_system = {
 
 static void psi_avgs_work(struct work_struct *work);
 
+static unsigned long psi_memtime_fixup(u32 growth);
+
 static void group_init(struct psi_group *group)
 {
 	int cpu;
@@ -492,6 +494,23 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
+static unsigned long psi_memtime_fixup(u32 growth)
+{
+	struct rq *rq = task_rq(current);
+	unsigned long growth_fixed = (unsigned long)growth;
+
+	if !(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH)
+		return growth_fixed;
+
+	if ((current->in_memstall)
+		&& (current->se.avg.util_avg <= rq->cfs.avg.util_avg)
+		&& current->se.avg.util_avg != 0)
+		growth_fixed = div64_ul((current->se.avg.util_avg + 1) * growth,
+			rq->cfs.avg.util_avg + rq->avg_rt.util_avg + 1);
+
+	return growth_fixed;
+}
+
 static void init_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
@@ -658,6 +677,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 	}
 
 	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
+		delta = psi_memtime_fixup(delta);
 		groupc->times[PSI_MEM_SOME] += delta;
 		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
@@ -928,8 +948,8 @@ void psi_memstall_leave(unsigned long *flags)
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->in_memstall = 0;
 	psi_task_change(current, TSK_MEMSTALL, 0);
+	current->in_memstall = 0;
 
 	rq_unlock_irq(rq, &rf);
 }
-- 
1.9.1

