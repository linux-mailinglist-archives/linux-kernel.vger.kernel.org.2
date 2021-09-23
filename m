Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283A84167E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbhIWWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:17:56 -0400
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:18053 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236039AbhIWWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:17:53 -0400
Received: from localhost.localdomain (85-76-102-236-nat.elisa-mobile.fi [85.76.102.236])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id a281e6f2-1cb9-11ec-8d6d-005056bd6ce9;
        Fri, 24 Sep 2021 01:00:17 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Steve Glendinning <steve.glendinning@shawell.net>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andre Edich <andre.edich@microchip.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] smsc95xx: fix stalled rx after link change
Date:   Fri, 24 Sep 2021 01:00:16 +0300
Message-Id: <20210923220016.18221-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 05b35e7eb9a1 ("smsc95xx: add phylib support"), link changes
are no longer propagated to usbnet. As a result, rx URB allocation won't
happen until there is a packet sent out first (this might never happen,
e.g. running just ssh server with a static IP). Fix by triggering usbnet
EVENT_LINK_CHANGE.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/net/usb/smsc95xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 7d953974eb9b..26b1bd8e845b 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1178,7 +1178,10 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static void smsc95xx_handle_link_change(struct net_device *net)
 {
+	struct usbnet *dev = netdev_priv(net);
+
 	phy_print_status(net->phydev);
+	usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
 }
 
 static int smsc95xx_start_phy(struct usbnet *dev)
-- 
2.17.0

