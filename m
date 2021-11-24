Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA245B097
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 01:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhKXAPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 19:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbhKXAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:15:47 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E36C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:12:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p3-20020a170903248300b00143c00a5411so219780plw.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dYxWWLQR2AueZjWPaZwF5Hcz730Itl6Y4oL2JqKhOwA=;
        b=KKhM2pSGmxAdoUG2ZbJlzGPYN+chL2co3ivh/yrifROdkYPuUHB7Tr+C9KVUhUpNZS
         cC/dZMUYoI/Qg/Kbw6aQQysTy59+8GL70M6nLAPKBOTjEM7lNgweL3WlIO+x11HnBw2d
         BcgVtC3/jBTBHg7eJBxSstBSoBBQRPq6kEyyL051w2YVq/UOJvJjg6ZHLOIExu0hGHno
         mJTaLkIOCfwxloTeL6Z9HTbXIKr6ehjAjIPPU6jEl8wGviaLS0F+I9cTa7rYjUvG8foe
         oDSnlyb78puU7MXtEThHy6F6UsWn7F1LJd/xkoXmICmf7mGi484AkJu198fco9jGcqU6
         HRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dYxWWLQR2AueZjWPaZwF5Hcz730Itl6Y4oL2JqKhOwA=;
        b=1WRI+ZLySmni7UxLccBZ36ULBCafV8hb7nJIL1Q58zbfyP6ZolPnbnzGUDJBsL1mzp
         2bhSOTNQtFXARveggsp98ZbfEr1gX89SiYobJ0sClCvhvVC6GG04/BIaTCmtcqwyQTBx
         U8Am34Bqc3XwlkrR5epacvIMCN3paWCexNfGpguATxjhTor6afwlR/0TAYjEYNmJ0lVT
         unBft61UZzuhlGpLFOyKPUQuMv5pV796oTvd2OfjwAE97WbniEUd3OguLjyUtPh0pK9I
         IirHyqzA2igzYmfWAgX4HxCI1WNB1YrIohR1HoTbRzISltvDrMRnTWNjg8wW7L33nV98
         QhHg==
X-Gm-Message-State: AOAM530IqPzecNNpKsoXoBwlxCH4zOOe4fw1d0aoBbHhLkEGJIJO+s8v
        vNg/nyoyJ41Zl1FyiqRkJ1b7sJM/OvCW
X-Google-Smtp-Source: ABdhPJxKOaTWZcbrF7Z4IY5OaGdjtnvHoaxZ/vm1Fs9H3/MKVq25R+IQZqX3XD2EA9Hl5hWhMUwX+JFnwgNC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a17:90a:cb98:: with SMTP id
 a24mr2128308pju.153.1637712758232; Tue, 23 Nov 2021 16:12:38 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:12:30 -0800
In-Reply-To: <20211124001231.3277836-1-irogers@google.com>
Message-Id: <20211124001231.3277836-3-irogers@google.com>
Mime-Version: 1.0
References: <20211124001231.3277836-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 3/4] perf tools: Fix SMT fallback with large core counts
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtoull can only read a 64-bit bitmap. On an AMD EPYC core_cpus may look
like:
00000000,00000000,00000000,00000001,00000000,00000000,00000000,00000001
and so the sibling wasn't spotted. Fix by writing a simple hweight string
parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 68 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 34f1b1b1176c..2636be65305a 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -5,6 +5,56 @@
 #include "api/fs/fs.h"
 #include "smt.h"
 
+/**
+ * hweight_str - Returns the number of bits set in str. Stops at first non-hex
+ *	       or ',' character.
+ */
+static int hweight_str(char *str)
+{
+	int result = 0;
+
+	while (*str) {
+		switch (*str++) {
+		case '0':
+		case ',':
+			break;
+		case '1':
+		case '2':
+		case '4':
+		case '8':
+			result++;
+			break;
+		case '3':
+		case '5':
+		case '6':
+		case '9':
+		case 'a':
+		case 'A':
+		case 'c':
+		case 'C':
+			result += 2;
+			break;
+		case '7':
+		case 'b':
+		case 'B':
+		case 'd':
+		case 'D':
+		case 'e':
+		case 'E':
+			result += 3;
+			break;
+		case 'f':
+		case 'F':
+			result += 4;
+			break;
+		default:
+			goto done;
+		}
+	}
+done:
+	return result;
+}
+
 int smt_on(void)
 {
 	static bool cached;
@@ -15,9 +65,12 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
-	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0)
-		goto done;
+	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0) {
+		cached = true;
+		return cached_result;
+	}
 
+	cached_result = 0;
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
 		unsigned long long siblings;
@@ -35,18 +88,13 @@ int smt_on(void)
 				continue;
 		}
 		/* Entry is hex, but does not have 0x, so need custom parser */
-		siblings = strtoull(str, NULL, 16);
+		siblings = hweight_str(str);
 		free(str);
-		if (hweight64(siblings) > 1) {
+		if (siblings > 1) {
 			cached_result = 1;
-			cached = true;
 			break;
 		}
 	}
-	if (!cached) {
-		cached_result = 0;
-done:
-		cached = true;
-	}
+	cached = true;
 	return cached_result;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

