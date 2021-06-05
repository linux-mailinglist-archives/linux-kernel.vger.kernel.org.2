Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03AA39CA03
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFERBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFERBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:01:20 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7FC061767;
        Sat,  5 Jun 2021 09:59:31 -0700 (PDT)
Received: from dslb-188-096-145-192.188.096.pools.vodafone-ip.de ([188.96.145.192] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lpZdu-0002hw-G5; Sat, 05 Jun 2021 18:59:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: rtl8188eu: remove RT_TRACE and DBG_88E prints from usb_ops_linux.c
Date:   Sat,  5 Jun 2021 18:58:55 +0200
Message-Id: <20210605165858.3175-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605165858.3175-1-martin@kaiser.cx>
References: <20210605165858.3175-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said elsewhere, these prints are disabled by default.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  | 130 ++----------------
 1 file changed, 8 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index e8222ffb6fea..ec07b2017fb7 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -28,10 +28,8 @@ static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbu
 {
 	struct hal_data_8188e *haldata = adapt->HalData;
 
-	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
-		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
+	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN)
 		return;
-	}
 
 	/*  HISR */
 	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
@@ -66,20 +64,11 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 	pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
 
 	do {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("%s: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
-			  __func__, prxstat->rxdw0, prxstat->rxdw1,
-			  prxstat->rxdw2, prxstat->rxdw4));
-
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
-		if (!precvframe) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-				 ("%s: precvframe==NULL\n", __func__));
-			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
+		if (!precvframe)
 			goto _exit_recvbuf2recvframe;
-		}
 
 		INIT_LIST_HEAD(&precvframe->list);
 
@@ -88,8 +77,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pattrib = &precvframe->attrib;
 
 		if ((pattrib->crc_err) || (pattrib->icv_err)) {
-			DBG_88E("%s: RX Warning! crc_err=%d icv_err=%d, skip!\n", __func__, pattrib->crc_err, pattrib->icv_err);
-
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -100,9 +87,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 ("%s: pkt_len<=0\n", __func__));
-			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -138,8 +122,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			skb_reserve(pkt_copy, shift_sz);/* force ip_hdr at 8-byte alignment address according to shift_sz. */
 			skb_put_data(pkt_copy, (pbuf + pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
 		} else {
-			DBG_88E("%s: alloc_skb fail , drop frag frame\n",
-				__func__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -159,11 +141,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
 			if (pattrib->physt)
 				update_recvframe_phyinfo_88e(precvframe, pphy_status);
-			if (rtw_recv_entry(precvframe) != _SUCCESS) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n",
-					 __func__));
-			}
+			rtw_recv_entry(precvframe);
 		} else if (pattrib->pkt_rpt_type == TX_REPORT1) {
 			/* CCX-TXRPT ack for xmit mgmt frames. */
 			handle_txrpt_ccx_88e(adapt, precvframe->pkt->data);
@@ -223,15 +201,11 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:(adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
-			  __func__));
 		status = -EPERM;
 		goto exit;
 	}
 
 	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
-		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
 		status = -EINVAL;
 		goto exit;
 	}
@@ -272,10 +246,6 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 			if (reqtype == REALTEK_USB_VENQT_READ)
 				memcpy(pdata, pIo_buf,  len);
 		} else { /*  error cases */
-			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (reqtype == REALTEK_USB_VENQT_READ) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
-
 			if (status < 0) {
 				if (status == -ESHUTDOWN || status == -ENODEV)
 					adapt->bSurpriseRemoved = true;
@@ -340,29 +310,15 @@ static void usb_read_port_complete(struct urb *purb)
 	struct adapter *adapt = (struct adapter *)precvbuf->adapter;
 	struct recv_priv *precvpriv = &adapt->recvpriv;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s!!!\n", __func__));
-
 	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
-			 __func__, adapt->bDriverStopped,
-			 adapt->bSurpriseRemoved));
-
 		precvbuf->reuse = true;
-		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
-			__func__, adapt->bDriverStopped,
-			adapt->bSurpriseRemoved, adapt->bReadPortCancel);
 		return;
 	}
 
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s: (purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)\n",
-				 __func__));
 			precvbuf->reuse = true;
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
-			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
 		} else {
 			skb_put(precvbuf->pskb, purb->actual_length);
 			skb_queue_tail(&precvpriv->rx_skb_queue, precvbuf->pskb);
@@ -375,11 +331,6 @@ static void usb_read_port_complete(struct urb *purb)
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
 		}
 	} else {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s : purb->status(%d) != 0\n",
-			  __func__, purb->status));
-
-		DBG_88E("###=> %s => urb status(%d)\n", __func__, purb->status);
 		skb_put(precvbuf->pskb, purb->actual_length);
 		precvbuf->pskb = NULL;
 
@@ -392,8 +343,6 @@ static void usb_read_port_complete(struct urb *purb)
 			fallthrough;
 		case -ENOENT:
 			adapt->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s:bDriverStopped=true\n", __func__));
 			break;
 		case -EPROTO:
 		case -EOVERFLOW:
@@ -402,7 +351,6 @@ static void usb_read_port_complete(struct urb *purb)
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
 			break;
 		case -EINPROGRESS:
-			DBG_88E("ERROR: URB IS IN PROGRESS!\n");
 			break;
 		default:
 			break;
@@ -422,17 +370,11 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
 	    adapter->pwrctrlpriv.pnp_bstop_trx) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:(adapt->bDriverStopped ||adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
-			  __func__));
 		return _FAIL;
 	}
 
-	if (!precvbuf) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:precvbuf==NULL\n", __func__));
+	if (!precvbuf)
 		return _FAIL;
-	}
 
 	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
@@ -443,11 +385,8 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 	/* re-assign for linux based on skb */
 	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ);
-		if (!precvbuf->pskb) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
-			DBG_88E("#### %s() alloc_skb fail!#####\n", __func__);
+		if (!precvbuf->pskb)
 			return _FAIL;
-		}
 	} else { /* reuse skb */
 		precvbuf->reuse = false;
 	}
@@ -464,14 +403,8 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 			  precvbuf);/* context is precvbuf */
 
 	err = usb_submit_urb(purb, GFP_ATOMIC);
-	if ((err) && (err != (-EPERM))) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("cannot submit rx in-token(err=0x%.8x), URB_STATUS =0x%.8x",
-			 err, purb->status));
-		DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
-			err, purb->status);
+	if ((err) && (err != (-EPERM)))
 		ret = _FAIL;
-	}
 
 	return ret;
 }
@@ -483,8 +416,6 @@ void rtw_hal_inirp_deinit(struct adapter *padapter)
 
 	precvbuf = padapter->recvpriv.precv_buf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bReadPortCancel = true;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
@@ -547,49 +478,23 @@ static void usb_write_port_complete(struct urb *purb)
 		break;
 	}
 
-	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
-	    padapter->bWritePortCancel) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			  __func__, padapter->bDriverStopped,
-			  padapter->bSurpriseRemoved));
-		DBG_88E("%s(): TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
-			__func__, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved, padapter->bReadPortCancel,
-			pxmitbuf->ext_tag);
-
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped || padapter->bWritePortCancel)
 		goto check_completion;
-	}
 
 	if (purb->status) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s : purb->status(%d) != 0\n",
-			  __func__, purb->status));
-		DBG_88E("###=> %s status(%d)\n", __func__, purb->status);
 		if ((purb->status == -EPIPE) || (purb->status == -EPROTO)) {
 			sreset_set_wifi_error_status(padapter, USB_WRITE_PORT_FAIL);
 		} else if (purb->status == -EINPROGRESS) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s: EINPROGRESS\n", __func__));
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
-			DBG_88E("%s: -ENOENT\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ECONNRESET) {
-			DBG_88E("%s: -ECONNRESET\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s: ESHUTDOWN\n", __func__));
 			padapter->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s:bDriverStopped = true\n", __func__));
 			goto check_completion;
 		} else {
 			padapter->bSurpriseRemoved = true;
-			DBG_88E("bSurpriseRemoved = true\n");
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("%s:bSurpriseRemoved = true\n", __func__));
 			goto check_completion;
 		}
 	}
@@ -616,13 +521,8 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 	struct xmit_frame *pxmitframe = (struct xmit_frame *)xmitbuf->priv_data;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("+%s\n", __func__));
-
 	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
 	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s:( padapter->bDriverStopped ||padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
-			  __func__));
 		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
 		goto exit;
 	}
@@ -670,11 +570,6 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-		DBG_88E("%s, status =%d\n", __func__, status);
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("%s(): usb_submit_urb, status =%x\n",
-			  __func__, status));
-
 		if (status == -ENODEV)
 			padapter->bDriverStopped = true;
 
@@ -683,8 +578,6 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 
 	ret = _SUCCESS;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("-%s\n", __func__));
-
 exit:
 	if (ret != _SUCCESS)
 		rtw_free_xmitbuf(pxmitpriv, xmitbuf);
@@ -696,8 +589,6 @@ void usb_write_port_cancel(struct adapter *padapter)
 	int i, j;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bWritePortCancel = true;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
@@ -726,7 +617,6 @@ void rtl8188eu_recv_tasklet(struct tasklet_struct *t)
 
 	while (NULL != (pskb = skb_dequeue(&precvpriv->rx_skb_queue))) {
 		if ((adapt->bDriverStopped) || (adapt->bSurpriseRemoved)) {
-			DBG_88E("recv_tasklet => bDriverStopped or bSurpriseRemoved\n");
 			dev_kfree_skb_any(pskb);
 			break;
 		}
@@ -746,12 +636,8 @@ void rtl8188eu_xmit_tasklet(struct tasklet_struct *t)
 		return;
 
 	while (1) {
-		if ((adapt->bDriverStopped) ||
-		    (adapt->bSurpriseRemoved) ||
-		    (adapt->bWritePortCancel)) {
-			DBG_88E("xmit_tasklet => bDriverStopped or bSurpriseRemoved or bWritePortCancel\n");
+		if ((adapt->bDriverStopped) || (adapt->bSurpriseRemoved) || (adapt->bWritePortCancel))
 			break;
-		}
 
 		if (!rtl8188eu_xmitframe_complete(adapt, pxmitpriv))
 			break;
-- 
2.20.1

