Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9219245EC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhKZLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:18:39 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:33368 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhKZLQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:16:34 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AQAjlFB048316;
        Fri, 26 Nov 2021 18:45:47 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Nov
 2021 19:10:03 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "kernel test robot" <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
Date:   Fri, 26 Nov 2021 19:09:53 +0800
Message-ID: <20211126110954.2677627-3-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AQAjlFB048316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote wakeup signaling will be automatically issued
whenever any write commands has been received in suspend
state.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c |  3 +++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 18 ++++++++++++++----
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 22 ++++++++++++++++------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..122ee7ef0b03 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -240,6 +240,9 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	if (vhub->force_usb1)
 		ctrl |= VHUB_CTRL_FULL_SPEED_ONLY;
 
+	/* Enable auto remote wakeup */
+	ctrl |= VHUB_CTRL_AUTO_REMOTE_WAKEUP;
+
 	ctrl |= VHUB_CTRL_UPSTREAM_CONNECT;
 	writel(ctrl, vhub->regs + AST_VHUB_CTRL);
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d918e8b2af3c..4462f4b73b04 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct ast_vhub_dev *d,
 				u16 wIndex, u16 wValue,
 				bool is_set)
 {
+	u32 val;
+
 	DDBG(d, "%s_FEATURE(dev val=%02x)\n",
 	     is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_driver;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		d->wakeup_en = is_set;
+		return std_req_complete;
 
-	d->wakeup_en = is_set;
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(d->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, d->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_driver;
 }
 
 static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index d76f83bc7762..ac589d3ba7a2 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct ast_vhub_ep *ep,
 				    u16 wIndex, u16 wValue,
 				    bool is_set)
 {
+	u32 val;
+
 	EPDBG(ep, "%s_FEATURE(dev val=%02x)\n",
 	      is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_stall;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		ep->vhub->wakeup_en = is_set;
+		EPDBG(ep, "Hub remote wakeup %s\n",
+		      is_set ? "enabled" : "disabled");
+		return std_req_complete;
 
-	ep->vhub->wakeup_en = is_set;
-	EPDBG(ep, "Hub remote wakeup %s\n",
-	      is_set ? "enabled" : "disabled");
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(ep->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, ep->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_stall;
 }
 
 static int ast_vhub_hub_ep_feature(struct ast_vhub_ep *ep,
-- 
2.25.1

