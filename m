Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7C352EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhDBRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:20606 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:27 -0400
IronPort-SDR: 6Yoaze5LMM58CJCjR/oit/pB7l6frsDqeiKaW00ecborq/JzoPGPN2IX6OlL/99W29/DiXoH4g
 avSzq3LUcjDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="256488268"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="256488268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:26 -0700
IronPort-SDR: fWfYtUytKxXSQ1fmtjw3x5xDFEYSgL3sLwMrp3fzttCidp5mF/Vry3S7M2coXKF8+CFaoCikE2
 gM4xh/nlmM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="596812986"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2021 10:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86BD134E; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 02/10] ipmi_si: Remove bogus err_free label
Date:   Fri,  2 Apr 2021 20:43:26 +0300
Message-Id: <20210402174334.13466-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more 'free' in the error path, so drop the label and
return errors inline.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 8f2fefc015b2..e5cd5006f0e5 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -316,7 +316,6 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	acpi_status status;
 	unsigned long long tmp;
 	struct resource *res;
-	int rv = -EINVAL;
 
 	if (!si_tryacpi)
 		return -ENODEV;
@@ -336,7 +335,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status)) {
 		dev_err(&pdev->dev,
 			"Could not find ACPI IPMI interface type\n");
-		goto err_free;
+		return -EINVAL;
 	}
 
 	switch (tmp) {
@@ -350,21 +349,18 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 		io.si_type = SI_BT;
 		break;
 	case 4: /* SSIF, just ignore */
-		rv = -ENODEV;
-		goto err_free;
+		return -ENODEV;
 	default:
 		dev_info(&pdev->dev, "unknown IPMI type %lld\n", tmp);
-		goto err_free;
+		return -EINVAL;
 	}
 
 	io.regsize = DEFAULT_REGSIZE;
 	io.regshift = 0;
 
 	res = ipmi_get_info_from_resources(pdev, &io);
-	if (!res) {
-		rv = -EINVAL;
-		goto err_free;
-	}
+	if (!res)
+		return -EINVAL;
 
 	/* If _GPE exists, use it; otherwise use standard interrupts */
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
@@ -390,9 +386,6 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	request_module("acpi_ipmi");
 
 	return ipmi_si_add_smi(&io);
-
-err_free:
-	return rv;
 }
 
 static const struct acpi_device_id acpi_ipmi_match[] = {
-- 
2.30.2

