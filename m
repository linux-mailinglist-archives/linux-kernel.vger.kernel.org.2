Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3C40B654
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhINR6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:58:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:8655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhINR6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:58:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="220210790"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220210790"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 10:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="472100839"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2021 10:56:52 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.c, ak@linux.intel.comom,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 3/3] Fix IIO event constraints for Snowridge
Date:   Tue, 14 Sep 2021 20:56:46 +0300
Message-Id: <20210914175646.35437-4-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210914175646.35437-1-alexander.antonov@linux.intel.com>
References: <20210914175646.35437-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

According to the latest uncore document, DATA_REQ_OF_CPU (0x83),
DATA_REQ_BY_CPU (0xc0) and COMP_BUF_OCCUPANCY (0xd5) events have
constraints. Add uncore IIO constraints for Snowridge.

Fixes: 210cc5f9db7a ("perf/x86/intel/uncore: Add uncore support for Snow Ridge server")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4aa675a8a8eb..2143be4b8e7a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4528,6 +4528,13 @@ static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
 	pmu_iio_cleanup_mapping(type, &snr_iio_mapping_group);
 }
 
+static struct event_constraint snr_uncore_iio_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type snr_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -4539,6 +4546,7 @@ static struct intel_uncore_type snr_uncore_iio = {
 	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.box_ctl		= SNR_IIO_MSR_PMON_BOX_CTL,
 	.msr_offset		= SNR_IIO_MSR_OFFSET,
+	.constraints		= snr_uncore_iio_constraints,
 	.ops			= &ivbep_uncore_msr_ops,
 	.format_group		= &snr_uncore_iio_format_group,
 	.attr_update		= snr_iio_attr_update,
-- 
2.21.3

