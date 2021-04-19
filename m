Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27339363F02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbhDSJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:42:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:60390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231904AbhDSJm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:27 -0400
IronPort-SDR: 2YC4LCTtThz0YflRoiUY8a6/B/WmYq3K6OgPUsFSUdO9/o2CLumvYNAAjgT9ROseT93+XFJ7u0
 3Aj28LMpKWaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174787674"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="174787674"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 02:41:58 -0700
IronPort-SDR: E1DomlE8udAJKtddbxmOe9Z/y9Jy4Rk6rqqr/7XyG2GL+BIIXXYm68gJ1Zn2ctUeq+q4fcwN5M
 DjuEqsQWqElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="452089684"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2021 02:41:54 -0700
From:   alexander.antonov@linux.intel.com
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [RESEND PATCH v5 2/4] perf stat: Helper functions for PCIe root ports list in iostat mode
Date:   Mon, 19 Apr 2021 12:41:45 +0300
Message-Id: <20210419094147.15909-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
References: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Introduce helper functions to control PCIe root ports list.
These helpers will be used in the follow-up patch.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/arch/x86/util/iostat.c | 110 ++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/iostat.c

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
new file mode 100644
index 000000000000..c4471f8efa5e
--- /dev/null
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * perf iostat
+ *
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
+ */
+
+#include <api/fs/fs.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <regex.h>
+#include "util/cpumap.h"
+#include "util/debug.h"
+#include "util/iostat.h"
+#include "util/counts.h"
+#include "path.h"
+
+struct iio_root_port {
+	u32 domain;
+	u8 bus;
+	u8 die;
+	u8 pmu_idx;
+	int idx;
+};
+
+struct iio_root_ports_list {
+	struct iio_root_port **rps;
+	int nr_entries;
+};
+
+static void iio_root_port_show(FILE *output,
+			       const struct iio_root_port * const rp)
+{
+	if (output && rp)
+		fprintf(output, "S%d-uncore_iio_%d<%04x:%02x>\n",
+			rp->die, rp->pmu_idx, rp->domain, rp->bus);
+}
+
+static struct iio_root_port *iio_root_port_new(u32 domain, u8 bus,
+					       u8 die, u8 pmu_idx)
+{
+	struct iio_root_port *p = calloc(1, sizeof(*p));
+
+	if (p) {
+		p->domain = domain;
+		p->bus = bus;
+		p->die = die;
+		p->pmu_idx = pmu_idx;
+	}
+	return p;
+}
+
+static void iio_root_ports_list_free(struct iio_root_ports_list *list)
+{
+	int idx;
+
+	if (list) {
+		for (idx = 0; idx < list->nr_entries; idx++)
+			free(list->rps[idx]);
+		free(list->rps);
+		free(list);
+	}
+}
+
+static struct iio_root_port *iio_root_port_find_by_notation(
+	const struct iio_root_ports_list * const list, u32 domain, u8 bus)
+{
+	int idx;
+	struct iio_root_port *rp;
+
+	if (list) {
+		for (idx = 0; idx < list->nr_entries; idx++) {
+			rp = list->rps[idx];
+			if (rp && rp->domain == domain && rp->bus == bus)
+				return rp;
+		}
+	}
+	return NULL;
+}
+
+static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
+				      struct iio_root_port * const rp)
+{
+	struct iio_root_port **tmp_buf;
+
+	if (list && rp) {
+		rp->idx = list->nr_entries++;
+		tmp_buf = realloc(list->rps,
+				  list->nr_entries * sizeof(*list->rps));
+		if (!tmp_buf) {
+			pr_err("Failed to realloc memory\n");
+			return -ENOMEM;
+		}
+		tmp_buf[rp->idx] = rp;
+		list->rps = tmp_buf;
+	}
+	return 0;
+}
-- 
2.21.3

