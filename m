Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5022D3DBFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhG3Umn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhG3Umj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:42:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852CC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:42:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gn26so19026631ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OTvw/vz/MoiC7ggWi+Lx+RTd5Xd1sl050H55gD7g/c=;
        b=qWEsmJqkA7bT/ckKxO6s3MSlP5pU5+8RXt0FEQ0taOXyTFe0GZAXyTbjeHUHNarGiE
         dPNdfZhuWbhMQ+OkYpEh6T9hP3GfufKpUpXgcA0emGjdT22kPoonF4nFePJZUt8a+cUW
         itvJDcqZpk8sciLSOMB1IGPrhL9pHWshfbdNTmJD/TI0+ZEuG/Ux0rC2uu9nbDgT++/F
         YBcAgFNQ8V4W+TlZ87K9fdHvlcFIPdIjqXvzbE7wj/PzWI22o2seOt8wuKdaS+K39ryp
         couVhHUmFpyH9rnfmkdVtuWq5vMLJtZ7ycRKUvms3uJ58JArVel+YcIb4JionTkt7UBM
         iZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OTvw/vz/MoiC7ggWi+Lx+RTd5Xd1sl050H55gD7g/c=;
        b=BqNPZmmfWsjUMA90jJGpOvrScqXc+ySL6sztz7D/0ez5AD3CwzNje0F3EnzawPewOe
         iO/LrNmjWXZk20kycfo/mbIEMXkoFi3fqM8u10+Er0OITCCdIQb64jLv1Si7VBqXisYK
         7w4i1fjTtQsegn1q7TKhOCMDlk9jq489BU4UxUC2YHqIqhck+Y00ASOvF08dI6y8D5Jh
         vpqLI54x9w82RMY5P6Ebj3+eCE2WSpelXFJVpSAxeODMoDBZx02P8B1ANzBbUZRIvQNp
         GJlggc1aqQxZNoIdCcxshTgruDNJOg7+CNpgMNBL/eKbLklQfI/zOdClqOZVPxPgrovt
         tcdQ==
X-Gm-Message-State: AOAM5333fl+xeG2kB475XuMGJ0ySOERsK+s28Ps1JT6gmlejOErK5exC
        2geHld8JH6MQQ/PMuy00ChM=
X-Google-Smtp-Source: ABdhPJzd2Hfko33/ZkdoG/8XLn4KWl6PyYkMOySdCarKqb/kH9jKOqPJiq9o5sWV1WxlMAhTTurU5w==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr4518383ejy.222.1627677751189;
        Fri, 30 Jul 2021 13:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id dg20sm1139034edb.13.2021.07.30.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 13:42:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: add missing spaces after ',' and before braces
Date:   Fri, 30 Jul 2021 22:41:53 +0200
Message-Id: <20210730204153.27270-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730204153.27270-1-straube.linux@gmail.com>
References: <20210730204153.27270-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required before the open parenthesis '('
ERROR: space required before the open brace '{'
ERROR: space required after that ',' (ctx:ExV)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c            |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c          | 10 +++++-----
 drivers/staging/r8188eu/core/rtw_security.c      |  4 ++--
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c   |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c           |  2 +-
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c  |  2 +-
 drivers/staging/r8188eu/os_dep/rtw_android.c     |  4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 463c9ca40492..0bb545135206 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1028,7 +1028,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		/* set  Max Rx AMPDU size  to 64K */
 		pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_FACTOR & 0x03);
 
-		if(rf_type == RF_1T1R) {
+		if (rf_type == RF_1T1R) {
 			pht_cap->mcs.rx_mask[0] = 0xff;
 			pht_cap->mcs.rx_mask[1] = 0x0;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f07e4e233788..d692f1477cc8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1317,7 +1317,7 @@ static u8 search_max_mac_id(struct adapter *padapter)
 }
 
 /* FOR AP , AD-HOC mode */
-void rtw_sta_media_status_rpt(struct adapter *adapter,struct sta_info *psta,
+void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 			      u32 mstatus)
 {
 	u16 media_status_rpt;
@@ -1330,7 +1330,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter,struct sta_info *psta,
 	rtw_hal_set_hwreg(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
 	/* MACID|OPMODE:1 connect */
 	media_status_rpt = (u16)((psta->mac_id<<8) | mstatus);
-	rtw_hal_set_hwreg(adapter,HW_VAR_H2C_MEDIA_STATUS_RPT,
+	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT,
 			  (u8 *)&media_status_rpt);
 }
 
@@ -1428,7 +1428,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
-		if(adapter->registrypriv.wifi_spec == 1)
+		if (adapter->registrypriv.wifi_spec == 1)
 			rtw_set_roaming(adapter, 0); /* don't roam */
 		else if (rtw_to_roaming(adapter) > 0)
 			pmlmepriv->to_roaming--; /* this stadel_event is caused by roaming, decrease to_roaming */
@@ -1651,7 +1651,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	if (rtw_is_desired_network(adapter, competitor)  == false)
 		goto exit;
 
-	if(rtw_to_roaming(adapter) > 0) {
+	if (rtw_to_roaming(adapter) > 0) {
 		if (rtw_get_passing_time_ms((u32)competitor->last_scanned) >= RTW_SCAN_RESULT_EXPIRE ||
 		    is_same_ess(&competitor->network, &pmlmepriv->cur_network.network) == false)
 			goto exit;
@@ -1668,7 +1668,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 			(*candidate)->network.Ssid.Ssid,
 			(*candidate)->network.MacAddress,
 			(int)(*candidate)->network.Rssi);
-		DBG_88E("[to_roaming:%u]\n",rtw_to_roaming(adapter));
+		DBG_88E("[to_roaming:%u]\n", rtw_to_roaming(adapter));
 	}
 
 exit:
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index ee4775b8284b..2c1b9a6dcdf2 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1229,7 +1229,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
-				} else{
+				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len ;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
@@ -1237,7 +1237,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					pframe = (u8 *)RND4((size_t)(pframe));
 				}
 			}
-		} else{
+		} else {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index fc58d5fb1264..f90827577059 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -539,7 +539,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 5);
 						} else if (v1 == 0xf9) {
 							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 1);
-						} else{
+						} else {
 							if (v1 == 0xa24)
 								dm_odm->RFCalibrateInfo.RegA24 = v2;
 
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index cb0635850aa8..1d813b6c3678 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -201,7 +201,7 @@ u8 rtw_hal_intf_ps_func(struct adapter *adapt,
 s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter,
 			      struct xmit_frame *pxmitframe)
 {
-	if(padapter->HalFunc.hal_xmitframe_enqueue)
+	if (padapter->HalFunc.hal_xmitframe_enqueue)
 		return padapter->HalFunc.hal_xmitframe_enqueue(padapter, pxmitframe);
 	return false;
 }
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index a26c36cf8786..1a2055249192 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -77,7 +77,7 @@ void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 		ODM_delay_us(5);
 	} else if (Addr == 0xf9) {
 		ODM_delay_us(1);
-	} else{
+	} else {
 		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
 			     ("===> @@@@@@@ ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X %08X\n",
 			     Addr, Bitmask, Data));
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index fa6c092e714d..1a7a62dd8504 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1741,7 +1741,7 @@ static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 	} else if (IS_2T2R(ChipVersion)) {
 		pHalData->rf_type = RF_2T2R;
 		pHalData->NumTotalRFPath = 2;
-	} else{
+	} else {
 		pHalData->rf_type = RF_1T1R;
 		pHalData->NumTotalRFPath = 1;
 	}
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index ce02bfc6d02a..2b9e719e2a51 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -62,12 +62,12 @@ static int g_wifi_on = true;
 int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
-	for(cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
+	for (cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0))
 		if (!strncasecmp(cmdstr, android_wifi_cmd_str[cmd_num],
 		    strlen(android_wifi_cmd_str[cmd_num])))
 #else
-		if(0 == strnicmp(cmdstr, android_wifi_cmd_str[cmd_num],
+		if (0 == strnicmp(cmdstr, android_wifi_cmd_str[cmd_num],
 		   strlen(android_wifi_cmd_str[cmd_num])))
 #endif
 			break;
-- 
2.32.0

