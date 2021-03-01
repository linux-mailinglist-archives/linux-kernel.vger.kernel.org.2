Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301C9328128
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhCAOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:44:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:38252 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbhCAOoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:44:32 -0500
IronPort-SDR: UTkTT2kFZIZyy3UnFlACNJK5bEr95Tn2SlKLiGuwFEVZ1o0FW+2Kwt6mIXvzltCSSKSu/z/Wer
 0Z++pGEpoAzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166359607"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="166359607"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:42:45 -0800
IronPort-SDR: D8lrfKHkmSzWlsrEigytLh4RTe7+02MaSSDjlwkg3k9W04LkjxYRa8x6Oof1SHftPTpEexoYpd
 GAOxHwJwQaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="599335461"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2021 06:42:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C264AF4; Mon,  1 Mar 2021 16:42:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] mfd: intel-lpss: Constify device property structures
Date:   Mon,  1 Mar 2021 16:42:20 +0200
Message-Id: <20210301144222.31290-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to have non-constant device properties in this driver.
Thus, constify them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c |  8 ++++----
 drivers/mfd/intel-lpss-pci.c  | 10 +++++-----
 drivers/mfd/intel-lpss.h      |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index c8fe334b5fe8..14a9cd83d4ef 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -22,7 +22,7 @@ static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
 };
 
-static struct property_entry spt_i2c_properties[] = {
+static const struct property_entry spt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
 	{ },
 };
@@ -32,7 +32,7 @@ static const struct intel_lpss_platform_info spt_i2c_info = {
 	.properties = spt_i2c_properties,
 };
 
-static struct property_entry uart_properties[] = {
+static const struct property_entry uart_properties[] = {
 	PROPERTY_ENTRY_U32("reg-io-width", 4),
 	PROPERTY_ENTRY_U32("reg-shift", 2),
 	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
@@ -49,7 +49,7 @@ static const struct intel_lpss_platform_info bxt_info = {
 	.clk_rate = 100000000,
 };
 
-static struct property_entry bxt_i2c_properties[] = {
+static const struct property_entry bxt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
@@ -61,7 +61,7 @@ static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.properties = bxt_i2c_properties,
 };
 
-static struct property_entry apl_i2c_properties[] = {
+static const struct property_entry apl_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 207),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1522c8afc540..7837f77d70d0 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -65,7 +65,7 @@ static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
 };
 
-static struct property_entry spt_i2c_properties[] = {
+static const struct property_entry spt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
 	{ },
 };
@@ -75,7 +75,7 @@ static const struct intel_lpss_platform_info spt_i2c_info = {
 	.properties = spt_i2c_properties,
 };
 
-static struct property_entry uart_properties[] = {
+static const struct property_entry uart_properties[] = {
 	PROPERTY_ENTRY_U32("reg-io-width", 4),
 	PROPERTY_ENTRY_U32("reg-shift", 2),
 	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
@@ -98,7 +98,7 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
 	.properties = uart_properties,
 };
 
-static struct property_entry bxt_i2c_properties[] = {
+static const struct property_entry bxt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
@@ -110,7 +110,7 @@ static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.properties = bxt_i2c_properties,
 };
 
-static struct property_entry apl_i2c_properties[] = {
+static const struct property_entry apl_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 207),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
@@ -122,7 +122,7 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 	.properties = apl_i2c_properties,
 };
 
-static struct property_entry glk_i2c_properties[] = {
+static const struct property_entry glk_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 313),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 290),
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 4ae58a86bb42..a2fbaed061ba 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -22,7 +22,7 @@ struct intel_lpss_platform_info {
 	int irq;
 	unsigned long clk_rate;
 	const char *clk_con_id;
-	struct property_entry *properties;
+	const struct property_entry *properties;
 };
 
 int intel_lpss_probe(struct device *dev,
-- 
2.30.1

