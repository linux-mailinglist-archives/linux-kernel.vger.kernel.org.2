Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DD313D05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhBHSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:16:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:62781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhBHPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:01 -0500
IronPort-SDR: J4pjKMrqfc4iG0v4bERqSnc5BWH+af0pjTAyS739tzL8moR2wyv7WMcArGz+BiWWWDyW6Mu2Ti
 DKc9VCmAacsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952010"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952010"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:30 -0800
IronPort-SDR: Xd+rzhnuc+ItfFw2MpeKozFjkm7sCjKxt+L6SbuW2jlwilEmM3emCLKfky4nYPRKeDIsSt1xBM
 8dJumHG8IWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820816"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:30 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 23/49] perf/x86/msr: Add Alder Lake CPU support
Date:   Mon,  8 Feb 2021 07:25:20 -0800
Message-Id: <1612797946-18784-24-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

PPERF and SMI_COUNT MSRs are also supported on Alder Lake.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 680404c..c853b28 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -100,6 +100,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
 	case INTEL_FAM6_ROCKETLAKE:
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.7.4

