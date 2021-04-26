Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B936B3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDZNRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:17:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:57069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233647AbhDZNRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:17:01 -0400
IronPort-SDR: jIjORq9T4PayNXasO5IJvWLldPDCDdkRplpQodQQJ7VbqZX5CmhpP9corbDo6/uyElkzeGEt+i
 k78zwocGZnFg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175815567"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175815567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 06:16:20 -0700
IronPort-SDR: 6o7YnBkd7JFtQIuBafBfbbYk0eiVNlO5HAD2uGmxMdIF1aMz/casjEAPxMc2PCcLGfKC62ESva
 LcXbJgCFZh/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="424903142"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2021 06:16:17 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [PATCH 1/3] perf/x86/intel/uncore: Generalize I/O stacks to PMON mapping procedure
Date:   Mon, 26 Apr 2021 16:16:12 +0300
Message-Id: <20210426131614.16205-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Currently I/O stacks to IIO PMON mapping is available on Skylake servers
only and need to make code more general to easily enable further platforms.
So, introduce get_topology() callback in struct intel_uncore_type which
allows to move common code to separate function and make mapping procedure
more general.

Cc: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 96569dc2119d..d91733337f94 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -92,6 +92,7 @@ struct intel_uncore_type {
 	/*
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
+	int (*get_topology)(struct intel_uncore_type *type);
 	int (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
 };
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index acc3c0e52f4d..72970b4c907b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3689,12 +3689,19 @@ static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
 }
 
 static umode_t
-skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+pmu_iio_mapping_visible(struct kobject *kobj, struct attribute *attr,
+			 int die, int zero_bus_pmu)
 {
 	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(kobj_to_dev(kobj));
 
-	/* Root bus 0x00 is valid only for die 0 AND pmu_idx = 0. */
-	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx) ? 0 : attr->mode;
+	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx != zero_bus_pmu) ? 0 : attr->mode;
+}
+
+static umode_t
+skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 0. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 0);
 }
 
 static ssize_t skx_iio_mapping_show(struct device *dev,
@@ -3779,7 +3786,8 @@ static const struct attribute_group *skx_iio_attr_update[] = {
 	NULL,
 };
 
-static int skx_iio_set_mapping(struct intel_uncore_type *type)
+static int
+pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
 	char buf[64];
 	int ret;
@@ -3787,7 +3795,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	struct attribute **attrs = NULL;
 	struct dev_ext_attribute *eas = NULL;
 
-	ret = skx_iio_get_topology(type);
+	ret = type->get_topology(type);
 	if (ret < 0)
 		goto clear_attr_update;
 
@@ -3814,7 +3822,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 		eas[die].var = (void *)die;
 		attrs[die] = &eas[die].attr.attr;
 	}
-	skx_iio_mapping_group.attrs = attrs;
+	ag->attrs = attrs;
 
 	return 0;
 err:
@@ -3828,6 +3836,11 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	return ret;
 }
 
+static int skx_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
+}
+
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
 {
 	struct attribute **attr = skx_iio_mapping_group.attrs;
@@ -3858,6 +3871,7 @@ static struct intel_uncore_type skx_uncore_iio = {
 	.ops			= &skx_uncore_iio_ops,
 	.format_group		= &skx_uncore_iio_format_group,
 	.attr_update		= skx_iio_attr_update,
+	.get_topology		= skx_iio_get_topology,
 	.set_mapping		= skx_iio_set_mapping,
 	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
-- 
2.21.3

