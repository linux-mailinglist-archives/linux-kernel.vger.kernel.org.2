Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A833334BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhCJFMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:12:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:50276 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCJFMD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:12:03 -0500
IronPort-SDR: RB3BhizsX3IraSnZVj+DBgXaBKaDDxGskH3Jf0EiBUsSYQxgTBUKgkSd/EsQwn7UArxuKgNLwg
 X7xXJjsQnP9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175986255"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="175986255"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 21:12:02 -0800
IronPort-SDR: xJNOPGTXdMQU7bFFcUM/kYwREaFQUlWeSruOezUR/03oCjA3HfjH3Sp09R13jfr1Gg7r+V/BwC
 3I49PZPmCBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="431066039"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2021 21:12:00 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4] perf pmu: Validate raw event with sysfs exported format bits
Date:   Wed, 10 Mar 2021 13:11:38 +0800
Message-Id: <20210310051138.12154-1-yao.jin@linux.intel.com>
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

The valid bits (bit8-bit15) are recorded in bitmap of format 'umask'.

We collect total valid bits of all formats, save to a local variable
'masks' and reverse it. Now '~masks' represents total invalid bits.

bits = config & ~masks;

The set bits in 'bits' indicate the invalid bits used in config.
Finally we use bitmap_scnprintf to report the invalid bits.

Some architectures may not export supported bits through sysfs,
so if masks is 0, perf_pmu__warn_invalid_config directly returns.

After:

Single event without name:

  # ./perf stat -e cpu/r031234/ -a -- sleep 1
  WARNING: event 'N/A' not valid (bits 16-17 of config '31234' not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      cpu/r031234/

         1.001597373 seconds time elapsed

Multiple events with names:

  # ./perf stat -e cpu/rf01234,name=aaa/,cpu/r031234,name=bbb/ -a -- sleep 1
  WARNING: event 'aaa' not valid (bits 20,22 of config 'f01234' not supported by kernel)!
  WARNING: event 'bbb' not valid (bits 16-17 of config '31234' not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      aaa
                   0      bbb

         1.001573787 seconds time elapsed

Warnings are reported for invalid bits.

Co-developed-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c |  3 +++
 tools/perf/util/pmu.c          | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h          |  3 +++
 3 files changed, 39 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..c0c0fab22cb8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -356,6 +356,9 @@ __add_event(struct list_head *list, int *idx,
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 
+	if (pmu && attr->type == PERF_TYPE_RAW)
+		perf_pmu__warn_invalid_config(pmu, attr->config, name);
+
 	if (init_attr)
 		event_attr_init(attr);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef28302fc7..46fd0f998484 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1812,3 +1812,36 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	return nr_caps;
 }
+
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   char *name)
+{
+	struct perf_pmu_format *format;
+	__u64 masks = 0, bits;
+	char buf[100];
+	unsigned int i;
+
+	list_for_each_entry(format, &pmu->format, list)	{
+		if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
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
+		return;
+
+	bits = config & ~masks;
+	if (bits == 0)
+		return;
+
+	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
+
+	pr_warning("WARNING: event '%s' not valid (bits %s of config "
+		   "'%llx' not supported by kernel)!\n",
+		   name ?: "N/A", buf, config);
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388478c6..160b0f561771 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -123,4 +123,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   char *name);
+
 #endif /* __PMU_H */
-- 
2.17.1

