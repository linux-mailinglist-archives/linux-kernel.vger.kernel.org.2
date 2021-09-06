Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227FC40200F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbhIFS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbhIFSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2CBC0613A4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n27so15091912eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6Mu2rmKCPwNJW+9zwnqhgEVtP2V6TMjoxJ0ql5/F1I=;
        b=SoRDw5MME8u/nH+eRY+ImHFCaKPG3MlFoOIoNVNS6BY+B/nzEBwYJW3LmI/2AwDC5s
         wNMLROjzBA0OzsB2YgrofIHJor3PezOZjdfvAhwho87Vxl0LtgNtRt24dJdU0Dyp3W2f
         DFtvaoMRxZ+noJAnlFeVoVkjhWoH+gz+zsj4c0hZ7w0a0aqbsRn/UlHWCLUuhS/iEgXb
         ItWbECwgCNNtEoWn5V5zxpKwCC5Z6LXSf18idRxHor907uyMziCCjThefw+Zszj7fgf6
         eh2K3K9l4ggoKe16vm7Sq33Z1K8qaSjDs1eLNqsPsYm4hmwCrsoam8B2tvvdjMCUyLHR
         FSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6Mu2rmKCPwNJW+9zwnqhgEVtP2V6TMjoxJ0ql5/F1I=;
        b=SLAEv18SBhfA8c0QGhmONKXvwcgO22A+m4mA56eCI5e07KhCOsiNpOdb2Emr+zEr7E
         9Ih4u9H3pY+ObWHhhUR4gGrHDuTVYS8DEVHgUhuhAlw8+mWfpTKLCC+Sn2qcXLfQlAyw
         ZZoP29oHZsKZXoIo3RVWQeAep14HlsjAOUchcNXLH5KKGvAelq1E2cjqO0XtM8YJbwrn
         pTPBM8a8E6NRuhlazyoDAnZRzdtRCdVPUj3x0zqmq6GVwPHxd3p3ma/bv64aaNi+qJjX
         9fp4SBagv/Qkp2mNQa5j/WHn7ci8jHo82RasLcF5jrZeMt9bXPyqr+32dqtzo8m5zKrH
         wArg==
X-Gm-Message-State: AOAM533I76CjpjG9oJaZROMnxWd25QYnT7xRgPFKujbWWBcQ04Z6v/wj
        GSQXONX89PMjF0D2iAun4Ps=
X-Google-Smtp-Source: ABdhPJwuORQc5BSzTNOzlONv6HzgA7IvZ/3UMXRaufSmzzYp42/H83B/bayEEHgelvuoVMCfQg00yA==
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr13890688eja.57.1630954469082;
        Mon, 06 Sep 2021 11:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 36/40] staging: r8188eu: remove hal_notch_filter from hal_ops
Date:   Mon,  6 Sep 2021 20:53:23 +0200
Message-Id: <20210906185327.10326-37-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_notch_filter from hal_ops and remove its wrapper
rtw_hal_notch_filter(). Call hal_notch_filter_8188e() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 +-------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 6 ++----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4a9820c2b36e..4394c6825f1a 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -24,7 +24,7 @@ uint	 rtw_hal_init(struct adapter *adapt)
 		adapt->hw_init_completed = true;
 
 		if (adapt->registrypriv.notch_filter == 1)
-			rtw_hal_notch_filter(adapt, 1);
+			hal_notch_filter_8188e(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
 		DBG_88E("rtw_hal_init: hal__init fail\n");
@@ -201,9 +201,3 @@ int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 							   bndy_cnt);
 	return _FAIL;
 }
-
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
-{
-	if (adapter->HalFunc.hal_notch_filter)
-		adapter->HalFunc.hal_notch_filter(adapter, enable);
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f87cfa0e404a..9a76e9aaa2d0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,7 +1748,7 @@ void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_ada
 	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
 }
 
-static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
@@ -1768,8 +1768,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
-
-	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fdde4b2b8ec4..35201286704f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -172,8 +172,6 @@ struct hal_ops {
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
 				  struct xmit_frame *frame, u32 max_wait,
 				  u32 bndy_cnt);
-
-	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -207,6 +205,8 @@ u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bP
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
+
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
@@ -249,8 +249,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt);
 
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
-- 
2.33.0

