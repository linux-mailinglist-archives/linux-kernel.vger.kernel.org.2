Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC508368796
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhDVUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhDVUDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so70638421ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkWnCgvlzZOc7GDuxDqpwiNvgd9/wmq2P41XHrZMyMk=;
        b=BeFgRFPrZjtYaNpmQTOvHrWqWMrcTyxoPbL3+vzXzWfM6Kt0dK6dWA4+h+qrit1K+c
         1dcLGroBeVhIZx2s4RGo6VLCPrRJIr4kcs+eOnEpW38uFsJX8WSyfIYykumSRx3t7jgl
         i1CqNsDWxuc0uNO+rIkq8+2ZKp3q3l9sq8cHIGDv4KPkJzx04QVSvT41/y2YT8cN/4C3
         KCklccRnxsZUMu2UwrM3P/R6rw7fsXWiuHzLoikpf3SkBTBnoAOm9KvY8PFIfyKUVXKa
         9UZ+kh7qISf3HH7bcZHDyyydB4i8qS3IYTh29bk7VpYvGlXLeehuOPiT8PyG8S3OtcDN
         CFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkWnCgvlzZOc7GDuxDqpwiNvgd9/wmq2P41XHrZMyMk=;
        b=ojMLniErMmmml5nR0MnqWebaSKmFGCuw1aO2Xo2cfU7alF6D0SEN0MRbA5A2Gr+7m0
         uxWoUfwGtjkHY6JT/aRIKST+p3GNEJVorAxPq6XY00OxGB7whw0nKBNl2NF0YLgL65MO
         bfKXDZwV8ZrmKtQG8xZ5PGk+gOYxau9I9Mn5D7zWlDMJMftfTuaZlAWp6hLFhxiZZc7E
         pSF/gxWEQn7q+98huAn6M2Re8QAb9Rmnok7y2yAwIz70Pf5ywAu7HF0UNJKBz+Xt7/C9
         YWiLM53mBho/4EchWLOxLHatZe/HrlAPh4FFgVFTGDPP2uoRtsuNHqKUFsHkO5aNvqbE
         cQPg==
X-Gm-Message-State: AOAM532Q7MpxMtqcf149IX47byqiJkutAkxg8HCi10a0ldP04NlSDEHq
        M4/UUhavnDrIQ3robci3wA==
X-Google-Smtp-Source: ABdhPJx07+pmiULzsSoVtl4zj0qdxFNqbt1zSIkcWqEUmleZyZSShcEx039rCOlIjJTn6LDKtV8Jkw==
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr392727ejm.130.1619121765052;
        Thu, 22 Apr 2021 13:02:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id u15sm2936199edx.34.2021.04.22.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:02:44 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 1/4] sched: make nr_running() return 32-bit
Date:   Thu, 22 Apr 2021 23:02:25 +0300
Message-Id: <20210422200228.1423391-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating 2**32 tasks is impossible due to futex pid limits and wasteful
anyway. Nobody has done it.

Bring nr_running() into 32-bit world to save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/loadavg.c          | 2 +-
 fs/proc/stat.c             | 2 +-
 include/linux/sched/stat.h | 2 +-
 kernel/sched/core.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index 8468baee951d..f32878d9a39f 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -16,7 +16,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index f25e8531fd27..941605de7f9a 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -200,7 +200,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"\nctxt %llu\n"
 		"btime %llu\n"
 		"processes %lu\n"
-		"procs_running %lu\n"
+		"procs_running %u\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 568286411b43..f742229091ec 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -16,7 +16,7 @@ extern unsigned long total_forks;
 extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
+extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..713ea35cb995 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4331,9 +4331,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+unsigned int nr_running(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_running;
-- 
2.30.2

