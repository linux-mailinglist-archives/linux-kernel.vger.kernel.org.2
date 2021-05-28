Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91C393CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 08:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhE1GM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:12:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235513AbhE1GMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:12:45 -0400
X-UUID: 825034e1e0f4440ba69e5ae5850e754c-20210528
X-UUID: 825034e1e0f4440ba69e5ae5850e754c-20210528
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 920044613; Fri, 28 May 2021 14:11:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 14:11:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 14:11:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 2/5] usb: mtu3: remove repeated setting of speed
Date:   Fri, 28 May 2021 14:10:57 +0800
Message-ID: <1622182260-23767-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1622182260-23767-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1622182260-23767-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtu3_gadget_start() will set speed, no need set it again in
mtu3_gadget_set_speed(), just save the desired speed.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h        | 1 -
 drivers/usb/mtu3/mtu3_core.c   | 2 +-
 drivers/usb/mtu3/mtu3_gadget.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index a8a7ee11f7b7..531b9c78d7c3 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -425,7 +425,6 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set);
 void mtu3_start(struct mtu3 *mtu);
 void mtu3_stop(struct mtu3 *mtu);
 void mtu3_dev_on_off(struct mtu3 *mtu, int is_on);
-void mtu3_set_speed(struct mtu3 *mtu, enum usb_device_speed speed);
 
 int mtu3_gadget_setup(struct mtu3 *mtu);
 void mtu3_gadget_cleanup(struct mtu3 *mtu);
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 2ef528f39ba3..6b5da98de648 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -207,7 +207,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_DEV_LINK_INTR_ENABLE, SSUSB_DEV_SPEED_CHG_INTR);
 }
 
-void mtu3_set_speed(struct mtu3 *mtu, enum usb_device_speed speed)
+static void mtu3_set_speed(struct mtu3 *mtu, enum usb_device_speed speed)
 {
 	void __iomem *mbase = mtu->mac_base;
 
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 38f17d66d5bc..5e21ba05ebf0 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -577,7 +577,7 @@ mtu3_gadget_set_speed(struct usb_gadget *g, enum usb_device_speed speed)
 	dev_dbg(mtu->dev, "%s %s\n", __func__, usb_speed_string(speed));
 
 	spin_lock_irqsave(&mtu->lock, flags);
-	mtu3_set_speed(mtu, speed);
+	mtu->speed = speed;
 	spin_unlock_irqrestore(&mtu->lock, flags);
 }
 
-- 
2.18.0

