Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EEB402047
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbhIFTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343624AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF7C0617A8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id e21so15056041ejz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTO2QXrKZY0AGmkUtVFYURWGtcSjnC2Lr7CY2NRAnG4=;
        b=YwOnebAFXKuHr8VTn2Nyv32yAWhmULRkKiOaFAEk9TykEDihOsVZQ0EG/nXwF6XGCA
         h8SppyVrFfgaMccjaJNvzNmK//45EHkXCSPJQ/Q6vhBmJ/XrPmhMlgr3a31cE74dPETZ
         yqj/nGamn5SKYr1ppSrd2UXtvHKi8k1AIFgnCEiQd5IwoQcHt1x23U5M6mkzMYDB7hxC
         ZBd350Y2/yBn/bQR0QfAFkXGKvgBCAwzc5p08s/cRtcVwXTfCrh7aKXJueCOv/jVIUsZ
         8EOcLeqyJQz4xpyIJBarvlOtHdFgjpUeupcFO98wuHcL76LXc3wTNJhmgu2uDU3NACcy
         47+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTO2QXrKZY0AGmkUtVFYURWGtcSjnC2Lr7CY2NRAnG4=;
        b=JZ6FafbGQekLcKiLMWiIG67PHEKh1ro1bJgG3yHPX894R1umkKwZzQHd9eDzCzT+sp
         KJLSemaaZGHGtKdAiYyfCUoMa8BexlG0kn69Fd018lFqwlloeoHrXuxhAnto0Kiq4za3
         NOdYvAhkinwqQV/ObyvL4XZhuWMYApViLteSJDnPDejrSge84x0u+bRMiGsFTpf2so4b
         kEPuKhtbyv4u0ZyYVhVKrBaAFJX75l/qBU/IPm4UAwwepBEjO+LAcbetmFze/CAksn78
         0O6/acr6XJXUs+Ck1rdBogNxg5Lb5oavZNcPtk5VtGHsnCOK3hKOwYwbKvd8Uq1JckVa
         LU0Q==
X-Gm-Message-State: AOAM5322/ftxenfYm3IJ2a0coZiG2OZe1SJH9xIJrdVnk2PSZh0z9hm0
        k71T4SekOYbQS+Zr9LTv53E=
X-Google-Smtp-Source: ABdhPJx2cdaZBxVejVEmjInER6IaxiP22CRXYCqxWtzm3sWV2Eo4EeyBw8awRRr1Ka3kuBuC+pSVvQ==
X-Received: by 2002:a17:906:878f:: with SMTP id za15mr14858137ejb.140.1630954988928;
        Mon, 06 Sep 2021 12:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 32/40] staging: r8188eu: remove AntDivBeforeLinkHandler from hal_ops
Date:   Mon,  6 Sep 2021 21:02:15 +0200
Message-Id: <20210906190223.11396-33-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove AntDivBeforeLinkHandler from hal_ops and remove its wrapper
rtw_hal_antdiv_before_linked(). Call AntDivBeforeLink8188E() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2bdc1ed18149..ef04845d7a71 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6370,7 +6370,7 @@ void site_survey(struct adapter *padapter)
 			/*  20100721:Interrupt scan operation here. */
 			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
 			/*  It compares the scan result and select beter one to do connection. */
-			if (rtw_hal_antdiv_before_linked(padapter)) {
+			if (AntDivBeforeLink8188E(padapter)) {
 				pmlmeext->sitesurvey_res.bss_cnt = 0;
 				pmlmeext->sitesurvey_res.channel_idx = -1;
 				pmlmeext->chan_scan_time = SURVEY_TO / 2;
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 27adaea61f84..1bec02b1dede 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -206,13 +206,6 @@ void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
 		adapt->HalFunc.SetBeaconRelatedRegistersHandler(adapt);
 }
 
-u8 rtw_hal_antdiv_before_linked(struct adapter *adapt)
-{
-	if (adapt->HalFunc.AntDivBeforeLinkHandler)
-		return adapt->HalFunc.AntDivBeforeLinkHandler(adapt);
-	return false;
-}
-
 void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 				  struct wlan_bssid_ex *dst,
 				  struct wlan_bssid_ex *src)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 33d4e534f05e..62fd62ced0e5 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1773,7 +1773,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
 
-	pHalFunc->AntDivBeforeLinkHandler = &AntDivBeforeLink8188E;
 	pHalFunc->AntDivCompareHandler = &AntDivCompare8188E;
 	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 4b937bd2c63c..929e861cc81b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -156,7 +156,6 @@ struct hal_ops {
 	void	(*run_thread)(struct adapter *adapter);
 	void	(*cancel_thread)(struct adapter *adapter);
 
-	u8	(*AntDivBeforeLinkHandler)(struct adapter *adapter);
 	void	(*AntDivCompareHandler)(struct adapter *adapter,
 					struct wlan_bssid_ex *dst,
 					struct wlan_bssid_ex *src);
@@ -256,7 +255,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
 void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
-- 
2.33.0

