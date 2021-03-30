Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA37934F0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhC3SQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:16:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:31057 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhC3SQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:53 -0400
IronPort-SDR: 0eB7Sp1VrmuzaWQH4+vP2RNGZyGKmyTIOc47N9UuTUVkOoSMz3l1XrSjGoNtoSOmpLBc95CP90
 o7h/7c/8lZPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191302390"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191302390"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:52 -0700
IronPort-SDR: BhNwHlGYtgaOuEpW5zUSCwe75lTAG7QKxPZogZorg/cZZ27ARlQ4U0EAOci3yMIhM9Yh5pdzOM
 wQLq5l/SAjGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="610195633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2021 11:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 22E4ED7; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 02/10] ipmi_si: Remove bogus err_free label
Date:   Tue, 30 Mar 2021 21:16:41 +0300
Message-Id: <20210330181649.66496-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
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
index d7bd093f80e9..009563073d30 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -314,7 +314,6 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	acpi_status status;
 	unsigned long long tmp;
 	struct resource *res;
-	int rv = -EINVAL;
 
 	if (!si_tryacpi)
 		return -ENODEV;
@@ -334,7 +333,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status)) {
 		dev_err(&pdev->dev,
 			"Could not find ACPI IPMI interface type\n");
-		goto err_free;
+		return -EINVAL;
 	}
 
 	switch (tmp) {
@@ -348,21 +347,18 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
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
@@ -388,9 +384,6 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 	request_module("acpi_ipmi");
 
 	return ipmi_si_add_smi(&io);
-
-err_free:
-	return rv;
 }
 
 static const struct acpi_device_id acpi_ipmi_match[] = {
-- 
2.30.2

