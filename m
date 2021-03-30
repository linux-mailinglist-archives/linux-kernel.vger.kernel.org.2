Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FF34E0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhC3FYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhC3FX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:23:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F4C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:23:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so8846558pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwXr3vjSZpLIoOM9DoVVhO68I6yLdQil7+tSZVGbBzQ=;
        b=LF4uiDrp4dCGgZ0YXK3ZhTFQ60U3ryA246mKSr+8btsXJqp1+gS35Fp1JRhV/0vUIg
         qBdcRDfNVFr1l196pK72LfzlIHGFVSBSAyAl7WU1hCzBP5/oyzX4/LSVc2YZ8neTN+8Q
         EVZojeiuFKGeU8ourybIUKAbELQBJqmvNKC1r7hLFhgiboSf1pW9HRZN7tZDGpk6Vzc0
         MOCX+D1H/cZmu2Aj6hApV+TA7lltni/sOTzaQmvsGETqhJcaZlGh8tk5VZhxwdaxrKzm
         oMyAiCBDCXQ1Qtp4J2GMAZvWDFcLiK5RW9+VVge61QHYRSZCZWUZ4h+YpbjiPMpUzczs
         hEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwXr3vjSZpLIoOM9DoVVhO68I6yLdQil7+tSZVGbBzQ=;
        b=VCTnQJwYlQEjAefz/9v1q1+tj7nxyak63R2xnQTD4KRt51MNPvVAqGJ5GYB8+TjTFt
         fzBEOBDSWEAnNEhV/lTOkLfWhGmNaoPG9waT7G38AFXdNk6x8lUUGQDM6X6oftaORsuc
         dC+2qy6CWk9pN9FFWZtsoJroaIY/uiPoCtH4baAapoukehgJrRTE3n5vNM8RCI5MM1er
         6pNPBszAgFM2INusf+DCv+wz3avdSoiL6J6pjz2I2y5q33ab7yC3FXH6b6JaqschkiSS
         rBOnDxh6XcxwfKDYTHKwAxLLaUtF6aL8CJyHx7aCfn2WQWbVlYNdoUPZbamYyrludHEh
         gfRA==
X-Gm-Message-State: AOAM532qqu4JozdQVdO0VVIt7Tdg5INlKoIkGIGcbzM1EA41xqXPM+A+
        tmltST725RaJbwXTXLeEQCU=
X-Google-Smtp-Source: ABdhPJyfF1YIFxmPujUBgicXniCfgZNGT7jdHSt6tGSxkr+Qw6lurI/MIlRPAPYLZm5xINlkt2UCRg==
X-Received: by 2002:a17:90a:1b0e:: with SMTP id q14mr2505567pjq.41.1617081835595;
        Mon, 29 Mar 2021 22:23:55 -0700 (PDT)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y29sm19005832pfp.206.2021.03.29.22.23.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 22:23:55 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        quentin.perret@arm.com, zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: [PATCH] sched/fair: use signed long when compute energy delta in eas
Date:   Tue, 30 Mar 2021 13:21:54 +0800
Message-Id: <20210330052154.26861-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

now the energy delta compute as follow:

base_energy_pd = compute_energy(p, -1, pd);
	--->Traverse all CPUs in pd
	--->em_pd_energy()
----------------------------------------------------- \
search for the max_sapre_cap_cpu                       \
---------------------------------                       search time
cur_delta = compute_energy(p, max_spare_cap_cpu, pd);  /
	--->Traverse all CPUs in pd                   /
---------------------------------------------------- /
	--->em_pd_energy()
cur_delta -= base_energy_pd;

During the search_time, or when calculate the cpu_util in
compute_energy(), there may occurred task dequeue or cpu_util change,
it may cause the cur_energy < base_energy_pd, so the cur_delta
would be negative. But the cur_delta is unsigned long, at this time,
the cur_delta would always bigger than best_delta of last pd.

Change the vars to signed long.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..310d9d215cd7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6586,7 +6586,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
-	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
+	long prev_delta = LONG_MAX, best_delta = LONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	unsigned long cpu_cap, util, base_energy = 0;
 	int cpu, best_energy_cpu = prev_cpu;
@@ -6613,13 +6613,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
-		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		long cur_delta;
+		unsigned long spare_cap, max_spare_cap = 0;
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
-
-		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
-		base_energy += base_energy_pd;
+		bool prev_in_pd = false;
 
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
@@ -6641,13 +6639,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
-			/* Always use prev_cpu as a candidate. */
-			if (cpu == prev_cpu) {
-				prev_delta = compute_energy(p, prev_cpu, pd);
-				prev_delta -= base_energy_pd;
-				best_delta = min(best_delta, prev_delta);
-			}
-
+			if (cpu == prev_cpu)
+				prev_in_pd = true;
 			/*
 			 * Find the CPU with the maximum spare capacity in
 			 * the performance domain
@@ -6658,6 +6651,16 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
+		/* Compute the 'base' energy of the pd, without @p */
+		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy += base_energy_pd;
+
+		/* Always use prev_cpu as a candidate. */
+		if (prev_in_pd) {
+			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta -= base_energy_pd;
+			best_delta = min(best_delta, prev_delta);
+		}
 		/* Evaluate the energy impact of using this CPU. */
 		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
@@ -6675,7 +6678,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if (prev_delta == ULONG_MAX)
+	if (prev_delta == LONG_MAX)
 		return best_energy_cpu;
 
 	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
-- 
2.29.0

