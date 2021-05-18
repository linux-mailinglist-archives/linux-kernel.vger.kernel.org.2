Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D713387745
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348775AbhERLSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:18:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbhERLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:18:08 -0400
Received: from 1-171-221-38.dynamic-ip.hinet.net ([1.171.221.38] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lixiR-0005s4-P5; Tue, 18 May 2021 11:16:48 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: State explicitly when the controller is inaccessible
Date:   Tue, 18 May 2021 19:16:40 +0800
Message-Id: <20210518111640.243559-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the dmesg says "Controller not ready at resume" because CNR is
flagged. But what actually happens is that the whole USBSTS becomes
inaccessible, and the reason could be disabled PCI I/O space or faulty
firmware/hardware.

So state the reason explicitly to make the message more clear.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca9385d22f68..0e6fbe1f4fcc 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1117,8 +1117,9 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		retval = xhci_handshake(&xhci->op_regs->status,
 					STS_CNR, 0, 10 * 1000 * 1000);
 		if (retval) {
-			xhci_warn(xhci, "Controller not ready at resume %d\n",
-				  retval);
+			xhci_warn(xhci, "Controller is %s at resume %d\n",
+				  retval == -ENODEV ? "inaccessible" :
+				  "not ready", retval);
 			spin_unlock_irq(&xhci->lock);
 			return retval;
 		}
-- 
2.31.1

