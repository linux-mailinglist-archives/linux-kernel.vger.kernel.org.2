Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7456308555
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhA2FuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2Fty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:49:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:14 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o16so5931971pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2hNIMsM1FztqDVmUosIsGkZhR6dVyf2aRKSK+cYHMw=;
        b=Bq7NVRBurxZuCzx0vHErLMYdupDcMHC/R5YIzhIBaDDFoGpZkoNieGgK76TvPefF1+
         6YeOWUiHGL/QN+HqcxJfU75YLct7sURIyN4tA40nVBBVKOP/el0peFOOAXItpdqd0t8n
         +vkEtxkFX7kl8GJTz/6LG0ug3r4XiIZkcRUTzsxBBaCLDU9Ti9fFhaKNc3CXzzBN0GHg
         fAPwNlOKGXOKZVnucB3/W6ExFDRjjt6hrrrpOlwvNbzueBX/QJrl2QPs1wnUZt4R4ad5
         jwnjZqaL2GrSvwgN5Ve+ZFth3HYFAc5PnI9/yVVyI/QxTZbqAHUP/pLVzRqFVBBewLoU
         zzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W2hNIMsM1FztqDVmUosIsGkZhR6dVyf2aRKSK+cYHMw=;
        b=WExKMYcOO8JMNKl754w0J9R79QschgXeQCYBYzQ064NbK1RnlRS9pW1X6pzZjZUST7
         9uKrTKJTNOBF5brQMiw/uEEiqDPmvbdQR899WKDRkCf5kYJYRmWlaiy7vt37ORv7gSqD
         UgSr6bWEvTpTLddYdnBzPmjYcnhxAobQwEGHJz8ZjpcvlXpWPjitm6PStMU/ISXTTM54
         f2w6l8S12r2EaISzf+Rfn+gWbkjQEMyKd+sSyv7OzLJuPPb3EmbU2eBAB8fa0EiLVn6S
         OQgvvQhDeJvmAkmRS9r57YGWNfoNLNqMRyzbJTelI4Ly67g0jI0Dc669XYZ+VcePfIjr
         O0oQ==
X-Gm-Message-State: AOAM530d9Dsh8SErtdsnkVK74iU52A40wtWgtAlSOKXVjxWlNHYGqO3Y
        IiqHOFdcMZAH7x+v4vl7zLZgPBvspwc=
X-Google-Smtp-Source: ABdhPJws5gxF4MPfcRryHaNX2ZbBzC9s8Por44UCj1lP7SKP/dfmgaqgKqzIdc2AEFgO4d8C26adRw==
X-Received: by 2002:a65:5903:: with SMTP id f3mr3163135pgu.28.1611899353895;
        Thu, 28 Jan 2021 21:49:13 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id j13sm7408098pfr.214.2021.01.28.21.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:49:13 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel threads
Date:   Fri, 29 Jan 2021 14:49:00 +0900
Message-Id: <20210129054901.1705483-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129054901.1705483-1-namhyung@kernel.org>
References: <20210129054901.1705483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To synthesize information to resolve sample IPs, it needs to scan task
and mmap info from the /proc filesystem.  For each process, it
opens (and reads) status and maps file respectively.  But as kernel
threads don't have memory maps so we can skip the maps file.

To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
file.  It's about the peak virtual memory usage so only user-level
tasks have that.  Also check "Threads:" line (which follows the VmPeak
line whether or not it exists) to be sure it's read enough data - just
in case of deeply nested pid namespaces or large number of
supplementary groups are involved.

This is for user process:

  $ head -40 /proc/1/status
  Name:	systemd
  Umask:	0000
  State:	S (sleeping)
  Tgid:	1
  Ngid:	0
  Pid:	1
  PPid:	0
  TracerPid:	0
  Uid:	0	0	0	0
  Gid:	0	0	0	0
  FDSize:	256
  Groups:
  NStgid:	1
  NSpid:	1
  NSpgid:	1
  NSsid:	1
  VmPeak:	  234192 kB           <-- here
  VmSize:	  169964 kB
  VmLck:	       0 kB
  VmPin:	       0 kB
  VmHWM:	   29528 kB
  VmRSS:	    6104 kB
  RssAnon:	    2756 kB
  RssFile:	    3348 kB
  RssShmem:	       0 kB
  VmData:	   19776 kB
  VmStk:	    1036 kB
  VmExe:	     784 kB
  VmLib:	    9532 kB
  VmPTE:	     116 kB
  VmSwap:	    2400 kB
  HugetlbPages:	       0 kB
  CoreDumping:	0
  THP_enabled:	1
  Threads:	1                     <-- and here
  SigQ:	1/62808
  SigPnd:	0000000000000000
  ShdPnd:	0000000000000000
  SigBlk:	7be3c0fe28014a03
  SigIgn:	0000000000001000

And this is for kernel thread:

  $ head -20 /proc/2/status
  Name:	kthreadd
  Umask:	0000
  State:	S (sleeping)
  Tgid:	2
  Ngid:	0
  Pid:	2
  PPid:	0
  TracerPid:	0
  Uid:	0	0	0	0
  Gid:	0	0	0	0
  FDSize:	64
  Groups:
  NStgid:	2
  NSpid:	2
  NSpgid:	0
  NSsid:	0
  Threads:	1                     <-- here
  SigQ:	1/62808
  SigPnd:	0000000000000000
  ShdPnd:	0000000000000000

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 32 +++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 800522591dde..8b38228c83d8 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -70,13 +70,13 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
  * the comm, tgid and ppid.
  */
 static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
-				    pid_t *tgid, pid_t *ppid)
+				    pid_t *tgid, pid_t *ppid, bool *kernel)
 {
 	char bf[4096];
 	int fd;
 	size_t size = 0;
 	ssize_t n;
-	char *name, *tgids, *ppids;
+	char *name, *tgids, *ppids, *vmpeak, *threads;
 
 	*tgid = -1;
 	*ppid = -1;
@@ -102,8 +102,14 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
 	bf[n] = '\0';
 
 	name = strstr(bf, "Name:");
-	tgids = strstr(bf, "Tgid:");
-	ppids = strstr(bf, "PPid:");
+	tgids = strstr(name ?: bf, "Tgid:");
+	ppids = strstr(tgids ?: bf, "PPid:");
+	vmpeak = strstr(ppids ?: bf, "VmPeak:");
+
+	if (vmpeak)
+		threads = NULL;
+	else
+		threads = strstr(ppids ?: bf, "Threads:");
 
 	if (name) {
 		char *nl;
@@ -141,12 +147,17 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
 		pr_debug("PPid: string not found for pid %d\n", tid);
 	}
 
+	if (!vmpeak && threads)
+		*kernel = true;
+	else
+		*kernel = false;
+
 	return 0;
 }
 
 static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t tid,
 				    struct machine *machine,
-				    pid_t *tgid, pid_t *ppid)
+				    pid_t *tgid, pid_t *ppid, bool *kernel)
 {
 	size_t size;
 
@@ -157,7 +168,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t ti
 	if (machine__is_host(machine)) {
 		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
-					     tgid, ppid) != 0) {
+					     tgid, ppid, kernel) != 0) {
 			return -1;
 		}
 	} else {
@@ -187,8 +198,10 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 					 struct machine *machine)
 {
 	pid_t tgid, ppid;
+	bool kernel_thread;
 
-	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid,
+				     &kernel_thread) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -748,6 +761,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	while ((dirent = readdir(tasks)) != NULL) {
 		char *end;
 		pid_t _pid;
+		bool kernel_thread;
 
 		_pid = strtol(dirent->d_name, &end, 10);
 		if (*end)
@@ -755,7 +769,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 
 		rc = -1;
 		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
-					     &tgid, &ppid) != 0)
+					     &tgid, &ppid, &kernel_thread) != 0)
 			break;
 
 		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
@@ -773,7 +787,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			break;
 
 		rc = 0;
-		if (_pid == pid) {
+		if (_pid == pid && !kernel_thread) {
 			/* process the parent's maps too */
 			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
 						process, machine, mmap_data);
-- 
2.30.0.365.g02bc693789-goog

