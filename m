Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20745496A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhKQPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:01:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:42383 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236167AbhKQPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:01:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233793433"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="233793433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="494940897"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2021 06:58:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91EA8557; Wed, 17 Nov 2021 16:58:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/2] serial: 8250_pericom: Re-enable higher baud rates
Date:   Wed, 17 Nov 2021 16:57:50 +0200
Message-Id: <20211117145750.43911-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Add UPF_MAGIC_MULTIPLIER to the port flags since there is now
range checking in serial8250_get_baud_rate() in 8250_port.c.

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pericom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index 322c3b743a38..e1b6a64da5c9 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -119,7 +119,7 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	uart.port.private_data = pericom;
 	uart.port.iotype = UPIO_MEM;
 	uart.port.uartclk = PERICOM8250_DEFAUL_BAUD_RATE * 16;
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_MAGIC_MULTIPLIER;
 	uart.port.set_divisor = pericom_do_set_divisor;
 	for (i = 0; i < nr && i < maxnr; i++) {
 		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
-- 
2.33.0

