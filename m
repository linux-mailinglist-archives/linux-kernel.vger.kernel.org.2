Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EC3D566B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGZIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhGZIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:41:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F79C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:21:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so6658155wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqNUqFciNN4LC8aT5JJ7kp05Roas++LREeGimN8w8rw=;
        b=aJh6pZUOKONswsCUiE+v3fACkMsH/juMZscKD8PQx3W+W4YoZXIKtYP4uCxWJq5DmK
         Mfg9ruke4uHCUx9+T7PYMVNTOnMJJMm/GAnB5hGh/PE6ed3a6IGjFyb18KGG6BXEGatI
         tEa4Q8OdPZ+8e5iRQ7SrdHqkmE6/76h1GHVglDpetTJUshrZoF/uKHOMbmQuSDkkjBeD
         53+eA+W58ulw80HVzHtH0i9jabQ/vAVlPUs8Mj4a/ps9x/a3yalQzkUySqz4MWLZq5wd
         18lScrdFp9T2D6IRX7u86+lpdeNwgCQuh4XRDRaB1Bj445MR/rpBppj2cgo0AtFGiybA
         FnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqNUqFciNN4LC8aT5JJ7kp05Roas++LREeGimN8w8rw=;
        b=SpCpiWg3UyzhoLvK7+lNE/VWVRzO/pCXuULtjJrsGWtquY+KY1sintHTS4gPRrwIhU
         Pz/StllMMU6uUhw41ngzSxCIRmQBN0e7Vv7+pgr6BikZ9+MLSHU2QhLcyDpxG15yW7GW
         hi4/PMDhzCe0NWAyhvDFEPM1HtD1iXMUXIMa2OQ1iMYAXAxEroWllPJ+oc/isuGh28wW
         EOwQRGbGUQXe8rt3RtHtqfO5dupzBvLd/R4gthdzk7rqmeO9VGDoIpdTRjYbWUcaOMGo
         MKF1eOXrUXqghN6YfTBQKBs8jlQk9FQjIhsnHsi6+H/ZW9/Ul42yqpRr2XRbmuOqrelS
         w78g==
X-Gm-Message-State: AOAM530NEet/5tq8U42VJaJrjlpM5mslZGePN6DQXipWvSQwolKuEFy4
        mIGUibn8JI9Ra2vfE8cidyc=
X-Google-Smtp-Source: ABdhPJz2uwaAY/feFqZNsLuiMK4gU1YCIYHxJAFsrMTudHMAMjr7Kd8aSGKX0T14AExgK2BUB4UnQg==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr18354347wrw.346.1627291311493;
        Mon, 26 Jul 2021 02:21:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id a191sm2555704wme.15.2021.07.26.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:21:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove braces from single line if blocks
Date:   Mon, 26 Jul 2021 11:21:29 +0200
Message-Id: <20210726092129.30334-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single line if blocks to clear checkpatch warnings.
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c          | 3 +--
 drivers/staging/rtl8188eu/core/rtw_mlme.c         | 3 +--
 drivers/staging/rtl8188eu/core/rtw_xmit.c         | 3 +--
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
 drivers/staging/rtl8188eu/hal/usb_halinit.c       | 6 ++----
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index eb89a52aa4e3..56ece839c9ca 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -1159,9 +1159,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (!psta) {
+			if (!psta)
 				goto createbss_cmd_fail;
-			}
 		}
 
 		rtw_indicate_connect(padapter);
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 71d205f3d73d..0d334aba9a3f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -953,9 +953,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s4. indicate connect */
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				rtw_indicate_connect(adapter);
-			}
 
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index d5fc59417ec6..c77ebd18f40c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1124,9 +1124,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		list_del_init(&pxmitbuf->list);
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irql);
 
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 6cf87312bc36..a67615708745 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -510,7 +510,6 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	else
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 
-	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
+	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
-	}
 }
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 1d7d5037ce89..3e8f7315d377 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -641,9 +641,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	}
 
 	status = rtw_hal_power_on(Adapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	/*  Save target channel */
 	haldata->CurrentChannel = 6;/* default set to 6 */
@@ -696,9 +695,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
 	status =  InitLLTTable(Adapter, txpktbuf_bndy);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	/*  Get Rx PHY status in order to report RSSI and others. */
 	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
-- 
2.32.0

