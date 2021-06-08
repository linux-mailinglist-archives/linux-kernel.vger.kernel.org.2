Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0539F040
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFHIA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49395 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231151AbhFHIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:06 -0400
X-UUID: 7e1a97eb2e474ef99b480ef8eba83467-20210608
X-UUID: 7e1a97eb2e474ef99b480ef8eba83467-20210608
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1351158784; Tue, 08 Jun 2021 15:58:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 12/23] usb: mtu3: use force mode for dual role switch
Date:   Tue, 8 Jun 2021 15:57:38 +0800
Message-ID: <1623139069-8173-13-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force IDDIG status for all three ways of dual role switch, this
is needed when use Type-C to switch mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c   | 10 +++-------
 drivers/usb/mtu3/mtu3_host.c |  6 +-----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 486d26a366b8..cf9e5b59a77e 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -148,12 +148,14 @@ static void ssusb_mode_sw_work(struct work_struct *work)
 
 	switch (desired_role) {
 	case USB_ROLE_HOST:
+		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
 		mtu3_stop(mtu);
 		switch_port_to_host(ssusb);
 		ssusb_set_vbus(otg_sx, 1);
 		ssusb->is_host = true;
 		break;
 	case USB_ROLE_DEVICE:
+		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_DEVICE);
 		ssusb->is_host = false;
 		ssusb_set_vbus(otg_sx, 0);
 		switch_port_to_device(ssusb);
@@ -225,13 +227,7 @@ void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	if (to_host) {
-		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
-		ssusb_set_mode(otg_sx, USB_ROLE_HOST);
-	} else {
-		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_DEVICE);
-		ssusb_set_mode(otg_sx, USB_ROLE_DEVICE);
-	}
+	ssusb_set_mode(otg_sx, to_host ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 0a8cd446cf1b..93a1a4c11e1e 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -213,8 +213,6 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
 
 static void ssusb_host_setup(struct ssusb_mtk *ssusb)
 {
-	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
-
 	host_ports_num_get(ssusb);
 
 	/*
@@ -222,9 +220,7 @@ static void ssusb_host_setup(struct ssusb_mtk *ssusb)
 	 * if support OTG, gadget driver will switch port0 to device mode
 	 */
 	ssusb_host_enable(ssusb);
-
-	if (otg_sx->manual_drd_enabled)
-		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
+	ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
 
 	/* if port0 supports dual-role, works as host mode by default */
 	ssusb_set_vbus(&ssusb->otg_switch, 1);
-- 
2.18.0

