Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEA352EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhDBRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:31706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234984AbhDBRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:27 -0400
IronPort-SDR: qqVslmzHweRySFjdpSlHsrzPiJ9ANzisoVEmafUAnRapRsg/WzFiD/fofEfwARswxu6Bwm06GD
 nujdfawm6RWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192613590"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192613590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:26 -0700
IronPort-SDR: 89XLoFq7u8idQk/vL2e+LxN8QOClgTxDC4cPVNCF9iT3HOKWCPtcN9s2PYXveV/ILOhzRRmgVw
 PO9PUNSRpYnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="517843208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2021 10:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 908212E4; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 03/10] ipmi_si: Utilize temporary variable to hold device pointer
Date:   Fri,  2 Apr 2021 20:43:27 +0300
Message-Id: <20210402174334.13466-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a temporary variable to hold a device pointer.
It can be utilized in the ->probe() and save a bit of LOCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index e5cd5006f0e5..5f641d316ecb 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -311,6 +311,7 @@ static int find_slave_address(struct si_sm_io *io, int slave_addr)
 
 static int acpi_ipmi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct si_sm_io io;
 	acpi_handle handle;
 	acpi_status status;
@@ -320,21 +321,20 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
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
 
@@ -351,10 +351,11 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
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
 
@@ -378,9 +379,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 
 	io.slave_addr = find_slave_address(&io, io.slave_addr);
 
-	io.dev = &pdev->dev;
-
-	dev_info(io.dev, "%pR regsize %d spacing %d irq %d\n",
+	dev_info(dev, "%pR regsize %d spacing %d irq %d\n",
 		 res, io.regsize, io.regspacing, io.irq);
 
 	request_module("acpi_ipmi");
-- 
2.30.2

