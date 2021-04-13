Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3511B35D4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbhDMBiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhDMBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:37:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:37:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so9838827pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=fkN7J03LraYcy/+AQdcfdiwi7rrGwjEgEPcz1nrHPII=;
        b=iMO7JIpupbTrN73WH109ZvV6tpnjW+HE7JlEmzHlV23bVlAPDXVF4mI+dUz9+gYp92
         gR5pgwJ4s0Ai1FMHgo2++NFhEeUFHlffs95OcU509OkV4NXEDCSjOGvde8xPg4i38mf/
         KhhVR55klYon3f9bm5FgxGA8M7hD9JcYVkFB5S9XOmx3dutxKFGDek4LSDMzT+fxhLCf
         s0/HmHOxYAzQgdXGQ0sKx616i+TA39K6ujujC8UT+Wm8ygwpqM7taUdfvu2dbDzclkvC
         mi4iHL8l3PEZKG0M5mEQJ60kNv+H9MQpRcdAYwhW76fYUXjMO1Bt0P5GFi7p2qrnithA
         4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fkN7J03LraYcy/+AQdcfdiwi7rrGwjEgEPcz1nrHPII=;
        b=sjAHTRBnVKhB/VHr1Vkiq0mlCiwfVmry6zuy5HVZkvcLbvlcWbgze74jVB7gtfp3ot
         NCX6hK1XpJmiNWZBqc5pbGVX3IvsQFAnxOl5Cf/IF8/Q3i/EkIT6N2BtLUVFL2bwbv+8
         Bg+meqnMYrY7qDtEi2AsfVYrEUUJDicQ5XZA7KQyZpmNiqGHddtTfL91+ZoYevE18k4O
         06gzDLqeh/7Q63g6ETGdMPbUCvvQS3+cKhX9dYylwUuLsIAvPAdIIty72g6JRoLqTGhF
         fXG2eBEGKMcPkechKWYeO6+loTRTIe/RMefPKQrF44GUlXBboSbyC5gLXnBPvfjNuW0d
         QGVQ==
X-Gm-Message-State: AOAM531N002OITNC4R/GbDGkg/oeideDOmpMiPqHHme7DogK2Cv7a7N1
        XC6yRdk+/wL5hPbvfThAYmsp2zG+Z1E4Yg==
X-Google-Smtp-Source: ABdhPJyg+zehqB0oPInUuoc0xlS+d9bcjXyD6RLLwvedkBfEoKYRH4RpcGTgJzTVAAoUtSAbytGM/g==
X-Received: by 2002:a17:90b:3718:: with SMTP id mg24mr2130006pjb.164.1618277853443;
        Mon, 12 Apr 2021 18:37:33 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id l1sm12593282pgt.29.2021.04.12.18.37.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:37:33 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] delayacct: Add a proc file to dump the delay info
Date:   Tue, 13 Apr 2021 09:37:27 +0800
Message-Id: <99fd223ec19a6bc17fa5b39aaf6aed6cbdbea722.1618275619.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
References: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
In-Reply-To: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
References: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Many distributions do not install the getdelay tool by
default, similar to task_io_accounting, adding a proc
file to make access easier.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/proc/base.c     |  7 +++++++
 kernel/delayacct.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cd..4de261a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
+#include <linux/delayacct.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3244,6 +3245,9 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	ONE("delays",	S_IRUSR, proc_delayacct_show),
+#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
@@ -3583,6 +3587,9 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tid_io_accounting),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	ONE("delays",	S_IRUSR, proc_delayacct_show),
+#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index ec580cb..990af3b 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -14,6 +14,7 @@
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
 
 int delayacct_on __read_mostly = 1;	/* Delay accounting turned on/off */
 EXPORT_SYMBOL_GPL(delayacct_on);
@@ -26,6 +27,18 @@ static int __init delayacct_setup_disable(char *str)
 }
 __setup("nodelayacct", delayacct_setup_disable);
 
+struct delayacct_stat {
+	const char *name;
+	unsigned int idx;
+};
+
+struct delayacct_stat delayacct_stats[] = {
+	{"blkio", DELAYACCT_BLKIO},
+	{"swapin", DELAYACCT_SWAPIN},
+	{"pagecache_thrashing", DELAYACCT_THRASHING},
+	{"mem_reclaim", DELAYACCT_FREEPAGES}
+};
+
 void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
@@ -126,3 +139,31 @@ u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	return ret;
 }
 
+#define K(x) ((x) / 1000)
+
+int proc_delayacct_show(struct seq_file *m, struct pid_namespace *ns,
+		       struct pid *pid, struct task_struct *task)
+{
+	struct delayacct_count *delays;
+	int idx;
+
+	if (!task->delays)
+		return 0;
+
+	delays = task->delays->delays;
+	for (idx = 0; idx < ARRAY_SIZE(delayacct_stats); idx++) {
+		u32 item = delayacct_stats[idx].idx;
+		u64 mean = 0;
+
+		if (delays[item].count)
+			mean = div_u64(delays[item].delay, delays[item].count);
+
+		seq_printf(m, "%s %llu %llu %u %llu\n",
+			   delayacct_stats[idx].name,
+			   K(mean),
+			   K(delays[item].max),
+			   delays[item].count,
+			   K(delays[item].delay));
+	}
+	return 0;
+}
-- 
1.8.3.1

