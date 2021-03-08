Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199DC330645
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhCHDPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:15:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:12842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233755AbhCHDPe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:15:34 -0500
IronPort-SDR: n5zybvJ1W5idlEyh+4s1vBNHteeBd6K+OItpDvtOCRD+U8HJeMLMDUJGT/Xrmv1gEv3btyb5SH
 PFp4J44NprOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="249336794"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="249336794"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 19:15:33 -0800
IronPort-SDR: 48fnTap4MuxSStf4OnEIZUvSoGmRZOh6rwF2+2FWS4aNBstkS0AfxA81cGsVVmQNeI+zd4BjEA
 pCLKlM/z5vLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="598690850"
Received: from unknown (HELO kbl-ppc.sh.intel.com) ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2021 19:15:30 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3] perf pmu: Validate raw event with sysfs exported format bits
Date:   Mon,  8 Mar 2021 11:15:06 +0800
Message-Id: <20210308031506.23019-1-yao.jin@linux.intel.com>
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
 tools/perf/util/pmu.c          | 36 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h          |  3 +++
 3 files changed, 42 insertions(+)

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
index 44ef28302fc7..03ab1e6d0418 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1812,3 +1812,39 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
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

