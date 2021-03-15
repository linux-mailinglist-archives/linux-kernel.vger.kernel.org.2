Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9133BEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhCOOuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhCOObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:31:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76295C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:31:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so8895876pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxMFtpQXBw8+Teasy1N+8sAYQpWswbzlBxa6vG+wy8E=;
        b=gtOUQuVWaqpqRobZHIW8g1STxSJRyKi2AepnJDvYLgM38OGEyhgC9dV4IzfmndbKBN
         5p8Z87ncIscRXOf8NB6ExyBfXH5nNBpI2CWlG2yCXUBYdM9Iv9KdmLNTw3EgD1c0CE+d
         B3PLhzYj8an+Io6C2Cu0fhrI6+b2lw5h021uBA4NWwrhhLnfPRpCjEGgAnZm/slngQnj
         Pptj70b0dLLYMG1fAw6JgAttVLVcqhup/KRiZWXD1U9VqxbLLshBynZcxEjQDIgzP9OO
         YciFGeOFojeopP4qWq5EtE9NoDOmNDI9iLdY37nwgKaQxVjmmTBXYyBT0HVy9vdGOZVS
         AqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxMFtpQXBw8+Teasy1N+8sAYQpWswbzlBxa6vG+wy8E=;
        b=adbEgPOT0iAefaGBjVnHgRYWV9YSPbliiFEWPLpoXxEXVo7k0IZAJRL+XI5oaNbe3k
         PX6YWy9ijpkgFS33UTjrQ94XS5kn6W+4GAiFsm2AtG7yIdgQ79+FCA2bIRqzWBiHnvGS
         HmWA2cBt4iXooFXMfV7apLUUHZf0gCYSiXqbEyG4+af0JkpsX0/dWMxN5JfVY6bj/n1k
         4aTRFdFTpYQQOtTZfmXEV2Y7HDKW6ZePHGeALBPSf4JI/QKI9mi7J4ZrRgalIcuQeAOS
         QBBtdA2h1Khor9rKixShuwlsWGm8JJsvtBwJRjcpY855xLUlfDJmkHyVmohxRRIhLLyx
         q/qQ==
X-Gm-Message-State: AOAM533xtrf2giplXXcpPl9weHhMWbSCiFuLq5W1ku4/pO12V4UJptDX
        hJ6qeVJrstBeeZyLMuFs1bs=
X-Google-Smtp-Source: ABdhPJxKtsRPy4NcaEoJGSbHx2fCY9CauFVtyzYtzmzK8JdAmS0T9v47E9RJwq6ggc6be8NLChXvVQ==
X-Received: by 2002:a17:90b:4d12:: with SMTP id mw18mr13173141pjb.196.1615818659958;
        Mon, 15 Mar 2021 07:30:59 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id e1sm14072652pfd.72.2021.03.15.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 07:30:59 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v2] perf stat: improve readability of shadow stats
Date:   Mon, 15 Mar 2021 22:30:47 +0800
Message-Id: <20210315143047.3867-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds function convert_unit_double() and selects appropriate
unit for shadow stats between K/M/G.

$ sudo ./perf stat -a -- sleep 1

Before: Unit 'M' is selected even the number is very small.
 Performance counter stats for 'system wide':

          4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
            16,179      context-switches          #    0.004 M/sec
               161      cpu-migrations            #    0.040 K/sec
             4,699      page-faults               #    0.001 M/sec
     6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
     5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
     4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
     4,720,130,587      instructions              #    0.77  insn per cycle
                                                  #    1.23  stalled cycles per insn  (83.28%)
       753,848,078      branches                  #  188.318 M/sec                    (83.61%)
        37,457,747      branch-misses             #    4.97% of all branches          (83.48%)

       1.001283725 seconds time elapsed

After:
$ sudo ./perf stat -a -- sleep 2

 Performance counter stats for 'system wide':

          8,005.52 msec cpu-clock                 #    3.999 CPUs utilized
            10,715      context-switches          #    1.338 K/sec
               785      cpu-migrations            #   98.057 /sec
               102      page-faults               #   12.741 /sec
     1,948,202,279      cycles                    #    0.243 GHz
     2,816,470,932      stalled-cycles-frontend   #  144.57% frontend cycles idle
     2,661,172,207      stalled-cycles-backend    #  136.60% backend cycles idle
       464,172,105      instructions              #    0.24  insn per cycle
                                                  #    6.07  stalled cycles per insn
        91,567,662      branches                  #   11.438 M/sec
         7,756,054      branch-misses             #    8.47% of all branches

       2.002040043 seconds time elapsed

Signed-off-by: Changbin Du <changbin.du@gmail.com>

v2:
  o do not change 'sec' to 'cpu-sec'.
  o use convert_unit_double to implement convert_unit.
---
 tools/perf/util/stat-shadow.c | 16 +++++++---------
 tools/perf/util/units.c       | 21 ++++++++++++++-------
 tools/perf/util/units.h       |  1 +
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 6ccf21a72f06..3f800e71126f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,6 +9,7 @@
 #include "expr.h"
 #include "metricgroup.h"
 #include "cgroup.h"
+#include "units.h"
 #include <linux/zalloc.h>
 
 /*
@@ -1270,18 +1271,15 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
-		char unit = 'M';
-		char unit_buf[10];
+		char unit = ' ';
+		char unit_buf[10] = "/sec";
 
 		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
-
 		if (total)
-			ratio = 1000.0 * avg / total;
-		if (ratio < 0.001) {
-			ratio *= 1000;
-			unit = 'K';
-		}
-		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
+			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
+
+		if (unit != ' ')
+			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
 		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
 		print_smi_cost(config, cpu, out, st, &rsd);
diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index a46762aec4c9..32c39cfe209b 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -33,28 +33,35 @@ unsigned long parse_tag_value(const char *str, struct parse_tag *tags)
 	return (unsigned long) -1;
 }
 
-unsigned long convert_unit(unsigned long value, char *unit)
+double convert_unit_double(double value, char *unit)
 {
 	*unit = ' ';
 
-	if (value > 1000) {
-		value /= 1000;
+	if (value > 1000.0) {
+		value /= 1000.0;
 		*unit = 'K';
 	}
 
-	if (value > 1000) {
-		value /= 1000;
+	if (value > 1000.0) {
+		value /= 1000.0;
 		*unit = 'M';
 	}
 
-	if (value > 1000) {
-		value /= 1000;
+	if (value > 1000.0) {
+		value /= 1000.0;
 		*unit = 'G';
 	}
 
 	return value;
 }
 
+unsigned long convert_unit(unsigned long value, char *unit)
+{
+	double v = convert_unit_double((double)value, unit);
+
+	return (unsigned long)v;
+}
+
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
 	char unit[4] = "BKMG";
diff --git a/tools/perf/util/units.h b/tools/perf/util/units.h
index 99263b6a23f7..ea43e74e3240 100644
--- a/tools/perf/util/units.h
+++ b/tools/perf/util/units.h
@@ -12,6 +12,7 @@ struct parse_tag {
 
 unsigned long parse_tag_value(const char *str, struct parse_tag *tags);
 
+double convert_unit_double(double value, char *unit);
 unsigned long convert_unit(unsigned long value, char *unit);
 int unit_number__scnprintf(char *buf, size_t size, u64 n);
 
-- 
2.25.1

