Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92436D708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhD1MK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhD1MKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A41C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e2so28385605plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ0ISyAjNzzN5FfydaMjwX+cPn7rkfwWXqcYmZ5n8y4=;
        b=d7FF2L8IT3sbXIJoLdmfQ1KY7hAsl9d8vTVNRpOxjoKBNmIbN/4ZXwmuQHMVtrzR0n
         nLQIbqNahWiJk6w4CNqsLGwAJbkkq8PiUQ1uYT7DdQjua2MDfmTwIrsNl4pkNZ7ahEVa
         4Ct9IwxIkJ/FmbjQcMbQyF9nZ3ujP/SZw+sDLXGZHhhlRI0qZwEVxhovTY+Ts6Q91Iqe
         sQYwsvlOP8D9SUZxBSylynWNoF2DHqJmWTopTpA2zhnmT0Fq9qL+90Ndvvy7/KJZVmBM
         62BBQRW2LElbzxOkk4GeabrNkY6UAOguVmwjYG80iNmJOtvsr4bFTzd/qgOc2QyZCIO+
         VUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ0ISyAjNzzN5FfydaMjwX+cPn7rkfwWXqcYmZ5n8y4=;
        b=KMwPOk4M3RalzbnuV2GLQAHdvvxDWaaZYwok83dxL8gAFK4BvkuHtaHtpQNTc/Muvx
         2tOpFbJhjlY3JXFG/LC6v3H1+oBpJ/oQrOEsyYCeyyUlzqCAGR0yftNYp77tGuFgHOUV
         UyvyKRBexQYGjs/cB+FeWqirQs8Mq3IvjWhi8oKZOqzQ7hQmYaYY1er+Zl6DmaF41xbY
         0XcCh7ztMUw3/R94+8M4d27hast/8YzQvI8aRMEonSgOS2/t8mRHCAiCWIKRihVBTV6F
         att00yw8goMfmn9eERB2YXheVp+lKibsUhxSLdREj27DU+sN4pFnrb0gLoLljFpd0hRo
         kaKw==
X-Gm-Message-State: AOAM532AESKmPgSPhg8c7Yc6t7CcgjRIySSSSgJ8jOugt4lL748k1V9Q
        LHs8iGqvERQgUhZ5pP2MVZMI1g==
X-Google-Smtp-Source: ABdhPJxYynOoQkNQvblkRo2YxHLJdGkBAkW8H7fjpN4spGu2fLqCertX0Fx9DgFQ/JLJqOtnpCIXEA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr990914pji.14.1619611778685;
        Wed, 28 Apr 2021 05:09:38 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id 123sm5074726pfz.127.2021.04.28.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 4/4] perf session: Dump PERF_RECORD_TIME_CONV event
Date:   Wed, 28 Apr 2021 20:09:15 +0800
Message-Id: <20210428120915.7123-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428120915.7123-1-leo.yan@linaro.org>
References: <20210428120915.7123-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now perf tool uses the common stub function process_event_op2_stub() for
dumping TIME_CONV event, thus it doesn't output the clock parameters
contained in the event.

This patch adds the callback function for dumping the hardware clock
parameters in TIME_CONV event.

Before:

  # perf report -D

  0x978 [0x38]: event: 79
  .
  . ... raw event: size 56 bytes
  .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
  .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
  .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
  .  0030:  01 01 00 00 00 00 00 00                          ........

  0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
  : unhandled!

  [...]

After:

  # perf report -D

  0x978 [0x38]: event: 79
  .
  . ... raw event: size 56 bytes
  .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
  .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
  .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
  .  0030:  01 01 00 00 00 00 00 00                          ........

  0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
  ... Time Shift      21
  ... Time Muliplier  20971520
  ... Time Zero       18446743935180835206
  ... Time Cycles     13852918225
  ... Time Mask       0xffffffffffffff
  ... Cap Time Zero   1
  ... Cap Time Short  1
  : unhandled!

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 13 ++++++++++++-
 tools/perf/util/tsc.c     | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/tsc.h     |  4 ++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e3cab92042d..cb6f9344341e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "tsc.h"
 #include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
@@ -451,6 +452,16 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
 	return 0;
 }
 
+static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
+					union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_time_conv(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
 						       union perf_event *event __maybe_unused,
 						       u64 file_offset __maybe_unused)
@@ -532,7 +543,7 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 	if (tool->stat_round == NULL)
 		tool->stat_round = process_stat_round_stub;
 	if (tool->time_conv == NULL)
-		tool->time_conv = process_event_op2_stub;
+		tool->time_conv = process_event_time_conv_stub;
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
 	if (tool->compressed == NULL)
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 62b4c75c966c..f19791d46e99 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <inttypes.h>
+#include <string.h>
 
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
@@ -110,3 +112,31 @@ u64 __weak rdtsc(void)
 {
 	return 0;
 }
+
+size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
+{
+	struct perf_record_time_conv *tc = (struct perf_record_time_conv *)event;
+	size_t ret;
+
+	ret  = fprintf(fp, "\n... Time Shift      %" PRI_lu64 "\n", tc->time_shift);
+	ret += fprintf(fp, "... Time Muliplier  %" PRI_lu64 "\n", tc->time_mult);
+	ret += fprintf(fp, "... Time Zero       %" PRI_lu64 "\n", tc->time_zero);
+
+	/*
+	 * The event TIME_CONV was extended for the fields from "time_cycles"
+	 * when supported cap_user_time_short, for backward compatibility,
+	 * prints the extended fields only if they are contained in the event.
+	 */
+	if (event_contains(*tc, time_cycles)) {
+		ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n",
+			       tc->time_cycles);
+		ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n",
+			       tc->time_mask);
+		ret += fprintf(fp, "... Cap Time Zero   %" PRId32 "\n",
+			       tc->cap_user_time_zero);
+		ret += fprintf(fp, "... Cap Time Short  %" PRId32 "\n",
+			       tc->cap_user_time_short);
+	}
+
+	return ret;
+}
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 72a15419f3b3..7d83a31732a7 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#include "event.h"
+
 struct perf_tsc_conversion {
 	u16 time_shift;
 	u32 time_mult;
@@ -24,4 +26,6 @@ u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
 
+size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
+
 #endif // __PERF_TSC_H
-- 
2.25.1

