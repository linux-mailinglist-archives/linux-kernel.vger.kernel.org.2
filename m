Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF83B0950
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFVPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhFVPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DshqHIYOJwBtlfK3WRxzWsuw80Dxqq8hJEaM3BIqgZA=;
        b=K2zy3RNXxI9yZTCfUGeRLU2GBnL6n4VJqFd1+yW/cIcjMqJQ+WPIjT4ziXHYjblF0rHXo7
        GsDdnvqv9GeTT5lqklFSMB5wdsN+925Ue2mmE5Uaig2QWM2ZQ+JHWewkHbnjUwvYazukJ7
        1OgsnUy2jsnJu9p+Q9Vp7oIOAeZGczU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-TQLbKRZSM4uyqtxOX2-dVA-1; Tue, 22 Jun 2021 11:39:42 -0400
X-MC-Unique: TQLbKRZSM4uyqtxOX2-dVA-1
Received: by mail-wm1-f70.google.com with SMTP id q123-20020a1c43810000b02901e0ebb6227fso460932wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DshqHIYOJwBtlfK3WRxzWsuw80Dxqq8hJEaM3BIqgZA=;
        b=MaqHbN9xGnTpugUH/Bo7NDQNgYgJ4gD6uFOYJBP7d5zdzzZ8dPF3uuPPTYunYCdwAD
         Iapstfb0FN86iNnijcMnRS9nOestUpWamiJG2ExZbGzxq+2oLMoZPYXl0QVFi4nQ5b75
         oyPvGZqh3AeL3famDM06o8KtYE/0OIylyTakm8/CouSzEFlwJbhdndalZ+6aDpCcmHfe
         ber2EfiifsxUe/K0vZAUF+NYoq2T0k9b5gGOi5QJfqeLl5HTcBAAa9EU2j9AOMxHN2tY
         Gwl1FMm7So/4zt5GqDQV9u/dHycT/GB+q9knv5tgRxSy+NeqoPMztzugZ5skv3aD3ujb
         p1nA==
X-Gm-Message-State: AOAM531aX8uP1Am7EHbl5OjeJLhtemunTb6Wx6FIJO9tRPx1tHSIpIfh
        7PkfCV6c7z7auZcPAPGTo0E3YQHFKmFXFjAzKXlKCiO7DXjPWZY9zZGVvFQLm4s5l6MPz/MfGi6
        M21b1FZfr5yQKtf26o1vl/mX7
X-Received: by 2002:adf:a2d1:: with SMTP id t17mr5566300wra.74.1624376380826;
        Tue, 22 Jun 2021 08:39:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze2gmtvf5CL694C47Iqc9gzNg87FgIPiqyYvhvjaij2JVDG/jbL+PUexFrQcofHLpaVH8ZMA==
X-Received: by 2002:adf:a2d1:: with SMTP id t17mr5566278wra.74.1624376380698;
        Tue, 22 Jun 2021 08:39:40 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:40 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 09/10] perf report: Display build id fails stats
Date:   Tue, 22 Jun 2021 17:39:17 +0200
Message-Id: <20210622153918.688500-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to display build id fails in --stats option:

  # perf report --stat

  Aggregated stats:
           TOTAL events:        104
            COMM events:          2  ( 1.9%)
                    ....
         BUILD_ID fails:          4  (14.3%)

This stat is displayed only for session recorded with --buildid-mmap
and contains HEADER_BUILD_ID_MMAP header feature.

We process all MMAP2 events and in case it does not contain build id
and it should - it's regular file, we count the BUILD_ID fail and
display it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/map.h       | 15 +++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bc5c393021dc..b5c03bcc4395 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -13,6 +13,7 @@
 #include "util/annotate.h"
 #include "util/color.h"
 #include "util/dso.h"
+#include "util/vdso.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/err.h>
@@ -100,6 +101,8 @@ struct report {
 	u64			nr_entries;
 	u64			queue_size;
 	u64			total_cycles;
+	u64			buildid_fails;
+	u64			buildid_total;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
@@ -729,10 +732,36 @@ static int count_sample_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int count_buildid_fails(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample __maybe_unused,
+			       struct machine *machine __maybe_unused)
+{
+	struct report *rep = container_of(tool, struct report, tool);
+	struct perf_record_mmap2 *mmap2 = &event->mmap2;
+
+	/* No build id should be generated */
+	if (!is_buildid_memory(mmap2->filename))
+		return 0;
+
+	rep->buildid_total++;
+
+	/* The build id should be generated, but wasn't - fault. */
+	if (!(mmap2->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
+		rep->buildid_fails++;
+
+	return 0;
+}
+
 static void stats_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
 	rep->tool.sample = count_sample_event;
+
+	if (perf_header__has_feat(&rep->session->header,
+				  HEADER_BUILD_ID_MMAP))
+		rep->tool.mmap2 = count_buildid_fails;
+
 	rep->tool.no_warn = true;
 }
 
@@ -742,6 +771,12 @@ static int stats_print(struct report *rep)
 
 	perf_session__fprintf_nr_events(session, stdout, rep->skip_empty);
 	evlist__fprintf_nr_events(session->evlist, stdout, rep->skip_empty);
+
+	if (rep->buildid_fails) {
+		fprintf(stdout, "%23s: %10" PRIu64 "  (%4.1f%%)\n", "BUILD_ID fails",
+			rep->buildid_fails,
+			100.0 * rep->buildid_fails / rep->buildid_total);
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index d32f5b28c1fb..9b96ebed412d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include "vdso.h"
 
 struct dso;
 struct maps;
@@ -186,4 +187,18 @@ static inline int is_no_dso_memory(const char *filename)
 	       !strncmp(filename, "/SYSV", 5)  ||
 	       !strcmp(filename, "[heap]");
 }
+
+static inline int is_vsyscall_memory(const char *filename)
+{
+	return !strcmp(filename, "[vsyscall]");
+}
+
+static inline int is_buildid_memory(const char *filename)
+{
+	return !is_anon_memory(filename) &&
+	       !is_vdso_map(filename) &&
+	       !is_no_dso_memory(filename) &&
+	       !is_vsyscall_memory(filename);
+}
+
 #endif /* __PERF_MAP_H */
-- 
2.31.1

