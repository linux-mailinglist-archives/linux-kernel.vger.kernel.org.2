Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9B4563F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhKRUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhKRUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:20:36 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34404C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:17:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b11-20020a17090acc0b00b001a9179dc89fso5461958pju.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yvIsiU4fo0PY3oKFjGIIQ+X2k7DatrTvg/7PGB6w3us=;
        b=PidhYQBy9IPs44X/8FB3GEYdAXP3nJDDI3K3siYRXZ7n9gVt2JhMqQOiqcCogz8AM1
         MPUQ/Hwggh4jdSwu5h6Wpw9JHzj3yKpZuZ5NzXFk6bHZRN0ioRr2/GXlvmCdILUb4RVo
         WUcaMVEEuH/jfie2oZtuJH3TZrNT+KkvR7+giD+wu6edC/rGDjk7zVSwaz9mKR7DPnQ2
         uRpyqTf4eFBhCSISjFITn9wlJ3blx3c2kSRgEJqSEJNVjNIqFf+r3IDvXiXqQcrTOEGL
         itNsGULC+3/FAPWJdUXxLGfimClG6CTxZ28948M2hVnftfgn5u9/+yOjQ/tYaShr50lV
         AbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yvIsiU4fo0PY3oKFjGIIQ+X2k7DatrTvg/7PGB6w3us=;
        b=z2i2fGExnYLMVk3nY0oGHoCnDez9WJEnKUHQZcNfXzOLJBuDmI4lZ06jtcoXLxCMAv
         eBnpkggqc+oWzQGyM0gftuiAE8lnQnrySAZlfWrxdh6iZJA9Jno5RdyuCu97FS4qeCU9
         tNFRCZ8zwPz5jBE/2mduplZoMntNqotfLMWJ4zA4wcgVrFi3K7QUHiw3suN0TIyvwAq2
         sR52LXtvJ44NBa/SKPS9+xbgk3yxa77ghVDZ01FzCoF5+5dFXU2LTFXkDXjCrR7aBGwX
         ONJH+g1n1XHAraF6NSPFzkBmdO7zBC4BJx0w9bvzj5f0X0tZBhocttmKw463Ox+M7j1F
         +Qag==
X-Gm-Message-State: AOAM5302UtqpWEYk7G+0ldcIFk6V7iTdjUuB/2vOXKXhZPaxVV4hhsHJ
        yTTsNnaDKM8s+KkkkkhVYFIEf9bH3ZMS
X-Google-Smtp-Source: ABdhPJyYTUhZvjoijd9kXyTauJHLqV071pawmKUqV1uPlP0G2WQjzi3dWrzJzX0hciubliQSkzUtiV2yBz84
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3908:af20:80e3:e47])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1686:b0:44d:50e:de9e with SMTP id
 k6-20020a056a00168600b0044d050ede9emr59075424pfc.4.1637266655684; Thu, 18 Nov
 2021 12:17:35 -0800 (PST)
Date:   Thu, 18 Nov 2021 12:17:30 -0800
Message-Id: <20211118201730.2302927-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] perf header: Fix memory leaks
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These leaks were found with leak sanitizer running "perf pipe recording
and injection test". In pipe mode feat_fd may hold onto an events struct
that needs freeing. When string features are processed they may
overwrite an already created string, so free this before the overwrite.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 79cce216727e..e3c1a532d059 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2321,6 +2321,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
 #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
 static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
 {\
+	free(ff->ph->env.__feat_env);		     \
 	ff->ph->env.__feat_env = do_read_string(ff); \
 	return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
 }
@@ -4124,6 +4125,7 @@ int perf_event__process_feature(struct perf_session *session,
 	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
 	int type = fe->header.type;
 	u64 feat = fe->feat_id;
+	int ret = 0;
 
 	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
@@ -4141,11 +4143,13 @@ int perf_event__process_feature(struct perf_session *session,
 	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
-	if (feat_ops[feat].process(&ff, NULL))
-		return -1;
+	if (feat_ops[feat].process(&ff, NULL)) {
+		ret = -1;
+		goto out;
+	}
 
 	if (!feat_ops[feat].print || !tool->show_feat_hdr)
-		return 0;
+		goto out;
 
 	if (!feat_ops[feat].full_only ||
 	    tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
@@ -4154,8 +4158,9 @@ int perf_event__process_feature(struct perf_session *session,
 		fprintf(stdout, "# %s info available, use -I to display\n",
 			feat_ops[feat].name);
 	}
-
-	return 0;
+out:
+	free_event_desc(ff.events);
+	return ret;
 }
 
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
-- 
2.34.0.rc2.393.gf8c9666880-goog

