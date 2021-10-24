Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22434438B35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhJXSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhJXSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:07:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CDC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:05:05 -0700 (PDT)
Received: from dslb-178-004-201-201.178.004.pools.vodafone-ip.de ([178.4.201.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mehrh-00049p-M2; Sun, 24 Oct 2021 20:05:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: wifi_error_status is write-only
Date:   Sun, 24 Oct 2021 20:04:45 +0200
Message-Id: <20211024180448.20624-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024180448.20624-1-martin@kaiser.cx>
References: <20211024180448.20624-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wifi_error_status in struct sreset_priv is set in a couple of places,
its value is never used.

Remove wifi_error_status itself, the defines for the possible values and
the sreset_set_wifi_error_status function.

Rewrite the if statement in usb_write_port_complete. For purb->status ==
-EPIPE or -EPROTO, nothing should be done.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sreset.c      |  8 --------
 drivers/staging/r8188eu/hal/usb_ops_linux.c    | 10 ----------
 drivers/staging/r8188eu/include/rtw_sreset.h   |  7 -------
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c |  6 ++----
 4 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index 60596a3a3aad..08e5b1b00bd1 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -9,7 +9,6 @@ void sreset_init_value(struct adapter *padapter)
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
 	mutex_init(&psrtpriv->silentreset_mutex);
-	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 	psrtpriv->last_tx_time = 0;
 	psrtpriv->last_tx_complete_time = 0;
 }
@@ -18,13 +17,6 @@ void sreset_reset_value(struct adapter *padapter)
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
-	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 	psrtpriv->last_tx_time = 0;
 	psrtpriv->last_tx_complete_time = 0;
 }
-
-void sreset_set_wifi_error_status(struct adapter *padapter, u32 status)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-	pHalData->srestpriv.wifi_error_status = status;
-}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4c1974cc9a16..cb825aa29e85 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -39,9 +39,6 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	}
 
 	if (status < 0) {
-		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
-			USB_VEN_REQ_CMD_FAIL;
-
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
@@ -86,9 +83,6 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	}
 
 	if (status < 0) {
-		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
-			USB_VEN_REQ_CMD_FAIL;
-
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
@@ -441,10 +435,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			break;
 		case -EPROTO:
 		case -EOVERFLOW:
-			{
-				struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
-				haldata->srestpriv.wifi_error_status = USB_READ_PORT_FAIL;
-			}
 			precvbuf->reuse = true;
 			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
 			break;
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 2489f55d0594..1a3745dabfb6 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -9,20 +9,13 @@
 
 struct sreset_priv {
 	struct mutex	silentreset_mutex;
-	u8	wifi_error_status;
 	unsigned long last_tx_time;
 	unsigned long last_tx_complete_time;
 };
 
 #include "rtl8188e_hal.h"
 
-#define	WIFI_STATUS_SUCCESS		0
-#define	USB_VEN_REQ_CMD_FAIL	BIT(0)
-#define	USB_READ_PORT_FAIL		BIT(1)
-#define	USB_WRITE_PORT_FAIL		BIT(2)
-
 void sreset_init_value(struct adapter *padapter);
 void sreset_reset_value(struct adapter *padapter);
-void sreset_set_wifi_error_status(struct adapter *padapter, u32 status);
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 4085f3e6067d..966fba50f73d 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -87,9 +87,7 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (purb->status) {
 		DBG_88E("###=> urb_write_port_complete status(%d)\n", purb->status);
-		if ((purb->status == -EPIPE) || (purb->status == -EPROTO)) {
-			sreset_set_wifi_error_status(padapter, USB_WRITE_PORT_FAIL);
-		} else if (purb->status == -EINPROGRESS) {
+		if (purb->status == -EINPROGRESS) {
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
 			DBG_88E("%s: -ENOENT\n", __func__);
@@ -100,7 +98,7 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 		} else if (purb->status == -ESHUTDOWN) {
 			padapter->bDriverStopped = true;
 			goto check_completion;
-		} else {
+		} else if ((purb->status != -EPIPE) && (purb->status != -EPROTO)) {
 			padapter->bSurpriseRemoved = true;
 			DBG_88E("bSurpriseRemoved = true\n");
 
-- 
2.20.1

