Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376A32A7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579137AbhCBQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:44894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572964AbhCBOIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:11 -0500
IronPort-SDR: JCOriTqhmGKnOVL0jQVhndI2abA15pRi7AZI4upZD3VUr4nsGlSI/i4kkbAujHSVK/7oIlT6kf
 XprIOS0TcmJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186875217"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186875217"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:56:28 -0800
IronPort-SDR: Q2ZY2kVnXUvFNuxZ7PPIS4LFb0xzEqZIQwIPijJ6pPw/wXtWGuKqdNHERs+9huzTC+0dqKSvEP
 CLaw4fjunQsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595799610"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2021 05:56:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A52BAF4; Tue,  2 Mar 2021 15:56:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify static struct resources"
Date:   Tue,  2 Mar 2021 15:56:16 +0200
Message-Id: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structures are used as place holders, so they are modified at run-time.
Obviously they may not be constants.

  BUG: unable to handle page fault for address: d0643220
  ...
  CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
  Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
  EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]

This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.

While at it, add a comment to avoid similar changes in the future.

Fixes: c4a164f41554 ("mfd: Constify static struct resources")
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 55a9e017edee..124c0ee84169 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -72,7 +72,8 @@ static const struct dmi_system_id dmi_platform_info[] = {
 	{}
 };
 
-static const struct resource intel_quark_i2c_res[] = {
+/* This is used as a place holder and will be modified at run-time */
+static struct resource intel_quark_i2c_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
@@ -85,7 +86,8 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
 	.adr = MFD_ACPI_MATCH_I2C,
 };
 
-static const struct resource intel_quark_gpio_res[] = {
+/* This is used as a place holder and will be modified at run-time */
+static struct resource intel_quark_gpio_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
-- 
2.30.1

