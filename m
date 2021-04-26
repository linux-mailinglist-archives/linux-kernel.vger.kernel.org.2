Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DBE36B3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhDZNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:17:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:57069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233694AbhDZNRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:17:07 -0400
IronPort-SDR: bqMzxKJzBTGDvu6uLC3M0/FN7iwiZBRQpB3zr2GAhQiOpxSaYXyUJ9qs441owaqDtpYZuUqOA/
 Rj6L3xbrCffg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175815586"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175815586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 06:16:26 -0700
IronPort-SDR: zuQKKjcg8HjooymPtpCbgHOO5tbYpuj7LQgxCTBh8FiweO8syxbjyZGQuAlJywsEWxOuAPkDiA
 k+TGfNpb+njg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="424903167"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2021 06:16:23 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [PATCH 3/3] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX
Date:   Mon, 26 Apr 2021 16:16:14 +0300
Message-Id: <20210426131614.16205-4-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

This patch enables I/O stacks to IIO PMON mapping on Icelake server.

Mapping of IDs in SAD_CONTROL_CFG notation to IDs in PMON notation for
Icelake server:

Stack Name         | CBDMA/DMI | PCIe_1 | PCIe_2 | PCIe_3 | PCIe_4 | PCIe_5
SAD_CONTROL_CFG ID |     0     |    1   |    2   |    3   |    4   |    5
PMON ID            |     5     |    0   |    1   |    2   |    3   |    4

I/O stacks to IIO PMON mapping is exposed through attributes
/sys/devices/uncore_iio_<pmu_idx>/dieX, where dieX is file which holds
"Segment:Root Bus" for PCIe root port which can be monitored by that
IIO PMON block. Example for 2-S Icelake server:

==> /sys/devices/uncore_iio_0/die0 <==
0000:16
==> /sys/devices/uncore_iio_0/die1 <==
0000:97
==> /sys/devices/uncore_iio_1/die0 <==
0000:30
==> /sys/devices/uncore_iio_1/die1 <==
0000:b0
==> /sys/devices/uncore_iio_3/die0 <==
0000:4a
==> /sys/devices/uncore_iio_3/die1 <==
0000:c9
==> /sys/devices/uncore_iio_4/die0 <==
0000:64
==> /sys/devices/uncore_iio_4/die1 <==
0000:e2
==> /sys/devices/uncore_iio_5/die0 <==
0000:00
==> /sys/devices/uncore_iio_5/die1 <==
0000:80

Cc: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9d75da6d9c75..e756c40d54fb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5050,6 +5050,53 @@ static struct event_constraint icx_uncore_iio_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static umode_t
+icx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 5. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 5);
+}
+
+static struct attribute_group icx_iio_mapping_group = {
+	.is_visible	= icx_iio_mapping_visible,
+};
+
+static const struct attribute_group *icx_iio_attr_update[] = {
+	&icx_iio_mapping_group,
+	NULL,
+};
+
+/*
+ * ICX has a static mapping of stack IDs from SAD_CONTROL_CFG notation to PMON
+ */
+enum {
+	ICX_PCIE1_PMON_ID,
+	ICX_PCIE2_PMON_ID,
+	ICX_PCIE3_PMON_ID,
+	ICX_PCIE4_PMON_ID,
+	ICX_PCIE5_PMON_ID,
+	ICX_CBDMA_DMI_PMON_ID
+};
+
+static u8 icx_sad_pmon_mapping[] = {
+	ICX_CBDMA_DMI_PMON_ID,
+	ICX_PCIE1_PMON_ID,
+	ICX_PCIE2_PMON_ID,
+	ICX_PCIE3_PMON_ID,
+	ICX_PCIE4_PMON_ID,
+	ICX_PCIE5_PMON_ID,
+};
+
+static int icx_iio_get_topology(struct intel_uncore_type *type)
+{
+	return sad_cfg_iio_topology(type, icx_sad_pmon_mapping);
+}
+
+static int icx_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &icx_iio_mapping_group);
+}
+
 static struct intel_uncore_type icx_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -5064,6 +5111,10 @@ static struct intel_uncore_type icx_uncore_iio = {
 	.constraints		= icx_uncore_iio_constraints,
 	.ops			= &skx_uncore_iio_ops,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= icx_iio_attr_update,
+	.get_topology		= icx_iio_get_topology,
+	.set_mapping		= icx_iio_set_mapping,
+	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
 
 static struct intel_uncore_type icx_uncore_irp = {
-- 
2.21.3

