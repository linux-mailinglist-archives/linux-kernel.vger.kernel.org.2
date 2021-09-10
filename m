Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36B84067C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhIJHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:38:08 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:25319 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhIJHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:38:07 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18A7GoO4001125;
        Fri, 10 Sep 2021 15:16:50 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from NealLiu-PC01.aspeedtech.com (192.168.2.78) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Sep 2021 15:36:23 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>,
        Tao Ren <rentao.bupt@gmail.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v4] usb: ehci: handshake CMD_RUN instead of STS_HALT
Date:   Fri, 10 Sep 2021 15:36:19 +0800
Message-ID: <20210910073619.26095-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.78]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18A7GoO4001125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Aspeed, HCHalted status depends on not only Run/Stop but also
ASS/PSS status.
Handshake CMD_RUN on startup instead.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
 drivers/usb/host/ehci-platform.c |  6 ++++++
 drivers/usb/host/ehci.h          |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

---
Fix STS_HALT handshake failure for Aspeed 2500/2600 platform.

Change since v3:
- Add more description.

Change since v2:
- Use my "real" name for both the Signed-off-by: line and the From: line.

Change since v1:
- Handshake CMD_RUN status on startup instead of easily skip it.
---

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6bdc6d6bf74d..55f92d25336b 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
 	/* Wait until HC become operational */
 	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
 	msleep(5);
-	rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1000);
+
+	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
+	 * Check CMD_RUN instead.
+	 */
+	if (ehci->is_aspeed)
+		rc = ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
+				    1, 100 * 1000);
+	else
+		rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
+				    0, 100 * 1000);
 
 	up_write(&ehci_cf_port_reset_rwsem);
 
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index c70f2d0b4aaf..c3dc906274d9 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -297,6 +297,12 @@ static int ehci_platform_probe(struct platform_device *dev)
 					  "has-transaction-translator"))
 			hcd->has_tt = 1;
 
+		if (of_device_is_compatible(dev->dev.of_node,
+					    "aspeed,ast2500-ehci") ||
+		    of_device_is_compatible(dev->dev.of_node,
+					    "aspeed,ast2600-ehci"))
+			ehci->is_aspeed = 1;
+
 		if (soc_device_match(quirk_poll_match))
 			priv->quirk_poll = true;
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 80bb823aa9fe..fdd073cc053b 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
 	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
 	unsigned		spurious_oc:1;
+	unsigned		is_aspeed:1;
 
 	/* required for usb32 quirk */
 	#define OHCI_CTRL_HCFS          (3 << 6)
-- 
2.25.1

