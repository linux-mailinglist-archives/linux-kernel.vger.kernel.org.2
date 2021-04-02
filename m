Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03495352E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDBRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:8786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:27 -0400
IronPort-SDR: XlfCDN0YvjZWlaVQ5AwtiwzZcSesnyZzwCDnUe8xPaIG53uMQpFvRhiLyFSJTK1+Cs8QOLzGy2
 /jxzIzYh5ibQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="189251476"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="189251476"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:25 -0700
IronPort-SDR: LodzqoQ0ebiztRTWnb3q2rnBVgcASDIphZTGWzwVFzd9G4zQjjl/dTB9PvxRUrbfMTkce1MHpU
 50wCXZUYHnvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="385294384"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2021 10:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9EEA63F1; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 04/10] ipmi_si: Use proper ACPI macros to check error code for failures
Date:   Fri,  2 Apr 2021 20:43:28 +0300
Message-Id: <20210402174334.13466-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
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
index 5f641d316ecb..b87bd9933724 100644
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

