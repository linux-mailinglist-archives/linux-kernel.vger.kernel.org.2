Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7C311E66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBFPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBFPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:23:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDEAC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:22:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w2so17650985ejk.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQstEu2a0rN7v2mV2gvbL2rYIqiyp6eQv1p8OhNKE8M=;
        b=IIGjPdf2EwGqckcx1EHB+DZpaQkdDc0oNOkldTOwwz2RMxi4xXvtWuLXsrqMnDdvMf
         Wjso6x1c4oIe+5rS6jlb1Hpg5JInj4qItVizVtzMCxpjupVR4PVmWzopyCRKEWgM3iHU
         9pQu32BfkJrdUlDfmBEYELSFQtsgwRCxf091X5woSHWJY9IAPymRkjssnd+CL/NtFGLn
         JWqcvNZbBfxS2m3VFCRjLdU6d+OQ7z7zhEIy0P/H3Ph69ITG/Q3OSSgYw4jdoxbZYjZG
         NqPAwxWsJmueIm3N33kzAGaozarCv19d7f1M89F0sLLEgHqXQEi9T20YClhMwIDls7aa
         0h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQstEu2a0rN7v2mV2gvbL2rYIqiyp6eQv1p8OhNKE8M=;
        b=hv0uQMnNYThk4auUiZMda8DR7FtBqJtajj2SUIM9cWM0S9/XhCB7P0eYvCWwm2QKt+
         Bj6EcmPyBunR+jEft3WywuCMDuuK9I/91w5STemNNzjmdNNpDlmuV0nHJCx2QbsmzO54
         gFmsxukGAoQtV2NppM7pYIpMt+WlrRwDZcVwJRN6NORPeSqnjVNiwNaMjYqbGozK2UVm
         Tw3NLloEOxTmDeBcYqcCcN5SGPsiKXmaJ/jSYPzy6XkEC+dRSwGiufgzkH1fQAg4Y0/I
         5Y6YVQ0uK+OTLd4MPgTCl7ppMcPdWrK0+4/7YolQtJX87pfXfsjEFQvISEuUaSB3HoR1
         w3TA==
X-Gm-Message-State: AOAM531OZlexcJFpqqR5v2PX4n5i7uwpnPUg/7rRY2W/pdV4KdAaoQgx
        6AZ+HP4hKqAcovzrYEAmlQ==
X-Google-Smtp-Source: ABdhPJxYnNHnsgAdu1WMt2BrZLSz5Q1opX+vrQnm+uTQf96Kj4A91Nz0edwto1HK2v8DpcZH+B/tnQ==
X-Received: by 2002:a17:906:a091:: with SMTP id q17mr9568531ejy.286.1612624950969;
        Sat, 06 Feb 2021 07:22:30 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id w26sm54863edq.46.2021.02.06.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:22:30 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:22:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sched: make nr_iowait() return 32-bit value
Message-ID: <20210206152229.GC487103@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210206151832.GA487103@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating 2**32 tasks to wait in D-state is impossible and wasteful.

Return "unsigned int" and save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/stat.c             |    2 +-
 include/linux/sched/stat.h |    2 +-
 kernel/sched/core.c        |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -201,7 +201,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %u\n"
-		"procs_blocked %lu\n",
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned long nr_iowait(void);
+unsigned int nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4418,9 +4418,9 @@ unsigned long nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned long nr_iowait(void)
+unsigned int nr_iowait(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
 		sum += nr_iowait_cpu(i);
