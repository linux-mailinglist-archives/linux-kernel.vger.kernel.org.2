Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6930BA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhBBJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhBBJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:02:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1A8C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:01:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d13so12111509plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB1wFn+Tv1XzRlFlwroRGPk/S+X85rzvdaZF3gKNuNE=;
        b=Nq7mOQ6FOaFPQI/AX99KQREnIeMvd6srylLc5IUdAKr99w5TzVhTQAP68pSKwJb7N8
         VPuTmqYw+miDE/o2F14/g3MFc2dabhc4ZvsnqHoy5Crx/eD+wIj9l6qvQcc2Mw8fjm3G
         dDhyaTkkCDqukzXruLgLARghEaNdCyegwViqyzzaE+NSieNGvSr2948cV8kRfmGHno9p
         /uWnKg3VQAutr05b3UKnl8KgQ0pRIQ3NQ9NgOQ8HWtV+QQplc2v9e8zx8po/joT2h+zV
         Nb9of8GxBme3uTgbseAZXC2kTFHQRiTguAU14KpW1fDJTavFxn/FKdFzlNsDeC6SCIQp
         nGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gB1wFn+Tv1XzRlFlwroRGPk/S+X85rzvdaZF3gKNuNE=;
        b=i07ODI/hYN+UXv3R2ETwcYhCdA/j0QMknsyM9IHyAHAkL2aOxayKkExvt7Nweoeaa4
         MGRTR0SX7bO4vQPb3vOD0Dnze9xa7Lme3SfNeI1EcS1H0BOdrt/ZbiRkaZhZbk3pCfuC
         jamGEMK7Zy4zLfFygc2w54Iljkm1JHLvQdhlqkAt0C+LUd1cgK2foNmxANzeLtg50xkk
         dMUyT2yFZaQnKI4VkENwXwa2UDDXyokfubhQicVBw45ni4szVnTJpKrG1xedC0LVfLn+
         1s6b+hmoVW1yK+uhpdZlDq7ojiS5JENqdNOjBrxTAKvAdL/bedYsP7Xj1sE0mrLwr0kM
         DDuA==
X-Gm-Message-State: AOAM533u67UTtmtycAj0vsqA87hHRBa+KUCTrQw3gaiKyTjbxU8Hjclf
        shmICb9ueF/tbuuMTt8pArQ=
X-Google-Smtp-Source: ABdhPJxpZ0vGDNWn7BVV3mICY2aDatVQIG2mvbTLUJytuKoa4rbQzx0d1UeDR464VKCuFJ3vH8gAuw==
X-Received: by 2002:a17:902:23:b029:df:54fa:ce43 with SMTP id 32-20020a1709020023b02900df54face43mr21529387pla.49.1612256496953;
        Tue, 02 Feb 2021 01:01:36 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id t6sm21246909pfe.177.2021.02.02.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:01:36 -0800 (PST)
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
Date:   Tue,  2 Feb 2021 18:01:18 +0900
Message-Id: <20210202090118.2008551-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202090118.2008551-1-namhyung@kernel.org>
References: <20210202090118.2008551-1-namhyung@kernel.org>
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
index abea6885f94b..fcec775636ac 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -704,6 +704,11 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
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
@@ -712,10 +717,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
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
@@ -747,18 +752,16 @@ static int __event__synthesize_thread(union perf_event *comm_event,
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
 
@@ -791,7 +794,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	closedir(tasks);
+	for (i = 0; i < n; i++)
+		zfree(&dirent[i]);
+	free(dirent);
+
 	return rc;
 }
 
@@ -976,7 +982,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		return 0;
 
 	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, 0, alphasort);
+	n = scandir(proc_path, &dirent, filter_task, alphasort);
 	if (n < 0)
 		return err;
 
-- 
2.30.0.365.g02bc693789-goog

