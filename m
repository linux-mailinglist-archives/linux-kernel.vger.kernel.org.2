Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF653D562F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGZIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhGZIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:30:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC2C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:10:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nd39so15410004ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yl7CupfQBRHivtmWrPtpI7/TUlZwh31U/GvJWFLimQ4=;
        b=rNCoEe0Goq1rhpi2aFAuXK08hyQrUT7HX4EakktKx14Ke0ZIuNCbRCWJtxdAZzF0gi
         OG+DeTF9f1sb/RdF/p8TGbLIMTtqDWQohf8nPVrA4+MyFj0Qv8MpV34Fpc5XKzanAF3S
         QZFHYM+fW7t1J3elT0n1aEOJ0OyOIWdMKwWA2vJM38A0QpNG4PnNQ7s8rZVXILiPvq5x
         pTI+P1ANjopIlsqtRICVJD6b2rOQ7MLZNfnM96j/Y5X60ERqXbACiatWEuT4xnjGs7JB
         vsrvf9Kg7q6QW654s4l4NKMn+utxovUgZhRSjqMpmokOxlwCbUdMlW5MF1saY77Wp8GV
         Emxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yl7CupfQBRHivtmWrPtpI7/TUlZwh31U/GvJWFLimQ4=;
        b=h5OuMtG9dJDqTnYiQm8DFINlb45/89PbZjUv4cpgi/H+TP2fkUOeq01OtGcFfBVVYA
         tt1wgIdLJhjrle1Pbm5mp1lpPf5gxac1HBk0gYryoS7snepxVp8PkWqcMCwIBmew4bWF
         U8pCZhrtitlc2N1o5GBNOImpfKF6dEcyVxp02bg+27sPU2zCbunpMSJg2iisTZ/JS9dx
         +Mii5Av7adK+Sa75b+WdrnX/SdT2qNUtqsJDz8e8DU7FpunRWFHNNb8pxQHU8Vkmcz8U
         QH1P8w0I9UydVhJlJw0EXA8FDaxwn5R6c42RmxKw9Fnqf6zM+LmOKbp9PHc2ZaWYVxdY
         iNyw==
X-Gm-Message-State: AOAM532Zy9v3Qm0V7YJHiFxqCrMt7+PgXVVtAIHMQvTUna/YZTodTHOc
        jYabKNGSOgAUKM5NvC6nYUk=
X-Google-Smtp-Source: ABdhPJz5COJjMIP1Epi4BOUioeC9uXPs3GQrWZf9sDP+RROCNt87NcaBznzYib0LFfzH8Ry4WKWK5A==
X-Received: by 2002:a17:906:585a:: with SMTP id h26mr16251647ejs.31.1627290636937;
        Mon, 26 Jul 2021 02:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id p3sm14536647ejy.20.2021.07.26.02.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:10:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove blank lines
Date:   Mon, 26 Jul 2021 11:10:14 +0200
Message-Id: <20210726091014.21405-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c           | 3 ---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c     | 1 -
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c    | 1 -
 4 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index b817aa8b9de4..a2aeb78733d5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -381,7 +381,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		/* set ra_id, init_rate */
 		psta->raid = raid;
 		psta->init_rate = init_rate;
-
 	}
 }
 
@@ -453,7 +452,6 @@ static void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -1140,7 +1138,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 
 static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 {
-
 	if (!memcmp(WPS_OUI, oui, 4))
 		update_bcn_wps_ie(padapter);
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 25653ebfaafd..b1fe30e9a2b4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4723,7 +4723,6 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 						pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 						break;
 					}
-
 				}
 			}
 			break;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 2afef26ddb56..6cf87312bc36 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -455,7 +455,6 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 		 hal_com_get_channel_plan(hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
 					  padapter->registrypriv.channel_plan,
 					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
-
 }
 
 void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index d4dce8ef0322..2b43c7eab71f 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1212,7 +1212,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.ssid_length)) &&
 			    (pnetwork->network.ssid.ssid_length == ndis_ssid.ssid_length)) {
-
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 						continue;
-- 
2.32.0

