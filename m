Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167EC316131
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBJIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBJIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:34:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E084C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e7so779249pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axC5GN60Y7bXFrS3Lq1oTVI8eOvE2cwq/4TZ5xWus2k=;
        b=dSfPu9MR1mh3dcCP/G9ng1u2/HsUuvJse2mdp+G5+IXTn97u6Nbw2tdcBEN/5O0TZO
         ytkI1jsiCeTa6t/eSjVCxGbhryuwvf+cl6B9/6KhT/iiCkvCf1BLcJVAMmdEu8y1j8N5
         hLzVtgVzx8MQ9djgbmU2xMzTs+c+/swdmI51adv0NryWoUDw7d2g23uMXExws2CXJrvv
         maqcRvssyTCQqvfgOm+i9ikEX7Hn1o6aEDvYaduo6fwu6oWgyHGcWVhPeC0cVljhNdWS
         t59ZScHLzaqG7rW7fMFK2FsHlfDixCnpCWZ1JWCaRgydy+cyJG4hU2OkBUZtSO/wQmRf
         uC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=axC5GN60Y7bXFrS3Lq1oTVI8eOvE2cwq/4TZ5xWus2k=;
        b=lxL14Y5cQjk9pp89ZdRZ2Jx+s3ZnVW98yA4BkXT67a6QUnRUUtwZ1PeJjzbb8IDFKk
         ayDUqccT5+LY+tRN85a9IKiZw1orxkBLBeaEzduxa8KezwE3DhgrS40sorg1TDr9xmy2
         nlwjPP7zbpkw7JDsUY3YSrEOxPwqCV1TI9yQKF0wVaqDpfAVaaQK/W4JZuSImPdoFRgZ
         oAZ1c7TgY15tQxTKpjABBnfQ+IHtwSqEkP7r1Q8OYjEqQ848Mg9ven89OA1AeQBV+c3I
         3XR6Nmz2B04qjvAle54wjVq08zJTF66GhM2vlKcTVA+o2VEdELHw1NxaBL8kSFXzWNwc
         zp0Q==
X-Gm-Message-State: AOAM530gJrv2+rEzFXsAgKYYYWlLVlSqy+AyqFKnRpYVEFuuhHa7pdgY
        adtWEoB948AlJ4Ke4OEtLlU=
X-Google-Smtp-Source: ABdhPJzX3YmPE+tyxDdCJdG/pYi7wu2lxLINFJMD3CqpuBN1eSaZNNFx5rw3jEL/zWLrvKOAM77LAg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr2133514pgc.423.1612946015739;
        Wed, 10 Feb 2021 00:33:35 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id l21sm1401341pjy.31.2021.02.10.00.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:33:32 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 1/3] perf core: Factor out __perf_sw_event_sched
Date:   Wed, 10 Feb 2021 17:33:25 +0900
Message-Id: <20210210083327.22726-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, we need to check more than whether the software event
is enabled.  So split the condition check and the actual event
handling.  This is a preparation for the next change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fab42cfbd350..2a1be6026a2f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1174,30 +1174,24 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
  * which is guaranteed by us not actually scheduling inside other swevents
  * because those disable preemption.
  */
-static __always_inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
+static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id])) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
+	struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
 
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(event_id, nr, regs, addr);
-	}
+	perf_fetch_caller_regs(regs);
+	___perf_sw_event(event_id, nr, regs, addr);
 }
 
 extern struct static_key_false perf_sched_events;
 
-static __always_inline bool
-perf_sw_migrate_enabled(void)
+static __always_inline bool __perf_sw_enabled(int swevt)
 {
-	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
-		return true;
-	return false;
+	return static_key_false(&perf_swevent_enabled[swevt]);
 }
 
 static inline void perf_event_task_migrate(struct task_struct *task)
 {
-	if (perf_sw_migrate_enabled())
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
 		task->sched_migrated = 1;
 }
 
@@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_in(prev, task);
 
-	if (perf_sw_migrate_enabled() && task->sched_migrated) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
-
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
+	    task->sched_migrated) {
+		__perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
 		task->sched_migrated = 0;
 	}
 }
@@ -1219,7 +1211,8 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 static inline void perf_event_task_sched_out(struct task_struct *prev,
 					     struct task_struct *next)
 {
-	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
+		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
 
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
@@ -1475,8 +1468,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)			{ }
-static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
 static inline int perf_register_guest_info_callbacks
-- 
2.30.0.478.g8a0d178c01-goog

