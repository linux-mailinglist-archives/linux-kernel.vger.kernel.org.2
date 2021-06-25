Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912B73B3D40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFYHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFYHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:20:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u2so4279482plf.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=comlckjoM31IJz5c+hv0OofR+3A50I4kq0mDmihPVpk=;
        b=fy9XOV8IMHNVqTigLV8tOdA+PCsiHyVhYLI8hOmkenpM0qEMY6aVi4IQfUBCb2vO+9
         ADKnieMM8zvhl4DKM44Q00zd2UEVf6jPr0K6wH1wKLSA86XU9feuG1qqhblHrzuk6weE
         V98MnNNZIBDJp/YSpWy/artjLcfbmB3DCSRFQbQ9JwhgtwtCSsfLenboo2G/5ClmDSiN
         ifZ5M5/9KksNgpxEG8v2JQUd5+4nL0W2hRp7RBVbNwZ3G5so3AcqSjMAPW40xQzWtjoh
         Ej8qTmx1TIG04jaM2N5dejwMs+YSluFFwZY5ohyJFqeu9I/8nU4Zow/UWqMErDsVYlbV
         op0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=comlckjoM31IJz5c+hv0OofR+3A50I4kq0mDmihPVpk=;
        b=s20Gt/FcE6nt9YGFTkTlaYjo6o7dIWy7c6suJPL1n4qeGChHqBfnGg+qJ2IwP9arLP
         A8ecixVUez/jGDQabsFqeQVIIG0WIDMV4JR7dRVDHzNVW4lHWACoxOJSSLhjk91GY0hZ
         VCSz3BTkBrpiYhZmGkyOkuP42DKSYn6yT8E8ACEOPWYdz0JcHUtM9mc96sSuKjM92jCE
         jt9GyromtO/MeipUZi5SCfrOWQnZj7swA9enYjMDWhEw+7PObIusWvQTPn5k3pVDWmYc
         Ye6E0WLYZ+eb33SANTW4Nrv2deg/SJYO0wMA9UCo4/h13IWfPZEtvsABR6QBX2O8efUH
         hAwQ==
X-Gm-Message-State: AOAM531ojYFgdFIUhlDVfyj9svUNa5HAy7uYXwAFyG5Nkb/OH9FOqfsp
        ocHdO6lWiwlBI7sJ76UR7jw=
X-Google-Smtp-Source: ABdhPJzgUrGCj/cQAmdRWJttxevDDbLlF0vDsPaC4T0TM82oQ/aT3o8Vqz8AsixsL/+RT+Lw8qvECA==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr19674638pjs.126.1624605511445;
        Fri, 25 Jun 2021 00:18:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:1b9c:b593:f9be:6b24])
        by smtp.gmail.com with ESMTPSA id c68sm4759176pfc.75.2021.06.25.00.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:18:31 -0700 (PDT)
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
Subject: [PATCH 2/4] perf tools: Add cgroup_is_v2() helper
Date:   Fri, 25 Jun 2021 00:18:24 -0700
Message-Id: <20210625071826.608504-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210625071826.608504-1-namhyung@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup_is_v2() is to check if the given subsystem is mounted on
cgroup v2 or not.  It'll be used by BPF cgroup code later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 19 +++++++++++++++++++
 tools/perf/util/cgroup.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index ef18c988c681..e819a4f30fc2 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -9,6 +9,7 @@
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/statfs.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
@@ -70,6 +71,24 @@ int read_cgroup_id(struct cgroup *cgrp)
 }
 #endif  /* HAVE_FILE_HANDLE */
 
+#ifndef CGROUP2_SUPER_MAGIC
+#define CGROUP2_SUPER_MAGIC  0x63677270
+#endif
+
+int cgroup_is_v2(const char *subsys)
+{
+	char mnt[PATH_MAX + 1];
+	struct statfs stbuf;
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, subsys))
+		return -1;
+
+	if (statfs(mnt, &stbuf) < 0)
+		return -1;
+
+	return (stbuf.f_type == CGROUP2_SUPER_MAGIC);
+}
+
 static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
 {
 	struct evsel *counter;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 707adbe25123..1549ec2fd348 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -47,4 +47,6 @@ int read_cgroup_id(struct cgroup *cgrp)
 }
 #endif  /* HAVE_FILE_HANDLE */
 
+int cgroup_is_v2(const char *subsys);
+
 #endif /* __CGROUP_H__ */
-- 
2.32.0.93.g670b81a890-goog

