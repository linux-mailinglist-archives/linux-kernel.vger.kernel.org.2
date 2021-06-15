Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6353F3A73ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFOC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhFOC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:29:10 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A23C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:27:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z15so8958746vsn.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SPfHND9MVRbWvqH4g5LlYvvBDKL5bi9dBm7W+g4Upk=;
        b=DIXuHtU8eko6wCGSKtkZmumwiCYDZ3aqLja5/O9z44N7O3BXBMAym+zA3Lfrjuccfo
         vhX1GvMYYh+BYeDXOTwADCtYAAuGfBwmUmIvGbOaldnWp7mB25x6lMCQWD5pVJ5synZ6
         HRROGHfh39nFxZTHSz+iTCEgUfmnFPzmXyISg/jaGo9QA12qlPubPXbktKfNit8gPzU2
         RgmhysNmCOlH12DAxhgM27VcscVWHUzo3iHz34GkL8gJGpGBoabVS3fjDoipNFKcLIu1
         95+CkHkNAqDrvedML5JrMDb6tMdxTkenlZIOzivupqi5awVRSNikxfah79gUA2RysA8R
         XeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2SPfHND9MVRbWvqH4g5LlYvvBDKL5bi9dBm7W+g4Upk=;
        b=GGwHnmCsOMc2OjHcordBDRxawa7QqJso0VU1TkpyMtdNGNWCsixFcc7V2Vp9sIjiTZ
         smWZBRlXFc+45i84QZJsJJfBIBoUqW+WvsqHTCrMVpfp9yYYDi/jGqD+01s9sqUXYJGB
         CJF91VN4HOWL5fvm4n9sw8D6zffdGO5Qf/fvVFDMutQKrITgzGEB8YabSKnOjDN01ZF+
         dVP4Umqh6DzGa4zJ/oGXwdP7fIM7ekWG6MXnMkRyKsMn0G4Gi/VwDN46+oTdeH3ta4V+
         HafekRw/kkCoNHE+n4l1qnMqvbE7AbJT9jCGHianiG3B8dhmdUNL+VG0deMny0VNwOCd
         T4PA==
X-Gm-Message-State: AOAM531ZjzWJFA7Yw+PVtlvMjjTURDb4eGQ7fwJ+kt/l802FYFFJPwRJ
        X5oMnFwqW/i37BxeUH8SEg+TsPbw2tjsJw==
X-Google-Smtp-Source: ABdhPJzda9M/1b63ZJQR8RGYcwrAtk9NfcH4bd59rj/WQsa81wB6kKEeClWwrcchZZH+MtNwL8BmPg==
X-Received: by 2002:a62:8c55:0:b029:2ea:2165:503d with SMTP id m82-20020a628c550000b02902ea2165503dmr1882925pfd.68.1623719848453;
        Mon, 14 Jun 2021 18:17:28 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:5db9:f2a7:a913:e1ba])
        by smtp.gmail.com with ESMTPSA id z15sm14881758pgu.71.2021.06.14.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:17:27 -0700 (PDT)
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
Subject: [PATCH 1/3] perf tools: Add read_cgroup_id() function
Date:   Mon, 14 Jun 2021 18:17:22 -0700
Message-Id: <20210615011724.672612-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615011724.672612-1-namhyung@kernel.org>
References: <20210615011724.672612-1-namhyung@kernel.org>
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

