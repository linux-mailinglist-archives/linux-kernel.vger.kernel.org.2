Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F90364646
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhDSOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhDSOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:37:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15237C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:37:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g16so10017394pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=kAefkyFaBIXLmjTEJSLAmCovAj/sOKipvNUJKWBPzMo=;
        b=sXPC0bki/h8OXmhIMllb/gFHXCwGt0/ujMMP06AO5/NLRCas0Zvih2xI3Mwu4zWIvP
         YrOO2snNp6sGObZpNqm6/UrBoA17bzK2/kIUHOi6Ws3qqzKCnaWANbr/TYxnFEAlS+3E
         8k/4nn3kDTMyUopy82vtsCnpqnpCOPXbNlH1y3obHG5TXMXhOlWzdzDRwidD99Yh1bvJ
         Kx4Jr/scI/AaBvZfsoIjM92CDKB5PgRlumTYLYzWDOjNvriNPRCmLD21hgABsleargnr
         x0RmHbSdjSKWoXTh0M4RlXYTMBBjyp9ILFcWmwS15DKAg6gQAdzS2AusR2WZgNiKhROy
         JYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kAefkyFaBIXLmjTEJSLAmCovAj/sOKipvNUJKWBPzMo=;
        b=WVBscWe6LLQ64eMVNQUSXANOH8+ZC+qNfAi4vGIw91fN1cpLM9kX7WeLSBSfAVj7Qj
         96k/6/p4P2QZsyx2PG1dDtZv6Ri5khpx43rp0Kz7pYmWoC9naijVLSBMQukkUmRKHmV7
         uwoPV9Y7/FZL5Vn8UWH9l1SkptYx0p8qqFOJJUpFLaYZBav/DOF2VR8dvLC0w/Zs42y7
         iFq1jPBaom+bNH/QaZ2ytIzkSPSy30Vk8LdMsgsv0ofxSahemfKRrfICchoZAtkter2U
         Xmm8aN9uWl5D0Ofu2GUktdAQ8YX3goy7YmclDEHksLBupkZbqxX3L0hVu8lY1OuBMK6s
         AQXw==
X-Gm-Message-State: AOAM532Izl1IJYXtUJzeJrDXQtuob5EFqIXhEipqoeHua7bj+k9NF8ET
        prH/bgxOgAM6e6UvTfA8Ttw=
X-Google-Smtp-Source: ABdhPJwH1WdUmLq/+JAXDVNRvAyUQ6jQhJCH8kfnz8oM53cQZtb/z5vitkqPEa03+EdgcCGuahroZA==
X-Received: by 2002:a63:b00b:: with SMTP id h11mr11933818pgf.204.1618843032680;
        Mon, 19 Apr 2021 07:37:12 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k21sm9403134pff.214.2021.04.19.07.37.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Apr 2021 07:37:12 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] delayacct: add a proc file to dump the delay info
Date:   Mon, 19 Apr 2021 22:37:07 +0800
Message-Id: <3da76d1d565c423c6cbf92b02cbae9f86cd5accd.1618841970.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
References: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
In-Reply-To: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
References: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Many distributions do not install the getdelay tool by
default, similar to task_io_accounting, adding a proc
file to make access easier.

v2: Fix some errors prompted by the kernel test robot.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reported-by: kernel test robot <lkp@intel.com>
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
index ec580cb..87d091a 100644
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
+static struct delayacct_stat delayacct_stats[] = {
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
 
+#define K(x) ({ u64 _tmp = x; do_div(_tmp, 1000); _tmp; })
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
+		u64 mean = delays[item].delay;
+
+		if (delays[item].count)
+			do_div(mean, delays[item].count);
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

