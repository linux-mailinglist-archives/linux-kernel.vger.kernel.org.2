Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66902308554
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhA2Ftw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2Ftu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:49:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so4632199plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmn7SqrzWE2ZS2vOZ1mlcWCQaUY7UHM0k+x1gzyAp2k=;
        b=a96Q/sUzivXaHTys/xLFjrWoo5TcuJMvxpn5vj/3IRX3y/hDG3oia0FGPnFlL1GIB0
         wvgOL2hh5240TMZZondLZ13SX2+4jc+j67GaGsNHBjfw69EIHgq18aM6U7aV9h9c2Hrm
         Wu6yoeLyfOZtiW6jIvjuQxm8ySvpFWLKMHWig+lQif0/8p3jFTWzpmOCZEsnlwKPoQle
         oLCYUvtAR4bWAYY2komyHJ3/go1ubZNPcd+tGIECjqsO3dyog1eRtZhW5w/4sy9CnJZe
         XwxUhhlEsnXTitT78TWJ1gr5VkttYiLVpDOcW5LNwV5gF5puvYFQTg19XZ/XxSnIOKmJ
         /AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cmn7SqrzWE2ZS2vOZ1mlcWCQaUY7UHM0k+x1gzyAp2k=;
        b=qAv9wUKRFsJSrdGUCUoztg2EfXdJPK+Dgc3wmLiIcJ0S/aZUYuCy9X1X3mnVlXEwia
         cmjS/fP/pHNrIhGYz7oHo3dent1+Tj1DmW8suoXGUf7NabtRB1p26UsXH4OGcIbw3N8e
         7IUkFTgv7EhErglNYPPjjgvXh4aWXFAzVSfPAISHgYaoB4JcjKQfp4IGFXhuYJUE0lm5
         5G2DmAy4WAlbPpAEmq1cxZ4Pn40zycc15tDOxlyXIVSyRUfMOzDkJ4jtoTSlB2DrLDHW
         kL7AWk3Ome4kT/ve8VG7dbKli+aiWXkuIBIpFmGPlGeMUm/GY6Uu8AFn63JOFiFu5/dj
         PG5w==
X-Gm-Message-State: AOAM530AppaFYqROi2sCDnrszGUw5fzDj//CVNXFZkZqFKerWeJYzjMr
        TZfOVxz93wHhi/tmvkLNUjQ=
X-Google-Smtp-Source: ABdhPJwQT4r8hkrqg0Vk3szdrZ9NK2WmsATo1VnLxJx3daQgpOZ7oVa+4S48+B9wpsmlbhvio+OBcQ==
X-Received: by 2002:a17:902:a501:b029:dc:3e1d:4ddb with SMTP id s1-20020a170902a501b02900dc3e1d4ddbmr2932518plq.60.1611899350210;
        Thu, 28 Jan 2021 21:49:10 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id j13sm7408098pfr.214.2021.01.28.21.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:49:09 -0800 (PST)
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
Subject: [PATCH 1/3] perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
Date:   Fri, 29 Jan 2021 14:48:59 +0900
Message-Id: <20210129054901.1705483-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129054901.1705483-1-namhyung@kernel.org>
References: <20210129054901.1705483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To save memory usage, it needs to reduce number of entries in the proc
filesystem.  It's using /proc/<PID>/task directory to traverse threads
in the process and then kernel creates /proc/<PID>/task/<TID> entries.

After that it checks the thread info using the /proc/<TID>/status file
rather than /proc/<PID>/task/<TID>/status.  As far as I can see, they
are the same and contain all the info we need.

Using the latter eliminates the unnecessary /proc/<TID> entry.  This
can be useful especially a large number of threads are used in the
system.  In my experiment around 1KB of memory on average was saved
for each thread (which is not a thread group leader).

To do this, pass both pid and tid to perf_event_prepare_comm() if it
knows them.  In case it doesn't know, passing 0 as pid will do the old
way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3a898520f05c..800522591dde 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -69,7 +69,7 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
  * Assumes that the first 4095 bytes of /proc/pid/stat contains
  * the comm, tgid and ppid.
  */
-static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
+static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
 	char bf[4096];
@@ -81,7 +81,10 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	*tgid = -1;
 	*ppid = -1;
 
-	snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
+	if (pid)
+		snprintf(bf, sizeof(bf), "/proc/%d/task/%d/status", pid, tid);
+	else
+		snprintf(bf, sizeof(bf), "/proc/%d/status", tid);
 
 	fd = open(bf, O_RDONLY);
 	if (fd < 0) {
@@ -93,7 +96,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	close(fd);
 	if (n <= 0) {
 		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
-			   pid);
+			   tid);
 		return -1;
 	}
 	bf[n] = '\0';
@@ -116,27 +119,32 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 		memcpy(comm, name, size);
 		comm[size] = '\0';
 	} else {
-		pr_debug("Name: string not found for pid %d\n", pid);
+		pr_debug("Name: string not found for pid %d\n", tid);
 	}
 
 	if (tgids) {
 		tgids += 5;  /* strlen("Tgid:") */
 		*tgid = atoi(tgids);
+
+		if (pid && pid != *tgid) {
+			pr_debug("Tgid: not match to given pid: %d vs %d\n",
+				 pid, *tgid);
+		}
 	} else {
-		pr_debug("Tgid: string not found for pid %d\n", pid);
+		pr_debug("Tgid: string not found for pid %d\n", tid);
 	}
 
 	if (ppids) {
 		ppids += 5;  /* strlen("PPid:") */
 		*ppid = atoi(ppids);
 	} else {
-		pr_debug("PPid: string not found for pid %d\n", pid);
+		pr_debug("PPid: string not found for pid %d\n", tid);
 	}
 
 	return 0;
 }
 
-static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
+static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t tid,
 				    struct machine *machine,
 				    pid_t *tgid, pid_t *ppid)
 {
@@ -147,7 +155,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	memset(&event->comm, 0, sizeof(event->comm));
 
 	if (machine__is_host(machine)) {
-		if (perf_event__get_comm_ids(pid, event->comm.comm,
+		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
 					     tgid, ppid) != 0) {
 			return -1;
@@ -168,7 +176,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	event->comm.header.size = (sizeof(event->comm) -
 				(sizeof(event->comm.comm) - size) +
 				machine->id_hdr_size);
-	event->comm.tid = pid;
+	event->comm.tid = tid;
 
 	return 0;
 }
@@ -180,7 +188,7 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 {
 	pid_t tgid, ppid;
 
-	if (perf_event__prepare_comm(event, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -746,7 +754,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			continue;
 
 		rc = -1;
-		if (perf_event__prepare_comm(comm_event, _pid, machine,
+		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
 					     &tgid, &ppid) != 0)
 			break;
 
-- 
2.30.0.365.g02bc693789-goog

