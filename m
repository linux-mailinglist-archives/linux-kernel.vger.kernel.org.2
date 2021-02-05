Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555DF310F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhBEQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:14:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:14366 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBEQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:12:09 -0500
IronPort-SDR: r4A52dysCmuKpqciXo0kzM3eae7+hCnMIi5EKaxdnTeqkcaMQTnAtrByRP6KCv+RRx0/u8eQij
 +xo3cMbesZDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180690062"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180690062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:53:51 -0800
IronPort-SDR: y6W/rgQOPCKraLevadSjJyFNlAqAOSw+ZVhY4CWGRQ5X9d/qU/UDEqqul4GPSs4Dxi8InNfHrI
 sCLfkf7w5ucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583856320"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 09:53:49 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf intel-pt: Fix missing CYC processing in PSB
Date:   Fri,  5 Feb 2021 19:53:47 +0200
Message-Id: <20210205175350.23817-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205175350.23817-1-adrian.hunter@intel.com>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CYC packet processing when walking through PSB+. This
improves the accuracy of timestamps that follow PSB+, until the next
MTC.

Fixes: 3d49807870f08 ("perf tools: Add new Intel PT packet definitions")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 697513f35154..91cba0582736 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1761,6 +1761,9 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_CYC:
+			intel_pt_calc_cyc_timestamp(decoder);
+			break;
+
 		case INTEL_PT_VMCS:
 		case INTEL_PT_MNT:
 		case INTEL_PT_PAD:
-- 
2.17.1

