Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A68438B36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJXSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhJXSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:07:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8BC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:05:07 -0700 (PDT)
Received: from dslb-178-004-201-201.178.004.pools.vodafone-ip.de ([178.4.201.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mehrj-00049p-OY; Sun, 24 Oct 2021 20:05:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: remove last_tx_complete_time
Date:   Sun, 24 Oct 2021 20:04:47 +0200
Message-Id: <20211024180448.20624-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024180448.20624-1-martin@kaiser.cx>
References: <20211024180448.20624-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

last_tx_complete_time from struct sreset_priv is set / calculated when a
packet is sent out. Like other sreset_priv components, it is not read and
can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sreset.c      |  2 --
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c  | 15 ---------------
 drivers/staging/r8188eu/include/rtw_sreset.h   |  1 -
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c |  4 ----
 4 files changed, 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index bf436a653c71..1df46673bddd 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -9,7 +9,6 @@ void sreset_init_value(struct adapter *padapter)
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
 	psrtpriv->last_tx_time = 0;
-	psrtpriv->last_tx_complete_time = 0;
 }
 void sreset_reset_value(struct adapter *padapter)
 {
@@ -17,5 +16,4 @@ void sreset_reset_value(struct adapter *padapter)
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
 	psrtpriv->last_tx_time = 0;
-	psrtpriv->last_tx_complete_time = 0;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index ea793fef6f10..7b3ac6e306ce 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -8,12 +8,6 @@
 
 void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
-	unsigned long current_time;
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-	unsigned int diff_time;
 	u32 txdma_status;
 
 	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
@@ -22,15 +16,6 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
 	}
 	/* total xmit irp = 4 */
-	current_time = jiffies;
-	if (0 == pxmitpriv->free_xmitbuf_cnt) {
-		diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_time);
-
-		if (diff_time > 2000) {
-			if (psrtpriv->last_tx_complete_time == 0)
-				psrtpriv->last_tx_complete_time = current_time;
-		}
-	}
 }
 
 void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index f404cbd54f9f..ff84cdc02c2c 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -9,7 +9,6 @@
 
 struct sreset_priv {
 	unsigned long last_tx_time;
-	unsigned long last_tx_complete_time;
 };
 
 #include "rtl8188e_hal.h"
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 966fba50f73d..57a435138bf0 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -53,7 +53,6 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)purb->context;
 	struct adapter	*padapter = pxmitbuf->padapter;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-	struct hal_data_8188e	*haldata;
 
 	switch (pxmitbuf->flags) {
 	case VO_QUEUE_INX:
@@ -106,9 +105,6 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 		}
 	}
 
-	haldata = GET_HAL_DATA(padapter);
-	haldata->srestpriv.last_tx_complete_time = jiffies;
-
 check_completion:
 	rtw_sctx_done_err(&pxmitbuf->sctx,
 			  purb->status ? RTW_SCTX_DONE_WRITE_PORT_ERR :
-- 
2.20.1

