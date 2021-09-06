Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AB40200B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbhIFS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbhIFSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77030C0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n27so15091688eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTO2QXrKZY0AGmkUtVFYURWGtcSjnC2Lr7CY2NRAnG4=;
        b=bLK3GLegpsgv72yW36JL8xtQkLIvtw6UT4qzox+xpApIuBYyHBymAsFAR+Ar3KYbKe
         63Pv5ZIYiMuuPEQiLDsY6UaUtxPaPJKGiGC4bpOlwoeslVCclHD7Dwsw34va9RCdT18r
         4PQO57h4LZtkKopXuydz7vEuBDm2Vtl/0ost3R3DReFfWw4lI5wnzTLmSFSFuetF8bCT
         khBCkBJvEBd2qgHjGJgS4zYArySGlN+d4mYRk/PDkF9viucE7KDIyfCt+K9sPCts1+cx
         xUSKQDsm2VBoGQlFsgJrCd8T+Gs60gbk1q+WpZ/YdP6cTenqi2TuFrvohziktkyVYRlx
         /nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTO2QXrKZY0AGmkUtVFYURWGtcSjnC2Lr7CY2NRAnG4=;
        b=P5Wa5o2qb4HXGj5WdKS9Qao/kI5HCtwD8NS/pKFSLThIRr1wMScEoUgzLyi+KtFZ5M
         4MHz79bm0eM8K+3tu+Rp1VeEtwt/+WNfnXZZkReOzSjbdzO1KMM3CMa5c+LYesl/XeJ6
         D6fUMyl5lrQoFO2zdQTLWiNRs9SeosBDI30gcURYPAIkH4MZ9GyGnT7J3F2uAT8LvIHy
         PdgCa5dgcxuzJggROAMM8p4ZTDvd2/7k+ON61omzu+OSHxz3p/VvS/tUcJqJcZYDDoLq
         +zW79KAtb5fPQlapwAwGjPYaEpajKOYASEJLtH0mSKNxrKeDT97PMTTkQ1f4MpSzcKHK
         6H6Q==
X-Gm-Message-State: AOAM533Y2DinDnj5sNzpEi+Xk3hIZ/OtfHIow1UcTtnHaqNlPv2/7hGa
        X34WOjcgfKOUtFxMBJmUGgs=
X-Google-Smtp-Source: ABdhPJxfkiCxc0pjKRKN9BoNcZvv2i5RCauxeaVG1sVbKUeB2Vj6UJE8/K0rBX1a2ta9N9/yW0jOqA==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr14813151ejr.398.1630954466125;
        Mon, 06 Sep 2021 11:54:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 32/40] staging: r8188eu: remove AntDivBeforeLinkHandler from hal_ops
Date:   Mon,  6 Sep 2021 20:53:19 +0200
Message-Id: <20210906185327.10326-33-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

