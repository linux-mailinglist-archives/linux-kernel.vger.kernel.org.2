Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0CF45ED46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377177AbhKZMC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:02:58 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:37260
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346217AbhKZMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:00:57 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0D4683F1C0;
        Fri, 26 Nov 2021 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637927862;
        bh=eV+QmyQswD4I2BWptekGk432GeDddqsdJec6l2n5sQw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=LE2OtPLbKlcRrlT437XxQVG215Tract7e+8qbkDPxrZscZJtSKTR78HTm1qZ0Nkl6
         sRr7cnAHOLYJ6AOKQYZH3ZK1D4D0hD2xnZX25zG/kZyUOUl0hRMo9G3Ey1pdR6E1vJ
         NW5Eps1AD9AxU1AMIQqg9STN3uFzvwHNMp4JcyFooI8+pdgd0wMygl30w3JzCnhyOK
         MCn2mPcojTovdO1FtOLsI5LQ4ba6mmBuijYpLb0/cTsCZUSuuBEN3yRpBSUZNQqdHD
         JpcAkZsKR1U1sxUxBydfIHuuaC13sT8CYQ3eaLenGt7FiaKJQ4H7r1/J55IdVvDNzs
         3fL/MxQd7jCiQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
Date:   Fri, 26 Nov 2021 19:56:51 +0800
Message-Id: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unplugging USB device may cause an incorrect warm reset loop:
[  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
[  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
[  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
[  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
[  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
[  143.039096] usb usb2-port3: link state change
[  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
[  143.039101] usb usb2-port3: do warm reset
[  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
[  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
[  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
[  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
[  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
[  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
[  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms

The warm reset is due to its PLS is in eSS.Inactive state. However, USB
3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
condition (disconnect event or other fault condition)", xHCI 1.2 spec
table 5-27 also states that "This flag shall automatically be cleared to
‘0’ by a disconnect event or other fault condition." on PED.

So use CSC = 0 and PED = 0 as indication that device is disconnecting to
avoid doing warm reset.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Change the variable type to bool.

 drivers/usb/core/hub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a9a04ea967019..4f081df70ecf2 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5564,6 +5564,7 @@ static void port_event(struct usb_hub *hub, int port1)
 		__must_hold(&port_dev->status_lock)
 {
 	int connect_change;
+	bool disconnect = false;
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
 	struct usb_device *hdev = hub->hdev;
@@ -5579,6 +5580,9 @@ static void port_event(struct usb_hub *hub, int port1)
 	if (portchange & USB_PORT_STAT_C_CONNECTION) {
 		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
 		connect_change = 1;
+		if (!(portstatus & USB_PORT_STAT_CONNECTION) &&
+		    !(portstatus & USB_PORT_STAT_ENABLE))
+			disconnect = true;
 	}
 
 	if (portchange & USB_PORT_STAT_C_ENABLE) {
@@ -5647,7 +5651,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	 * Warm reset a USB3 protocol port if it's in
 	 * SS.Inactive state.
 	 */
-	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
+	if (hub_port_warm_reset_required(hub, port1, portstatus) && !disconnect) {
 		dev_dbg(&port_dev->dev, "do warm reset\n");
 		if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
-- 
2.32.0

