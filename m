Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF605422A38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhJEOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:39284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235697AbhJEOIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="289254680"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="289254680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 06:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714385753"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 06:45:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 158D81C8; Tue,  5 Oct 2021 16:45:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/2] serial: 8250_dw: Re-use temporary variable for of_node
Date:   Tue,  5 Oct 2021 16:45:28 +0300
Message-Id: <20211005134529.23256-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In couple of places we may re-use temporary variable instead of
dereferencing it. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index cf87022e73e4..792389acf9f6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -389,8 +389,9 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
-	if (p->dev->of_node) {
-		struct device_node *np = p->dev->of_node;
+	struct device_node *np = p->dev->of_node;
+
+	if (np) {
 		int id;
 
 		/* get index of serial line, if found in DT aliases */
@@ -407,11 +408,13 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			data->skip_autocfg = true;
 		}
 #endif
-		if (of_device_is_big_endian(p->dev->of_node)) {
+
+		if (of_device_is_big_endian(np)) {
 			p->iotype = UPIO_MEM32BE;
 			p->serial_in = dw8250_serial_in32be;
 			p->serial_out = dw8250_serial_out32be;
 		}
+
 		if (of_device_is_compatible(np, "marvell,armada-38x-uart"))
 			p->serial_out = dw8250_serial_out38x;
 
-- 
2.33.0

