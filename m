Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDB329457
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhCAV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhCARZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:25:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B2C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:24:22 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s16so10321344plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2O7jttcS05L3DfTUjQfEbI7Sknr4oMWYp/RyjKYyFRk=;
        b=bZdJH8UiFGvpfp0EkEuoLPwV7u+p9QIYN0RidcM6+JY1pscDUzZsYwyuKveg0oafG9
         8dGiVWo52zb7+ZIhHdaR5n125dVVP4dldkQ+6M9YiXG4t5eU5/dJP1wZomu6xrBAh5p+
         FwKjwxw2wdcGb51wDZoauzU7kMYUh4TkHB/5UFKLjRleb0NAqVX2mtpaMpXDwJLzYw+F
         qYDsNHopFQ0T11+TuHQs7pVHSCwDG52oP1COI7kJLnRK8XbDRLt5Z3Z6iIf3kf5II1NI
         bv2cgf2ViQtvFoK6xeVil9cY/j8PW3lRMKK06Zehy+RQk6eShiQdSSv/XnqBx/+0QXAh
         TU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2O7jttcS05L3DfTUjQfEbI7Sknr4oMWYp/RyjKYyFRk=;
        b=UZuQuJw92ejGDz0b/QhWfocPZdbc+rltUY4PL8N79frTyVyW1yOJh0GZpOZJE0ZPDS
         Pzm0oGD5XDQR+Kc+ScchdtH/AjnT99s1dGeeaaHqvVPov3M0RpV6MNSabOESqr47Tnox
         k9QHgiJUWiKVXhGZ229claJ4mlmTW98kgfO2RP5TxrRyRw0RgzzzuQDLMtUZgJ2cozys
         ziXM6aDCQjXXMlfMO0BHRLjFPWd9ShG2qVFjzeNZHC5AmUOhWSrSwRTb5J7/g6EUh+Xa
         w1NIGQ8hN4N3HeDHKU3YJdBxZNyJadFptKzH3FBnEacctKO2zgoBzR0sBBd/eZwI8awI
         m9pg==
X-Gm-Message-State: AOAM533jtyvd6LZMqjbg9WrC4eX1L3aSDfHIpJyyb5/h/9ms1fjyOXN8
        JfGv9pNjM06EtLqeJd8lnAa0pybPjlk=
X-Google-Smtp-Source: ABdhPJyfDb9uvoNPZd5zjhrh72zewnujw4aSoY75SUYjX4JHVSYIM/UK5zTl/p896Z9hYTXvLjDg+Q==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr18704972pjh.141.1614619461760;
        Mon, 01 Mar 2021 09:24:21 -0800 (PST)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id w2sm18301318pgh.54.2021.03.01.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:24:21 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf stat: improve readability of shadow stats
Date:   Tue,  2 Mar 2021 01:24:02 +0800
Message-Id: <20210301172402.6794-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does follow two changes:
  1) Select appropriate unit between K/M/G.
  2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.

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

          8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
             9,768      context-switches          #    1.221 K/cpu-sec
               164      cpu-migrations            #   20.492  /cpu-sec
            74,146      page-faults               #    9.265 K/cpu-sec
    19,008,796,806      cycles                    #    2.375 GHz                      (83.21%)
    14,789,443,853      stalled-cycles-frontend   #   77.80% frontend cycles idle     (83.29%)
    11,867,812,064      stalled-cycles-backend    #   62.43% backend cycles idle      (66.80%)
     9,898,252,603      instructions              #    0.52  insn per cycle
                                                  #    1.49  stalled cycles per insn  (83.41%)
     2,063,251,998      branches                  #  257.803 M/cpu-sec                (83.41%)
        86,941,704      branch-misses             #    4.21% of all branches          (83.30%)

       2.001743706 seconds time elapsed

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/stat-shadow.c | 13 +++++--------
 tools/perf/util/units.c       | 22 ++++++++++++++++++++++
 tools/perf/util/units.h       |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 6ccf21a72f06..786b5ef512d8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,6 +9,7 @@
 #include "expr.h"
 #include "metricgroup.h"
 #include "cgroup.h"
+#include "units.h"
 #include <linux/zalloc.h>
 
 /*
@@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
-		char unit = 'M';
+		char unit = ' ';
 		char unit_buf[10];
 
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
+		snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
 		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
 		print_smi_cost(config, cpu, out, st, &rsd);
diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index a46762aec4c9..ac13b5ecde31 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
 	return value;
 }
 
+double convert_unit_double(double value, char *unit)
+{
+	*unit = ' ';
+
+	if (value > 1000.0) {
+		value /= 1000.0;
+		*unit = 'K';
+	}
+
+	if (value > 1000.0) {
+		value /= 1000.0;
+		*unit = 'M';
+	}
+
+	if (value > 1000.0) {
+		value /= 1000.0;
+		*unit = 'G';
+	}
+
+	return value;
+}
+
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
 	char unit[4] = "BKMG";
diff --git a/tools/perf/util/units.h b/tools/perf/util/units.h
index 99263b6a23f7..b3ace67ac16f 100644
--- a/tools/perf/util/units.h
+++ b/tools/perf/util/units.h
@@ -13,6 +13,7 @@ struct parse_tag {
 unsigned long parse_tag_value(const char *str, struct parse_tag *tags);
 
 unsigned long convert_unit(unsigned long value, char *unit);
+double convert_unit_double(double value, char *unit);
 int unit_number__scnprintf(char *buf, size_t size, u64 n);
 
 #endif /* PERF_UNIT_H */
-- 
2.25.1

