Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0B32BAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358212AbhCCL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:57:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:30750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353687AbhCCFUV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:20:21 -0500
IronPort-SDR: Ss3+zxOlqa78OL8z4nwrxIaOFU90/8l58GlZZs10kebQxPnnC/uwbXKQ5tllcBkBzAW8kdsEpW
 uxKkvnP9Hspg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206783410"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206783410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:18:37 -0800
IronPort-SDR: TyoxfolEA/zGv+88c4x1iRb6uOsfuSJzIveQbZXxyadY5csJ9brkJpXgPfhOjL/eR6oWOF/miC
 OjtFIDBJy7ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="506656331"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2021 21:18:33 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf pmu: Validate raw event with sysfs exported format bits
Date:   Wed,  3 Mar 2021 13:17:36 +0800
Message-Id: <20210303051736.26974-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A raw PMU event (eventsel+umask) in the form of rNNN is supported
by perf but lacks of checking for the validity of raw encoding.

For example, bit 16 and bit 17 are not valid on KBL but perf doesn't
report warning when encoding with these bits.

Before:

  # ./perf stat -e cpu/r031234/ -a -- sleep 1

   Performance counter stats for 'system wide':

                   0      cpu/r031234/

         1.003798924 seconds time elapsed

It may silently measure the wrong event!

The kernel supported bits have been exported through
/sys/devices/<pmu>/format/. Perf collects the information to
'struct perf_pmu_format' and links it to 'pmu->format' list.

The 'struct perf_pmu_format' has a bitmap which records the
valid bits for this format. For example,

  root@kbl-ppc:/sys/devices/cpu/format# cat umask
  config:8-15

bit8-bit15 are recorded in bitmap of format 'umask'.

We collect total valid bits of all formats, save to a local variable
'masks' and reverse it. Now '~masks' represents total invalid bits.

bits = config & ~masks;

The set bits in 'bits' indicate the invalid bits used in config.
Finally use strbuf to report the invalid bits.

Some architectures may not export supported bits through sysfs,
so if masks is 0, perf_pmu__config_valid just returns true.

After:

Single event:

  # ./perf stat -e cpu/r031234/ -a -- sleep 1
  WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      cpu/r031234/

         1.001403757 seconds time elapsed

Multiple events:

  # ./perf stat -e cpu/rf01234/,cpu/r031234/ -a -- sleep 1
  WARNING: event config 'f01234' not valid (bits 20 22 not supported by kernel)!
  WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      cpu/rf01234/
                   0      cpu/r031234/

The warning is reported for invalid bits.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 11 ++++++++++
 tools/perf/util/pmu.c          | 38 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h          |  4 ++++
 3 files changed, 53 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..1820b2c0a241 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -356,6 +356,17 @@ __add_event(struct list_head *list, int *idx,
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 
+	if (pmu && attr->type == PERF_TYPE_RAW) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (!perf_pmu__config_valid(pmu, attr->config, &buf)) {
+			pr_warning("WARNING: event config '%llx' not valid ("
+				   "bits%s not supported by kernel)!\n",
+				   attr->config, buf.buf);
+		}
+		strbuf_release(&buf);
+	}
+
 	if (init_attr)
 		event_attr_init(attr);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef28302fc7..5e361adb2698 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1812,3 +1812,41 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	return nr_caps;
 }
+
+bool perf_pmu__config_valid(struct perf_pmu *pmu, __u64 config,
+			    struct strbuf *buf)
+{
+	struct perf_pmu_format *format;
+	__u64 masks = 0, bits;
+	int i;
+
+	list_for_each_entry(format, &pmu->format, list)	{
+		/*
+		 * Skip extra configs such as config1/config2.
+		 */
+		if (format->value > 0)
+			continue;
+
+		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
+			masks |= 1ULL << i;
+	}
+
+	/*
+	 * Kernel doesn't export any valid format bits.
+	 */
+	if (masks == 0)
+		return true;
+
+	bits = config & ~masks;
+	if (bits == 0)
+		return true;
+
+	for (i = 0; i < PERF_PMU_FORMAT_BITS; i++) {
+		if (bits & 0x1)
+			strbuf_addf(buf, " %d", i);
+
+		bits >>= 1;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388478c6..980d6430c833 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -8,6 +8,7 @@
 #include <stdbool.h>
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
+#include "strbuf.h"
 
 struct evsel_config_term;
 
@@ -123,4 +124,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
+bool perf_pmu__config_valid(struct perf_pmu *pmu, __u64 config,
+			    struct strbuf *buf);
+
 #endif /* __PMU_H */
-- 
2.17.1

