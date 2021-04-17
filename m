Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C67362D23
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhDQDN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:44212 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: YTVMccnwC8D4cEyn/9AZJsXNjst0QEYoOnT43PfmmNZVnIhReqD606K8rQd8SwXVniG2WJosBM
 0+uzhVkydx7A==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="215694722"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="215694722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:50 -0700
IronPort-SDR: YmIZy2C4B1U9th5a+XdnVfVPY8rqGDbb/4K7YEBxxpa3tSZ/bfRyx8AjvVciRiWLjG7iL8/LtU
 yh1MolyND0jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="425815899"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2021 20:12:50 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id EBB6A580890;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/9] platform/x86: intel_pmc_core: Add LTR registers for Tiger Lake
Date:   Fri, 16 Apr 2021 20:12:51 -0700
Message-Id: <20210417031252.3020837-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Just like Ice Lake, Tiger Lake uses Cannon Lake's LTR information
and supports a few additional registers. Hence add the LTR registers
specific to Tiger Lake to the cnp_ltr_show_map[].

Also adjust the number of LTR IPs for Tiger Lake to the correct amount.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
---

V2:	No change

 drivers/platform/x86/intel_pmc_core.c | 2 ++
 drivers/platform/x86/intel_pmc_core.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 97cf3384c4c0..786b67171ddc 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -383,6 +383,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 	 * a list of core SoCs using this.
 	 */
 	{"WIGIG",		ICL_PMC_LTR_WIGIG},
+	{"THC0",                TGL_PMC_LTR_THC0},
+	{"THC1",                TGL_PMC_LTR_THC1},
 	/* Below two cannot be used for LTR_IGNORE */
 	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
 	{"AGGREGATED_SYSTEM",	CNP_PMC_LTR_CUR_ASLT},
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index c45805671c4a..e8dae9c6c45f 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -191,8 +191,10 @@ enum ppfear_regs {
 #define GET_X2_COUNTER(v)			((v) >> 1)
 #define LPM_STS_LATCH_MODE			BIT(31)
 
-#define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
+#define TGL_PMC_LTR_THC0			0x1C04
+#define TGL_PMC_LTR_THC1			0x1C08
+#define TGL_NUM_IP_IGN_ALLOWED			23
 #define TGL_PMC_LPM_RES_COUNTER_STEP_X2		61	/* 30.5us * 2 */
 
 /*
-- 
2.25.1

