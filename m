Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13213DF838
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhHCXGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhHCXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B9C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11so113938wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fha1LXoMm1ejOZCKaIYrghwSrtyDw7IRZF3pOvDsN8k=;
        b=zN5M/RJISf62v3T2SlIieTsGoCZ7dVG0tSF7h/AbHt0rTr9sGuF5VPLvwzmK5BRxmN
         KOYb/PI18y+KKmL61bayINoZwmbTkAYs/6pwM4CvZZI7Y49jt3FGb7Xt1XYJGfS3cxMd
         a/0EBH0NONw6OWAW5v7yzht3ZN8U0rtd+4hGr0bg/4g6yVcFL3CIq+qccYkUaBaasEzv
         4qWOA06lkQjIssMxG6G1EBPq9+gq4btZPF8xU0KZcjZBjLYSZ1DcCZNMj1XAP+KymGC0
         2KikYQcb6xJY0jBMpsxBSMpO3hPK/IPQ6ExS8K5ovUuXH0gaJqWwt05rgeuhPCtu9FqV
         Yf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fha1LXoMm1ejOZCKaIYrghwSrtyDw7IRZF3pOvDsN8k=;
        b=uMijE9cv9sMFkly35E0SXpuPUKf+JH4ErBP2MH9nmZu4m9csHwvxW24C86YrnepOpe
         nC1GvMewfd175y0fo/3LijsJp9lgC3XZCYR2A3mkXOCK3YhsB1XCMIl+nhNywJzyEydi
         gilS5ZZYEyMBR691U9dottm/3/TUlVB50EfAnZnOw3hqc3VaP9bPTfYE3QCVYU4afH1n
         pOjwyObMJF/++p/dY5E0DYBC00idnqfPrQyCNW5OBqInAqySmsxIuxq5jjT0WpJrrOHl
         CnoeiP8x0mbKcPm24qynL2qEKfl2XJ6heSA232I57uDRSOJJXVkERLCyejMvPbl6asa8
         We0A==
X-Gm-Message-State: AOAM530NqQyJGj9yIh0V64YsOFEaTgt6oIri7gkecI218Lgd7i3D3xDV
        RsAlxjp2sfd991IT5kg9nsE+cg==
X-Google-Smtp-Source: ABdhPJxzeTghmnqiJ+UoaHeDU6QOGbROFAY6PKLF5EQ1duCtMLNWcIZB9AVIlJSnhCwCncNJ7puATg==
X-Received: by 2002:a1c:a94f:: with SMTP id s76mr6271599wme.17.1628031944199;
        Tue, 03 Aug 2021 16:05:44 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:43 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: r8188eu: remove RT_TRACE calls from hal/usb_ops_linux.c
Date:   Wed,  4 Aug 2021 00:05:35 +0100
Message-Id: <20210803230535.74254-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/usb_ops_linux.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 38 ++-------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 577090db84be..ce70c62572a8 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -22,7 +22,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usbctrl_vendorreq:(adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
 		status = -EPERM;
 		goto exit;
 	}
@@ -311,15 +310,10 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 	pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
 
 	do {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("recvbuf2recvframe: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
-			  prxstat->rxdw0, prxstat->rxdw1, prxstat->rxdw2, prxstat->rxdw4));
-
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
 		if (precvframe == NULL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvbuf2recvframe: precvframe==NULL\n"));
 			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -345,7 +339,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recvbuf2recvframe: pkt_len<=0\n"));
 			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfoer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
@@ -421,10 +414,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
 			if (pattrib->physt)
 				update_recvframe_phyinfo_88e(precvframe, (struct phy_stat *)pphy_status);
-			if (rtw_recv_entry(precvframe) != _SUCCESS) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					("recvbuf2recvframe: rtw_recv_entry(precvframe) != _SUCCESS\n"));
-			}
+			rtw_recv_entry(precvframe);
 		} else {
 			/* enqueue recvframe to txrtp queue */
 			if (pattrib->pkt_rpt_type == TX_REPORT1) {
@@ -484,15 +474,9 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	struct adapter	*adapt = (struct adapter *)precvbuf->adapter;
 	struct recv_priv *precvpriv = &adapt->recvpriv;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete!!!\n"));
-
 	precvpriv->rx_pending_cnt--;
 
 	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port_complete:bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
-			 adapt->bDriverStopped, adapt->bSurpriseRemoved));
-
 		precvbuf->reuse = true;
 		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
 			__func__, adapt->bDriverStopped,
@@ -502,8 +486,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("usb_read_port_complete: (purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)\n"));
 			precvbuf->reuse = true;
 			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
 			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
@@ -522,8 +504,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
 		}
 	} else {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete : purb->status(%d) != 0\n", purb->status));
-
 		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
 		skb_put(precvbuf->pskb, purb->actual_length);
 		precvbuf->pskb = NULL;
@@ -536,11 +516,9 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		case -EPIPE:
 		case -ENODEV:
 		case -ESHUTDOWN:
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete:bSurpriseRemoved=true\n"));
 			__attribute__((__fallthrough__));
 		case -ENOENT:
 			adapt->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete:bDriverStopped=true\n"));
 			break;
 		case -EPROTO:
 		case -EOVERFLOW:
@@ -575,17 +553,11 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 	u32 ret = _SUCCESS;
 
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
-	    adapter->pwrctrlpriv.pnp_bstop_trx) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port:(adapt->bDriverStopped ||adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+	    adapter->pwrctrlpriv.pnp_bstop_trx)
 		return _FAIL;
-	}
 
-	if (!precvbuf) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port:precvbuf==NULL\n"));
+	if (!precvbuf)
 		return _FAIL;
-	}
 
 	if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
 		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
@@ -599,7 +571,6 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 		if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
 			precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
 			if (precvbuf->pskb == NULL) {
-				RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
 				DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
 				return _FAIL;
 			}
@@ -638,9 +609,6 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 
 		err = usb_submit_urb(purb, GFP_ATOMIC);
 		if ((err) && (err != (-EPERM))) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("cannot submit rx in-token(err=0x%.8x), URB_STATUS =0x%.8x",
-				 err, purb->status));
 			DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
 				err, purb->status);
 			ret = _FAIL;
-- 
2.31.1

