Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8922A45F336
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhKZR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhKZR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:57:45 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC167C07E5E6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:22 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf57-00083N-6O; Fri, 26 Nov 2021 18:32:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/8] staging: r8188eu: only the bulk in ep is used for network data
Date:   Fri, 26 Nov 2021 18:31:59 +0100
Message-Id: <20211126173205.21352-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All supported devices use a single bulk in endpoint for receiving
network data.

The rtw_read_port function needs no addr parameter. The ff_hwaddr in
struct recv_priv is also a constant value. We can use RECV_BULK_IN_ADDR
directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c   |  4 +---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 10 +++++-----
 drivers/staging/r8188eu/include/rtw_io.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_recv.h  |  1 -
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 030438073661..ad54d5fcf45e 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -932,12 +932,10 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 
 	status = _SUCCESS;
 
-	precvpriv->ff_hwaddr = RECV_BULK_IN_ADDR;
-
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (!rtw_read_port(Adapter, precvpriv->ff_hwaddr, (unsigned char *)precvbuf)) {
+		if (!rtw_read_port(Adapter, (unsigned char *)precvbuf)) {
 			status = _FAIL;
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 92fcc4441ee9..6af55cd6c061 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -401,7 +401,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
 			precvbuf->reuse = true;
-			rtw_read_port(adapt, precvpriv->ff_hwaddr, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, (unsigned char *)precvbuf);
 			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
 		} else {
 			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
@@ -415,7 +415,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 
 			precvbuf->pskb = NULL;
 			precvbuf->reuse = false;
-			rtw_read_port(adapt, precvpriv->ff_hwaddr, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, (unsigned char *)precvbuf);
 		}
 	} else {
 		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
@@ -436,7 +436,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		case -EPROTO:
 		case -EOVERFLOW:
 			precvbuf->reuse = true;
-			rtw_read_port(adapt, precvpriv->ff_hwaddr, (unsigned char *)precvbuf);
+			rtw_read_port(adapt, (unsigned char *)precvbuf);
 			break;
 		case -EINPROGRESS:
 			DBG_88E("ERROR: URB IS IN PROGRESS!/n");
@@ -447,7 +447,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 }
 
-u32 rtw_read_port(struct adapter *adapter, u32 addr, u8 *rmem)
+u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 {
 	struct urb *purb = NULL;
 	struct recv_buf	*precvbuf = (struct recv_buf *)rmem;
@@ -507,7 +507,7 @@ u32 rtw_read_port(struct adapter *adapter, u32 addr, u8 *rmem)
 	purb = precvbuf->purb;
 
 	/* translate DMA FIFO addr to pipehandle */
-	pipe = ffaddr2pipehdl(pdvobj, addr);
+	pipe = ffaddr2pipehdl(pdvobj, RECV_BULK_IN_ADDR);
 
 	usb_fill_bulk_urb(purb, pusbd, pipe,
 			  precvbuf->pbuf,
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 0e896d0b56a7..6910e2b430e2 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -224,7 +224,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-u32 rtw_read_port(struct adapter *adapter, u32 addr, u8 *pmem);
+u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
 void rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 1e28ec731547..b43a46887343 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -177,7 +177,6 @@ struct recv_priv {
 	uint  rx_smallpacket_crcerr;
 	uint  rx_middlepacket_crcerr;
 	struct semaphore allrxreturnevt;
-	uint	ff_hwaddr;
 	u8	rx_pending_cnt;
 
 	struct tasklet_struct irq_prepare_beacon_tasklet;
-- 
2.20.1

