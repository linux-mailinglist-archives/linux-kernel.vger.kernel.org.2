Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5C33E718
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhCQCqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:46:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:26359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhCQCp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:45:28 -0400
IronPort-SDR: jPraQM7cBHKxzm9X00F9HiyR9zuvx92M2jS/3Jj2esA8FjYEELctMTaHqVNOGwWI0Tj0SJ7Cwh
 J0iCEMQLcjDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176508002"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="176508002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:45:27 -0700
IronPort-SDR: Zh0sV5Ub02iIIiGOQZh1OemzaPBt6dffjNB2cX0RzHDWLy/WEWW4xZck6Y+2xL27U3dsIyenxS
 iDn+DznQtmPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="439306015"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2021 19:45:26 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 6969E580812;
        Tue, 16 Mar 2021 19:45:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform_x86: intel_pmt_crashlog: Fix incorrect macros
Date:   Tue, 16 Mar 2021 19:44:55 -0700
Message-Id: <20210317024455.3071477-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317024455.3071477-1-david.e.box@linux.intel.com>
References: <20210317024455.3071477-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes off-by-one bugs in the macro assignments for the crashlog control
bits. Was initially tested on emulation but bug revealed after testing on
silicon.

Fixes: 5ef9998c96b0 ("platform/x86: Intel PMT Crashlog capability driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmt_crashlog.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel_pmt_crashlog.c
index 97dd749c8290..92d315a16cfd 100644
--- a/drivers/platform/x86/intel_pmt_crashlog.c
+++ b/drivers/platform/x86/intel_pmt_crashlog.c
@@ -23,18 +23,17 @@
 #define CRASH_TYPE_OOBMSM	1
 
 /* Control Flags */
-#define CRASHLOG_FLAG_DISABLE		BIT(27)
+#define CRASHLOG_FLAG_DISABLE		BIT(28)
 
 /*
- * Bits 28 and 29 control the state of bit 31.
+ * Bits 29 and 30 control the state of bit 31.
  *
- * Bit 28 will clear bit 31, if set, allowing a new crashlog to be captured.
- * Bit 29 will immediately trigger a crashlog to be generated, setting bit 31.
- * Bit 30 is read-only and reserved as 0.
+ * Bit 29 will clear bit 31, if set, allowing a new crashlog to be captured.
+ * Bit 30 will immediately trigger a crashlog to be generated, setting bit 31.
  * Bit 31 is the read-only status with a 1 indicating log is complete.
  */
-#define CRASHLOG_FLAG_TRIGGER_CLEAR	BIT(28)
-#define CRASHLOG_FLAG_TRIGGER_EXECUTE	BIT(29)
+#define CRASHLOG_FLAG_TRIGGER_CLEAR	BIT(29)
+#define CRASHLOG_FLAG_TRIGGER_EXECUTE	BIT(30)
 #define CRASHLOG_FLAG_TRIGGER_COMPLETE	BIT(31)
 #define CRASHLOG_FLAG_TRIGGER_MASK	GENMASK(31, 28)
 
-- 
2.25.1

