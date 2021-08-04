Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41A73E0348
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhHDOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:32:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:14739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238820AbhHDOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:30:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="235883635"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="235883635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 07:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="636996840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2021 07:29:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C0484142; Wed,  4 Aug 2021 17:30:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/2] platform/surface: aggregator: Use serdev_acpi_get_uart_resource() helper
Date:   Wed,  4 Aug 2021 17:29:59 +0300
Message-Id: <20210804142959.67981-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804142959.67981-1-andriy.shevchenko@linux.intel.com>
References: <20210804142959.67981-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serdev provides a generic helper to get UART Serial Bus resources.
Use it instead of an open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
---
v2: added Rb tag (Maximilian)
 drivers/platform/surface/aggregator/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 279d9df19c01..c61bbeeec2df 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -301,20 +301,13 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
 						  void *ctx)
 {
 	struct serdev_device *serdev = ctx;
-	struct acpi_resource_common_serialbus *serial;
 	struct acpi_resource_uart_serialbus *uart;
 	bool flow_control;
 	int status = 0;
 
-	if (rsc->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+	if (!serdev_acpi_get_uart_resource(rsc, &uart))
 		return AE_OK;
 
-	serial = &rsc->data.common_serial_bus;
-	if (serial->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
-		return AE_OK;
-
-	uart = &rsc->data.uart_serial_bus;
-
 	/* Set up serdev device. */
 	serdev_device_set_baudrate(serdev, uart->default_baud_rate);
 
-- 
2.30.2

