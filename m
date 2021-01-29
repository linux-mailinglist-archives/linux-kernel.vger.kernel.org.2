Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAF308558
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhA2FuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhA2Ft5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:49:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED51C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w14so5550609pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHa7MkSd62NVn3SBTV2HKSS7Xv4AilcAIIMBnC9C0u8=;
        b=coNJ+a8UaKDyVWKzGENVJ2m/ljgVgd5TVMGPhNcCGExGIZgIMixdPcA+sRvrmug8Ju
         V0uyDh6CW4uRZkf5jE9t2/x/lc4GRDuaZfMniR/gTBi3qdK6Irvp2nug+Q0DiVPF0GNc
         3H2gY0kJLI+b+l6V0TnbABNMu5Ii9MbHVzWeiHnTTmDns0HjL89ymy1Ey1GEkgvZk4LQ
         o/RQza4bM4itHUOHpLKYPjTVUBYqR6rgcRQRfQxHOyIDGZ1zx6fD7jNNsM0BHX43fBbu
         a4S0cmmbvHOKGHuLaCykVNCGfHfC6tqUK9MdPHAusGjuAblvab2J+pV+fYkPQDSLYZx6
         MaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KHa7MkSd62NVn3SBTV2HKSS7Xv4AilcAIIMBnC9C0u8=;
        b=JYCogME5N2E5fL+VwxJS2ohX85hv5K/qFYILo4yn0fsMbBOjrutyt+O6ttSluD5hiD
         4UygMZ0QIjDqVDFztfjSMWvagGHiTxBXMNxmdOy6KxjyX1CQPFn+PQ1TWmEXyAwEGulu
         DDIEAA6kYf/ylmcUlkeTVd1mUlotdEfPb3dOOumpaGtquwaHJZPw3gl3OSCP3KDQsNBV
         pflIIeqjk15UVckIEnbSpqrvfAwKSF8gu9RgC/KJxkPwNY4IJIZNV3sSLQ+wFr5Li2kT
         X3Hz7SPYN/PijlkhZX4n699+Fm/0wgdGssOqosiXRB3Vba+jRFjqI0900ePAV7hg6VXL
         R2Qw==
X-Gm-Message-State: AOAM531vtTHkkpXimniMJsImn14kYt+lF2UgGmnA/v5inyFbuS0E5eXr
        7rzcM38L8qUwIVtiqLN+w+g=
X-Google-Smtp-Source: ABdhPJxPjjkbwI422S8H6wZXfuKtfXMa3o4QczyIfzAGYLBxJVTRXk4hQEuzMVX1w011cIz0credgg==
X-Received: by 2002:a63:4851:: with SMTP id x17mr3008682pgk.451.1611899357304;
        Thu, 28 Jan 2021 21:49:17 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id j13sm7408098pfr.214.2021.01.28.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:49:16 -0800 (PST)
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
Subject: [PATCH 3/3] perf tools: Use scandir() to iterate threads
Date:   Fri, 29 Jan 2021 14:49:01 +0900
Message-Id: <20210129054901.1705483-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129054901.1705483-1-namhyung@kernel.org>
References: <20210129054901.1705483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in __event__synthesize_thread(), I think it's better to use
scandir() instead of the readdir() loop.  In case some malicious task
continues to create new threads, the readdir() loop will run over and
over to collect tids.  The scandir() also has the problem but the
window is much smaller since it doesn't do much work during the
iteration.

Also add filter_task() function as we only care the tasks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8b38228c83d8..334e577b8ae4 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -709,6 +709,11 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	return rc;
 }
 
+static int filter_task(const struct dirent *dirent)
+{
+	return isdigit(dirent->d_name[0]);
+}
+
 static int __event__synthesize_thread(union perf_event *comm_event,
 				      union perf_event *mmap_event,
 				      union perf_event *fork_event,
@@ -717,10 +722,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      struct perf_tool *tool, struct machine *machine, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	DIR *tasks;
-	struct dirent *dirent;
+	struct dirent **dirent;
 	pid_t tgid, ppid;
 	int rc = 0;
+	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -752,18 +757,16 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	tasks = opendir(filename);
-	if (tasks == NULL) {
-		pr_debug("couldn't open %s\n", filename);
-		return 0;
-	}
+	n = scandir(filename, &dirent, filter_task, alphasort);
+	if (n < 0)
+		return n;
 
-	while ((dirent = readdir(tasks)) != NULL) {
+	for (i = 0; i < n; i++) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread;
 
-		_pid = strtol(dirent->d_name, &end, 10);
+		_pid = strtol(dirent[i]->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -796,7 +799,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	closedir(tasks);
+	for (i = 0; i < n; i++)
+		zfree(&dirent[i]);
+	free(dirent);
+
 	return rc;
 }
 
@@ -981,7 +987,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		return 0;
 
 	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, 0, alphasort);
+	n = scandir(proc_path, &dirent, filter_task, alphasort);
 	if (n < 0)
 		return err;
 
-- 
2.30.0.365.g02bc693789-goog

