Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90924402029
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbhIFTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhIFTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g21so10643745edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCUzF7n3QUF1nNR3jeQewitNVHMSh2p1GXrSnbO7b0c=;
        b=aKI2Y3Pp7BTg6O31hHW+qFAuQ+YO9LUTsSfkzUvoF4jpdlkQ4QlrVPQLcLSY3gncZR
         f4xywHNAvbZPiHsUUFBSki/wBqMeOVctK5Djke3VAjdF2fMtKZbXeb/r2RIsi/CRsrK1
         mQDokY5pDGfYXwN5TabSloJjsF5loeXIBQFhuOne2E+zn3qY9CvqjbLoozoXLPHCRIxW
         zGOTpIzpbhI5nqUFvTZvQW0Fr/yYLfsx35os2GCf+x75yxWh4locpFbBS8RwxEwGNQjh
         IuIB5FmbW8WfYnq8M3XwbS4sotsz56DS9k2EE6q2WGXy755y6GKf51xevTUZ0zA+8sfa
         QKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCUzF7n3QUF1nNR3jeQewitNVHMSh2p1GXrSnbO7b0c=;
        b=Q2vm8TpFFxeCab5wafiI8LHJ+ROezsxYeqg52GU5EtjCIojwG4GzSxKkf6UPJgvI1u
         AJSiyuiwQq7pUhfPSU/lH8wIfRpisfydOI+WhkGXBlLudSSjl+QFfMQYwoAAR3LAOn59
         +RL8FkLPHZP7OF/1192aDTCrpD/66vfQErybrsLWO3EN10e51hdvKB25BeledwT7OQYV
         rG5AROhfC+sXe6JDVHbIhF36kfjdgdpv9FEz2nvHSvwYQ5eogcX1nNT43iuGJ50HYYtV
         LvEM1d5EjlFbOMXPzsBs0Qdb1JPd4ecfj7nqlCmCHvHTWe3UDPWVYlGlo5S5gE7XYCDE
         tnUw==
X-Gm-Message-State: AOAM5312d00StydQAnGRxENgYprEsXkOdylERc49vQ9BZdVQZhut4f88
        hI7dJvj19pSxKnChfilU1mM=
X-Google-Smtp-Source: ABdhPJyvnmu81r3VKLS4lhq++tX1aXUpYHvvcQ46Noy/wcP8DMlT5V6G1VnuiB68bnCjdHyB5s3dCw==
X-Received: by 2002:aa7:de92:: with SMTP id j18mr14675992edv.141.1630954975012;
        Mon, 06 Sep 2021 12:02:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 13/40] staging: r8188eu: remove Add_RateATid from hal_ops
Date:   Mon,  6 Sep 2021 21:01:56 +0200
Message-Id: <20210906190223.11396-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Add_RateATid from hal_ops and remove its wrapper
rtw_hal_add_ra_tid(). Call rtl8188e_Add_RateATid() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c           | 5 +++--
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 --------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 3 ---
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index da8b5332b5e7..8e6b1964f533 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -7,6 +7,7 @@
 #include "../include/drv_types.h"
 #include "../include/wifi.h"
 #include "../include/ieee80211.h"
+#include "../include/rtl8188e_cmd.h"
 
 #ifdef CONFIG_88EU_AP_MODE
 
@@ -393,7 +394,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		/* bitmap[28:31]= Rate Adaptive id */
 		/* arg[0:4] = macid */
 		/* arg[5] = Short GI */
-		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
+		rtl8188e_Add_RateATid(padapter, tx_ra_bitmap, arg, rssi_level);
 
 		if (shortGIrate)
 			init_rate |= BIT(6);
@@ -467,7 +468,7 @@ void update_bmc_sta(struct adapter *padapter)
 			/* bitmap[28:31]= Rate Adaptive id */
 			/* arg[0:4] = macid */
 			/* arg[5] = Short GI */
-			rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, 0);
+			rtl8188e_Add_RateATid(padapter, tx_ra_bitmap, arg, 0);
 		}
 		/* set ra_id, init_rate */
 		psta->raid = raid;
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 79a2a5a0abd9..39b1a8711754 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -158,14 +158,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-void rtw_hal_add_ra_tid(struct adapter *adapt, u32 bitmap, u8 arg,
-			u8 rssi_level)
-{
-	if (adapt->HalFunc.Add_RateATid)
-		adapt->HalFunc.Add_RateATid(adapt, bitmap, arg,
-					       rssi_level);
-}
-
 /*	Start specifical interface thread		*/
 void rtw_hal_start_thread(struct adapter *adapt)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 4274b11e456c..0b14748e1346 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1784,7 +1784,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->Add_RateATid = &rtl8188e_Add_RateATid;
 	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3bf0d18e2ba8..9f804f9f5363 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -154,8 +154,6 @@ struct hal_ops {
 				       u32 mac_id, u8 rssi_level);
 	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
 
-	void	(*Add_RateATid)(struct adapter *adapter, u32 bitmap, u8 arg,
-				u8 rssi_level);
 	void	(*run_thread)(struct adapter *adapter);
 	void	(*cancel_thread)(struct adapter *adapter);
 
@@ -257,7 +255,6 @@ s32	rtw_hal_init_recv_priv(struct adapter *padapter);
 void	rtw_hal_free_recv_priv(struct adapter *padapter);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
-void	rtw_hal_add_ra_tid(struct adapter *adapt, u32 bitmap, u8 arg, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 void	rtw_hal_start_thread(struct adapter *padapter);
-- 
2.33.0

