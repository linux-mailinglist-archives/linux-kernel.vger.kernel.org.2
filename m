Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475C32E3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCEIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:32:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:41303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhCEIca (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:32:30 -0500
IronPort-SDR: Q4jKOMW5Bi3MdDAC3fHswiUB/4acWIXALLHaDB52uPq46q8TxYIqu1Vi2PihtkeM3KwCtMjMT+
 i2XGceFTivMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="186956984"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="186956984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 00:32:30 -0800
IronPort-SDR: 00qOALUjoLTOqdjXVWdJRTGIMWA+dwUDEgQRsojsMz5T55r9IaowTXh3AVojjA01XpuyHP3tGV
 aGJogQcIgDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="507921193"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2021 00:32:22 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf pmu: Validate raw event with sysfs exported format bits
Date:   Fri,  5 Mar 2021 08:56:25 +0800
Message-Id: <20210305005625.14987-1-yao.jin@linux.intel.com>
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
so if masks is 0, perf_pmu__warn_invalid_config directly returns.

After:

Single event without name:

  # ./perf stat -e cpu/r031234/ -a -- sleep 1
  WARNING: event not valid (bits 16 17 of config '31234' not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      cpu/r031234/

         1.001414935 seconds time elapsed

Multiple events with names:

  # ./perf stat -e cpu/rf01234,name=aaa/,cpu/r031234,name=bbb/ -a -- sleep 1
  WARNING: event 'aaa' not valid (bits 20 22 of config 'f01234' not supported by kernel)!
  WARNING: event 'bbb' not valid (bits 16 17 of config '31234' not supported by kernel)!

   Performance counter stats for 'system wide':

                   0      aaa
                  36      bbb

         1.001565999 seconds time elapsed

Warning is reported for invalid bits.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c |  3 +++
 tools/perf/util/pmu.c          | 46 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h          |  3 +++
 3 files changed, 52 insertions(+)

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
index 44ef28302fc7..31e975b75766 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1812,3 +1812,49 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	return nr_caps;
 }
+
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   char *name)
+{
+	struct perf_pmu_format *format;
+	__u64 masks = 0, bits;
+	struct strbuf buf = STRBUF_INIT;
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
+		goto out;
+
+	bits = config & ~masks;
+	if (bits == 0)
+		goto out;
+
+	for_each_set_bit(i, (unsigned long *)&bits, sizeof(bits) * 8)
+		strbuf_addf(&buf, " %d", i);
+
+	if (name) {
+		pr_warning("WARNING: event '%s' not valid (bits%s of config "
+			   "'%llx' not supported by kernel)!\n",
+			   name, buf.buf, config);
+	} else {
+		pr_warning("WARNING: event not valid (bits%s of config "
+			   "'%llx' not supported by kernel)!\n",
+			   buf.buf, config);
+	}
+
+out:
+	strbuf_release(&buf);
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

