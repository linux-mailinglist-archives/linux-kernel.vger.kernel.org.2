Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2C34F0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhC3SRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:9467 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232455AbhC3SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:55 -0400
IronPort-SDR: B+ADsE4VTB/Ty12EueoKfo+fF8wYvLndiJdtvHt2+pIYHeoRYSdSSGI2ptbvmSRCoinxmGLF/y
 aBcAvJgGHDGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="212049422"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="212049422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:53 -0700
IronPort-SDR: kz2IuKPH3CCBrBalibVA7/OaMYQpFS1/mf4HCFw/ARlheGrQ8SGdOuHIcFgLRdt9ZLeTpyMj1W
 n9oP0zuCFVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="411753270"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2021 11:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D629269; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 04/10] ipmi_si: Use proper ACPI macros to check error code for failures
Date:   Tue, 30 Mar 2021 21:16:43 +0300
Message-Id: <20210330181649.66496-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of direct comparison, use proper ACPI macros to check error code
for failures.

While at it, drop unneeded 'else' keyword.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 954c297b459b..023c88ea9c4c 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -85,18 +85,18 @@ static int acpi_gpe_irq_setup(struct si_sm_io *io)
 					  ACPI_GPE_LEVEL_TRIGGERED,
 					  &ipmi_acpi_gpe,
 					  io);
-	if (status != AE_OK) {
+	if (ACPI_FAILURE(status)) {
 		dev_warn(io->dev,
 			 "Unable to claim ACPI GPE %d, running polled\n",
 			 io->irq);
 		io->irq = 0;
 		return -EINVAL;
-	} else {
-		io->irq_cleanup = acpi_gpe_irq_cleanup;
-		ipmi_irq_finish_setup(io);
-		dev_info(io->dev, "Using ACPI GPE %d\n", io->irq);
-		return 0;
 	}
+
+	io->irq_cleanup = acpi_gpe_irq_cleanup;
+	ipmi_irq_finish_setup(io);
+	dev_info(io->dev, "Using ACPI GPE %d\n", io->irq);
+	return 0;
 }
 #endif
 
-- 
2.30.2

