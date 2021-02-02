Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5463030BA89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhBBJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhBBJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:02:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:01:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v19so14458175pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGsNv6zL8o9Buvp2fEUb9sv5ifTApo94dAhaJ7V7nCM=;
        b=Te4KwuqSRTgv1UTZu6YOgjfF9X1bzzMpdqBGustOGg/DXMBZh2NJloQtNy8Qnf0J/C
         ec7FTJRreKGW5hr7l4eDyQ6XKUW+HiPimoUPISIMh45K88idOSb+ot9D2jmdPUaiajxI
         uZ4Lu3g89eOSL9Y99mT6vWTZKzIioA38i1uuxP7BmboMah0GsylV8JPLaZor+QbG8vIg
         AMmdp3ojYTGCd8qofkeaHfLWRg0G53JprueMavImXRvyGiHgJKX7NkaeiANEfN3S9MXa
         Im6QOwH4jjFCqg+whokeuM5CAiDU5tNCzULPJIMX1hvnqgZBFqayGvlY9P7AwqthdjpR
         QKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uGsNv6zL8o9Buvp2fEUb9sv5ifTApo94dAhaJ7V7nCM=;
        b=k0qBYegCbkwsU1T6iyNONLoNtud7WupLou2nV0P3QHxr4noSc8QExaUB0EYtx9DUMI
         7dX9c8zqaoYCkqr9p8vty3lqk6ksCXntfAH0+zr5zGHtxTsURSolzkep73jfINhR4t4F
         Hnz3sDpi/D7tkiD8uFO9kXoiDVVEnfLr3CBg96bT7xN9+7kEYEAjxGIue6mR+fSAmzYC
         gZ1skJ/1bm+kK7tE/Qkg4zpOCW1W1IAULa16YmCx18NF++hsQaVx+yoSUPIwNsRRJ9EQ
         wUa1h5WOLfmdYqWubaOwyXBg3eBocBZMQdeKqpvZkEnriYutY/0furYJObOQ3auP0FR5
         fssg==
X-Gm-Message-State: AOAM533McxCxm91I8D3T+kxfd13QMWs6x/5X0qn23ZRjX27HtUldnwaz
        8FzAEK8D+/DFjFDbgQzZCp2o4BySde0=
X-Google-Smtp-Source: ABdhPJwW6va9Tdp8x2dwlReyDVY4KZGg6As2s5tDd/YEObm4IHX7Yve6+NWgn8wGHt/YC7QIudrBHQ==
X-Received: by 2002:aa7:92c6:0:b029:1cb:1c6f:c605 with SMTP id k6-20020aa792c60000b02901cb1c6fc605mr15269472pfa.4.1612256493158;
        Tue, 02 Feb 2021 01:01:33 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id t6sm21246909pfe.177.2021.02.02.01.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:01:32 -0800 (PST)
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
Date:   Tue,  2 Feb 2021 18:01:17 +0900
Message-Id: <20210202090118.2008551-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202090118.2008551-1-namhyung@kernel.org>
References: <20210202090118.2008551-1-namhyung@kernel.org>
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
tasks have that.  Note that it's possible to miss the line due to
partial reads.  So we should double-check if it's a really kernel
thread when there's no VmPeak line.

Thus check "Threads:" line (which follows the VmPeak line whether or
not it exists) to be sure it's read enough data - just in case of
deeply nested pid namespaces or large number of supplementary groups
are involved.

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
index 0cc998663b03..abea6885f94b 100644
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
@@ -136,12 +142,17 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
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
 
@@ -152,7 +163,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t ti
 	if (machine__is_host(machine)) {
 		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
-					     tgid, ppid) != 0) {
+					     tgid, ppid, kernel) != 0) {
 			return -1;
 		}
 	} else {
@@ -182,8 +193,10 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 					 struct machine *machine)
 {
 	pid_t tgid, ppid;
+	bool kernel_thread;
 
-	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid,
+				     &kernel_thread) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -743,6 +756,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	while ((dirent = readdir(tasks)) != NULL) {
 		char *end;
 		pid_t _pid;
+		bool kernel_thread;
 
 		_pid = strtol(dirent->d_name, &end, 10);
 		if (*end)
@@ -750,7 +764,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 
 		rc = -1;
 		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
-					     &tgid, &ppid) != 0)
+					     &tgid, &ppid, &kernel_thread) != 0)
 			break;
 
 		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
@@ -768,7 +782,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			break;
 
 		rc = 0;
-		if (_pid == pid) {
+		if (_pid == pid && !kernel_thread) {
 			/* process the parent's maps too */
 			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
 						process, machine, mmap_data);
-- 
2.30.0.365.g02bc693789-goog

