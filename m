Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59E314614
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBICMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBICMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:12:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A6C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:12:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so749923pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bMTb1SiUkPIVHGlvKm64n9tcLssKrIhbRkdSh07bVg=;
        b=07gVrzt/GIGu4WFROZlJv/9+SdxsR9m5e4UMDUn9+MPXS1z9jhIQCX/vILmVxK+DEy
         B7DTlhcB06TWA4LiEfJ+ggDW7mbVeANk6yO6FOnbCirAZ3szitXiV35DGuWOjU/IMVb7
         682Zh+q0IWRLY32dXMYclBwda1i8E6Di8ps4xJc9c5kTBHyp7OP/ABH/ffDyj9Ra1MC/
         B1BTz2I7ZSCloVg4l/tx1U8WHGDOeJF51creNx0tD/i2kmslB9gk+8eutWApMk5DX8T2
         OOjGg0WTF9w90RKTyDs3D5O8FSLIxmRJJtwIyk2HoMPK0+9SgjhbDKBEd7Mj77EEDiqe
         SFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bMTb1SiUkPIVHGlvKm64n9tcLssKrIhbRkdSh07bVg=;
        b=MrsbPeDj7Ty27K4k7DyFUQA+EPDmo9duwQlXD73xYPelqarnB51RZ3p3i0V6dQ781M
         OlenbzFkO/SkojtlAhIYhhZwLR9AftpHHRMiE54R3yZ28Iwd6l4rPV//imJNwe6uHV4h
         Xrj4CWnuPSkokSGPv5a0U12tgaXn/hDwdh0tXj1bAsNcYud7WSr1N17ksIdOgbjfsSB1
         Ql/fhrxavWx+b6gmoTlU4/nFB2buyshPtqdkMF9qifn6yln4IPtN7hWlFeKPC+G+wv41
         QZTu7qXPPiMoUuc2goYH904jM+oPZX11ObMFbos0odzVY0uYgtn+ukRXW+w2dzgAjxQz
         Sbng==
X-Gm-Message-State: AOAM531GM8LayTmh2qprffCsTKyXJ244ARIdhNrQpgyc1BQ364Ykwdq0
        PnMpsouN+AV4MiSws4WCDYXQ+A==
X-Google-Smtp-Source: ABdhPJyDtUfCGC3OGL4DJP8V2r2ZYw1xVnD1CNNM29Vn2mzO+5lG9CNlfishCCezzn7UOWywjhfACg==
X-Received: by 2002:a17:90b:250:: with SMTP id fz16mr1685950pjb.227.1612836731967;
        Mon, 08 Feb 2021 18:12:11 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id s126sm16608492pfs.81.2021.02.08.18.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 18:12:11 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2] psi: Add PSI_CPU_FULL state
Date:   Tue,  9 Feb 2021 10:12:03 +0800
Message-Id: <20210209021203.3631-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FULL state doesn't exist for the CPU resource at the system level,
but exist at the cgroup level, means all non-idle tasks in a cgroup are
delayed on the CPU resource which used by others outside of the cgroup
or throttled by the cgroup cpu.max configuration.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi_types.h |  3 ++-
 kernel/sched/psi.c        | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index b95f3211566a..0a23300d49af 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -50,9 +50,10 @@ enum psi_states {
 	PSI_MEM_SOME,
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
+	PSI_CPU_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 6,
+	NR_PSI_STATES = 7,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..2293c45d289d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -34,7 +34,10 @@
  * delayed on that resource such that nobody is advancing and the CPU
  * goes idle. This leaves both workload and CPU unproductive.
  *
- * (Naturally, the FULL state doesn't exist for the CPU resource.)
+ * Naturally, the FULL state doesn't exist for the CPU resource at the
+ * system level, but exist at the cgroup level, means all non-idle tasks
+ * in a cgroup are delayed on the CPU resource which used by others outside
+ * of the cgroup or throttled by the cgroup cpu.max configuration.
  *
  *	SOME = nr_delayed_tasks != 0
  *	FULL = nr_delayed_tasks != 0 && nr_running_tasks == 0
@@ -225,6 +228,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
 		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+	case PSI_CPU_FULL:
+		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -678,8 +683,11 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (groupc->state_mask & (1 << PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
 		groupc->times[PSI_CPU_SOME] += delta;
+		if (groupc->state_mask & (1 << PSI_CPU_FULL))
+			groupc->times[PSI_CPU_FULL] += delta;
+	}
 
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
@@ -1018,7 +1026,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2 - (res == PSI_CPU); full++) {
+	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
 		u64 total;
 		int w;
-- 
2.11.0

