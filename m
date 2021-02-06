Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61314311E65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBFPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBFPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:21:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11789C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:20:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i8so17688686ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fKZa5ef0f/JsVVxwPS0Mh8EDmKSue5flkLbzWhoGFo=;
        b=gewUvIBfuJ12n1zR6WfvJXluAVgtkbZhNYVrfF5HLgH+2LyFsYnDUVvsT5Y9Do2Sto
         XIOsDCZKut6H2gcpnvsZHXXwWadaXtUq0gqn8QpOEDGYkS7XocZzz2EHqeK4bVatTCgH
         7XmSDlLHuKL0DwGvnWpyyjlSvG6KScH5RhNPU4wfBTW7b2PiVmehRtSJgIimEgnS/yu0
         gprFfEm77NL59+g+nDC04iWSYkICkqqqVMWzTLJTJBMF2dUVk5AzXkbwORaSY3kB57m3
         ZyaeXHH9HUpl0lUN3k0QIauxqoIXHGKSq20gkQFZ1JSAUvIY/kY7DJ6c73A9PsyWiH7q
         gzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fKZa5ef0f/JsVVxwPS0Mh8EDmKSue5flkLbzWhoGFo=;
        b=Q/QbbDdIostqRL1gvmYFYKALp3USgJDEUxtNbQ/W84Se1tLIY6wtMxw+8eAczGGmky
         YHFq7w3j6ozqBlUhwsPKcEvQ2YfoGHOu1WDvpcm6c35OtfEe52KmfdZ2hYdQK5y3dVDK
         AQ3wkpCNhIRDKs11/IVp7zNqePtpuZjHdlzYPY2gAuQdELOBkK6szHcMRCszvX40Cdzp
         K4eoVm8Nkxbrfb0D8freohN4/WGz0xT19P4AbyjNCf4vDauzL1X2TwpPt1wY0s3JRoRo
         EIMfgeoxgYMY1bYdYSZWkTqABLTJjGyE7++K8p1HMataHzID0orzXrl1lgh+R5M4TR2r
         4+jw==
X-Gm-Message-State: AOAM532BsJuCinWOglzwlYgZ3OUjYptXSTf+wUOA56NYFnyZnoKkMeqp
        +6kCS816q8Nfff2nyKRg3g==
X-Google-Smtp-Source: ABdhPJwfjqNJLF49YcoDKAvxGoF/vQBz5lbD5VDKtWwf3zFjgGnDo0BPbVEA5ZugGtAtRrDZg1ASLQ==
X-Received: by 2002:a17:906:3685:: with SMTP id a5mr9173646ejc.544.1612624853870;
        Sat, 06 Feb 2021 07:20:53 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id f6sm2842098edr.72.2021.02.06.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:20:53 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:20:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sched: make nr_running() return 32-bit
Message-ID: <20210206152051.GB487103@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210206151832.GA487103@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating 2**32 tasks to run is impossible due to futex pid limits
and wasteful anyway. Nobody have done it.

Bring nr_running() into 32-bit world to save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/loadavg.c          |    2 +-
 fs/proc/stat.c             |    2 +-
 include/linux/sched/stat.h |    2 +-
 kernel/sched/core.c        |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -16,7 +16,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %d/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
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
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -16,7 +16,7 @@ extern unsigned long total_forks;
 extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
+unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4336,9 +4336,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
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
