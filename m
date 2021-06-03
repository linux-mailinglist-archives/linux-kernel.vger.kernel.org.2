Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6276039A63C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFCQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:52:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:51088 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFCQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:52:58 -0400
IronPort-SDR: FP8/IeF4W2QbkxtdY9lfbu15QBrNsBkbXApBX/h75lrv797QKZQ+6eRfb4hWZY0NFmcOPPWeaa
 mJ0WncRYn8aA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="203902845"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="203902845"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 09:51:10 -0700
IronPort-SDR: CjEgiKaKQl05KKifFCuIPD1z4v5Kgpnm/0eBOCXaWASGlOdDIxlsK6UO356OUjh/qQ10jjKNj8
 fR3bJrner2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="480294004"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2021 09:51:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 406E1269; Thu,  3 Jun 2021 19:51:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Cannon Lake ACPI IDs
Date:   Thu,  3 Jun 2021 19:51:28 +0300
Message-Id: <20210603165128.46586-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the machines, like Dell Precision 3630,
may expose LPSS devices via ACPI.

Add their IDs to the list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 1f396039d58f..3f1d976eb67c 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -89,6 +89,11 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 	.swnode = &apl_i2c_node,
 };
 
+static const struct intel_lpss_platform_info cnl_i2c_info = {
+	.clk_rate = 216000000,
+	.swnode = &spt_i2c_node,
+};
+
 static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	/* SPT */
 	{ "INT3440", (kernel_ulong_t)&spt_info },
@@ -102,6 +107,19 @@ static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	{ "INT3448", (kernel_ulong_t)&spt_uart_info },
 	{ "INT3449", (kernel_ulong_t)&spt_uart_info },
 	{ "INT344A", (kernel_ulong_t)&spt_uart_info },
+	/* CNL */
+	{ "INT34B0", (kernel_ulong_t)&spt_info },
+	{ "INT34B1", (kernel_ulong_t)&spt_info },
+	{ "INT34B2", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B3", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B4", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B5", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B6", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B7", (kernel_ulong_t)&cnl_i2c_info },
+	{ "INT34B8", (kernel_ulong_t)&spt_uart_info },
+	{ "INT34B9", (kernel_ulong_t)&spt_uart_info },
+	{ "INT34BA", (kernel_ulong_t)&spt_uart_info },
+	{ "INT34BC", (kernel_ulong_t)&spt_info },
 	/* BXT */
 	{ "80860AAC", (kernel_ulong_t)&bxt_i2c_info },
 	{ "80860ABC", (kernel_ulong_t)&bxt_info },
-- 
2.30.2

