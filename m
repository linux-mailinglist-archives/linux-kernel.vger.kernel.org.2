Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1E4072B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhIJUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:51:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BEC061757
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so4375477wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJG447Okjdn+Cghd2I5M9SNYR6YFuJs4u2ZMKHwhhnQ=;
        b=AdXTIp6hbJvhYv2WWY4DsAC5We0paaNqoGPa27GiYdtTLbHq5LONBrQHs1NhiR/f5o
         Q6l8zMc2hh0l/8gKUQcADrMF3fbonvCXoKDSqJZsuRK+ygdNu0GcL0iEOQc0kC9gfCwO
         xEUoR0qeIMwqHyzSaXOdB1QkYECUVk+lOjR2g63ENQJNv3LIZG4nNsiql8vrsXdViuwA
         obHxyEZCDLaPLnE88b83oxSADKVzgq6m46D09aIJAg7w3WONj2+BDcb0TbbuH1eoTkT/
         Tw9hzCIMNcrc6gXzdEpnPQg55/rNVh1TddSMzyVfNgGNOVIcoye2XobNMGaWmKvEioib
         z35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJG447Okjdn+Cghd2I5M9SNYR6YFuJs4u2ZMKHwhhnQ=;
        b=q3AOpoJ6NTiaf1W2+ZbX7OFoI3fVGA1ySWixq5/H3QkIATm+uiHE+8nilbV9vINyIj
         7Jpa6ZQMcidtYAsdEq32gX4QXVQqrx3RCO5CVcDkaRFpdVlFDBw0wmKMKmXr6o4mqf2q
         0w7oNhPmN3xdd3IMHdo3HcxwwI/x/XRMHOpZOz6WLnCx1/DFbARiuLETykg1HeWipB/v
         eJ/CrNmWIb5TjaBmooP/USAaKnUfJ37KRGqdL1v76Bx8u0E6cHWXam/DWbk5WU+7ZRHw
         YyQZdLQACQ2HxyGyyLuRkbcDZO4Rd3lyApBTXVkMSElnx/+vYfRQF9W70W8hSF/Mg3Oo
         vrbw==
X-Gm-Message-State: AOAM531YDRKHrYDY6IjNbTxS+v0hUOudjAlVgKFOXwgwRswUB2nCtQbH
        8vI9BWfiIaLfjYnXI68LnVY=
X-Google-Smtp-Source: ABdhPJxP+mxtvECRUOBN4lKmUGf7P9dDNmKj8wS2xy/wJ3Og5fD3XSX/XmUkB74m7LpdxWu00L43Mg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr11583291wrr.382.1631307046803;
        Fri, 10 Sep 2021 13:50:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: remove hal_xmit from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:28 +0200
Message-Id: <20210910205033.3778-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_xmit from struct hal_ops and its wrapper rtw_hal_xmit().
Call rtl8188eu_hal_xmit() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c     | 9 +++++----
 drivers/staging/r8188eu/hal/hal_intf.c      | 8 --------
 drivers/staging/r8188eu/hal/usb_halinit.c   | 2 --
 drivers/staging/r8188eu/include/hal_intf.h  | 5 -----
 5 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a01e6f822cc0..26e14e91a42c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -8100,7 +8100,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 				pxmitframe->attrib.qsel = 0x11;/* HIQ */
 
 				spin_unlock_bh(&psta_bmc->sleep_q.lock);
-				if (rtw_hal_xmit(padapter, pxmitframe))
+				if (rtl8188eu_hal_xmit(padapter, pxmitframe))
 					rtw_os_xmit_complete(padapter, pxmitframe);
 				spin_lock_bh(&psta_bmc->sleep_q.lock);
 			}
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1bfb91f445df..3773ff97198f 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -9,6 +9,7 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
+#include "../include/rtl8188e_xmit.h"
 
 static u8 P802_1H_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0xf8 };
 static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
@@ -1780,7 +1781,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	}
 	spin_unlock_bh(&pxmitpriv->lock);
 
-	if (!rtw_hal_xmit(padapter, pxmitframe))
+	if (!rtl8188eu_hal_xmit(padapter, pxmitframe))
 		return 1;
 
 	return 0;
@@ -2014,7 +2015,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 		pxmitframe->attrib.triggered = 1;
 
 		spin_unlock_bh(&psta->sleep_q.lock);
-		if (rtw_hal_xmit(padapter, pxmitframe))
+		if (rtl8188eu_hal_xmit(padapter, pxmitframe))
 			rtw_os_xmit_complete(padapter, pxmitframe);
 		spin_lock_bh(&psta->sleep_q.lock);
 	}
@@ -2064,7 +2065,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 			pxmitframe->attrib.triggered = 1;
 
 			spin_unlock_bh(&psta_bmc->sleep_q.lock);
-			if (rtw_hal_xmit(padapter, pxmitframe))
+			if (rtl8188eu_hal_xmit(padapter, pxmitframe))
 				rtw_os_xmit_complete(padapter, pxmitframe);
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 		}
@@ -2138,7 +2139,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 
 		pxmitframe->attrib.triggered = 1;
 
-		if (rtw_hal_xmit(padapter, pxmitframe))
+		if (rtl8188eu_hal_xmit(padapter, pxmitframe))
 			rtw_os_xmit_complete(padapter, pxmitframe);
 
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 98f33747c680..fecdd272f84e 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -88,14 +88,6 @@ u32 rtw_hal_inirp_deinit(struct adapter *adapt)
 	return _FAIL;
 }
 
-s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
-{
-	if (adapt->HalFunc.hal_xmit)
-		return adapt->HalFunc.hal_xmit(adapt, pxmitframe);
-
-	return false;
-}
-
 s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 {
 	if (adapt->HalFunc.init_xmit_priv)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4b732efeef39..aeaf53c1cfbf 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2228,7 +2228,5 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
 	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
 
-	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
-
 	rtl8188e_set_hal_ops(halfunc);
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index d50dc2554d61..da1fd5bddeb7 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -147,9 +147,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	s32	(*hal_xmit)(struct adapter *padapter,
-			    struct xmit_frame *pxmitframe);
-
 	u32	(*read_bbreg)(struct adapter *padapter, u32 RegAddr,
 			      u32 BitMask);
 	void	(*write_bbreg)(struct adapter *padapter, u32 RegAddr,
@@ -215,8 +212,6 @@ u8 rtw_hal_get_def_var(struct adapter *padapter,
 u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
-s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
-
 s32	rtw_hal_init_xmit_priv(struct adapter *padapter);
 
 s32	rtw_hal_init_recv_priv(struct adapter *padapter);
-- 
2.33.0

