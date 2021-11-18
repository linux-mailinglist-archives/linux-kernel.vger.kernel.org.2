Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E096B4555CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbhKRHlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241249AbhKRHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:41:12 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DCAC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:38:12 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h20-20020ac85e14000000b002b2e9555bb1so3693889qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TFfa5wiuotNTzLbkIBClp3IPZFeNgKPNPoXCn0plpmo=;
        b=i8ZttbYOruYKJ5dGlhRhLWvKBbtk58XjUQFvrZ+ft3Qdf1NoAt18UAyMpgikdGQ+Ar
         07XLuRB786ICA+G2CfNdoWJP7o0howjQlA0ZsnaB2TSUDOsGtBfuVEG0a6XFk3supkIg
         txuz7Mc9LOGi2+HzlBhJIC0QTm6rmBjg/XEx6a9LFHFHDuoJTdhLIUkicognmbEh3Pk0
         MuoNxpUNZuHXp5MyV7apw0IwRgiKt6lbH6tNXrYI/osKU40I3Qb/P+S7mndYmbDLDGR3
         FmckGE/1h37xgUM4sFUy3oDFJuRCdvgZn1RQHzXLBOh5L1Y7ffX8cN5wmVa8EaUDYW0q
         ZMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TFfa5wiuotNTzLbkIBClp3IPZFeNgKPNPoXCn0plpmo=;
        b=zgtq6AqJSCGvB+ErsFJZhsvrXvS3kiupw3DYZY9p79QKkguhENH/wqPVR9S0rpL29e
         DbSbGR9bMmrLX84x7//x3CMvX9msXbfFa1/eePJ+IF/a6wzRXrJjAHHXUbxbHwzGAOr3
         Y73Nb/IlmDYkT1oOQorCoyvHH4JurLytfy03BdNUnHkoywQ4gwkU4qyB+2oK0PXwyLda
         0zNT0f6Fa4CawEawAS0ucs7MbnrW4TzaEqERUu4/WM4oBBqz/fgtSnETCBZquviSFgmy
         hDAUly824ukYLNmRzXH6Mtfaho2fd+zuVThaQx3SsUHfwIX/8lMAib7bM5ueyexr54PT
         SbRg==
X-Gm-Message-State: AOAM532CTDav5by3cTt9Juo1x9TvlS/bFT94AdR9mXmD5lq1KLy1hvlW
        B2U+R7Hd2cqMGmM79Rz5XbeH6TCoOsIm
X-Google-Smtp-Source: ABdhPJyJYk7fjLROFuYZ0tUx1ZNfgsQJWzy1ZXOmFFSSAILvifDB6A2kWajkD+/FlptJslqMRW+addL51uWE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b539:25b3:faf2:d1b3])
 (user=irogers job=sendgmr) by 2002:ac8:5803:: with SMTP id
 g3mr23281714qtg.317.1637221091577; Wed, 17 Nov 2021 23:38:11 -0800 (PST)
Date:   Wed, 17 Nov 2021 23:38:04 -0800
Message-Id: <20211118073804.2149974-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] perf report: Fix memory leaks around perf_tip
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

perf_tip may allocate memory or use a literal, this means memory wasn't
freed if allocated. Change the API so that literals aren't used. At the
same time add missing frees for system_path. These issues were spotted
using leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 15 +++++++++------
 tools/perf/util/util.c      | 14 +++++++-------
 tools/perf/util/util.h      |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8167ebfe776a..8ae400429870 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -619,14 +619,17 @@ static int report__browse_hists(struct report *rep)
 	int ret;
 	struct perf_session *session = rep->session;
 	struct evlist *evlist = session->evlist;
-	const char *help = perf_tip(system_path(TIPDIR));
+	char *help = NULL, *path = NULL;
 
-	if (help == NULL) {
+	path = system_path(TIPDIR);
+	if (perf_tip(&help, path) || help == NULL) {
 		/* fallback for people who don't install perf ;-) */
-		help = perf_tip(DOCDIR);
-		if (help == NULL)
-			help = "Cannot load tips.txt file, please install perf!";
+		free(path);
+		path = system_path(DOCDIR);
+		if (perf_tip(&help, path) || help == NULL)
+			help = strdup("Cannot load tips.txt file, please install perf!");
 	}
+	free(path);
 
 	switch (use_browser) {
 	case 1:
@@ -651,7 +654,7 @@ static int report__browse_hists(struct report *rep)
 		ret = evlist__tty_browse_hists(evlist, rep, help);
 		break;
 	}
-
+	free(help);
 	return ret;
 }
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 37a9492edb3e..df3c4671be72 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -379,32 +379,32 @@ fetch_kernel_version(unsigned int *puint, char *str,
 	return 0;
 }
 
-const char *perf_tip(const char *dirpath)
+int perf_tip(char **strp, const char *dirpath)
 {
 	struct strlist *tips;
 	struct str_node *node;
-	char *tip = NULL;
 	struct strlist_config conf = {
 		.dirname = dirpath,
 		.file_only = true,
 	};
+	int ret = 0;
 
+	*strp = NULL;
 	tips = strlist__new("tips.txt", &conf);
 	if (tips == NULL)
-		return errno == ENOENT ? NULL :
-			"Tip: check path of tips.txt or get more memory! ;-p";
+		return -errno;
 
 	if (strlist__nr_entries(tips) == 0)
 		goto out;
 
 	node = strlist__entry(tips, random() % strlist__nr_entries(tips));
-	if (asprintf(&tip, "Tip: %s", node->s) < 0)
-		tip = (char *)"Tip: get more memory! ;-)";
+	if (asprintf(strp, "Tip: %s", node->s) < 0)
+		ret = -ENOMEM;
 
 out:
 	strlist__delete(tips);
 
-	return tip;
+	return ret;
 }
 
 char *perf_exe(char *buf, int len)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ad737052e597..9f0d36ba77f2 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -39,7 +39,7 @@ int fetch_kernel_version(unsigned int *puint,
 #define KVER_FMT	"%d.%d.%d"
 #define KVER_PARAM(x)	KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVEL(x)
 
-const char *perf_tip(const char *dirpath);
+int perf_tip(char **strp, const char *dirpath);
 
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
-- 
2.34.0.rc1.387.gb447b232ab-goog

