Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0230BA88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhBBJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhBBJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:02:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD651C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:01:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d2so1937482pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f3OSwgD3dk4GproO1vpwKhibdyF+WeHmVKiAJdEFBE=;
        b=nd+Ene6lRFbvuPus7xQu7T1893rh3CsdodtNkwz1MRH7yhIGk4X8iWS1CJMKuUZ1KP
         oZ5Ypc2J75Y8H6vSoloEFByVaphBXv85aLesm6oY2BahYXHMwesnvZKZIX6n/L5mQaHw
         npHunqTvXLYofLX15PA6CETdXIpnryDEQkMVaAMAATTEfbIfX24TByUBMoh8VjPZRIlk
         x79iPfc4R3JQtdkh9srAR8NB3p4VzkT6TsNyWNsoBNQKY0u3tZk6091IugzOgVq44zp2
         VJNiAsGvVsGxV7lzo/d1LDaFgvRzOf2fdBYOEte4u1u0UWa5drP+9EgoSNEG+89GFn8b
         wQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6f3OSwgD3dk4GproO1vpwKhibdyF+WeHmVKiAJdEFBE=;
        b=jvro/u6xllmKEelHEdUAL+6bVabvUqRgyVBW7plqNlIt7dYfdNdYFLqsfS4HluUrXP
         fielKTogwcjrpFzFy51WbJrOJVEe7qcBnHFpxehaIeaLOhl2yBSQVU8HJIfwC+XUhZOC
         VbyMJIs4MoAWZY4CQX09fChRTjiNqTnUb5xdK3AgPJsuQi4dI6dnG4ogZ7ofZzk5ZVnb
         FkW2qoSuWs9nDUqQ4JPv9jG++c337gtc217u2u0mXUUE9pvq43jkxDSW6RF7oQlZEQcH
         ix/mh/iDzw7W0YDaVmPN+JGrHBoPYfK37I/iW6i78nA9+AvRnhrcN3k69gczIaCD6JG4
         Poig==
X-Gm-Message-State: AOAM530Gz1iuqHadY6C3/+a/SNobHoQiUWwMJpscQzIdkQec6zwXdeFm
        fGYKM7x26VqZJdb/X/rCDxA=
X-Google-Smtp-Source: ABdhPJwQXiovegUThumb6KwgNea6mwQCCNNCX25SbYzPTcj6QU1QR6yKRVvPfZ/JEKsElSwIGh9GDQ==
X-Received: by 2002:a17:90a:f2d3:: with SMTP id gt19mr3284908pjb.212.1612256489505;
        Tue, 02 Feb 2021 01:01:29 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id t6sm21246909pfe.177.2021.02.02.01.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:01:28 -0800 (PST)
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
Date:   Tue,  2 Feb 2021 18:01:16 +0900
Message-Id: <20210202090118.2008551-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202090118.2008551-1-namhyung@kernel.org>
References: <20210202090118.2008551-1-namhyung@kernel.org>
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
 tools/perf/util/synthetic-events.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3a898520f05c..0cc998663b03 100644
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
@@ -116,27 +119,27 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 		memcpy(comm, name, size);
 		comm[size] = '\0';
 	} else {
-		pr_debug("Name: string not found for pid %d\n", pid);
+		pr_debug("Name: string not found for pid %d\n", tid);
 	}
 
 	if (tgids) {
 		tgids += 5;  /* strlen("Tgid:") */
 		*tgid = atoi(tgids);
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
@@ -147,7 +150,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	memset(&event->comm, 0, sizeof(event->comm));
 
 	if (machine__is_host(machine)) {
-		if (perf_event__get_comm_ids(pid, event->comm.comm,
+		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
 					     tgid, ppid) != 0) {
 			return -1;
@@ -168,7 +171,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	event->comm.header.size = (sizeof(event->comm) -
 				(sizeof(event->comm.comm) - size) +
 				machine->id_hdr_size);
-	event->comm.tid = pid;
+	event->comm.tid = tid;
 
 	return 0;
 }
@@ -180,7 +183,7 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 {
 	pid_t tgid, ppid;
 
-	if (perf_event__prepare_comm(event, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -746,7 +749,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			continue;
 
 		rc = -1;
-		if (perf_event__prepare_comm(comm_event, _pid, machine,
+		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
 					     &tgid, &ppid) != 0)
 			break;
 
-- 
2.30.0.365.g02bc693789-goog

