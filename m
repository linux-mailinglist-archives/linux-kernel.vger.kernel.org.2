Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8563A13CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhFIMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:12:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63417 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhFIMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1623240643; x=1654776643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Xk1ujB2kl+qiFwhxmEUDgjYRlHoyizFUOvEaQMLa0Q=;
  b=tXSUyw2cWH8jBLfG86cGT9FcEm253iJ7gc2pert7i7SM8n3gWc7zXVH/
   pL6EEZbs4s6Ulbrk1xGfB5ZbSnL/o/dgQwwPhSnGlzZri0NHepZJMsTJg
   Vx2jqIQIkOCOXmXm709g/LnuVuTYGKsu96VkiZ27rvIYqD5WOFe7YYNAU
   9yKi1U3oNKgomfmY4sTPdpnb3OLpWexxQNZqP92C0uHepkC4HSwU5N8/S
   jPwYQuGnakrBOYwOIl9HRwxJbXdPIy6zPiy2cCDRdTb5v7DF+E/ex4GBd
   vSBENC1hOFn3kBBt2C3BZ7BhQH5Yx3dyCDO7Ef2vIrtI9iS8g2fgPNdYd
   g==;
IronPort-SDR: 3KzQrg30tx/nO9bPITuPmyiWWqx6Ljl9T7xHt4v9Qgo9Hqwn2eOA1iX/acZsDFbKKUkbD8MRoW
 DZpuQ4UJCIVKPH7JK4ELc/XhBuS4yiyBdbqFv4c4DVY36sZu4NPlWxyx6m23Uy33zDwWvTg8v1
 pdwbtllNctVMs0K1X6EQZvLmi4C7mMkzeZXfUhuAB/KCGOutsgBvVnKvWM9MunReDEZPMhVdOL
 2ofz/IFDXqKbZzsZS+R3rb9ypyqOrJvVgdqjF0Ty2LyxKttm1sbF0NdtDRd/ZREmBFzOFM90MA
 xiE=
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="120688966"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2021 05:10:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 05:10:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 9 Jun 2021 05:10:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <cristian.birsan@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before OHCI accesses
Date:   Wed, 9 Jun 2021 15:10:27 +0300
Message-ID: <20210609121027.70951-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 suspending ports will cut the access to OHCI registers and
any subsequent access to them will lead to CPU being blocked trying to
access that memory. Same thing happens on resume: if OHCI memory is
accessed before resuming ports the CPU will block on that access. The
OCHI memory is accessed on suspend/resume though
ohci_suspend()/ohci_resume().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

The patch was tested on SAMA7G5, SAMA5D2 and SAM9X60.

Thank you,
Claudiu Beznea

 drivers/usb/host/ohci-at91.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index b3a6a497dcb1..7c6202b05ff4 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -666,8 +666,6 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	if (ohci_at91->wakeup)
 		enable_irq_wake(hcd->irq);
 
-	ohci_at91_port_suspend(ohci_at91, 1);
-
 	ret = ohci_suspend(hcd, ohci_at91->wakeup);
 	if (ret) {
 		if (ohci_at91->wakeup)
@@ -687,7 +685,10 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
 		msleep(1);
+		ohci_at91_port_suspend(ohci_at91, 1);
 		at91_stop_clock(ohci_at91);
+	} else {
+		ohci_at91_port_suspend(ohci_at91, 1);
 	}
 
 	return ret;
@@ -699,6 +700,8 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
+	ohci_at91_port_suspend(ohci_at91, 0);
+
 	if (ohci_at91->wakeup)
 		disable_irq_wake(hcd->irq);
 	else
@@ -706,8 +709,6 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	ohci_resume(hcd, false);
 
-	ohci_at91_port_suspend(ohci_at91, 0);
-
 	return 0;
 }
 
-- 
2.25.1

