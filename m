Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CA34F0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhC3SRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:41754 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhC3SQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:54 -0400
IronPort-SDR: Jo9YF01DisfE8TqfMGHSY5I6wTVS24xMdSNOMnHHxlEqFkLzY0cDW6rJQEgaBiwpxZmqkXq/is
 LcuCzmg7rynQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="188566238"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="188566238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:53 -0700
IronPort-SDR: AtZFsGZV+z3V5Mjxt/3UBqH8C3TGIwXONIAyr3PiF1Joqi9HQgPiop4yYF2LvDEVelOVNn9yjz
 Z2OLtu+erZ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="376935106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2021 11:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D3B0199; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 03/10] ipmi_si: Utilize temporary variable to hold device pointer
Date:   Tue, 30 Mar 2021 21:16:42 +0300
Message-Id: <20210330181649.66496-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By one of the previous clean up change we got a temporary variable to hold
a device pointer. It can be utilized in other calls in the ->probe() and
save a bit of LOCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 009563073d30..954c297b459b 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -309,6 +309,7 @@ static int find_slave_address(struct si_sm_io *io, int slave_addr)
 
 static int acpi_ipmi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct si_sm_io io;
 	acpi_handle handle;
 	acpi_status status;
@@ -318,21 +319,20 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	if (!si_tryacpi)
 		return -ENODEV;
 
-	handle = ACPI_HANDLE(&pdev->dev);
+	handle = ACPI_HANDLE(dev);
 	if (!handle)
 		return -ENODEV;
 
 	memset(&io, 0, sizeof(io));
 	io.addr_source = SI_ACPI;
-	dev_info(&pdev->dev, "probing via ACPI\n");
+	dev_info(dev, "probing via ACPI\n");
 
 	io.addr_info.acpi_info.acpi_handle = handle;
 
 	/* _IFT tells us the interface type: KCS, BT, etc */
 	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&pdev->dev,
-			"Could not find ACPI IPMI interface type\n");
+		dev_err(dev, "Could not find ACPI IPMI interface type\n");
 		return -EINVAL;
 	}
 
@@ -349,10 +349,11 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	case 4: /* SSIF, just ignore */
 		return -ENODEV;
 	default:
-		dev_info(&pdev->dev, "unknown IPMI type %lld\n", tmp);
+		dev_info(dev, "unknown IPMI type %lld\n", tmp);
 		return -EINVAL;
 	}
 
+	io.dev = dev;
 	io.regsize = DEFAULT_REGSIZE;
 	io.regshift = 0;
 
@@ -376,9 +377,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 
 	io.slave_addr = find_slave_address(&io, io.slave_addr);
 
-	io.dev = &pdev->dev;
-
-	dev_info(io.dev, "%pR regsize %d spacing %d irq %d\n",
+	dev_info(dev, "%pR regsize %d spacing %d irq %d\n",
 		 res, io.regsize, io.regspacing, io.irq);
 
 	request_module("acpi_ipmi");
-- 
2.30.2

