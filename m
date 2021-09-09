Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40684046A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhIIIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhIIIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8ADC06179A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:58 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so2646745qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8in3eNvKM5bNosYyw6M888LU8jMRnNBshM+fnnuLh8c=;
        b=knxMpAOztiiK7xjpLpYU/MIHLywg5ApNPRb4Zi/4A04IAwhqcFadN6s2wMfTMyghXX
         jn9k/x6cAH9N21ATOMvLbadZd54XJ4hlWBHQ5k7unbxJIIt02wtEcU/0LnTx0Wofs7ED
         7/RtO+DkMb+0mr7VDZv1n+YFjj21X8qGMPPjYn3L45ExuYvtPkLSl6ERB4IQh+yA2zl6
         QPiUqJQRvggSm5ucd7RHH61ZvJPCl2k1cpCQtlhBz2CpmVskak4QuuSn9NptU0f4sO3h
         ciyVWPUX1HRivPopWr7JBzGKumvbalLn586wonBFhKvsZ6rmDQAGOGYMMdvMvuRLmdaN
         p9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8in3eNvKM5bNosYyw6M888LU8jMRnNBshM+fnnuLh8c=;
        b=5JZwMLEG9fyi96XvIJ2cHNexoSSTECXhVV84QIvMnVvVsnbC0UsBD6GxUSxGkwe+ma
         KlrqLnUd0Addge9hylUlPK5YgDabz/jxT5RgxJ/nZ9mCtMgXUXNaoJwhCTU3UB1zVQgY
         VWZClEMuuDWFllmL3F673cfzHND6P1k0R3UmdtHvtHhVVtzYBybtDfAUZMtex1SguM33
         pb5Bc7zVBYGsTRd22hWzFdw6IKzg+hJI8Gbha/9HwRMZclR8Yv/p48FZf7d07xGWIHRw
         WybCHDeKHgbjS9r0MaZ0IEqSOV7puh3t0chRDr56+g2ziRXP4WXiRbc3u1OWQEkBg/SA
         As+A==
X-Gm-Message-State: AOAM531oJ9efilCBRZYA+saC+TWo9Ool+WF1yGZL30rQ/NsptMQnj0A7
        YU6C6sbS6GsOAwUY8DutY0mOe+Db5GV49CUCCfpSImgH1J/5tfW9qg/2ZacN3cNJiFzJjjKGkZ1
        oBMHyb1OQNlwGY9pfhCb78NsSrujqcLn0/k+6RymCPQalJZvlN6jFTbxjnii41v4UJ0Gq7XEv
X-Google-Smtp-Source: ABdhPJwx16fXLEo1qUNzeVLG4/uTtMZ90O/HfTBkHzW+E0RS3aKXaaQceZfYz/mqKFFzCbBwjWHUQU9WeLZS
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a0c:c2c1:: with SMTP id
 c1mr1580685qvi.59.1631174337492; Thu, 09 Sep 2021 00:58:57 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:55 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-9-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 08/13] perf/x86/core: add idle hooks
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the perf idle hooks x86 idle routines.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/mwait.h |  6 +++++-
 kernel/sched/idle.c          | 12 ++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 29dd27b5a339..92080fdc1d2a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
+#include <linux/perf_event.h>
 
 #include <asm/cpufeature.h>
 #include <asm/nospec-branch.h>
@@ -114,8 +115,11 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
+		if (!need_resched()) {
+			perf_lopwr_cb(true);
 			__mwait(eax, ecx);
+			perf_lopwr_cb(false);
+		}
 	}
 	current_clr_polling();
 }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 14ce130aee1b..c0ddc3c32a33 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,7 +179,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (need_resched()) {
 		local_irq_enable();
-		perf_lopwr_cb(false);
 		return;
 	}
 
@@ -230,6 +229,9 @@ static void cpuidle_idle_call(void)
 		tick_nohz_idle_stop_tick();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
+		if (!cpu_idle_force_poll)
+			perf_lopwr_cb(true);
+
 		call_cpuidle(drv, dev, next_state);
 	} else {
 		bool stop_tick = true;
@@ -244,12 +246,17 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
+		if (!cpu_idle_force_poll)
+			perf_lopwr_cb(true);
+
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
 		 */
 		cpuidle_reflect(dev, entered_state);
 	}
+	if (!cpu_idle_force_poll)
+		perf_lopwr_cb(false);
 
 exit_idle:
 	__current_set_polling();
@@ -259,7 +266,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (WARN_ON_ONCE(irqs_disabled())) {
 		local_irq_enable();
-		perf_lopwr_cb(false);
 	}
 }
 
@@ -293,8 +299,6 @@ static void do_idle(void)
 	while (!need_resched()) {
 		rmb();
 
-		perf_lopwr_cb(true);
-
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-- 
2.33.0.153.gba50c8fa24-goog

