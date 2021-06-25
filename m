Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD163B3D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFYHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFYHUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:20:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g192so7322560pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfeHorlkQORFitvlHuzqPATfLQHxaBsb+MkBDDJ6ZeE=;
        b=hlFSprR7UJbWhkG1vC4x2FePgEc4LD1jSRwMLVv76tHHsLZTjJBXNlTniSfEH9rpbI
         xdp4GlUQKbrAOcltDiD3gj0PFK3BFPnn9mf1NyG4R4r8qOB24T2LfFxIBFtPB9zYVPJW
         TASsu5rfUfJkoTdThxAS9NDpm/YMtoqIjk1uCD/C9T9V1Rtf1vyg32Du6JEApy7GSV42
         dqEI2m9iyVG7BUiVsVVEee8TUHAmR5JP3TjbX5ujmLVaeGTB/ahIKbX+cvkwNtJX28Uk
         d/nxcfoxVUz5aqZtIEs9lH9QA4hCIScfgTMirulqkYhszfefxennOmLLu2f0s+SBeo1x
         JIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TfeHorlkQORFitvlHuzqPATfLQHxaBsb+MkBDDJ6ZeE=;
        b=mp6OtBFppb7I3Mv0/EI1MNu0PZCnmHTR+RlxHuMfAh4gS3Xr5EE4El/dc7WD3D+H2w
         WwN+J6EjdzRmyKdwcCrE1AH7SL2Q6UKikJWdgZL6Ix4sJXJl2EadqWHedxH4PmzAB+N9
         pP1FZBbG4Hh2gWqGkVDjo3mawM5ofw/xPhZ+y+P14BR9ZIQOJ9I1yDPs+CbX8BeEcLee
         KUj8K10iv0/zGlLlDV7FPEIwv1XSjF4FpmNoZggVZRkamJl471xq50KtdcnEWVvN6qlL
         U/mXAF4238ACxPSpmpSBN9FxUGkhG6VlquSUF8GZ/vesTb+0wAk+hCAzet1fICsSLQaY
         XiXw==
X-Gm-Message-State: AOAM533aXMa+N+iAdTF89gZw5ijcd7CYxA44sDPl5oAw8uRwWIpYKhmp
        k9KOmpR9clndC7b6rxYvIPUrlQnC/oxVoA==
X-Google-Smtp-Source: ABdhPJwMHawSYLrw3lFau4vlZ0sZOjy/ngxc5ISnGacTjlQZjDPEdTEwXA82D/uaqBUh/J1pVEQPlQ==
X-Received: by 2002:a62:1c86:0:b029:2fe:b583:6418 with SMTP id c128-20020a621c860000b02902feb5836418mr9109709pfc.23.1624605509984;
        Fri, 25 Jun 2021 00:18:29 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:1b9c:b593:f9be:6b24])
        by smtp.gmail.com with ESMTPSA id c68sm4759176pfc.75.2021.06.25.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:18:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 1/4] perf tools: Add read_cgroup_id() function
Date:   Fri, 25 Jun 2021 00:18:23 -0700
Message-Id: <20210625071826.608504-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210625071826.608504-1-namhyung@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read_cgroup_id() is to read a cgroup id from a file handle using
name_to_handle_at(2) for the given cgroup.  It'll be used by bperf
cgroup stat later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 25 +++++++++++++++++++++++++
 tools/perf/util/cgroup.h |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f24ab4585553..ef18c988c681 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -45,6 +45,31 @@ static int open_cgroup(const char *name)
 	return fd;
 }
 
+#ifdef HAVE_FILE_HANDLE
+int read_cgroup_id(struct cgroup *cgrp)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s", mnt, cgrp->name);
+
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
+		return -1;
+
+	cgrp->id = handle.cgroup_id;
+	return 0;
+}
+#endif  /* HAVE_FILE_HANDLE */
+
 static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
 {
 	struct evsel *counter;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 162906f3412a..707adbe25123 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -38,4 +38,13 @@ struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
 
 void perf_env__purge_cgroups(struct perf_env *env);
 
+#ifdef HAVE_FILE_HANDLE
+int read_cgroup_id(struct cgroup *cgrp);
+#else
+int read_cgroup_id(struct cgroup *cgrp)
+{
+	return -1;
+}
+#endif  /* HAVE_FILE_HANDLE */
+
 #endif /* __CGROUP_H__ */
-- 
2.32.0.93.g670b81a890-goog

