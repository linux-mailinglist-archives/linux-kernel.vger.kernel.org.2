Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA12402046
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbhIFTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72660C0613A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u14so15077851ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXXSA0c+SHY34EOMuaUJW7qEAiEP8/m0m4ZBvHYTna8=;
        b=NrTxGG8XrD0/rdBps/3A6JBfgBkJvnrRgB4IYT0WT+uS+mjKaj0oQNN9TrNKUrywIV
         HNb/Zoj3e4FKFnSjePHj0t7HHljxt76oHhZjwxxW3G/Bwng8PfFOTggkQENjJaqDtUrF
         wfcIKO9uhhlSKgSlYcNaoVKrv29fdWp3M8n8Ybs3CndKs04IA4alkAETgGB4gteFaZG6
         wKsrjL3aSTnsqDo5cIKUg3OugTTnAdJiINm7CBsPMKfIiPF61iFYHe/aoWhcvaFnn79v
         7mPyrKhVxdXyqMoVa2Nalt6YCQozlsbP/Wi0068dlh8mKZzp769bsMrMkc8Rp+30wNdN
         P3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXXSA0c+SHY34EOMuaUJW7qEAiEP8/m0m4ZBvHYTna8=;
        b=S0mOJMzgOmDndvsbQbJVhvg8sZG32WO2zZAApEHEDmblVXZFJy+dXxxxXGXpBO5JHe
         fGovhKASt/6L7oKwVvGA15BSpC5hXqUE0C8KOxgN4o38EmhGspJ2FUS0WHmPoIgexxSt
         ey90X68a+yPuBNwkKhkckpmRma3cVvIvTOr5qq44PivJVmRosExK+t34XD+iZVHiH+03
         nGOM/lUkJV9yb54pIgRYYyDUClBBJBMK509HCU9akh82kS06odT3YR3WIqJy+Gp44IFU
         9x+NdTeFYKuMrfP7F0NrJCptGGHimBJdZgrzB//PSQ1F64RWa+21ls6V8VAWDhqfB5aV
         V27g==
X-Gm-Message-State: AOAM5334gsNg0QAE2xa/mHYTnvlbC4YsuOFfWEeQDtdWM1ShBuwmK+iw
        If4njw+cDrcikBmK/WkeJYk=
X-Google-Smtp-Source: ABdhPJwcSCWB1rbPAOP1/qgV2muNa6gdBhd/17fjqqF1eGzPM3ZD2MPSE4LnrE1B/rIdYKBJ8p+Iiw==
X-Received: by 2002:a17:906:1d19:: with SMTP id n25mr15140242ejh.11.1630954991065;
        Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 35/40] staging: r8188eu: remove empty function rtl8188e_stop_thread()
Date:   Mon,  6 Sep 2021 21:02:18 +0200
Message-Id: <20210906190223.11396-36-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty function rtl8188e_stop_thread() and related code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h      | 3 ---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 --
 5 files changed, 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 3ea581fb2c7e..4a9820c2b36e 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -151,13 +151,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-/*	Start specifical interface thread		*/
-void rtw_hal_stop_thread(struct adapter *adapt)
-{
-	if (adapt->HalFunc.cancel_thread)
-		adapt->HalFunc.cancel_thread(adapt);
-}
-
 u32 rtw_hal_read_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask)
 {
 	u32 data = 0;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index fc420cbec5de..f87cfa0e404a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,10 +1748,6 @@ void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_ada
 	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
 }
 
-void rtl8188e_stop_thread(struct adapter *padapter)
-{
-}
-
 static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
@@ -1766,8 +1762,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
-
 	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index caee83ed962d..fdde4b2b8ec4 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -153,8 +153,6 @@ struct hal_ops {
 				       u32 mac_id, u8 rssi_level);
 	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
 
-	void	(*cancel_thread)(struct adapter *adapter);
-
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
 	s32 (*mgnt_xmit)(struct adapter *padapter,
@@ -236,7 +234,6 @@ void	rtw_hal_free_recv_priv(struct adapter *padapter);
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
-void	rtw_hal_stop_thread(struct adapter *padapter);
 
 void rtw_hal_bcn_related_reg_setting(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5947708594d2..40bc00a9b23b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -439,7 +439,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
 void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
-void rtl8188e_stop_thread(struct adapter *padapter);
 
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
 s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index c18f6a7237c7..3b277774b39a 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -742,8 +742,6 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 	up(&padapter->cmdpriv.cmd_queue_sema);
 	if (padapter->cmdThread)
 		_rtw_down_sema(&padapter->cmdpriv.terminate_cmdthread_sema);
-
-	rtw_hal_stop_thread(padapter);
 }
 
 static u8 rtw_init_default_value(struct adapter *padapter)
-- 
2.33.0

