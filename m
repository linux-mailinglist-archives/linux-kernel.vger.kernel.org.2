Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A83A73C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhFOC0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1BAC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:24:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l12so8862110oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUJYKayNfd7wLkK7CR9UE6s58mPG0xc0iN8ikDyx7C4=;
        b=ErD17wVtCJS/EGYZU6jpJeyrLuBMCCSWZF9gJ0vqNm035+rEofDHV/H2rrqAMAnI+i
         5w+k1/FhWlRQlAIMeCQBrRERE9t0b2AeqkxnqWdU0kUYFxnZE/9IPlUHRyQYHXp1C7mg
         YCBtF5MntVgZDgU3/XTgt4fKaP+8E3slPZ+oMyXpeiIgzTOH5I2KbfIxEvoY1DI0zhGA
         Eg0o7ETJLDV6egwYIAu3RwWwnZ39dzNeFRs0Ip487ToKtvv84zro6vLbgtouzJkVAROT
         jsDnE/fL5eyFX6t9Lg19cZZeyQpS+B2gANs/zmusDH9HM5E7xGBcmjWvorQY207lKlCW
         +Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oUJYKayNfd7wLkK7CR9UE6s58mPG0xc0iN8ikDyx7C4=;
        b=uf3boklJuy2nfncCpN8ee3e/OTUfHDJt3lKbYNM2qJ3lZrz52nE3n8lf/98z/HuMLv
         q9PH+rXCery8LV9nQxvPZbQ/Rc1EpFs6x/Ly8XpN3n/ca3r+upcu9gMyGLip/5baP0Ko
         PNJ/0/lJ9neRVUwvpxuVyPKfcWgloykZY3C6krXULj7wpcn+D1tQghTysHTC14t7jCdt
         dyQPfKufK6rJ9ciVdmmwvFuHbxAz1An6vH6y7uJ/Ll9RG3tz7tn46H4dN/7VvXY2i3Ya
         pf1M+pXIjMeALQV/0Ob1OrNp/lsVg793g+lffm6FIguKGZERZ6Oy3QMMfv+IpMLmYRmT
         IBvw==
X-Gm-Message-State: AOAM532JCARAPIXxdDmLZccc752/gVo2jmKsTFiVrv0GBzJur1Sals/l
        po+PQjSsPrF0w9vdoduItip4bCfIhlWBUw==
X-Google-Smtp-Source: ABdhPJzgD2vFKeayUIHzL1DCHS0UNX36XuXYAoQOztBDYuTjKZMSffg9Yw/DotFyaoGMB6JxrnharA==
X-Received: by 2002:a17:90a:d106:: with SMTP id l6mr21978571pju.164.1623719850016;
        Mon, 14 Jun 2021 18:17:30 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:5db9:f2a7:a913:e1ba])
        by smtp.gmail.com with ESMTPSA id z15sm14881758pgu.71.2021.06.14.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:17:29 -0700 (PDT)
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
Subject: [PATCH 2/3] perf tools: Add cgroup_is_v2() helper
Date:   Mon, 14 Jun 2021 18:17:23 -0700
Message-Id: <20210615011724.672612-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615011724.672612-1-namhyung@kernel.org>
References: <20210615011724.672612-1-namhyung@kernel.org>
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
index ef18c988c681..48ec79211270 100644
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
+	if (statfs(mnt, stbuf) < 0)
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
2.32.0.272.g935e593368-goog

