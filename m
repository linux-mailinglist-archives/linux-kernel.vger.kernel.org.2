Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79673401FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbhIFS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245004AbhIFSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7833C0617AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v5so10609415edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8j2ZRB4ao6UP+171+LDKHORW3G/O4Ani+xbmAGpa/c=;
        b=c94GZTBjpFuoxpzw6ohIS5qoJgyVkgCkQP80ubbd5aDb+ZJcukaAvzYece9wg3+cvP
         szp0+o8dKbcflGT+EOPf2lwUzF+V6wbVCmALNACmm62Sixv9b+T8DZZKCexR1+Oz/AVX
         GXZFvZ6g7QnuMD+pLnxVjUhmyNGBKf8xnF9apPIgKlJP+RgAdcYY0Y75+l1Xa7ussqBR
         wJb9Zn0pZ30GQJy0HU91duxPLo39BGD49xlrSVS8uMQcTZymrOGjFvk5zgAYuCCfd5df
         J6Sh8b6v5kKXEkmfZbUEHPAqw5BuASQQvdPuQ5+4/xy6cU+IFyOLvanHBcinH5K8s+Q+
         QOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8j2ZRB4ao6UP+171+LDKHORW3G/O4Ani+xbmAGpa/c=;
        b=CfpYKVVal6BZk3Od9BCaNAeZcuK1ciKL2iKT/vRBTpLjesztVuN9staSAzXCxUEj2P
         V79t2TMmj8+dYEa68++WB7BYwr0wdQCXSPzau3z/4/qkar9RbbQXCTNRPsUgyiHZx69n
         Vcy3Zfbv3yC9fGNDzrU6wFbDlM9bOrmJvg0f6SLi+uHbcCgulPcrwGOfVmFXDRsy/UEN
         MYVvxhJfM+RqTbqqmdJsrsNxPCqrMDb4tUPmtKJoKxqiVKMpDNM1rYq7nX6D39fcncTV
         E7yTo1J+tuJV27KQjGTjWxLhCS+pMheNV3gS58k5MmBZq4ojoBsmU9aqNM7KjG+IJAyZ
         dVhw==
X-Gm-Message-State: AOAM5338eyhBChFurIm6wnNPHI9YlIgalWwTawwpByhb+m7R90XcIwdz
        rLqm+NJ8ZZBal2rL497Jmys=
X-Google-Smtp-Source: ABdhPJyUqyf+//PhPmvIyHGgRtsQTzRuJx1lfExywwyTiP2L06EQg5XTA5Fop7xoUImsrDSoliTCNQ==
X-Received: by 2002:a50:f1c6:: with SMTP id y6mr14389301edl.354.1630954456610;
        Mon, 06 Sep 2021 11:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 19/40] staging: r8188eu: remove sreset_linked_status_check from hal_ops
Date:   Mon,  6 Sep 2021 20:53:06 +0200
Message-Id: <20210906185327.10326-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_linked_status_check from hal_ops and remove its wrapper
rtw_hal_sreset_linked_status_check().
Call rtl8188e_sreset_linked_status_check() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 3 ++-
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 57cf74d30984..2bdc1ed18149 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -10,6 +10,7 @@
 #include "../include/wlan_bssdef.h"
 #include "../include/mlme_osdep.h"
 #include "../include/recv_osdep.h"
+#include "../include/rtl8188e_sreset.h"
 
 static struct mlme_handler mlme_sta_tbl[] = {
 	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
@@ -7400,7 +7401,7 @@ void linked_status_chk(struct adapter *padapter)
 	if (padapter->bRxRSSIDisplay)
 		_linked_rx_signal_strehgth_display(padapter);
 
-	rtw_hal_sreset_linked_status_check(padapter);
+	rtl8188e_sreset_linked_status_check(padapter);
 
 	if (is_client_associated_to_ap(padapter)) {
 		/* linked infrastructure client mode */
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index b1a71a8fdf38..1840c4046859 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -221,12 +221,6 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
 }
 
-void rtw_hal_sreset_linked_status_check(struct adapter *adapt)
-{
-	if (adapt->HalFunc.sreset_linked_status_check)
-		adapt->HalFunc.sreset_linked_status_check(adapt);
-}
-
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *adapt)
 {
 	u8 status = 0;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 9b44fd2d93d7..0ee7da10633a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
 	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 2f4bc16aeabd..baa08d9346f9 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*sreset_linked_status_check) (struct adapter *padapter);
 	u8 (*sreset_get_wifi_status)(struct adapter *padapter);
 
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
@@ -270,7 +269,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
 
-void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
 
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
-- 
2.33.0

