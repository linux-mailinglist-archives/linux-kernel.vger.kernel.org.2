Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C63C33CD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGJJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 05:04:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38400 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231877AbhGJJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 05:04:03 -0400
X-UUID: 0e341645ef3541739d1f20280fc97dad-20210710
X-UUID: 0e341645ef3541739d1f20280fc97dad-20210710
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1306515868; Sat, 10 Jul 2021 17:01:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 17:01:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 17:01:05 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <timur@kernel.org>, <linux@armlinux.org.uk>, <alcooperx@gmail.com>,
        <tklauser@distanz.ch>, <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hui.liu@mediatek.com>, <yuchen.huang@mediatek.com>,
        <huihui.wang@mediatek.com>, <eddie.huang@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH] uart: mediatek: fix memory corruption issue
Date:   Sat, 10 Jul 2021 17:01:03 +0800
Message-ID: <20210710090103.2643-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
References: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to fix memory corruption issue when rx power off.
1. add spin lock in mtk8250_dma_rx_complete function in APDMA mode.
2. add processing mechanism which count value is 0

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f7d3023f860f..09f7d2166315 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -91,12 +91,15 @@ static void mtk8250_dma_rx_complete(void *param)
 	struct mtk8250_data *data = up->port.private_data;
 	struct tty_port *tty_port = &up->port.state->port;
 	struct dma_tx_state state;
-	int copied, total, cnt;
+	unsigned int copied, total, cnt;
 	unsigned char *ptr;
+	unsigned long flags;
 
 	if (data->rx_status == DMA_RX_SHUTDOWN)
 		return;
 
+	spin_lock_irqsave(&up->port.lock, flags);
+
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 	total = dma->rx_size - state.residue;
 	cnt = total;
@@ -104,9 +107,11 @@ static void mtk8250_dma_rx_complete(void *param)
 	if ((data->rx_pos + cnt) > dma->rx_size)
 		cnt = dma->rx_size - data->rx_pos;
 
-	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
-	copied = tty_insert_flip_string(tty_port, ptr, cnt);
-	data->rx_pos += cnt;
+	if (cnt != 0) {
+		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
+		copied = tty_insert_flip_string(tty_port, ptr, cnt);
+		data->rx_pos += cnt;
+	}
 
 	if (total > cnt) {
 		ptr = (unsigned char *)(dma->rx_buf);
@@ -120,6 +125,8 @@ static void mtk8250_dma_rx_complete(void *param)
 	tty_flip_buffer_push(tty_port);
 
 	mtk8250_rx_dma(up);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void mtk8250_rx_dma(struct uart_8250_port *up)
-- 
2.18.0

