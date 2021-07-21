Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D03D1416
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhGUPow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:44:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:26287 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhGUPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:44:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="233274550"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="233274550"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 09:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="564789777"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2021 09:24:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E303FF; Wed, 21 Jul 2021 19:24:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_lpss: Enable DMA on Intel Elkhart Lake
Date:   Wed, 21 Jul 2021 19:24:52 +0300
Message-Id: <20210721162452.48764-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSE UARTs on Intel Elkhart Lake support DMA mode.
Enable DMA on these ports.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 4dee8a9e0c95..848d81e3838c 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -158,6 +158,16 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
+	struct uart_8250_dma *dma = &lpss->data.dma;
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	/*
+	 * This simply makes the checks in the 8250_port to try the DMA
+	 * channel request which in turn uses the magic of ACPI tables
+	 * parsing (see drivers/dma/acpi-dma.c for the details) and
+	 * matching with the registered General Purpose DMA controllers.
+	 */
+	up->dma = dma;
 	return 0;
 }
 
-- 
2.30.2

