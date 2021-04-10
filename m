Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AA35AA7D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhDJDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 23:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbhDJDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 23:19:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDDC061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:19:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u7so1842673plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3t/tngU8dtQcXWco3+3yVgjTirlCoixl9GVxEPlU/c=;
        b=r4t3ZqvEbzCz3VJyhkOOYl+YIWFnFpLLWVfy2cMMEMDSvDm/2RFbxwQHPMBQ0Sk30z
         tUBYOwOwtZSXYXVKhj9WV4shDKLiPDWhR/SW6qPBOpsbLTdSy/XB1jNmJ673IGkmfwEs
         F1kjbwDv3aNrXzTtC1XuKQXXFVvfOaFNMsrDflLnp+K95Nxv7AjGmfm2ouOkiRvG7BD8
         VlgrUpZHWi375Alq4asoT6CoW9hAozgCY+i4wNDRr0EYbq8rq37mcBXmRg05aIFsbnXY
         FVzDTxsf4K7m7XFrwntvH0GtT34HHQ/usa6PW61DYHy4vBXgSc4jWVHIDjjmxbVvfCDO
         Cs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3t/tngU8dtQcXWco3+3yVgjTirlCoixl9GVxEPlU/c=;
        b=W5VCN+qTsHBYPG92RxQXtlHZWe2j0nMq9RnvPSFwdIwzYJVfaI8bOTSvzw+3C17DB6
         hAL2WhIlGJ2JXpO2x8b8EWH6juOswo9eB6oMLwVwWSeLhuKiGeZZsW53vFueT2sjmwDt
         +1Cd/fruhKyOMJEOf3qIwMnGuvEGwNpR9cG/xe8UsTK2Kr8SscdhTZz3jot4Njt49eUP
         ZsJHunb0sz+GAeVcCuPbtohxX9CUCIsNil356R4hO7Ic/Rv/L2pZLi4VOiTrU/NkgFQY
         Mnhz9NUkNqIP2/i63qTO9a7k45X3iWaVjlR+JJCbQZ0GHmDgaMfbpwSgexydgORKb1iQ
         36fQ==
X-Gm-Message-State: AOAM530L4qRdf3lTchWCo6M26qjTJ/jOfrWS5HNQcgykR9jajtOqIby+
        i6ul37cJ+gnQoZauuCEpdrRwJQ==
X-Google-Smtp-Source: ABdhPJz1EU9fLuIjlR5/vm/8x7bvYhEHkQ5mY81Fj+zfQnyHc8KMVv+f/rVLcV+dzpPcMAKCGQhgMA==
X-Received: by 2002:a17:902:ac98:b029:ea:b3c2:53da with SMTP id h24-20020a170902ac98b02900eab3c253damr3268892plr.23.1618024780487;
        Fri, 09 Apr 2021 20:19:40 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id b7sm3335976pfi.42.2021.04.09.20.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 20:19:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf session: Dump PERF_RECORD_TIME_CONV event
Date:   Sat, 10 Apr 2021 11:19:30 +0800
Message-Id: <20210410031930.18064-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
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
---
 tools/perf/util/session.c | 13 ++++++++++++-
 tools/perf/util/tsc.c     | 18 ++++++++++++++++++
 tools/perf/util/tsc.h     |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9a8808507bd9..75931c8054aa 100644
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
index 62b4c75c966c..4ac3cc72f3e1 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <inttypes.h>
+#include <string.h>
 
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
@@ -110,3 +112,19 @@ u64 __weak rdtsc(void)
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
+	ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n", tc->time_cycles);
+	ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n", tc->time_mask);
+	ret += fprintf(fp, "... Cap Time Zero   %" PRId32 "\n", tc->cap_user_time_zero);
+	ret += fprintf(fp, "... Cap Time Short  %" PRId32 "\n", tc->cap_user_time_short);
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

