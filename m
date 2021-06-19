Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9602F3AD99C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhFSKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhFSKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E6C061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so13702938wri.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkt2WWbVn+/Hh1EL4Radl4Tcgqu1MC2AccCD7qb5GzU=;
        b=uEh4vE2voQso19ina3tjQ3eILysqx6CNWt3mKh9W/IcLjAyKGrM1IvTUk7B45uWVBQ
         TAk1BM/ZVCXHdiebRny6qbjfTHWaHpSwvPigwkjYtHnp3EoxToSrRKu69qzNtR6RWMo/
         um1Zs18zFsbWEtV4aEu8fhZbvs6j3gRtqhowzfMYt0VZ0zzYR66jdyZLHCMjc4fC37AK
         od7VgVvY+lgZrB0uYwIuH9xiQr2bQrubxAbE0ywAk47d09y+nnnaKExm7iX4e6XSRrGg
         mNcmYsPOmRcPEBfm/BxBoc29jRi6QKHaEnr4olXlu22RYgSLN/zEomUBPeSV/bX6csRM
         b7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkt2WWbVn+/Hh1EL4Radl4Tcgqu1MC2AccCD7qb5GzU=;
        b=oQ+z0c9yd6+3puL41gkTLXVAAlPs35dEn0bRTMkrdPnJ/36/rM1tiN0j1tb6OgxuFy
         OyGSXIsQDiVuc30tN+1O6+AiyBKGOWZz+Uej0fBe0XIhVfnR/cPnIwPMKjH+Fkq3bOln
         00fSEwAKWYAE182ix6jw0rrSEruN4KNLg6/ynh26fXMtd2Hm+S0s72tKPfsMF0yxbLi2
         4cPYL+u39VnAMNsPcySysi6tvKyaLq4w6M6Ge2q7KWYpLxMxmCbbfeP/zZ8CymiGVKpi
         26M7S33hcYSHzLMKUaYYsDZiH5JNDxzFQs9KsZrj2Mf8vLufvLueUt/14tLLupkOO/8X
         pYgA==
X-Gm-Message-State: AOAM533NK/KV6P9WWO9LFWBJAy9Y+m6O6dP+nySZYyLU3RlCXSGP/++u
        NCSsui+1bXgk+zj4PhWCZd+ISyS753lzaA==
X-Google-Smtp-Source: ABdhPJzDJ6npXouMPTN0i0Dw7cRxTm1TUh7XlmW4FxaoPDFW7ejxqmHlJNCiqtG2/MVDoTeuMAcmyw==
X-Received: by 2002:adf:8bc7:: with SMTP id w7mr17957654wra.198.1624099653014;
        Sat, 19 Jun 2021 03:47:33 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id m5sm11402981wmg.32.2021.06.19.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] staging: rtl8723bs: remove all branchings between 2.4Ghz and 5Ghz band types
Date:   Sat, 19 Jun 2021 12:47:10 +0200
Message-Id: <eca2c976ca376cd5ebc53fc2a1e31ea0ebeb5cc1.1624099125.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all code branchings tied to dual band support. The device
works only on 2.4Ghz band so there's no need to check which
band we are on. Removed all code branches that would be valid
only for 5Ghz for it's dead code. Removed enums, table fields
indexing by band type, function arguments passing current
band type and all other thing related to telling us
which band we are on.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   |   4 +-
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   |   5 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |   1 -
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |  17 +-
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  | 518 +++++++------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   2 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   4 -
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 720 +++++-------------
 drivers/staging/rtl8723bs/hal/odm.c           |   8 -
 drivers/staging/rtl8723bs/hal/odm.h           |  11 -
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |   5 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.h        |   2 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |   1 -
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   6 +-
 .../rtl8723bs/include/hal_com_phycfg.h        |  10 +-
 drivers/staging/rtl8723bs/include/hal_data.h  |  34 +-
 drivers/staging/rtl8723bs/include/hal_phy.h   |   7 -
 17 files changed, 488 insertions(+), 867 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index adfdc4f14b08..dc58bb87f1b0 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2222,7 +2222,6 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	bool bRoam = false;
 	bool bScan = false;
 	bool bLink = false;
-	bool bWifiUnder5G = false;
 	bool bWifiUnderBMode = false;
 	bool bBtHsOn = false;
 	bool bWifiBusy = false;
@@ -2344,7 +2343,6 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_5G, &bWifiUnder5G);
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 	pBtCoexist->fBtcGet(
@@ -2358,7 +2356,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status",
-		(bWifiUnder5G ? "5G" : "2.4G"),
+		("2.4G"),
 		((bWifiUnderBMode) ? "11b" : ((wifiBw == BTC_WIFI_BW_LEGACY) ? "11bg" : (((wifiBw == BTC_WIFI_BW_HT40) ? "HT40" : "HT20")))),
 		((!bWifiBusy) ? "idle" : ((wifiTrafficDir == BTC_WIFI_TRAFFIC_TX) ? "uplink" : "downlink")),
 		pCoexSta->nScanAPNum,
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 3829701f10f9..84241619fb3a 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -2431,7 +2431,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	u8 *cliBuf = pBtCoexist->cliBuf;
 	u8 u1Tmp[4], i, btInfoExt, psTdmaCase = 0;
 	u32 u4Tmp[4];
-	bool bRoam = false, bScan = false, bLink = false, bWifiUnder5G = false;
+	bool bRoam = false, bScan = false, bLink = false;
 	bool bBtHsOn = false, bWifiBusy = false;
 	s32 wifiRssi = 0, btHsRssi = 0;
 	u32 wifiBw, wifiTrafficDir, faOfdm, faCck;
@@ -2522,7 +2522,6 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_5G, &bWifiUnder5G);
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_TRAFFIC_DIRECTION, &wifiTrafficDir);
@@ -2530,7 +2529,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s / %s/ %s ", "Wifi status", \
-		(bWifiUnder5G ? "5G" : "2.4G"),
+		("2.4G"),
 		((BTC_WIFI_BW_LEGACY == wifiBw) ? "Legacy" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20"))),
 		((!bWifiBusy) ? "idle" : ((BTC_WIFI_TRAFFIC_TX == wifiTrafficDir) ? "uplink" : "downlink"))
 	);
diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index db9d8a529877..deb57fa15eaf 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -142,7 +142,6 @@ enum {
 	BTC_GET_BL_WIFI_LINK,
 	BTC_GET_BL_WIFI_ROAM,
 	BTC_GET_BL_WIFI_4_WAY_PROGRESS,
-	BTC_GET_BL_WIFI_UNDER_5G,
 	BTC_GET_BL_WIFI_AP_MODE_ENABLE,
 	BTC_GET_BL_WIFI_ENABLE_ENCRYPTION,
 	BTC_GET_BL_WIFI_UNDER_B_MODE,
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
index 77b9c672ff0e..3de8dcb5ed7c 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
@@ -543,12 +543,12 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG(struct dm_odm_t *pDM_Odm)
 ******************************************************************************/
 
 static u32 Array_MP_8723B_PHY_REG_PG[] = {
-	0, 0, 0, 0x00000e08, 0x0000ff00, 0x00003800,
-	0, 0, 0, 0x0000086c, 0xffffff00, 0x32343600,
-	0, 0, 0, 0x00000e00, 0xffffffff, 0x40424444,
-	0, 0, 0, 0x00000e04, 0xffffffff, 0x28323638,
-	0, 0, 0, 0x00000e10, 0xffffffff, 0x38404244,
-	0, 0, 0, 0x00000e14, 0xffffffff, 0x26303436
+	0, 0, 0x00000e08, 0x0000ff00, 0x00003800,
+	0, 0, 0x0000086c, 0xffffff00, 0x32343600,
+	0, 0, 0x00000e00, 0xffffffff, 0x40424444,
+	0, 0, 0x00000e04, 0xffffffff, 0x28323638,
+	0, 0, 0x00000e10, 0xffffffff, 0x38404244,
+	0, 0, 0x00000e14, 0xffffffff, 0x26303436
 };
 
 void ODM_ReadAndConfig_MP_8723B_PHY_REG_PG(struct dm_odm_t *pDM_Odm)
@@ -559,14 +559,13 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG_PG(struct dm_odm_t *pDM_Odm)
 	pDM_Odm->PhyRegPgVersion = 1;
 	pDM_Odm->PhyRegPgValueType = PHY_REG_PG_EXACT_VALUE;
 
-	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_PHY_REG_PG); i += 6) {
+	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_PHY_REG_PG); i += 5) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
 		u32 v3 = Array[i+2];
 		u32 v4 = Array[i+3];
 		u32 v5 = Array[i+4];
-		u32 v6 = Array[i+5];
 
-		odm_ConfigBB_PHY_REG_PG_8723B(pDM_Odm, v1, v2, v3, v4, v5, v6);
+		odm_ConfigBB_PHY_REG_PG_8723B(pDM_Odm, v1, v2, v3, v4, v5);
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
index e7a6566f2a24..f49032dc5bef 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
@@ -445,258 +445,258 @@ void ODM_ReadAndConfig_MP_8723B_TxPowerTrack_SDIO(struct dm_odm_t *pDM_Odm)
 ******************************************************************************/
 
 static u8 *Array_MP_8723B_TXPWR_LMT[] = {
-	"FCC", "2.4G", "20M", "CCK", "1T", "01", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "01", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "01", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "02", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "02", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "02", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "03", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "03", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "03", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "04", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "04", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "04", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "05", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "05", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "05", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "06", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "06", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "06", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "07", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "07", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "07", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "08", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "08", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "08", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "09", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "09", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "09", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "10", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "10", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "10", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "11", "32",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "11", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "11", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "12", "63",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "12", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "12", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "13", "63",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "13", "32",
-	"MKK", "2.4G", "20M", "CCK", "1T", "13", "32",
-	"FCC", "2.4G", "20M", "CCK", "1T", "14", "63",
-	"ETSI", "2.4G", "20M", "CCK", "1T", "14", "63",
-	"MKK", "2.4G", "20M", "CCK", "1T", "14", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "01", "28",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "01", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "01", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "02", "28",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "02", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "02", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "03", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "03", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "03", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "04", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "04", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "04", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "05", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "05", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "05", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "06", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "06", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "06", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "07", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "07", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "07", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "08", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "08", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "08", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "09", "32",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "09", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "09", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "10", "28",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "10", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "10", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "11", "28",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "11", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "11", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "12", "63",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "12", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "12", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "13", "63",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "13", "32",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "13", "32",
-	"FCC", "2.4G", "20M", "OFDM", "1T", "14", "63",
-	"ETSI", "2.4G", "20M", "OFDM", "1T", "14", "63",
-	"MKK", "2.4G", "20M", "OFDM", "1T", "14", "63",
-	"FCC", "2.4G", "20M", "HT", "1T", "01", "26",
-	"ETSI", "2.4G", "20M", "HT", "1T", "01", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "01", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "02", "26",
-	"ETSI", "2.4G", "20M", "HT", "1T", "02", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "02", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "03", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "03", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "03", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "04", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "04", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "04", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "05", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "05", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "05", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "06", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "06", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "06", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "07", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "07", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "07", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "08", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "08", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "08", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "09", "32",
-	"ETSI", "2.4G", "20M", "HT", "1T", "09", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "09", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "10", "26",
-	"ETSI", "2.4G", "20M", "HT", "1T", "10", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "10", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "11", "26",
-	"ETSI", "2.4G", "20M", "HT", "1T", "11", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "11", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "12", "63",
-	"ETSI", "2.4G", "20M", "HT", "1T", "12", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "12", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "13", "63",
-	"ETSI", "2.4G", "20M", "HT", "1T", "13", "32",
-	"MKK", "2.4G", "20M", "HT", "1T", "13", "32",
-	"FCC", "2.4G", "20M", "HT", "1T", "14", "63",
-	"ETSI", "2.4G", "20M", "HT", "1T", "14", "63",
-	"MKK", "2.4G", "20M", "HT", "1T", "14", "63",
-	"FCC", "2.4G", "20M", "HT", "2T", "01", "30",
-	"ETSI", "2.4G", "20M", "HT", "2T", "01", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "01", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "02", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "02", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "02", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "03", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "03", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "03", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "04", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "04", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "04", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "05", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "05", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "05", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "06", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "06", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "06", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "07", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "07", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "07", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "08", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "08", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "08", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "09", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "09", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "09", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "10", "32",
-	"ETSI", "2.4G", "20M", "HT", "2T", "10", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "10", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "11", "30",
-	"ETSI", "2.4G", "20M", "HT", "2T", "11", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "11", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "12", "63",
-	"ETSI", "2.4G", "20M", "HT", "2T", "12", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "12", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "13", "63",
-	"ETSI", "2.4G", "20M", "HT", "2T", "13", "32",
-	"MKK", "2.4G", "20M", "HT", "2T", "13", "32",
-	"FCC", "2.4G", "20M", "HT", "2T", "14", "63",
-	"ETSI", "2.4G", "20M", "HT", "2T", "14", "63",
-	"MKK", "2.4G", "20M", "HT", "2T", "14", "63",
-	"FCC", "2.4G", "40M", "HT", "1T", "01", "63",
-	"ETSI", "2.4G", "40M", "HT", "1T", "01", "63",
-	"MKK", "2.4G", "40M", "HT", "1T", "01", "63",
-	"FCC", "2.4G", "40M", "HT", "1T", "02", "63",
-	"ETSI", "2.4G", "40M", "HT", "1T", "02", "63",
-	"MKK", "2.4G", "40M", "HT", "1T", "02", "63",
-	"FCC", "2.4G", "40M", "HT", "1T", "03", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "03", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "03", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "04", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "04", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "04", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "05", "32",
-	"ETSI", "2.4G", "40M", "HT", "1T", "05", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "05", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "06", "32",
-	"ETSI", "2.4G", "40M", "HT", "1T", "06", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "06", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "07", "32",
-	"ETSI", "2.4G", "40M", "HT", "1T", "07", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "07", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "08", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "08", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "08", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "09", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "09", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "09", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "10", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "10", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "10", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "11", "26",
-	"ETSI", "2.4G", "40M", "HT", "1T", "11", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "11", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "12", "63",
-	"ETSI", "2.4G", "40M", "HT", "1T", "12", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "12", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "13", "63",
-	"ETSI", "2.4G", "40M", "HT", "1T", "13", "32",
-	"MKK", "2.4G", "40M", "HT", "1T", "13", "32",
-	"FCC", "2.4G", "40M", "HT", "1T", "14", "63",
-	"ETSI", "2.4G", "40M", "HT", "1T", "14", "63",
-	"MKK", "2.4G", "40M", "HT", "1T", "14", "63",
-	"FCC", "2.4G", "40M", "HT", "2T", "01", "63",
-	"ETSI", "2.4G", "40M", "HT", "2T", "01", "63",
-	"MKK", "2.4G", "40M", "HT", "2T", "01", "63",
-	"FCC", "2.4G", "40M", "HT", "2T", "02", "63",
-	"ETSI", "2.4G", "40M", "HT", "2T", "02", "63",
-	"MKK", "2.4G", "40M", "HT", "2T", "02", "63",
-	"FCC", "2.4G", "40M", "HT", "2T", "03", "30",
-	"ETSI", "2.4G", "40M", "HT", "2T", "03", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "03", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "04", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "04", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "04", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "05", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "05", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "05", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "06", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "06", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "06", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "07", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "07", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "07", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "08", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "08", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "08", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "09", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "09", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "09", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "10", "32",
-	"ETSI", "2.4G", "40M", "HT", "2T", "10", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "10", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "11", "30",
-	"ETSI", "2.4G", "40M", "HT", "2T", "11", "30",
-	"MKK", "2.4G", "40M", "HT", "2T", "11", "30",
-	"FCC", "2.4G", "40M", "HT", "2T", "12", "63",
-	"ETSI", "2.4G", "40M", "HT", "2T", "12", "32",
-	"MKK", "2.4G", "40M", "HT", "2T", "12", "32",
-	"FCC", "2.4G", "40M", "HT", "2T", "13", "63",
-	"ETSI", "2.4G", "40M", "HT", "2T", "13", "32",
-	"MKK", "2.4G", "40M", "HT", "2T", "13", "32",
-	"FCC", "2.4G", "40M", "HT", "2T", "14", "63",
-	"ETSI", "2.4G", "40M", "HT", "2T", "14", "63",
-	"MKK", "2.4G", "40M", "HT", "2T", "14", "63"
+	"FCC", "20M", "CCK", "1T", "01", "32",
+	"ETSI", "20M", "CCK", "1T", "01", "32",
+	"MKK", "20M", "CCK", "1T", "01", "32",
+	"FCC", "20M", "CCK", "1T", "02", "32",
+	"ETSI", "20M", "CCK", "1T", "02", "32",
+	"MKK", "20M", "CCK", "1T", "02", "32",
+	"FCC", "20M", "CCK", "1T", "03", "32",
+	"ETSI", "20M", "CCK", "1T", "03", "32",
+	"MKK", "20M", "CCK", "1T", "03", "32",
+	"FCC", "20M", "CCK", "1T", "04", "32",
+	"ETSI", "20M", "CCK", "1T", "04", "32",
+	"MKK", "20M", "CCK", "1T", "04", "32",
+	"FCC", "20M", "CCK", "1T", "05", "32",
+	"ETSI", "20M", "CCK", "1T", "05", "32",
+	"MKK", "20M", "CCK", "1T", "05", "32",
+	"FCC", "20M", "CCK", "1T", "06", "32",
+	"ETSI", "20M", "CCK", "1T", "06", "32",
+	"MKK", "20M", "CCK", "1T", "06", "32",
+	"FCC", "20M", "CCK", "1T", "07", "32",
+	"ETSI", "20M", "CCK", "1T", "07", "32",
+	"MKK", "20M", "CCK", "1T", "07", "32",
+	"FCC", "20M", "CCK", "1T", "08", "32",
+	"ETSI", "20M", "CCK", "1T", "08", "32",
+	"MKK", "20M", "CCK", "1T", "08", "32",
+	"FCC", "20M", "CCK", "1T", "09", "32",
+	"ETSI", "20M", "CCK", "1T", "09", "32",
+	"MKK", "20M", "CCK", "1T", "09", "32",
+	"FCC", "20M", "CCK", "1T", "10", "32",
+	"ETSI", "20M", "CCK", "1T", "10", "32",
+	"MKK", "20M", "CCK", "1T", "10", "32",
+	"FCC", "20M", "CCK", "1T", "11", "32",
+	"ETSI", "20M", "CCK", "1T", "11", "32",
+	"MKK", "20M", "CCK", "1T", "11", "32",
+	"FCC", "20M", "CCK", "1T", "12", "63",
+	"ETSI", "20M", "CCK", "1T", "12", "32",
+	"MKK", "20M", "CCK", "1T", "12", "32",
+	"FCC", "20M", "CCK", "1T", "13", "63",
+	"ETSI", "20M", "CCK", "1T", "13", "32",
+	"MKK", "20M", "CCK", "1T", "13", "32",
+	"FCC", "20M", "CCK", "1T", "14", "63",
+	"ETSI", "20M", "CCK", "1T", "14", "63",
+	"MKK", "20M", "CCK", "1T", "14", "32",
+	"FCC", "20M", "OFDM", "1T", "01", "28",
+	"ETSI", "20M", "OFDM", "1T", "01", "32",
+	"MKK", "20M", "OFDM", "1T", "01", "32",
+	"FCC", "20M", "OFDM", "1T", "02", "28",
+	"ETSI", "20M", "OFDM", "1T", "02", "32",
+	"MKK", "20M", "OFDM", "1T", "02", "32",
+	"FCC", "20M", "OFDM", "1T", "03", "32",
+	"ETSI", "20M", "OFDM", "1T", "03", "32",
+	"MKK", "20M", "OFDM", "1T", "03", "32",
+	"FCC", "20M", "OFDM", "1T", "04", "32",
+	"ETSI", "20M", "OFDM", "1T", "04", "32",
+	"MKK", "20M", "OFDM", "1T", "04", "32",
+	"FCC", "20M", "OFDM", "1T", "05", "32",
+	"ETSI", "20M", "OFDM", "1T", "05", "32",
+	"MKK", "20M", "OFDM", "1T", "05", "32",
+	"FCC", "20M", "OFDM", "1T", "06", "32",
+	"ETSI", "20M", "OFDM", "1T", "06", "32",
+	"MKK", "20M", "OFDM", "1T", "06", "32",
+	"FCC", "20M", "OFDM", "1T", "07", "32",
+	"ETSI", "20M", "OFDM", "1T", "07", "32",
+	"MKK", "20M", "OFDM", "1T", "07", "32",
+	"FCC", "20M", "OFDM", "1T", "08", "32",
+	"ETSI", "20M", "OFDM", "1T", "08", "32",
+	"MKK", "20M", "OFDM", "1T", "08", "32",
+	"FCC", "20M", "OFDM", "1T", "09", "32",
+	"ETSI", "20M", "OFDM", "1T", "09", "32",
+	"MKK", "20M", "OFDM", "1T", "09", "32",
+	"FCC", "20M", "OFDM", "1T", "10", "28",
+	"ETSI", "20M", "OFDM", "1T", "10", "32",
+	"MKK", "20M", "OFDM", "1T", "10", "32",
+	"FCC", "20M", "OFDM", "1T", "11", "28",
+	"ETSI", "20M", "OFDM", "1T", "11", "32",
+	"MKK", "20M", "OFDM", "1T", "11", "32",
+	"FCC", "20M", "OFDM", "1T", "12", "63",
+	"ETSI", "20M", "OFDM", "1T", "12", "32",
+	"MKK", "20M", "OFDM", "1T", "12", "32",
+	"FCC", "20M", "OFDM", "1T", "13", "63",
+	"ETSI", "20M", "OFDM", "1T", "13", "32",
+	"MKK", "20M", "OFDM", "1T", "13", "32",
+	"FCC", "20M", "OFDM", "1T", "14", "63",
+	"ETSI", "20M", "OFDM", "1T", "14", "63",
+	"MKK", "20M", "OFDM", "1T", "14", "63",
+	"FCC", "20M", "HT", "1T", "01", "26",
+	"ETSI", "20M", "HT", "1T", "01", "32",
+	"MKK", "20M", "HT", "1T", "01", "32",
+	"FCC", "20M", "HT", "1T", "02", "26",
+	"ETSI", "20M", "HT", "1T", "02", "32",
+	"MKK", "20M", "HT", "1T", "02", "32",
+	"FCC", "20M", "HT", "1T", "03", "32",
+	"ETSI", "20M", "HT", "1T", "03", "32",
+	"MKK", "20M", "HT", "1T", "03", "32",
+	"FCC", "20M", "HT", "1T", "04", "32",
+	"ETSI", "20M", "HT", "1T", "04", "32",
+	"MKK", "20M", "HT", "1T", "04", "32",
+	"FCC", "20M", "HT", "1T", "05", "32",
+	"ETSI", "20M", "HT", "1T", "05", "32",
+	"MKK", "20M", "HT", "1T", "05", "32",
+	"FCC", "20M", "HT", "1T", "06", "32",
+	"ETSI", "20M", "HT", "1T", "06", "32",
+	"MKK", "20M", "HT", "1T", "06", "32",
+	"FCC", "20M", "HT", "1T", "07", "32",
+	"ETSI", "20M", "HT", "1T", "07", "32",
+	"MKK", "20M", "HT", "1T", "07", "32",
+	"FCC", "20M", "HT", "1T", "08", "32",
+	"ETSI", "20M", "HT", "1T", "08", "32",
+	"MKK", "20M", "HT", "1T", "08", "32",
+	"FCC", "20M", "HT", "1T", "09", "32",
+	"ETSI", "20M", "HT", "1T", "09", "32",
+	"MKK", "20M", "HT", "1T", "09", "32",
+	"FCC", "20M", "HT", "1T", "10", "26",
+	"ETSI", "20M", "HT", "1T", "10", "32",
+	"MKK", "20M", "HT", "1T", "10", "32",
+	"FCC", "20M", "HT", "1T", "11", "26",
+	"ETSI", "20M", "HT", "1T", "11", "32",
+	"MKK", "20M", "HT", "1T", "11", "32",
+	"FCC", "20M", "HT", "1T", "12", "63",
+	"ETSI", "20M", "HT", "1T", "12", "32",
+	"MKK", "20M", "HT", "1T", "12", "32",
+	"FCC", "20M", "HT", "1T", "13", "63",
+	"ETSI", "20M", "HT", "1T", "13", "32",
+	"MKK", "20M", "HT", "1T", "13", "32",
+	"FCC", "20M", "HT", "1T", "14", "63",
+	"ETSI", "20M", "HT", "1T", "14", "63",
+	"MKK", "20M", "HT", "1T", "14", "63",
+	"FCC", "20M", "HT", "2T", "01", "30",
+	"ETSI", "20M", "HT", "2T", "01", "32",
+	"MKK", "20M", "HT", "2T", "01", "32",
+	"FCC", "20M", "HT", "2T", "02", "32",
+	"ETSI", "20M", "HT", "2T", "02", "32",
+	"MKK", "20M", "HT", "2T", "02", "32",
+	"FCC", "20M", "HT", "2T", "03", "32",
+	"ETSI", "20M", "HT", "2T", "03", "32",
+	"MKK", "20M", "HT", "2T", "03", "32",
+	"FCC", "20M", "HT", "2T", "04", "32",
+	"ETSI", "20M", "HT", "2T", "04", "32",
+	"MKK", "20M", "HT", "2T", "04", "32",
+	"FCC", "20M", "HT", "2T", "05", "32",
+	"ETSI", "20M", "HT", "2T", "05", "32",
+	"MKK", "20M", "HT", "2T", "05", "32",
+	"FCC", "20M", "HT", "2T", "06", "32",
+	"ETSI", "20M", "HT", "2T", "06", "32",
+	"MKK", "20M", "HT", "2T", "06", "32",
+	"FCC", "20M", "HT", "2T", "07", "32",
+	"ETSI", "20M", "HT", "2T", "07", "32",
+	"MKK", "20M", "HT", "2T", "07", "32",
+	"FCC", "20M", "HT", "2T", "08", "32",
+	"ETSI", "20M", "HT", "2T", "08", "32",
+	"MKK", "20M", "HT", "2T", "08", "32",
+	"FCC", "20M", "HT", "2T", "09", "32",
+	"ETSI", "20M", "HT", "2T", "09", "32",
+	"MKK", "20M", "HT", "2T", "09", "32",
+	"FCC", "20M", "HT", "2T", "10", "32",
+	"ETSI", "20M", "HT", "2T", "10", "32",
+	"MKK", "20M", "HT", "2T", "10", "32",
+	"FCC", "20M", "HT", "2T", "11", "30",
+	"ETSI", "20M", "HT", "2T", "11", "32",
+	"MKK", "20M", "HT", "2T", "11", "32",
+	"FCC", "20M", "HT", "2T", "12", "63",
+	"ETSI", "20M", "HT", "2T", "12", "32",
+	"MKK", "20M", "HT", "2T", "12", "32",
+	"FCC", "20M", "HT", "2T", "13", "63",
+	"ETSI", "20M", "HT", "2T", "13", "32",
+	"MKK", "20M", "HT", "2T", "13", "32",
+	"FCC", "20M", "HT", "2T", "14", "63",
+	"ETSI", "20M", "HT", "2T", "14", "63",
+	"MKK", "20M", "HT", "2T", "14", "63",
+	"FCC", "40M", "HT", "1T", "01", "63",
+	"ETSI", "40M", "HT", "1T", "01", "63",
+	"MKK", "40M", "HT", "1T", "01", "63",
+	"FCC", "40M", "HT", "1T", "02", "63",
+	"ETSI", "40M", "HT", "1T", "02", "63",
+	"MKK", "40M", "HT", "1T", "02", "63",
+	"FCC", "40M", "HT", "1T", "03", "26",
+	"ETSI", "40M", "HT", "1T", "03", "32",
+	"MKK", "40M", "HT", "1T", "03", "32",
+	"FCC", "40M", "HT", "1T", "04", "26",
+	"ETSI", "40M", "HT", "1T", "04", "32",
+	"MKK", "40M", "HT", "1T", "04", "32",
+	"FCC", "40M", "HT", "1T", "05", "32",
+	"ETSI", "40M", "HT", "1T", "05", "32",
+	"MKK", "40M", "HT", "1T", "05", "32",
+	"FCC", "40M", "HT", "1T", "06", "32",
+	"ETSI", "40M", "HT", "1T", "06", "32",
+	"MKK", "40M", "HT", "1T", "06", "32",
+	"FCC", "40M", "HT", "1T", "07", "32",
+	"ETSI", "40M", "HT", "1T", "07", "32",
+	"MKK", "40M", "HT", "1T", "07", "32",
+	"FCC", "40M", "HT", "1T", "08", "26",
+	"ETSI", "40M", "HT", "1T", "08", "32",
+	"MKK", "40M", "HT", "1T", "08", "32",
+	"FCC", "40M", "HT", "1T", "09", "26",
+	"ETSI", "40M", "HT", "1T", "09", "32",
+	"MKK", "40M", "HT", "1T", "09", "32",
+	"FCC", "40M", "HT", "1T", "10", "26",
+	"ETSI", "40M", "HT", "1T", "10", "32",
+	"MKK", "40M", "HT", "1T", "10", "32",
+	"FCC", "40M", "HT", "1T", "11", "26",
+	"ETSI", "40M", "HT", "1T", "11", "32",
+	"MKK", "40M", "HT", "1T", "11", "32",
+	"FCC", "40M", "HT", "1T", "12", "63",
+	"ETSI", "40M", "HT", "1T", "12", "32",
+	"MKK", "40M", "HT", "1T", "12", "32",
+	"FCC", "40M", "HT", "1T", "13", "63",
+	"ETSI", "40M", "HT", "1T", "13", "32",
+	"MKK", "40M", "HT", "1T", "13", "32",
+	"FCC", "40M", "HT", "1T", "14", "63",
+	"ETSI", "40M", "HT", "1T", "14", "63",
+	"MKK", "40M", "HT", "1T", "14", "63",
+	"FCC", "40M", "HT", "2T", "01", "63",
+	"ETSI", "40M", "HT", "2T", "01", "63",
+	"MKK", "40M", "HT", "2T", "01", "63",
+	"FCC", "40M", "HT", "2T", "02", "63",
+	"ETSI", "40M", "HT", "2T", "02", "63",
+	"MKK", "40M", "HT", "2T", "02", "63",
+	"FCC", "40M", "HT", "2T", "03", "30",
+	"ETSI", "40M", "HT", "2T", "03", "30",
+	"MKK", "40M", "HT", "2T", "03", "30",
+	"FCC", "40M", "HT", "2T", "04", "32",
+	"ETSI", "40M", "HT", "2T", "04", "30",
+	"MKK", "40M", "HT", "2T", "04", "30",
+	"FCC", "40M", "HT", "2T", "05", "32",
+	"ETSI", "40M", "HT", "2T", "05", "30",
+	"MKK", "40M", "HT", "2T", "05", "30",
+	"FCC", "40M", "HT", "2T", "06", "32",
+	"ETSI", "40M", "HT", "2T", "06", "30",
+	"MKK", "40M", "HT", "2T", "06", "30",
+	"FCC", "40M", "HT", "2T", "07", "32",
+	"ETSI", "40M", "HT", "2T", "07", "30",
+	"MKK", "40M", "HT", "2T", "07", "30",
+	"FCC", "40M", "HT", "2T", "08", "32",
+	"ETSI", "40M", "HT", "2T", "08", "30",
+	"MKK", "40M", "HT", "2T", "08", "30",
+	"FCC", "40M", "HT", "2T", "09", "32",
+	"ETSI", "40M", "HT", "2T", "09", "30",
+	"MKK", "40M", "HT", "2T", "09", "30",
+	"FCC", "40M", "HT", "2T", "10", "32",
+	"ETSI", "40M", "HT", "2T", "10", "30",
+	"MKK", "40M", "HT", "2T", "10", "30",
+	"FCC", "40M", "HT", "2T", "11", "30",
+	"ETSI", "40M", "HT", "2T", "11", "30",
+	"MKK", "40M", "HT", "2T", "11", "30",
+	"FCC", "40M", "HT", "2T", "12", "63",
+	"ETSI", "40M", "HT", "2T", "12", "32",
+	"MKK", "40M", "HT", "2T", "12", "32",
+	"FCC", "40M", "HT", "2T", "13", "63",
+	"ETSI", "40M", "HT", "2T", "13", "32",
+	"MKK", "40M", "HT", "2T", "13", "32",
+	"FCC", "40M", "HT", "2T", "14", "63",
+	"ETSI", "40M", "HT", "2T", "14", "63",
+	"MKK", "40M", "HT", "2T", "14", "63"
 };
 
 void ODM_ReadAndConfig_MP_8723B_TXPWR_LMT(struct dm_odm_t *pDM_Odm)
@@ -704,19 +704,17 @@ void ODM_ReadAndConfig_MP_8723B_TXPWR_LMT(struct dm_odm_t *pDM_Odm)
 	u32 i = 0;
 	u8 **Array = Array_MP_8723B_TXPWR_LMT;
 
-	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_TXPWR_LMT); i += 7) {
+	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_TXPWR_LMT); i += 6) {
 		u8 *regulation = Array[i];
-		u8 *band = Array[i+1];
-		u8 *bandwidth = Array[i+2];
-		u8 *rate = Array[i+3];
-		u8 *rfPath = Array[i+4];
-		u8 *chnl = Array[i+5];
-		u8 *val = Array[i+6];
+		u8 *bandwidth = Array[i+1];
+		u8 *rate = Array[i+2];
+		u8 *rfPath = Array[i+3];
+		u8 *chnl = Array[i+4];
+		u8 *val = Array[i+5];
 
 		odm_ConfigBB_TXPWR_LMT_8723B(
 			pDM_Odm,
 			regulation,
-			band,
 			bandwidth,
 			rate,
 			rfPath,
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 1b0f47b58110..9fa91023abfd 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -69,7 +69,7 @@ static void setIqkMatrix_8723B(
 	ele_D = (OFDMSwingTable_New[OFDM_index] & 0xFFC00000)>>22;
 
 	/* new element A = element D x X */
-	if ((IqkResult_X != 0) && (*(pDM_Odm->pBandType) == ODM_BAND_2_4G)) {
+	if (IqkResult_X != 0) {
 		if ((IqkResult_X & 0x00000200) != 0)	/* consider minus */
 			IqkResult_X = IqkResult_X | 0xFFFFFC00;
 		ele_A = ((IqkResult_X * ele_D)>>8)&0x000003FF;
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index da545c4eaac0..3b0573885dce 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -368,10 +368,6 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 		*pu8 = false;
 		break;
 
-	case BTC_GET_BL_WIFI_UNDER_5G:
-		*pu8 = pHalData->CurrentBandType == 1;
-		break;
-
 	case BTC_GET_BL_WIFI_AP_MODE_ENABLE:
 		*pu8 = check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE);
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 56e657d2aaac..732659a2d844 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -11,7 +11,7 @@
 #include <hal_data.h>
 #include <linux/kernel.h>
 
-u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
+u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 			    u8 TxNum, enum rate_section RateSection)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
@@ -20,73 +20,39 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 	if (RfPath > ODM_RF_PATH_D)
 		return 0;
 
-	if (Band == BAND_ON_2_4G) {
-		switch (RateSection) {
-		case CCK:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0];
-			break;
-		case OFDM:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1];
-			break;
-		case HT_MCS0_MCS7:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2];
-			break;
-		case HT_MCS8_MCS15:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3];
-			break;
-		case HT_MCS16_MCS23:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4];
-			break;
-		case HT_MCS24_MCS31:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
-			break;
-		case VHT_1SSMCS0_1SSMCS9:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6];
-			break;
-		case VHT_2SSMCS0_2SSMCS9:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7];
-			break;
-		case VHT_3SSMCS0_3SSMCS9:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8];
-			break;
-		case VHT_4SSMCS0_4SSMCS9:
-			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
-			break;
-		default:
-			break;
-		}
-	} else if (Band == BAND_ON_5G) {
-		switch (RateSection) {
-		case OFDM:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][0];
-			break;
-		case HT_MCS0_MCS7:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][1];
-			break;
-		case HT_MCS8_MCS15:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][2];
-			break;
-		case HT_MCS16_MCS23:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][3];
-			break;
-		case HT_MCS24_MCS31:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][4];
-			break;
-		case VHT_1SSMCS0_1SSMCS9:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][5];
-			break;
-		case VHT_2SSMCS0_2SSMCS9:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][6];
-			break;
-		case VHT_3SSMCS0_3SSMCS9:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][7];
-			break;
-		case VHT_4SSMCS0_4SSMCS9:
-			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][8];
-			break;
-		default:
-			break;
-		}
+	switch (RateSection) {
+	case CCK:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0];
+		break;
+	case OFDM:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1];
+		break;
+	case HT_MCS0_MCS7:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2];
+		break;
+	case HT_MCS8_MCS15:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3];
+		break;
+	case HT_MCS16_MCS23:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4];
+		break;
+	case HT_MCS24_MCS31:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
+		break;
+	case VHT_1SSMCS0_1SSMCS9:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6];
+		break;
+	case VHT_2SSMCS0_2SSMCS9:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7];
+		break;
+	case VHT_3SSMCS0_3SSMCS9:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8];
+		break;
+	case VHT_4SSMCS0_4SSMCS9:
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
+		break;
+	default:
+		break;
 	}
 
 	return value;
@@ -95,7 +61,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 static void
 phy_SetTxPowerByRateBase(
 	struct adapter *Adapter,
-	u8 Band,
 	u8 RfPath,
 	enum rate_section	RateSection,
 	u8 TxNum,
@@ -107,73 +72,39 @@ phy_SetTxPowerByRateBase(
 	if (RfPath > ODM_RF_PATH_D)
 		return;
 
-	if (Band == BAND_ON_2_4G) {
-		switch (RateSection) {
-		case CCK:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0] = Value;
-			break;
-		case OFDM:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1] = Value;
-			break;
-		case HT_MCS0_MCS7:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2] = Value;
-			break;
-		case HT_MCS8_MCS15:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3] = Value;
-			break;
-		case HT_MCS16_MCS23:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4] = Value;
-			break;
-		case HT_MCS24_MCS31:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
-			break;
-		case VHT_1SSMCS0_1SSMCS9:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6] = Value;
-			break;
-		case VHT_2SSMCS0_2SSMCS9:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7] = Value;
-			break;
-		case VHT_3SSMCS0_3SSMCS9:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8] = Value;
-			break;
-		case VHT_4SSMCS0_4SSMCS9:
-			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
-			break;
-		default:
-			break;
-		}
-	} else if (Band == BAND_ON_5G) {
-		switch (RateSection) {
-		case OFDM:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][0] = Value;
-			break;
-		case HT_MCS0_MCS7:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][1] = Value;
-			break;
-		case HT_MCS8_MCS15:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][2] = Value;
-			break;
-		case HT_MCS16_MCS23:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][3] = Value;
-			break;
-		case HT_MCS24_MCS31:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][4] = Value;
-			break;
-		case VHT_1SSMCS0_1SSMCS9:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][5] = Value;
-			break;
-		case VHT_2SSMCS0_2SSMCS9:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][6] = Value;
-			break;
-		case VHT_3SSMCS0_3SSMCS9:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][7] = Value;
-			break;
-		case VHT_4SSMCS0_4SSMCS9:
-			pHalData->TxPwrByRateBase5G[RfPath][TxNum][8] = Value;
-			break;
-		default:
-			break;
-		}
+	switch (RateSection) {
+	case CCK:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0] = Value;
+		break;
+	case OFDM:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1] = Value;
+		break;
+	case HT_MCS0_MCS7:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2] = Value;
+		break;
+	case HT_MCS8_MCS15:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3] = Value;
+		break;
+	case HT_MCS16_MCS23:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4] = Value;
+		break;
+	case HT_MCS24_MCS31:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
+		break;
+	case VHT_1SSMCS0_1SSMCS9:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6] = Value;
+		break;
+	case VHT_2SSMCS0_2SSMCS9:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7] = Value;
+		break;
+	case VHT_3SSMCS0_3SSMCS9:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8] = Value;
+		break;
+	case VHT_4SSMCS0_4SSMCS9:
+		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
+		break;
+	default:
+		break;
 	}
 }
 
@@ -185,50 +116,29 @@ struct adapter *padapter
 	u8 path, base;
 
 	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_B; ++path) {
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_11M);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, CCK, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_54M);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, OFDM, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_11M);
+		phy_SetTxPowerByRateBase(padapter, path, CCK, RF_1TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS0_MCS7, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_54M);
+		phy_SetTxPowerByRateBase(padapter, path, OFDM, RF_1TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_2TX, MGN_MCS15);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS8_MCS15, RF_2TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_MCS7);
+		phy_SetTxPowerByRateBase(padapter, path, HT_MCS0_MCS7, RF_1TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_3TX, MGN_MCS23);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS16_MCS23, RF_3TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_MCS15);
+		phy_SetTxPowerByRateBase(padapter, path, HT_MCS8_MCS15, RF_2TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_VHT1SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_MCS23);
+		phy_SetTxPowerByRateBase(padapter, path, HT_MCS16_MCS23, RF_3TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_2TX, MGN_VHT2SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_VHT1SS_MCS7);
+		phy_SetTxPowerByRateBase(padapter, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_3TX, MGN_VHT3SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_VHT2SS_MCS7);
+		phy_SetTxPowerByRateBase(padapter, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_54M);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, OFDM, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS0_MCS7, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_2TX, MGN_MCS15);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS8_MCS15, RF_2TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_3TX, MGN_MCS23);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS16_MCS23, RF_3TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_VHT1SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_2TX, MGN_VHT2SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_3TX, MGN_VHT2SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_VHT3SS_MCS7);
+		phy_SetTxPowerByRateBase(padapter, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
 	}
 }
 
@@ -687,7 +597,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 
 static void PHY_StoreTxPowerByRateNew(
 	struct adapter *padapter,
-	u32	Band,
 	u32	RfPath,
 	u32	TxNum,
 	u32	RegAddr,
@@ -701,9 +610,6 @@ static void PHY_StoreTxPowerByRateNew(
 
 	PHY_GetRateValuesOfTxPowerByRate(padapter, RegAddr, BitMask, Data, rateIndex, PwrByRateVal, &rateNum);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
-		return;
-
 	if (RfPath > ODM_RF_PATH_D)
 		return;
 
@@ -715,7 +621,7 @@ static void PHY_StoreTxPowerByRateNew(
 			 rateIndex[i] == PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS1))
 			TxNum = RF_2TX;
 
-		pHalData->TxPwrByRateOffset[Band][RfPath][TxNum][rateIndex[i]] = PwrByRateVal[i];
+		pHalData->TxPwrByRateOffset[RfPath][TxNum][rateIndex[i]] = PwrByRateVal[i];
 	}
 }
 
@@ -732,18 +638,16 @@ static void PHY_StoreTxPowerByRateOld(
 void PHY_InitTxPowerByRate(struct adapter *padapter)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
-	u8 band, rfPath, TxNum, rate;
+	u8 rfPath, TxNum, rate;
 
-	for (band = BAND_ON_2_4G; band <= BAND_ON_5G; ++band)
-			for (rfPath = 0; rfPath < TX_PWR_BY_RATE_NUM_RF; ++rfPath)
-				for (TxNum = 0; TxNum < TX_PWR_BY_RATE_NUM_RF; ++TxNum)
-					for (rate = 0; rate < TX_PWR_BY_RATE_NUM_RATE; ++rate)
-						pHalData->TxPwrByRateOffset[band][rfPath][TxNum][rate] = 0;
+	for (rfPath = 0; rfPath < TX_PWR_BY_RATE_NUM_RF; ++rfPath)
+		for (TxNum = 0; TxNum < TX_PWR_BY_RATE_NUM_RF; ++TxNum)
+			for (rate = 0; rate < TX_PWR_BY_RATE_NUM_RATE; ++rate)
+				pHalData->TxPwrByRateOffset[rfPath][TxNum][rate] = 0;
 }
 
 void PHY_StoreTxPowerByRate(
 	struct adapter *padapter,
-	u32	Band,
 	u32	RfPath,
 	u32	TxNum,
 	u32	RegAddr,
@@ -755,7 +659,7 @@ void PHY_StoreTxPowerByRate(
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
 	if (pDM_Odm->PhyRegPgVersion > 0)
-		PHY_StoreTxPowerByRateNew(padapter, Band, RfPath, TxNum, RegAddr, BitMask, Data);
+		PHY_StoreTxPowerByRateNew(padapter, RfPath, TxNum, RegAddr, BitMask, Data);
 	else if (pDM_Odm->PhyRegPgVersion == 0) {
 		PHY_StoreTxPowerByRateOld(padapter, RegAddr, BitMask, Data);
 
@@ -771,7 +675,7 @@ phy_ConvertTxPowerByRateInDbmToRelativeValues(
 struct adapter *padapter
 	)
 {
-	u8	base = 0, i = 0, value = 0, band = 0, path = 0, txNum = 0;
+	u8	base = 0, i = 0, value = 0, path = 0, txNum = 0;
 	u8	cckRates[4] = {
 		MGN_1M, MGN_2M, MGN_5_5M, MGN_11M
 	};
@@ -800,64 +704,62 @@ struct adapter *padapter
 		MGN_VHT3SS_MCS5, MGN_VHT3SS_MCS6, MGN_VHT3SS_MCS7, MGN_VHT3SS_MCS8, MGN_VHT3SS_MCS9
 	};
 
-	for (band = BAND_ON_2_4G; band <= BAND_ON_5G; ++band) {
-		for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
-			for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
-				/*  CCK */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_11M);
-				for (i = 0; i < ARRAY_SIZE(cckRates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, cckRates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, cckRates[i], value - base);
-				}
+	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
+		for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
+			/*  CCK */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_11M);
+			for (i = 0; i < ARRAY_SIZE(cckRates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, cckRates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, cckRates[i], value - base);
+			}
 
-				/*  OFDM */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_54M);
-				for (i = 0; i < sizeof(ofdmRates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, ofdmRates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, ofdmRates[i], value - base);
-				}
+			/*  OFDM */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_54M);
+			for (i = 0; i < sizeof(ofdmRates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, ofdmRates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, ofdmRates[i], value - base);
+			}
 
-				/*  HT MCS0~7 */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_MCS7);
-				for (i = 0; i < sizeof(mcs0_7Rates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, mcs0_7Rates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, mcs0_7Rates[i], value - base);
-				}
+			/*  HT MCS0~7 */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS7);
+			for (i = 0; i < sizeof(mcs0_7Rates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs0_7Rates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, mcs0_7Rates[i], value - base);
+			}
 
-				/*  HT MCS8~15 */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_MCS15);
-				for (i = 0; i < sizeof(mcs8_15Rates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, mcs8_15Rates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, mcs8_15Rates[i], value - base);
-				}
+			/*  HT MCS8~15 */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS15);
+			for (i = 0; i < sizeof(mcs8_15Rates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs8_15Rates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, mcs8_15Rates[i], value - base);
+			}
 
-				/*  HT MCS16~23 */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_MCS23);
-				for (i = 0; i < sizeof(mcs16_23Rates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, mcs16_23Rates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, mcs16_23Rates[i], value - base);
-				}
+			/*  HT MCS16~23 */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS23);
+			for (i = 0; i < sizeof(mcs16_23Rates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i], value - base);
+			}
 
-				/*  VHT 1SS */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_VHT1SS_MCS7);
-				for (i = 0; i < sizeof(vht1ssRates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, vht1ssRates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, vht1ssRates[i], value - base);
-				}
+			/*  VHT 1SS */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT1SS_MCS7);
+			for (i = 0; i < sizeof(vht1ssRates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht1ssRates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, vht1ssRates[i], value - base);
+			}
 
-				/*  VHT 2SS */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_VHT2SS_MCS7);
-				for (i = 0; i < sizeof(vht2ssRates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, vht2ssRates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, vht2ssRates[i], value - base);
-				}
+			/*  VHT 2SS */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT2SS_MCS7);
+			for (i = 0; i < sizeof(vht2ssRates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht2ssRates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, vht2ssRates[i], value - base);
+			}
 
-				/*  VHT 3SS */
-				base = PHY_GetTxPowerByRate(padapter, band, path, txNum, MGN_VHT3SS_MCS7);
-				for (i = 0; i < sizeof(vht3ssRates); ++i) {
-					value = PHY_GetTxPowerByRate(padapter, band, path, txNum, vht3ssRates[i]);
-					PHY_SetTxPowerByRate(padapter, band, path, txNum, vht3ssRates[i], value - base);
-				}
+			/*  VHT 3SS */
+			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT3SS_MCS7);
+			for (i = 0; i < sizeof(vht3ssRates); ++i) {
+				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht3ssRates[i]);
+				PHY_SetTxPowerByRate(padapter, path, txNum, vht3ssRates[i], value - base);
 			}
 		}
 	}
@@ -881,11 +783,10 @@ void PHY_SetTxPowerIndexByRateSection(
 
 	if (RateSection == CCK) {
 		u8 cckRates[]   = {MGN_1M, MGN_2M, MGN_5_5M, MGN_11M};
-		if (pHalData->CurrentBandType == BAND_ON_2_4G)
-			PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-						     pHalData->CurrentChannelBW,
-						     Channel, cckRates,
-						     ARRAY_SIZE(cckRates));
+		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
+					     pHalData->CurrentChannelBW,
+					     Channel, cckRates,
+					     ARRAY_SIZE(cckRates));
 
 	} else if (RateSection == OFDM) {
 		u8 ofdmRates[]  = {MGN_6M, MGN_9M, MGN_12M, MGN_18M, MGN_24M, MGN_36M, MGN_48M, MGN_54M};
@@ -957,41 +858,12 @@ void PHY_SetTxPowerIndexByRateSection(
 	}
 }
 
-static bool phy_GetChnlIndex(u8 Channel, u8 *ChannelIdx)
-{
-	u8 channel5G[CHANNEL_MAX_NUMBER_5G] = {
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 100, 102,
-		104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130,
-		132, 134, 136, 138, 140, 142, 144, 149, 151, 153, 155, 157, 159, 161,
-		163, 165, 167, 168, 169, 171, 173, 175, 177
-	};
-	u8  i = 0;
-	bool bIn24G = true;
-
-	if (Channel <= 14) {
-		bIn24G = true;
-		*ChannelIdx = Channel-1;
-	} else {
-		bIn24G = false;
-
-		for (i = 0; i < ARRAY_SIZE(channel5G); ++i) {
-			if (channel5G[i] == Channel) {
-				*ChannelIdx = i;
-				return bIn24G;
-			}
-		}
-	}
-
-	return bIn24G;
-}
-
 u8 PHY_GetTxPowerIndexBase(
 	struct adapter *padapter,
 	u8 RFPath,
 	u8 Rate,
 	enum channel_width	BandWidth,
-	u8 Channel,
-	bool *bIn24G
+	u8 Channel
 )
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
@@ -1001,69 +873,35 @@ u8 PHY_GetTxPowerIndexBase(
 	if (HAL_IsLegalChannel(padapter, Channel) == false)
 		chnlIdx = 0;
 
-	*bIn24G = phy_GetChnlIndex(Channel, &chnlIdx);
-
-	if (*bIn24G) { /* 3 ============================== 2.4 G ============================== */
-		if (IS_CCK_RATE(Rate))
-			txPower = pHalData->Index24G_CCK_Base[RFPath][chnlIdx];
-		else if (MGN_6M <= Rate)
-			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
-
-		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
-			txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
-
-		if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_24G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_24G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_24G_Diff[RFPath][TX_4S];
-
-		} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
+	if (IS_CCK_RATE(Rate))
+		txPower = pHalData->Index24G_CCK_Base[RFPath][chnlIdx];
+	else if (MGN_6M <= Rate)
+		txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
+
+	/*  OFDM-1T */
+	if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
+		txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
+
+	if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
+		if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
+		if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW20_24G_Diff[RFPath][TX_2S];
+		if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW20_24G_Diff[RFPath][TX_3S];
+		if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW20_24G_Diff[RFPath][TX_4S];
+
+	} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
+		if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
+		if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
+		if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
+		if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+			txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
-		}
-	} else {/* 3 ============================== 5 G ============================== */
-		if (MGN_6M <= Rate)
-			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
-
-		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
-			txPower += pHalData->OFDM_5G_Diff[RFPath][TX_1S];
-
-		/*  BW20-1S, BW20-2S */
-		if (BandWidth == CHANNEL_WIDTH_20) {
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31)  || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_5G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_5G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_5G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW20_5G_Diff[RFPath][TX_4S];
-
-		} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31)  || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_5G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_5G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_5G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_5G_Diff[RFPath][TX_4S];
-
-		}
 	}
 
 	return txPower;
@@ -1349,7 +1187,7 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate)
 }
 
 s8 PHY_GetTxPowerByRate(
-	struct adapter *padapter, u8 Band, u8 RFPath, u8 TxNum, u8 Rate
+	struct adapter *padapter, u8 RFPath, u8 TxNum, u8 Rate
 )
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
@@ -1360,9 +1198,6 @@ s8 PHY_GetTxPowerByRate(
 		   padapter->registrypriv.RegEnableTxPowerByRate == 0)
 		return 0;
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
-		return value;
-
 	if (RFPath > ODM_RF_PATH_D)
 		return value;
 
@@ -1372,13 +1207,12 @@ s8 PHY_GetTxPowerByRate(
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return value;
 
-	return pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex];
+	return pHalData->TxPwrByRateOffset[RFPath][TxNum][rateIndex];
 
 }
 
 void PHY_SetTxPowerByRate(
 	struct adapter *padapter,
-	u8 Band,
 	u8 RFPath,
 	u8 TxNum,
 	u8 Rate,
@@ -1388,9 +1222,6 @@ void PHY_SetTxPowerByRate(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	u8 rateIndex = PHY_GetRateIndexOfTxPowerByRate(Rate);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
-		return;
-
 	if (RFPath > ODM_RF_PATH_D)
 		return;
 
@@ -1400,18 +1231,16 @@ void PHY_SetTxPowerByRate(
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return;
 
-	pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex] = Value;
+	pHalData->TxPwrByRateOffset[RFPath][TxNum][rateIndex] = Value;
 }
 
 void PHY_SetTxPowerLevelByPath(struct adapter *Adapter, u8 channel, u8 path)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-	bool bIsIn24G = (pHalData->CurrentBandType == BAND_ON_2_4G);
 
 	/* if (pMgntInfo->RegNByteAccess == 0) */
 	{
-		if (bIsIn24G)
-			PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, CCK);
+		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, CCK);
 
 		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, OFDM);
 		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, HT_MCS0_MCS7);
@@ -1453,26 +1282,9 @@ static s8 phy_GetWorldWideLimit(s8 *LimitTable)
 	return min;
 }
 
-static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
+static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Channel)
 {
-	s8	channelIndex = -1;
-	u8 channel5G[CHANNEL_MAX_NUMBER_5G] = {
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 100, 102,
-		104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130,
-		132, 134, 136, 138, 140, 142, 144, 149, 151, 153, 155, 157, 159, 161,
-		163, 165, 167, 168, 169, 171, 173, 175, 177
-	};
-	u8 i = 0;
-	if (Band == BAND_ON_2_4G)
-		channelIndex = Channel - 1;
-	else if (Band == BAND_ON_5G) {
-		for (i = 0; i < ARRAY_SIZE(channel5G); ++i) {
-			if (channel5G[i] == Channel)
-				channelIndex = i;
-		}
-	}
-
-	return channelIndex;
+	return Channel - 1;
 }
 
 static s16 get_bandwidth_idx(const enum channel_width bandwidth)
@@ -1533,16 +1345,16 @@ static s16 get_rate_sctn_idx(const u8 rate)
 }
 
 s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
-		      enum band_type band_type, enum channel_width bandwidth,
+		      enum channel_width bandwidth,
 		      u8 rf_path, u8 data_rate, u8 channel)
 {
-	s16 idx_band       = -1;
 	s16 idx_regulation = -1;
 	s16 idx_bandwidth  = -1;
 	s16 idx_rate_sctn  = -1;
 	s16 idx_channel    = -1;
 	s8 pwr_lmt = MAX_POWER_INDEX;
 	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
+	s8 limits[10] = {0}; u8 i = 0;
 
 	if (((adapter->registrypriv.RegEnableTxPowerLimit == 2) &&
 	     (hal_data->EEPROMRegulatory != 1)) ||
@@ -1563,17 +1375,10 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		idx_regulation = TXPWR_LMT_WW;
 		break;
 	default:
-		idx_regulation = (band_type == BAND_ON_2_4G) ?
-			hal_data->Regulation2_4G :
-			hal_data->Regulation5G;
+		idx_regulation = hal_data->Regulation2_4G;
 		break;
 	}
 
-	if (band_type == BAND_ON_2_4G)
-		idx_band = 0;
-	else if (band_type == BAND_ON_5G)
-		idx_band = 1;
-
 	idx_bandwidth = get_bandwidth_idx(bandwidth);
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
@@ -1583,107 +1388,30 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	/*  HT on 80M will reference to HT on 40M */
 	if (idx_rate_sctn == 0 || idx_rate_sctn == 1)
 		idx_bandwidth = 0;
-	else if ((idx_rate_sctn == 2 || idx_rate_sctn == 3) &&
-		 (band_type == BAND_ON_5G) && (idx_bandwidth == 2))
-		idx_bandwidth = 1;
 
-	if (band_type == BAND_ON_2_4G || band_type == BAND_ON_5G)
-		channel = phy_GetChannelIndexOfTxPowerLimit(band_type, channel);
+	channel = phy_GetChannelIndexOfTxPowerLimit(channel);
 
-	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
+	if (idx_regulation == -1 || idx_bandwidth == -1 ||
 	    idx_rate_sctn == -1 || idx_channel == -1)
 		return MAX_POWER_INDEX;
 
-	if (band_type == BAND_ON_2_4G) {
-		s8 limits[10] = {0}; u8 i = 0;
-
-		for (i = 0; i < MAX_REGULATION_NUM; i++)
-			limits[i] = hal_data->TxPwrLimit_2_4G[i]
-							     [idx_bandwidth]
-							     [idx_rate_sctn]
-							     [idx_channel]
-							     [rf_path];
-
-		pwr_lmt = (idx_regulation == TXPWR_LMT_WW) ?
-			phy_GetWorldWideLimit(limits) :
-			hal_data->TxPwrLimit_2_4G[idx_regulation]
-						 [idx_bandwidth]
-						 [idx_rate_sctn]
-						 [idx_channel]
-						 [rf_path];
-
-	} else if (band_type == BAND_ON_5G) {
-		s8 limits[10] = {0}; u8 i = 0;
-
-		for (i = 0; i < MAX_REGULATION_NUM; ++i)
-			limits[i] = hal_data->TxPwrLimit_5G[i]
-							   [idx_bandwidth]
-							   [idx_rate_sctn]
-							   [idx_channel]
-							   [rf_path];
-
-		pwr_lmt = (idx_regulation == TXPWR_LMT_WW) ?
-			phy_GetWorldWideLimit(limits) :
-			hal_data->TxPwrLimit_5G[idx_regulation]
-					       [idx_bandwidth]
-					       [idx_rate_sctn]
-					       [idx_channel]
-					       [rf_path];
-	}
 
-	return pwr_lmt;
-}
+	for (i = 0; i < MAX_REGULATION_NUM; i++)
+		limits[i] = hal_data->TxPwrLimit_2_4G[i]
+						     [idx_bandwidth]
+						     [idx_rate_sctn]
+						     [idx_channel]
+						     [rf_path];
 
-static void phy_CrossReferenceHTAndVHTTxPowerLimit(struct adapter *padapter)
-{
-	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
-	u8 regulation, bw, channel, rateSection;
-	s8 tempPwrLmt = 0;
+	pwr_lmt = (idx_regulation == TXPWR_LMT_WW) ?
+		phy_GetWorldWideLimit(limits) :
+		hal_data->TxPwrLimit_2_4G[idx_regulation]
+					 [idx_bandwidth]
+					 [idx_rate_sctn]
+					 [idx_channel]
+					 [rf_path];
 
-	for (regulation = 0; regulation < MAX_REGULATION_NUM; ++regulation) {
-		for (bw = 0; bw < MAX_5G_BANDWIDTH_NUM; ++bw) {
-			for (channel = 0; channel < CHANNEL_MAX_NUMBER_5G; ++channel) {
-				for (rateSection = 0; rateSection < MAX_RATE_SECTION_NUM; ++rateSection) {
-					tempPwrLmt = pHalData->TxPwrLimit_5G[regulation][bw][rateSection][channel][ODM_RF_PATH_A];
-					if (tempPwrLmt == MAX_POWER_INDEX) {
-						u8 baseSection = 2, refSection = 6;
-						if (bw == 0 || bw == 1) { /*  5G 20M 40M VHT and HT can cross reference */
-							/*			1, bw, rateSection, channel, ODM_RF_PATH_A); */
-							if (rateSection >= 2 && rateSection <= 9) {
-								if (rateSection == 2) {
-									baseSection = 2;
-									refSection = 6;
-								} else if (rateSection == 3) {
-									baseSection = 3;
-									refSection = 7;
-								} else if (rateSection == 4) {
-									baseSection = 4;
-									refSection = 8;
-								} else if (rateSection == 5) {
-									baseSection = 5;
-									refSection = 9;
-								} else if (rateSection == 6) {
-									baseSection = 6;
-									refSection = 2;
-								} else if (rateSection == 7) {
-									baseSection = 7;
-									refSection = 3;
-								} else if (rateSection == 8) {
-									baseSection = 8;
-									refSection = 4;
-								} else if (rateSection == 9) {
-									baseSection = 9;
-									refSection = 5;
-								}
-								pHalData->TxPwrLimit_5G[regulation][bw][baseSection][channel][ODM_RF_PATH_A] =
-									pHalData->TxPwrLimit_5G[regulation][bw][refSection][channel][ODM_RF_PATH_A];
-							}
-						}
-					}
-				}
-			}
-		}
-	}
+	return pwr_lmt;
 }
 
 void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
@@ -1694,8 +1422,6 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 	s8 tempValue = 0, tempPwrLmt = 0;
 	u8 rfPath = 0;
 
-	phy_CrossReferenceHTAndVHTTxPowerLimit(Adapter);
-
 	for (regulation = 0; regulation < MAX_REGULATION_NUM; ++regulation) {
 		for (bw = 0; bw < MAX_2_4G_BANDWIDTH_NUM; ++bw) {
 			for (channel = 0; channel < CHANNEL_MAX_NUMBER_2G; ++channel) {
@@ -1705,17 +1431,17 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 					for (rfPath = ODM_RF_PATH_A; rfPath < MAX_RF_PATH_NUM; ++rfPath) {
 						if (pHalData->odmpriv.PhyRegPgValueType == PHY_REG_PG_EXACT_VALUE) {
 							if (rateSection == 5) /*  HT 4T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_4TX, HT_MCS24_MCS31);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_4TX, HT_MCS24_MCS31);
 							else if (rateSection == 4) /*  HT 3T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_3TX, HT_MCS16_MCS23);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_3TX, HT_MCS16_MCS23);
 							else if (rateSection == 3) /*  HT 2T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_2TX, HT_MCS8_MCS15);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_2TX, HT_MCS8_MCS15);
 							else if (rateSection == 2) /*  HT 1T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_1TX, HT_MCS0_MCS7);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, HT_MCS0_MCS7);
 							else if (rateSection == 1) /*  OFDM */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_1TX, OFDM);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, OFDM);
 							else if (rateSection == 0) /*  CCK */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, BAND_ON_2_4G, rfPath, RF_1TX, CCK);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, CCK);
 						} else
 							BW40PwrBasedBm2_4G = Adapter->registrypriv.RegPowerBase * 2;
 
@@ -1742,20 +1468,11 @@ void PHY_InitTxPowerLimit(struct adapter *Adapter)
 					for (l = 0; l < MAX_RF_PATH_NUM; ++l)
 						pHalData->TxPwrLimit_2_4G[i][j][k][m][l] = MAX_POWER_INDEX;
 	}
-
-	for (i = 0; i < MAX_REGULATION_NUM; ++i) {
-		for (j = 0; j < MAX_5G_BANDWIDTH_NUM; ++j)
-			for (k = 0; k < MAX_RATE_SECTION_NUM; ++k)
-				for (m = 0; m < CHANNEL_MAX_NUMBER_5G; ++m)
-					for (l = 0; l < MAX_RF_PATH_NUM; ++l)
-						pHalData->TxPwrLimit_5G[i][j][k][m][l] = MAX_POWER_INDEX;
-	}
 }
 
 void PHY_SetTxPowerLimit(
 	struct adapter *Adapter,
 	u8 *Regulation,
-	u8 *Band,
 	u8 *Bandwidth,
 	u8 *RateSection,
 	u8 *RfPath,
@@ -1813,38 +1530,21 @@ void PHY_SetTxPowerLimit(
 	else if (eqNByte(Bandwidth, (u8 *)("160M"), 4))
 		bandwidth = 3;
 
-	if (eqNByte(Band, (u8 *)("2.4G"), 4)) {
-		channelIndex = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_2_4G, channel);
-
-		if (channelIndex == -1)
-			return;
-
-		prevPowerLimit = pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A];
-
-		if (powerLimit < prevPowerLimit)
-			pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
-
-	} else if (eqNByte(Band, (u8 *)("5G"), 2)) {
-		channelIndex = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G, channel);
+	channelIndex = phy_GetChannelIndexOfTxPowerLimit(channel);
 
-		if (channelIndex == -1)
-			return;
-
-		prevPowerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A];
+	if (channelIndex == -1)
+		return;
 
-		if (powerLimit < prevPowerLimit)
-			pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
+	prevPowerLimit = pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A];
 
-	} else {
-		return;
-	}
+	if (powerLimit < prevPowerLimit)
+		pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
 }
 
 void Hal_ChannelPlanToRegulation(struct adapter *Adapter, u16 ChannelPlan)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 	pHalData->Regulation2_4G = TXPWR_LMT_WW;
-	pHalData->Regulation5G = TXPWR_LMT_WW;
 
 	switch (ChannelPlan) {
 	case RT_CHANNEL_DOMAIN_WORLD_NULL:
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index bfe0c3a773af..0307ea383806 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -972,10 +972,6 @@ void ODM_CmnInfoHook(struct dm_odm_t *pDM_Odm, enum odm_cmninfo_e CmnInfo, void
 		pDM_Odm->pwirelessmode = pValue;
 		break;
 
-	case ODM_CMNINFO_BAND:
-		pDM_Odm->pBandType = pValue;
-		break;
-
 	case ODM_CMNINFO_SEC_CHNL_OFFSET:
 		pDM_Odm->pSecChOffset = pValue;
 		break;
@@ -1183,10 +1179,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->WirelessMode = (u8)Value;
 		break;
 
-	case	ODM_CMNINFO_BAND:
-		pDM_Odm->BandType = (u8)Value;
-		break;
-
 	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
 		pDM_Odm->SecChOffset = (u8)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index a7a77fbb8390..788fc1c068b5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -315,7 +315,6 @@ enum odm_cmninfo_e {
 	ODM_CMNINFO_TX_UNI,
 	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
-	ODM_CMNINFO_BAND,		/*  ODM_BAND_TYPE_E */
 	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
 	ODM_CMNINFO_SEC_MODE,		/*  ODM_SECURITY_E */
 	ODM_CMNINFO_BW,			/*  ODM_BW_E */
@@ -459,14 +458,6 @@ enum { /* tag_Wireless_Mode_Definition */
 	ODM_WM_AUTO       = BIT5,
 };
 
-/*  ODM_CMNINFO_BAND */
-enum { /* tag_Band_Type_Definition */
-	ODM_BAND_2_4G = 0,
-	ODM_BAND_5G,
-	ODM_BAND_ON_BOTH,
-	ODM_BANDMAX
-};
-
 /*  ODM_CMNINFO_BW */
 enum { /* tag_Bandwidth_Definition */
 	ODM_BW20M		= 0,
@@ -788,8 +779,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	u64 *pNumRxBytesUnicast;
 	/*  Wireless mode B/G/A/N = BIT0/BIT1/BIT2/BIT3 */
 	u8 *pwirelessmode; /* ODM_WIRELESS_MODE_E */
-	/*  Frequence band 2.4G/5G = 0/1 */
-	u8 *pBandType;
 	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
 	u8 *pSecChOffset;
 	/*  Security mode Open/WEP/AES/TKIP = 0/1/2/3 */
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
index b77c61598294..a29bd9375023 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
@@ -117,7 +117,6 @@ void odm_ConfigBB_AGC_8723B(
 
 void odm_ConfigBB_PHY_REG_PG_8723B(
 	struct dm_odm_t *pDM_Odm,
-	u32 Band,
 	u32 RfPath,
 	u32 TxNum,
 	u32 Addr,
@@ -128,7 +127,7 @@ void odm_ConfigBB_PHY_REG_PG_8723B(
 	if (Addr == 0xfe || Addr == 0xffe)
 		msleep(50);
 	else {
-		PHY_StoreTxPowerByRate(pDM_Odm->Adapter, Band, RfPath, TxNum, Addr, Bitmask, Data);
+		PHY_StoreTxPowerByRate(pDM_Odm->Adapter, RfPath, TxNum, Addr, Bitmask, Data);
 	}
 }
 
@@ -162,7 +161,6 @@ void odm_ConfigBB_PHY_8723B(
 void odm_ConfigBB_TXPWR_LMT_8723B(
 	struct dm_odm_t *pDM_Odm,
 	u8 *Regulation,
-	u8 *Band,
 	u8 *Bandwidth,
 	u8 *RateSection,
 	u8 *RfPath,
@@ -173,7 +171,6 @@ void odm_ConfigBB_TXPWR_LMT_8723B(
 	PHY_SetTxPowerLimit(
 		pDM_Odm->Adapter,
 		Regulation,
-		Band,
 		Bandwidth,
 		RateSection,
 		RfPath,
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
index b392d14c389d..bdd6fde49fc6 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
@@ -25,7 +25,6 @@ void odm_ConfigBB_AGC_8723B(struct dm_odm_t *pDM_Odm,
 );
 
 void odm_ConfigBB_PHY_REG_PG_8723B(struct dm_odm_t *pDM_Odm,
-				   u32 Band,
 				   u32 RfPath,
 				   u32 TxNum,
 				   u32 Addr,
@@ -41,7 +40,6 @@ void odm_ConfigBB_PHY_8723B(struct dm_odm_t *pDM_Odm,
 
 void odm_ConfigBB_TXPWR_LMT_8723B(struct dm_odm_t *pDM_Odm,
 				  u8 *Regulation,
-				  u8 *Band,
 				  u8 *Bandwidth,
 				  u8 *RateSection,
 				  u8 *RfPath,
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 23be025ceb5b..5840a5241fde 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -109,7 +109,6 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_CHNL, &(pHalData->CurrentChannel));
 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_NET_CLOSED, &(Adapter->net_closed));
 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MP_MODE, &zero);
-	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_BAND, &(pHalData->CurrentBandType));
 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_FORCED_IGI_LB, &(pHalData->u1ForcedIgiLb));
 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_FORCED_RATE, &(pHalData->ForcedDataRate));
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 23435dcc5537..6e524034f388 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -546,15 +546,13 @@ u8 PHY_GetTxPowerIndex(
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	s8 txPower = 0, powerDiffByRate = 0, limit = 0;
-	bool bIn24G = false;
 
-	txPower = (s8) PHY_GetTxPowerIndexBase(padapter, RFPath, Rate, BandWidth, Channel, &bIn24G);
-	powerDiffByRate = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, ODM_RF_PATH_A, RF_1TX, Rate);
+	txPower = (s8) PHY_GetTxPowerIndexBase(padapter, RFPath, Rate, BandWidth, Channel);
+	powerDiffByRate = PHY_GetTxPowerByRate(padapter, ODM_RF_PATH_A, RF_1TX, Rate);
 
 	limit = phy_get_tx_pwr_lmt(
 		padapter,
 		padapter->registrypriv.RegPwrTblSel,
-		(u8)(!bIn24G),
 		pHalData->CurrentChannelBW,
 		RFPath,
 		Rate,
diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index 73f6cadb5c79..a30e1e09826d 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -73,7 +73,6 @@ struct bb_register_def {
 u8
 PHY_GetTxPowerByRateBase(
 struct adapter *Adapter,
-u8 		Band,
 u8 		RfPath,
 u8 		TxNum,
 enum rate_section	RateSection
@@ -113,7 +112,6 @@ u8 		RateSection
 s8
 PHY_GetTxPowerByRate(
 struct adapter *padapter,
-u8 	Band,
 u8 	RFPath,
 u8 	TxNum,
 u8 	RateIndex
@@ -122,7 +120,6 @@ u8 	RateIndex
 void
 PHY_SetTxPowerByRate(
 struct adapter *padapter,
-u8 	Band,
 u8 	RFPath,
 u8 	TxNum,
 u8 	Rate,
@@ -154,7 +151,6 @@ struct adapter *padapter
 void
 PHY_StoreTxPowerByRate(
 struct adapter *padapter,
-u32 		Band,
 u32 		RfPath,
 u32 		TxNum,
 u32 		RegAddr,
@@ -173,12 +169,11 @@ struct adapter *padapter,
 u8 		RFPath,
 u8 		Rate,
 enum channel_width	BandWidth,
-u8 		Channel,
-	bool		*bIn24G
+u8 		Channel
 	);
 
 s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 RegPwrTblSel,
-			enum band_type Band, enum channel_width Bandwidth,
+		      enum channel_width Bandwidth,
 u8 		RfPath,
 u8 		DataRate,
 u8 		Channel
@@ -188,7 +183,6 @@ void
 PHY_SetTxPowerLimit(
 struct adapter *Adapter,
 u8 			*Regulation,
-u8 			*Band,
 u8 			*Bandwidth,
 u8 			*RateSection,
 u8 			*RfPath,
diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index babcb03a7c23..78246356927b 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -59,8 +59,6 @@ enum rt_ampdu_burst {
 #define MAX_5G_BANDWIDTH_NUM			4
 
 #define MAX_BASE_NUM_IN_PHY_REG_PG_2_4G		10 /*   CCK:1, OFDM:1, HT:4, VHT:4 */
-#define MAX_BASE_NUM_IN_PHY_REG_PG_5G		9 /*  OFDM:1, HT:4, VHT:4 */
-
 
 /*  duplicate code, will move to ODM ######### */
 /* define IQK_MAC_REG_NUM		4 */
@@ -182,8 +180,6 @@ struct hal_com_data {
 	/* current WIFI_PHY values */
 	enum wireless_mode CurrentWirelessMode;
 	enum channel_width CurrentChannelBW;
-	enum band_type CurrentBandType;	/* 0:2.4G, 1:5G */
-	enum band_type BandSet;
 	u8 CurrentChannel;
 	u8 CurrentCenterFrequencyIndex1;
 	u8 nCur40MhzPrimeSC;/*  Control channel sub-carrier */
@@ -236,13 +232,6 @@ struct hal_com_data {
 	s8	OFDM_24G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
 	s8	BW20_24G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
 	s8	BW40_24G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
-	/* 3 [5G] */
-	u8 Index5G_BW40_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER];
-	u8 Index5G_BW80_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER_5G_80M];
-	s8	OFDM_5G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
-	s8	BW20_5G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
-	s8	BW40_5G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
-	s8	BW80_5G_Diff[MAX_RF_PATH][MAX_TX_COUNT];
 
 	u8 Regulation2_4G;
 	u8 Regulation5G;
@@ -253,15 +242,13 @@ struct hal_com_data {
 	/*  TX power by rate table at most 4RF path. */
 	/*  The register is */
 	/*  VHT TX power by rate off setArray = */
-	/*  Band:-2G&5G = 0 / 1 */
 	/*  RF: at most 4*4 = ABCD = 0/1/2/3 */
 	/*  CCK = 0 OFDM = 1/2 HT-MCS 0-15 =3/4/56 VHT =7/8/9/10/11 */
 	u8 TxPwrByRateTable;
 	u8 TxPwrByRateBand;
-	s8	TxPwrByRateOffset[TX_PWR_BY_RATE_NUM_BAND]
-						 [TX_PWR_BY_RATE_NUM_RF]
-						 [TX_PWR_BY_RATE_NUM_RF]
-						 [TX_PWR_BY_RATE_NUM_RATE];
+	s8 TxPwrByRateOffset[TX_PWR_BY_RATE_NUM_RF]
+			    [TX_PWR_BY_RATE_NUM_RF]
+			    [TX_PWR_BY_RATE_NUM_RATE];
 	/*  */
 
 	/* 2 Power Limit Table */
@@ -278,21 +265,10 @@ struct hal_com_data {
 	                                [CHANNEL_MAX_NUMBER_2G]
 						[MAX_RF_PATH_NUM];
 
-	/*  Power Limit Table for 5G */
-	s8	TxPwrLimit_5G[MAX_REGULATION_NUM]
-						[MAX_5G_BANDWIDTH_NUM]
-						[MAX_RATE_SECTION_NUM]
-						[CHANNEL_MAX_NUMBER_5G]
-						[MAX_RF_PATH_NUM];
-
-
 	/*  Store the original power by rate value of the base of each rate section of rf path A & B */
 	u8 TxPwrByRateBase2_4G[TX_PWR_BY_RATE_NUM_RF]
 						[TX_PWR_BY_RATE_NUM_RF]
 						[MAX_BASE_NUM_IN_PHY_REG_PG_2_4G];
-	u8 TxPwrByRateBase5G[TX_PWR_BY_RATE_NUM_RF]
-						[TX_PWR_BY_RATE_NUM_RF]
-						[MAX_BASE_NUM_IN_PHY_REG_PG_5G];
 
 	/*  For power group */
 	u8 PwrGroupHT20[RF_PATH_MAX_92C_88E][CHANNEL_MAX_NUMBER];
@@ -319,13 +295,9 @@ struct hal_com_data {
 	u32 AntennaRxPath;					/*  Antenna path Rx */
 
 	u8 PAType_2G;
-	u8 PAType_5G;
 	u8 LNAType_2G;
-	u8 LNAType_5G;
 	u8 ExternalPA_2G;
 	u8 ExternalLNA_2G;
-	u8 ExternalPA_5G;
-	u8 ExternalLNA_5G;
 	u8 TypeGLNA;
 	u8 TypeGPA;
 	u8 TypeALNA;
diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
index 6417d1b758d2..861aa71cd179 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy.h
@@ -17,13 +17,6 @@
 
 
 /*--------------------------Define Parameters-------------------------------*/
-enum band_type {
-	BAND_ON_2_4G = 0,
-	BAND_ON_5G,
-	BAND_ON_BOTH,
-	BANDMAX
-};
-
 enum {
 	RF_TYPE_MIN = 0,	/*  0 */
 	RF_8225 = 1,		/*  1 11b/g RF for verification only */
-- 
2.20.1

