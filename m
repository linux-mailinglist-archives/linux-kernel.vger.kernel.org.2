Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CC45EC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhKZLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:18:21 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:28819 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhKZLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:16:19 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AQAjlvc048315;
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
Subject: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
Date:   Fri, 26 Nov 2021 19:09:52 +0800
Message-ID: <20211126110954.2677627-2-neal_liu@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 1AQAjlvc048315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support qualifier descriptor to pass USB30CV compliance test.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 29 ++++++++++++++++++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index b9960fdd8a51..d76f83bc7762 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -68,6 +68,18 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bNumConfigurations	= 1,
 };
 
+static const struct usb_qualifier_descriptor ast_vhub_qual_desc = {
+	.bLength = 0xA,
+	.bDescriptorType = USB_DT_DEVICE_QUALIFIER,
+	.bcdUSB = cpu_to_le16(0x0200),
+	.bDeviceClass = USB_CLASS_HUB,
+	.bDeviceSubClass = 0,
+	.bDeviceProtocol = 0,
+	.bMaxPacketSize0 = 64,
+	.bNumConfigurations = 1,
+	.bRESERVED = 0,
+};
+
 /*
  * Configuration descriptor: same comments as above
  * regarding handling USB1 mode.
@@ -271,9 +283,11 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_dev_desc));
 		BUILD_BUG_ON(USB_DT_DEVICE_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
+	case USB_DT_OTHER_SPEED_CONFIG:
 	case USB_DT_CONFIG:
 		dsize = AST_VHUB_CONF_DESC_SIZE;
 		memcpy(ep->buf, &vhub->vhub_conf_desc, dsize);
+		((u8 *)ep->buf)[1] = desc_type;
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_conf_desc));
 		BUILD_BUG_ON(AST_VHUB_CONF_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
@@ -283,6 +297,10 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_hub_desc));
 		BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
+	case USB_DT_DEVICE_QUALIFIER:
+		dsize = sizeof(vhub->vhub_qual_desc);
+		memcpy(ep->buf, &vhub->vhub_qual_desc, dsize);
+		break;
 	default:
 		return std_req_stall;
 	}
@@ -417,10 +435,9 @@ enum std_req_rc ast_vhub_std_hub_request(struct ast_vhub_ep *ep,
 
 		/* GET/SET_CONFIGURATION */
 	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
-		return ast_vhub_simple_reply(ep, 1);
+		return ast_vhub_simple_reply(ep, vhub->current_config);
 	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
-		if (wValue != 1)
-			return std_req_stall;
+		vhub->current_config = wValue;
 		return std_req_complete;
 
 		/* GET_DESCRIPTOR */
@@ -428,6 +445,8 @@ enum std_req_rc ast_vhub_std_hub_request(struct ast_vhub_ep *ep,
 		switch (wValue >> 8) {
 		case USB_DT_DEVICE:
 		case USB_DT_CONFIG:
+		case USB_DT_DEVICE_QUALIFIER:
+		case USB_DT_OTHER_SPEED_CONFIG:
 			return ast_vhub_rep_desc(ep, wValue >> 8,
 						 wLength);
 		case USB_DT_STRING:
@@ -1033,6 +1052,10 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	else
 		ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
 
+	/* Initialize vhub Qualifier Descriptor. */
+	memcpy(&vhub->vhub_qual_desc, &ast_vhub_qual_desc,
+		sizeof(vhub->vhub_qual_desc));
+
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 87a5dea12d3c..e6a11a22422a 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -419,12 +419,14 @@ struct ast_vhub {
 
 	/* Upstream bus speed captured at bus reset */
 	unsigned int			speed;
+	u8				current_config;
 
 	/* Standard USB Descriptors of the vhub. */
 	struct usb_device_descriptor	vhub_dev_desc;
 	struct ast_vhub_full_cdesc	vhub_conf_desc;
 	struct usb_hub_descriptor	vhub_hub_desc;
 	struct list_head		vhub_str_desc;
+	struct usb_qualifier_descriptor	vhub_qual_desc;
 };
 
 /* Standard request handlers result codes */
-- 
2.25.1

