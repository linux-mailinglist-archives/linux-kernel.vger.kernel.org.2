Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1B393CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhE1GMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:12:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43767 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233893AbhE1GMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:12:43 -0400
X-UUID: d37cf73de93f4bcfb5d617056efdabac-20210528
X-UUID: d37cf73de93f4bcfb5d617056efdabac-20210528
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 885169257; Fri, 28 May 2021 14:11:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 14:11:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 14:11:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 1/5] usb: mtu3: remove mtu3_ep0_setup() declaration in mtu3.h
Date:   Fri, 28 May 2021 14:10:56 +0800
Message-ID: <1622182260-23767-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's defined and only used in the same file, so remove its declaration
in mtu3.h, and make it static

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      | 1 -
 drivers/usb/mtu3/mtu3_core.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index aef0a0bba25a..a8a7ee11f7b7 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -422,7 +422,6 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 		int interval, int burst, int mult);
 void mtu3_deconfig_ep(struct mtu3 *mtu, struct mtu3_ep *mep);
 void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set);
-void mtu3_ep0_setup(struct mtu3 *mtu);
 void mtu3_start(struct mtu3 *mtu);
 void mtu3_stop(struct mtu3 *mtu);
 void mtu3_dev_on_off(struct mtu3 *mtu, int is_on);
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b3b459937566..2ef528f39ba3 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -536,7 +536,7 @@ static void get_ep_fifo_config(struct mtu3 *mtu)
 		rx_fifo->base, rx_fifo->limit);
 }
 
-void mtu3_ep0_setup(struct mtu3 *mtu)
+static void mtu3_ep0_setup(struct mtu3 *mtu)
 {
 	u32 maxpacket = mtu->g.ep0->maxpacket;
 	u32 csr;
-- 
2.18.0

