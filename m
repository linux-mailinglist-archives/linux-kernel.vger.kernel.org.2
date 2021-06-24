Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A33B2492
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFXBjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:8652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhFXBjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:15 -0400
IronPort-SDR: RJgZ59HFYjV3fnIYtLrjBQjELMKU0xKykKq4UFEOnRNeSocvwWPPJPHOKeX/oHEntg/u+6r8oB
 DcvuAG3ASZ2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187756986"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187756986"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:36:56 -0700
IronPort-SDR: VIey3GLFL2hR1K5+bh3EsHxL25+2Xkb+ZVDqJij5x4k2Ig+3frzcMNIERB8e3tVRBegvleP33u
 AqSN17DzCSrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928472"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:36:55 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/7] perf: Create a symlink for a PMU
Date:   Wed, 23 Jun 2021 18:22:04 -0700
Message-Id: <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
server supports the discovery mechanism. Without the platform-specific
support, an uncore PMU is named by a type ID plus a box ID, e.g.,
uncore_type_0_0, because the real name of the uncore PMU cannot be
retrieved from the discovery table. With the platform-specific support
later, perf has the mapping information from a type ID to a specific
uncore unit. Just like the previous platforms, the uncore PMU will be
named by the real PMU name, e.g., uncore_cha_0. The user scripts which
work well with the old name may not work anymore. To avoid the issue, a
symlink should be created from the new to the old name.

The perf PMU devices are created under /sys/bus/event_source/devices/.
The symlink should be created in the same directory to facilitate the
perf tool.

Add a new variable, link_name, to store the new name of a PMU. Link it
to the old name if applies.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f..c8a3388 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -284,6 +284,7 @@ struct pmu {
 	const struct attribute_group	**attr_groups;
 	const struct attribute_group	**attr_update;
 	const char			*name;
+	const char			*link_name;
 	int				type;
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0cc8e5..b6024f6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10952,6 +10952,16 @@ static struct bus_type pmu_bus = {
 
 static void pmu_dev_release(struct device *dev)
 {
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (pmu && pmu->link_name) {
+		struct kset *devices_kset;
+
+		devices_kset = bus_get_devices_kset(pmu->dev->bus);
+		if (devices_kset)
+			sysfs_remove_link(&devices_kset->kobj, pmu->link_name);
+	}
+
 	kfree(dev);
 }
 
@@ -10989,6 +10999,15 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto del_dev;
 
+	if (pmu->link_name) {
+		struct kset *devices_kset;
+
+		devices_kset = bus_get_devices_kset(pmu->dev->bus);
+		if (devices_kset)
+			ret = sysfs_create_link(&devices_kset->kobj,
+						&pmu->dev->kobj,
+						pmu->link_name);
+	}
 out:
 	return ret;
 
-- 
2.7.4

