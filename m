Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936E3E3619
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhHGPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHGPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F65C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:17 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONr-0003Y3-SC; Sat, 07 Aug 2021 17:37:11 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/12] staging: r8188eu: remove RT_TRACE prints from usb_ops_linux.c
Date:   Sat,  7 Aug 2021 17:36:26 +0200
Message-Id: <20210807153636.11712-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the prints
that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index dd4bd14b76c2..62dd4a131534 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -89,9 +89,6 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    padapter->bWritePortCancel) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_write_port_complete:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			 padapter->bDriverStopped, padapter->bSurpriseRemoved));
 		DBG_88E("%s(): TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
 			__func__, padapter->bDriverStopped,
 			padapter->bSurpriseRemoved, padapter->bReadPortCancel,
@@ -101,12 +98,10 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 
 	if (purb->status) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete : purb->status(%d) != 0\n", purb->status));
 		DBG_88E("###=> urb_write_port_complete status(%d)\n", purb->status);
 		if ((purb->status == -EPIPE) || (purb->status == -EPROTO)) {
 			sreset_set_wifi_error_status(padapter, USB_WRITE_PORT_FAIL);
 		} else if (purb->status == -EINPROGRESS) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: EINPROGESS\n"));
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
 			DBG_88E("%s: -ENOENT\n", __func__);
@@ -115,14 +110,11 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 			DBG_88E("%s: -ECONNRESET\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: ESHUTDOWN\n"));
 			padapter->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete:bDriverStopped = true\n"));
 			goto check_completion;
 		} else {
 			padapter->bSurpriseRemoved = true;
 			DBG_88E("bSurpriseRemoved = true\n");
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete:bSurpriseRemoved = true\n"));
 
 			goto check_completion;
 		}
@@ -156,12 +148,8 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	struct xmit_frame *pxmitframe = (struct xmit_frame *)pxmitbuf->priv_data;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("+usb_write_port\n"));
-
 	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
 	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_write_port:( padapter->bDriverStopped ||padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
 		goto exit;
 	}
@@ -214,7 +202,6 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	} else {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
 		DBG_88E("usb_write_port, status =%d\n", status);
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port(): usb_submit_urb, status =%x\n", status));
 
 		switch (status) {
 		case -ENODEV:
@@ -230,8 +217,6 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 
 /*    We add the URB_ZERO_PACKET flag to urb so that the host will send the zero packet automatically. */
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("-usb_write_port\n"));
-
 exit:
 	if (ret != _SUCCESS)
 		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
-- 
2.20.1

