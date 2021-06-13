Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374123A5A52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFMUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhFMUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:22:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:20:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so8830859pjz.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SPfHND9MVRbWvqH4g5LlYvvBDKL5bi9dBm7W+g4Upk=;
        b=DpEICL/+M3hDFIwEHZHfBSDbXEErt3rxiTYbOulNL2HK32Eho7REkdMx7K3m8ZogCm
         rDX4hZtlDPUC0wmtAs3VXQUv8fs/KGHihnBf65bpMp3VBGMgS2ZWHo6f2sd4942XOW8D
         7bfWtpFhYEDDtD2CsayFVRAOze/DK7wYifTAPBWYywRhTLeeIhr5d5d3R5liQUgLPQfu
         cSoy4bid7czbkq4aDkwRvVVjBklKkrrQAAt2gTN1VHnkoL/u+TibYzQJJqmCcD0R4MzN
         HXC7y6TgmsEPdGmFXbJNpMs7L16TXdQQfVA+OxsrPaOHU/ZU8DwUfsQ8cMLz89K5K7DM
         FpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2SPfHND9MVRbWvqH4g5LlYvvBDKL5bi9dBm7W+g4Upk=;
        b=UndESEtWJCU9o7RqRAUT29HYHRFsz/L4AwDH7UwySwdicvtJBsnW9NPastF5nfFP1U
         viM+r+koBDIze9K73+HtXkp+AMe+M1qfZvFFgqpwfvZhJ09ay/8Y4AQufwGKnDo4+GI0
         I8qHvuBsq7b6MjsFwYz0pF9TFmwvtvJKgn7R1xcoZqmdDOHJG0oWu/KqcYsrnVwTCjDx
         yFepm+FumjJFVNbko7QatInmiCQydUH70qthTzdXUYgn92iQjE6T8aQTYnOiQgLNDPZz
         CX3uzh5b5rlsXUF/OgjdQ1Fqy/80XON837SFuI7CYXFD6Yu7ZEzSe29+/exLhBMUKAp3
         Y6Kw==
X-Gm-Message-State: AOAM530W5VLgGRJvllZMkbeFL664/lisKKRJ0j6SU3BZjKo27sKhpInl
        mmI5yIcq3/OxXlnvovq5WkU=
X-Google-Smtp-Source: ABdhPJx/r3M/YXGmtPS5phF4mWN/t6MdG9J+OsQ3VrjxiwywXFKddpInVMS1UemSIUae4ssavZndLA==
X-Received: by 2002:a17:90b:388e:: with SMTP id mu14mr4668977pjb.3.1623615603043;
        Sun, 13 Jun 2021 13:20:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:d4f4:222c:bec4:5307])
        by smtp.gmail.com with ESMTPSA id x8sm12512545pje.52.2021.06.13.13.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:20:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf tools: Add read_cgroup_id() function
Date:   Sun, 13 Jun 2021 13:19:59 -0700
Message-Id: <20210613202000.540674-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
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
2.32.0.272.g935e593368-goog

