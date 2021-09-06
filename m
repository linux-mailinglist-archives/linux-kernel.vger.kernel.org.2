Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D6A401FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245472AbhIFSzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbhIFSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AEBC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf2so15048986ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCUzF7n3QUF1nNR3jeQewitNVHMSh2p1GXrSnbO7b0c=;
        b=eCRvnbOugjRwcg7LKRDIQgV/TAZHE9yg+wnfLueJZqARViMlr0ugZ2Bxwy2tb3H6zQ
         pP59DYwCRwO8dxMMaN3AWnxkKOmpH2pDQLktWKr47gJsDEBznyQDKKFQnTLJwQZdnb5r
         TCK6j04wX5bpZuyosen37gIb0YqO6GQys5ecIW9HsMvXhQWfFa0mWihdh+jtpD1RuuCx
         XEdUsc4T9VgWIEmriXt8bAeLbPJm5y0ta18xdwssIuUfe/MWVjWHgcJ+z0WCdWLrAOmg
         JqKfSve3+M3do88OWtN5DISg9qo4XRdNvMxbRNfjLkMtNeXknjW1LRHrBZCf/I2Z7zyP
         IluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCUzF7n3QUF1nNR3jeQewitNVHMSh2p1GXrSnbO7b0c=;
        b=nN/CJ5QG8P6imXD3VKMnpP6h/1QZJKKcHOzxd3+dQigpZOmbDNIzVPM9IakOFml5RI
         GTvNUpwmwNEcNRJaIyhOhHLGEfzg/q4Cxg1jQAd+GSP1h8WE9YCrHo6ysFhI/lu6DzDV
         3AvmTVk+VX29FncBjsNsKt1SFu4fE7Z6kJA62Ffa7cUbuebd6rsDfO6/gzOGzXhlNXMx
         gXtyNY4uhbFfi3npapAVPq7gcs8T+OQsn1XQFB3lbCzPZoXrFhUJBjWnvSRCuaeU2m3q
         O6Qu9IjXz1Ckv/gkijnDfaTvHXbgH38KrxYrQFTrxempqbEiTs+jqIywOyfnzaZJgmN4
         b6sg==
X-Gm-Message-State: AOAM532fDgmV/B6aVGkpi/IsCvgWgvB2wHkeEJXZbgx/PsQ72w80niLJ
        k2mHIAo1rZBcDp1o6fdIf20=
X-Google-Smtp-Source: ABdhPJyBzmJM4vcKmxplHQurYA5ruf2Xip5p56XUFzlgfVvW3wS88TPvQ86yph+Efke0Clrmxiyz8Q==
X-Received: by 2002:a17:907:8309:: with SMTP id mq9mr14831065ejc.561.1630954452119;
        Mon, 06 Sep 2021 11:54:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 13/40] staging: r8188eu: remove Add_RateATid from hal_ops
Date:   Mon,  6 Sep 2021 20:53:00 +0200
Message-Id: <20210906185327.10326-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

