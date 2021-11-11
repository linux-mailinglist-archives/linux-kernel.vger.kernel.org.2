Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02844CE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhKKAYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhKKAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22385C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so2903402pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o2s1HY6bRmLdL93aXDkhFToh+qetSVkME/+Sdbttsko=;
        b=mVX4V6zF0dIRE/JQnNTLYXiozq0p7PGldkDIngFdUfStiTyhQjY1arMLWPx6VRsIgf
         g/GgW+eG4Ty6A9XreeYSAmXScdrpSeYOa0kh0y6sGdCKQdJlu6CiOYvWug5pWQ41+GCl
         JMNhhZpuer/SH4fqSe8UytlqIjLHH9KLnw6L2nJHwON8QYU1I64SvpmZVsR+rTNv6oqI
         n+wA4Jhhmv1fVJPbyLcdkeq6zTnCH0CVUpmQM/nnMWIQ1XGH0Er2PDn61eZGKNXSKcPZ
         jrfyk5HV3vKUjAv3gZeP3LVLFK0+sGYypulnVvaFXBDrWJuOTKucDZdfNoVvNxP9YQo8
         Rk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o2s1HY6bRmLdL93aXDkhFToh+qetSVkME/+Sdbttsko=;
        b=pSK0zwHxFs+OYVc9MCQZ+lQpJuO6p6xdIzCOi4NWNSvE+SZYr9hYqeKPDeI57uDdZY
         C/pzoMnS/Fgjbkuba6vDSQ3ohIbWgf5gt44olbIoFTAyrAg+jKrkz1EoWkMWMfgLuVkB
         LKsFSnhHzrbHewar2MvaFzOlbUUWfKijNdJUmQv1VzE7PxVu2cDz7C5tAC7fMlIZFjND
         l7YmFAocMVGQ6jymrMBsKyhJVrguLWdTyNGXC6l7RhYYkfRTDCdpEriX/dtqOVLwR6Nw
         0NzwGjiLWvn/ARvHmHKwamFd9gpXI7RiKIG7sBzhiiX1Erz2x01D0LxRClf0iEXHOTYG
         aQRQ==
X-Gm-Message-State: AOAM532/wufMa+VYmkZX5JySYmeqJZH26P/OVUd1o5HP6tY12x2MZadm
        R0F6EmKKVMp7Kb/XbjkrtBV7+eOULKUw
X-Google-Smtp-Source: ABdhPJzAkr9+M7qQY2UeoRH4MD8qJHSGO8hpsAhC7HVz2ihHE6lblwYSQzzN/R25pJmC2iefipmDInu7BOt+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr99315pjf.1.1636590083028; Wed, 10 Nov 2021 16:21:23 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:05 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-5-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 4/8] perf cputopo: Match thread_siblings to topology ABI name
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topology name for thread_siblings is core_cpus_list, use this for
consistency and add documentation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 26 +++++++++++++-------------
 tools/perf/util/cputopo.h | 11 +++++++++--
 tools/perf/util/header.c  |  6 +++---
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 420aeda16fbb..51b429c86f98 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -20,10 +20,10 @@
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define DIE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
-#define THRD_SIB_FMT \
-	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
-#define THRD_SIB_FMT_NEW \
+#define CORE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"
+#define CORE_CPUS_FMT_OLD \
+	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 #define NODE_ONLINE_FMT \
 	"%s/devices/system/node/online"
 #define NODE_MEMINFO_FMT \
@@ -104,10 +104,10 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT_NEW,
+	scnprintf(filename, MAXPATHLEN, CORE_CPUS_FMT,
 		  sysfs__mountpoint(), cpu);
 	if (access(filename, F_OK) == -1) {
-		scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+		scnprintf(filename, MAXPATHLEN, CORE_CPUS_FMT_OLD,
 			  sysfs__mountpoint(), cpu);
 	}
 	fp = fopen(filename, "r");
@@ -121,13 +121,13 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	if (p)
 		*p = '\0';
 
-	for (i = 0; i < tp->thread_sib; i++) {
-		if (!strcmp(buf, tp->thread_siblings[i]))
+	for (i = 0; i < tp->core_cpus_lists; i++) {
+		if (!strcmp(buf, tp->core_cpus_list[i]))
 			break;
 	}
-	if (i == tp->thread_sib) {
-		tp->thread_siblings[i] = buf;
-		tp->thread_sib++;
+	if (i == tp->core_cpus_lists) {
+		tp->core_cpus_list[i] = buf;
+		tp->core_cpus_lists++;
 		buf = NULL;
 	}
 	ret = 0;
@@ -151,8 +151,8 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	for (i = 0 ; i < tp->die_cpus_lists; i++)
 		zfree(&tp->die_cpus_list[i]);
 
-	for (i = 0 ; i < tp->thread_sib; i++)
-		zfree(&tp->thread_siblings[i]);
+	for (i = 0 ; i < tp->core_cpus_lists; i++)
+		zfree(&tp->core_cpus_list[i]);
 
 	free(tp);
 }
@@ -215,7 +215,7 @@ struct cpu_topology *cpu_topology__new(void)
 		tp->die_cpus_list = addr;
 		addr += sz;
 	}
-	tp->thread_siblings = addr;
+	tp->core_cpus_list = addr;
 
 	for (i = 0; i < nr; i++) {
 		if (!cpu_map__has(map, i))
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index a3e01c367853..854e18f9041e 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -9,7 +9,8 @@ struct cpu_topology {
 	u32	  package_cpus_lists;
 	/* The number of unique die_cpu_lists below. */
 	u32	  die_cpus_lists;
-	u32	  thread_sib;
+	/* The number of unique core_cpu_lists below. */
+	u32	  core_cpus_lists;
 	/*
 	 * An array of strings where each string is unique and read from
 	 * /sys/devices/system/cpu/cpuX/topology/package_cpus_list. From the ABI
@@ -24,7 +25,13 @@ struct cpu_topology {
 	 * The format is like 0-3, 8-11, 14,17.
 	 */
 	const char **die_cpus_list;
-	char	**thread_siblings;
+	/*
+	 * An array of string where each string is unique and from
+	 * /sys/devices/system/cpu/cpuX/topology/core_cpus_list. From the ABI
+	 * each of these is a human-readable list of CPUs within the same
+	 * core. The format is like 0-3, 8-11, 14,17.
+	 */
+	const char **core_cpus_list;
 };
 
 struct numa_topology_node {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e2ba261d1583..fda8d14c891f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -592,12 +592,12 @@ static int write_cpu_topology(struct feat_fd *ff,
 		if (ret < 0)
 			goto done;
 	}
-	ret = do_write(ff, &tp->thread_sib, sizeof(tp->thread_sib));
+	ret = do_write(ff, &tp->core_cpus_lists, sizeof(tp->core_cpus_lists));
 	if (ret < 0)
 		goto done;
 
-	for (i = 0; i < tp->thread_sib; i++) {
-		ret = do_write_string(ff, tp->thread_siblings[i]);
+	for (i = 0; i < tp->core_cpus_lists; i++) {
+		ret = do_write_string(ff, tp->core_cpus_list[i]);
 		if (ret < 0)
 			break;
 	}
-- 
2.34.0.rc1.387.gb447b232ab-goog

