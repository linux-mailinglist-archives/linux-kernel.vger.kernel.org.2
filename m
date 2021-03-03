Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0A32BAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhCCLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352585AbhCCD4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:56:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F3C061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:47:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j12so15266494pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mikBinDMbyRpVEpCpcCv+zMSrFXfTIIjvNTlhZImavg=;
        b=Qbyu2CCXt/1FVCjpDjFCpFvzcKzHY5Z7YgcF/qgD3DrEeMeawUr5TPGj1IMyjJRksE
         4eoAjTfV9HKa68N0RTZZ3shWU7hFo4XZncMAnGQpAw3Q6uK6PIfKtgjAGi+68i8u9b13
         F1ne2HTfX7PU4qcRLtRWXjVKQ/Jmu0N2vgcG66xjrS01JkfFrtaUwQ6pkhdDkVEt8H09
         ejXqmSgL1ZU7tcwpcfpJwdHObvUbxHc4rcbHCevr7/BXszsrHk//5fblMYPFS3nbi0MO
         +YunGA0VtvzbQVtqKS0MZWHaH9jjvtlyhB0URhmelj0LU/8bBiCPBbjuvUhSJ1H3FCff
         FL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mikBinDMbyRpVEpCpcCv+zMSrFXfTIIjvNTlhZImavg=;
        b=tSffYxbx8ff0Ehl/pSZM+9/I+7gOdH7GLGW6Ul+na0Fpe+q2PrD64zbqhpOwcyU1Ef
         fHPdvA77Afe+ufQI3iL+UayLjWsD8Ts23vjw5PnUmzugxSmw3DifrnsLcecKn0YNQvH7
         I+hFW5JMWbFYVsF0dvX13vCktQQK5J4F2AADRT7oNiLTIgDwq352OSxQUhL2wnOqidvc
         7Wj5liAG3FqDef25FDXEXaz0SXHkukIaHJHh+/q5jnPgkcrYpRgY76KpNlCRx7/GWX2I
         v0ggQ3LJCde2PB18MHB0enhvg9fWiaxShikqefalPLAmv+91wAxu2C16fr7gHRM8tMTW
         3A3Q==
X-Gm-Message-State: AOAM5316SR6+Yl08jovC4kXoZyJL1EA4QZhdR529dvW0k/vtra5nHI3A
        N2UozDg76pDZ9JJ5sigQQdr0Lw==
X-Google-Smtp-Source: ABdhPJyMO5Hy0y3mxK60JsHtrzWWdevaVgfI3jIIyNzo8rAmyg4HT/aGQpOLa9w2vxoHu4g6sK7DnA==
X-Received: by 2002:aa7:92c7:0:b029:1ee:75b2:2dab with SMTP id k7-20020aa792c70000b02901ee75b22dabmr1376199pfa.61.1614743240055;
        Tue, 02 Mar 2021 19:47:20 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p26sm23029703pfn.127.2021.03.02.19.47.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 19:47:19 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2 3/4] psi: pressure states are unlikely
Date:   Wed,  3 Mar 2021 11:46:58 +0800
Message-Id: <20210303034659.91735-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210303034659.91735-1-zhouchengming@bytedance.com>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Move the unlikely branches out of line. This eliminates undesirable
jumps during wakeup and sleeps for workloads that aren't under any
sort of resource pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0fe6ff6a6a15..3907a6b847aa 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -219,17 +219,17 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 {
 	switch (state) {
 	case PSI_IO_SOME:
-		return tasks[NR_IOWAIT];
+		return unlikely(tasks[NR_IOWAIT]);
 	case PSI_IO_FULL:
-		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
 	case PSI_MEM_SOME:
-		return tasks[NR_MEMSTALL];
+		return unlikely(tasks[NR_MEMSTALL]);
 	case PSI_MEM_FULL:
-		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
-		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
+		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -729,7 +729,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
+	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	groupc->state_mask = state_mask;
-- 
2.11.0

