Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2D3AFDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFVHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhFVHOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:14:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F4C061766
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e22so10129854pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4/JmgnB0PPJRokaTEnnczJFGZLrG8kBInbeNwocamI=;
        b=GuTPUvfQP3O5Ayi4mYYUyMhEwS696NPUHylmsUZXgFcfmuz/qjLqyv9Bj9kYNFrblM
         O7rGer18xGwnxu3ZyN90oCwpE3MLO7w+gWTCcmB2KOrTQYpL+ranER9AFRgA7X2lnM8i
         WZ801zoE0BGha1uQ8Zlh776fHTC5b3wgutmXIa1N04dRdY1ZckHwq977x6o3riI8lEaS
         ZlhN1Na2LP9XUkXWV1lN7F80VhbNavpL2Qm1Ogmj1bUsFiUk/1HdlsHxLJoejn19ETo2
         oC99k8bnPihPyOtcL5FOqWPXhPVI3LG5rs7Cf3+aKFUydpB1atm5dZVphqvIc1CRkCSh
         6pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z4/JmgnB0PPJRokaTEnnczJFGZLrG8kBInbeNwocamI=;
        b=cPpLuqu9seQvnFuAsDiWzaqUCpdehNFT0pAe62jaeWycvupwC2cR/bHXQl5UnQQ6R1
         M9QRvQljx00hu1BdncV58V7FhXt6mDFq0lR0mV571rFUQJhvvX+4W490mJ1antEb/52g
         OO3vB2qdIMeNt9qwGnceVxTHkQ6OxfbaqQ+7RlaVPaeTEdbggd52HEw7oLZMJdZ9ObmO
         iTArK6XUQ5UIWk2WeawPNg8/xt+CFjlDFxKiTMMuqYvWOLQXD83XpaRlxg3sQUn1CmHy
         +0/2ayBwVXA0zatl5jhLsDYQIyktXIRypm86Q2gJrDKgiMJbDAHNZJVjQtVdjSloUeY5
         y18Q==
X-Gm-Message-State: AOAM532ijhgzoZyvte+JvOZCPXa4fjf90tv9+ct2L6eR69maB6x5qf4o
        b97IkYCcT2jkEF2bLvoT/C4=
X-Google-Smtp-Source: ABdhPJznIPmuN98qBFG0Dsqz9x6IOnNtNdghDqtPjTlLy5Np4S5zNLT6rUqrK3/KDa3vKnEh8w5Gpw==
X-Received: by 2002:a63:5705:: with SMTP id l5mr2366653pgb.227.1624345947576;
        Tue, 22 Jun 2021 00:12:27 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:62e3:ad14:6151:62fa])
        by smtp.gmail.com with ESMTPSA id j4sm16449129pfj.111.2021.06.22.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:12:27 -0700 (PDT)
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
Date:   Tue, 22 Jun 2021 00:12:20 -0700
Message-Id: <20210622071221.128271-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210622071221.128271-1-namhyung@kernel.org>
References: <20210622071221.128271-1-namhyung@kernel.org>
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
2.32.0.288.g62a8d224e6-goog

