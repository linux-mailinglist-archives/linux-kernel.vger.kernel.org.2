Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA16734F76F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCaDZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhCaDYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:24:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A501DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so8786172pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=QL/LyJZrL/rwgnijucflVxg1r7dA+9W8RgZHAPEEOhU=;
        b=sAIiuRCgsEJt6I8UHQJ8+/ap7by0u3WLqkbctPHvqkUcyXVF5Ibwonb9zYp5T3uFtn
         lCX+yVdgFGf87bD7gQfJPOhUVJMkIE2AU6wJDV/P/Qql1azBNlw9JwE5THa11DD6POeX
         F7YhQ4UjAfyEmTfC+B0mRZXigL1ZHBfNmdc56zvSNZ64oicH2eCdvZiXvaN1hEJ09ZKo
         mqN0g3I8n766vuKG1opHxolgpyrpIj/ydM44U2bLUYCZ1frOkjWqeFUYyMYbgzTwFPqV
         bTjKljZ0wQybz5qn8QtE5zwFsA2pwQt5cYWcxu7lvGRsi3PAfgP/WoSjKnsppxLT82bA
         lJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QL/LyJZrL/rwgnijucflVxg1r7dA+9W8RgZHAPEEOhU=;
        b=cDt3HhTjqi7Ffo2QEuF6dJ1nh+mt8gZg/WXkNXy/27wsIoHEbFerZ9ajdh/ZH/dYWu
         K0azHoEaWAnQqk57dVBkSsiSPS06Knr7FuIlcKgevytduAWhAxPsWARDt6kw2WODlG9Z
         cfnAsM1pfCww46GKh8hNUV0o93jLxrgCv8OZL2kax4ze5EOAArYfT0ZQCpywjXjkuy/S
         Mg3vsjwbI+biw24odTEIpvWt022Q/zpaPr8tObh63NWvSnBivQIBlczVgbJhOaECuh0P
         w6e/AH4KFlmMnaTIxkkBXshTyVJC2+HCi8aaGnnYPFTIb/6Yzpdh5a+Wj6C2I/C6+NYm
         XUQQ==
X-Gm-Message-State: AOAM533rK41jnOCRbhsp668S4fHd34fQ/3ULwAx4JTkcMTG8IGe1aZbh
        UzUJ7cEWf+p7yOQVJDZq+/s=
X-Google-Smtp-Source: ABdhPJyxVs/XzoDUEN0ZcngbFMwb2xsj8HkoIUjcNhxMzXbh71bDKe2A0A4m+SqAyETNGMuLMfblHg==
X-Received: by 2002:a17:90a:420d:: with SMTP id o13mr1411238pjg.61.1617161087270;
        Tue, 30 Mar 2021 20:24:47 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id v13sm401196pfu.54.2021.03.30.20.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 20:24:46 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] delayacct: Add a proc file to dump the delay info
Date:   Wed, 31 Mar 2021 11:24:40 +0800
Message-Id: <ae6cefb8084b702e03036a0ab44a3323e1c688fd.1617160582.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
References: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
In-Reply-To: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
References: <afa2680e20e82cd0454234e3acd070286365f248.1617160582.git.brookxu@tencent.com>
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
+		seq_printf(m, "%s %llu %llu %llu %llu\n",
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

