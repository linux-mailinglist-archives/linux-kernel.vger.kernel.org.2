Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193943E2E07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbhHFP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:56:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:5382 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244860AbhHFP4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:56:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="278139335"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="278139335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="523545116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2021 08:56:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EBA69DE; Fri,  6 Aug 2021 18:50:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86/intel: pmt: Use y instead of objs in Makefile
Date:   Fri,  6 Aug 2021 18:50:17 +0300
Message-Id: <20210806155017.4633-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'objs' is for user space tools, for the kernel modules
we should use 'y'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Hans, feel free to fold in the original commit

 drivers/platform/x86/intel/pmt/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/Makefile b/drivers/platform/x86/intel/pmt/Makefile
index 019103ee6522..279e158c7c23 100644
--- a/drivers/platform/x86/intel/pmt/Makefile
+++ b/drivers/platform/x86/intel/pmt/Makefile
@@ -4,9 +4,9 @@
 # Intel Platform Monitoring Technology Drivers
 #
 
-pmt_class-objs				+= class.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt_class.o
-pmt_telemetry-objs			+= telemetry.o
+pmt_class-y				:= class.o
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= pmt_telemetry.o
-pmt_crashlog-objs			+= crashlog.o
+pmt_telemetry-y				:= telemetry.o
 obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= pmt_crashlog.o
+pmt_crashlog-y				:= crashlog.o
-- 
2.30.2

