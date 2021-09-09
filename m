Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263A4046A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhIIIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhIIIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776DC0612E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:59:00 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so2348219qke.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BgSZ4vSJq8yMEzglfnZjYa+8waXeoxZVtlTqeFJqwWk=;
        b=Wwf9fIqCnVY717dAREfz420rr5LxbSC0AT9GADAwJE1K1IMMORkr8RM3fXOfpR8V6I
         WOc5sVHE5GyGKkl0MrMhdEKHSTIUxAmMpBy32KNJxrZtsKs12g+yZIUBNb28sWjTBaX5
         Lek2LZm5d0biVht8EuJxSK0QaDiMKlVjvafLO2MERwvBStW1BU/VMsBjLWb0HzN4SVZ0
         eNy4R4zwIiYiuZM7ljf4/2iuHbF6Rr/fJPmqwCnblQhvVR8EYAAaOgqI1hsv4KkZn8WH
         wBIZ1ALgEzuWFWODjBn92UBHD1liv3JCtarHO+Ksl99QTm/MWGflwvcjE2CEyYOfebPS
         aGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BgSZ4vSJq8yMEzglfnZjYa+8waXeoxZVtlTqeFJqwWk=;
        b=1vrIUoYZ0cOL+xDFM+FM7i/eRN3id1oKra9wR/YbuNBoi3CXiXnKiZm8TR5LHfWJ95
         LwDHGYkD+00VQZSTBl0jvAL9hN8Mbrde2Ivz1VswFkApCAXkzkFRPJd9pEb7eVXdh2XS
         wH2ruK9nXPLm2WzgCl8xX4iRdgfRLkUdJg54uWTIfCnfVzNiVIh4vYwy7rNB0+6P6mCk
         0JE7glZrnQ3+03cYOOVi0ZOsdsyI8KVwX3j/wBZBQWGiRfinkx3silPMPa6x2hLJlH+H
         rsg20Wvixe0BL0Eu/GCIbYWy9hnQjyekirL5CB65Uwwv1QBuBK2q26lt8az3J+6NvNbA
         n4gg==
X-Gm-Message-State: AOAM532lMt0wb/CMxEz/9X3iI9alvx89WogZLGv4m2u/40g4Ezqzbvz7
        V89KfzfHnj18Cd8ZjNrofRm6KFCit80U5LoOuaDtMgECpaD0pGjA3i/MVjvydqQcd3VLIz8lcWR
        HMGCZ1zKLyI0rcz6wX3ecadCyhIM4ht1I6dmvp8Rj96zbj2rpur5ViB3YX3/fO8Ifndllzl52
X-Google-Smtp-Source: ABdhPJyGw6VBn/j/nJq44wF7m5Ue27usJr7V9UWJ7krWBOOatrFdLViEnuO+m2vyWpsm6A7agHEyKPW0ZcYq
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a0c:d450:: with SMTP id
 r16mr1588087qvh.30.1631174339626; Thu, 09 Sep 2021 00:58:59 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:56 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-10-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 09/13] perf/x86/amd: add idle hooks for branch sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before entering low power
and re-enabled (if was active) when returning from low power. Otherwise, the NMI interrupt may
be held up for too long and cause problems. Stopping BRS will cause the NMI to be delivered if it
was held up.

This patch connects the branch sampling code to the perf_events idle callbacks.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c    | 25 +++++++++++++++++++++++++
 arch/x86/events/amd/core.c   |  4 ++++
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 23b969001857..7d27591ba537 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -146,6 +146,7 @@ void amd_brs_enable(void)
 
 	/* Set enable bit */
 	set_debug_extn_cfg(cfg.val);
+	perf_lopwr_active_inc();
 }
 
 void amd_brs_disable(void)
@@ -175,6 +176,7 @@ void amd_brs_disable(void)
 		cfg.brsmen = 0;
 		set_debug_extn_cfg(cfg.val);
 	}
+	perf_lopwr_active_dec();
 }
 
 static bool amd_brs_match_plm(struct perf_event *event, u64 to)
@@ -292,6 +294,29 @@ static void amd_brs_poison_buffer(void)
 	wrmsrl(brs_to(idx), BRS_POISON);
 }
 
+/*
+ * called indirectly with irqs masked from mwait_idle_*()
+ */
+void amd_pmu_brs_lopwr_cb(bool lopwr_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union amd_debug_extn_cfg cfg;
+
+	/*
+	 * on mwait in, we may end up in non C0 state.
+	 * we must disable branch sampling to avoid holding the NMI
+	 * for too long. We disable it in hardware but we
+	 * keep the state in cpuc, so we can re-enable.
+	 *
+	 * The hardware will deliver the NMI if needed when brsmen cleared
+	 */
+	if (cpuc->brs_active) {
+		cfg.val = get_debug_extn_cfg();
+		cfg.brsmen = !lopwr_in;
+		set_debug_extn_cfg(cfg.val);
+	}
+}
+
 /*
  * On context switch in, we need to make sure no samples from previous user
  * are left in the BRS.
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d6d5119260a9..3e1985cd414d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1184,12 +1184,16 @@ static int __init amd_core_pmu_init(void)
 		 * invoked on context-switch in via sched_task_in(), so enable only when necessary
 		 */
 		if (!amd_brs_init()) {
+			struct pmu *pmu = x86_get_pmu(smp_processor_id());
 			x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
 			x86_pmu.sched_task = amd_pmu_sched_task;
 			/*
 			 * The put_event_constraints callback is shared with
 			 * Fam17h, set above
 			 */
+
+			/* branch sampling must be stopped when entering low power */
+			perf_register_lopwr_cb(pmu, amd_pmu_brs_lopwr_cb);
 		}
 	}
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a275553e78b9..73eac9d34bd9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1242,6 +1242,7 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 }
 
 void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in);
+void amd_pmu_brs_lopwr_cb(bool lopwr_in);
 
 /*
  * check if BRS is activated on the CPU
-- 
2.33.0.153.gba50c8fa24-goog

