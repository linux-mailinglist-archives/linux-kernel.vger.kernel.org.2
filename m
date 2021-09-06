Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13A140204C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbhIFTHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243143AbhIFTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD0C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e21so15056322ejz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7Q5ZHy3T5GJZxSylTWg0OrJkmDBjXdj8q48DoC9j8Y=;
        b=n0FIx6KuMtY+iRXYXTgrAfN60lAbfvkSKiA62/JeXzn++1aPOfe8n5KvErjITyyKRY
         MduUk8+HRwJQHNFd12irn2JjibdsnOAMFQaZhwvEmVsHA43+bQIqeLGy+5+PUKq5SXmg
         F32IvsElZDkGXaflsyK0YwRs5FaZo08JczOWZCM40172ndtuIYoNFPEbhKo1cAzuBLnN
         bfX25r9uErRUOA8dQPJe9T6J5JNMfrkksecuJX3Ee7oIeE5aM8YVzzPRXltfdQ2N18px
         seEbglkqO8vE/4WzKc11QdWguDS/TXeJwEqPFL5sMLLBLtkgse55ho6MOgIBMPywfxsF
         4u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7Q5ZHy3T5GJZxSylTWg0OrJkmDBjXdj8q48DoC9j8Y=;
        b=GuYUf9jws3bnsbBLNmgv6mNZzWljHMUlbyk20W6IytYzymYU7ATA/owXYLkdmYf4ju
         dTMduqoMlXgMRrO07HK/yN3rnwt1jYXhvpgyGwKdeJXFCMYmmGIiYx+ieEewcVp2Pdop
         Q0wRoEF3yypLIuZJaZWMmpxngpnP4PVSa3udmpOoBST2kTGyu3+WXRKTKsmdyIeH8fHK
         /pmH3A4/CnG9Pu9+WFxAaXuPo+knaJqh8AIMmuNgxf678mgVexMkEp+VWORwtUxLZo44
         WriTlL9nfOwtburZmBRtTVp+bALVWOTMAIrGjC3dSUGQ8Y8C0O9I66bbY/zfKMp84diQ
         4J2Q==
X-Gm-Message-State: AOAM531y77W+RWdRAwZkYv27X9jRCZb+40cqf/cU/fYTGtulTwAwwjOu
        haxUg8C6yPTtWnFpuQX4iLjQHt1p4XLZGg==
X-Google-Smtp-Source: ABdhPJzp5G6bYz6BKMzuElwJw7XSGX9c5/49g0BYtww43RvGoEkP7LNL/VYSglL7YA1iV/P/pYzvCw==
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr15088682ejb.450.1630954992538;
        Mon, 06 Sep 2021 12:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 37/40] staging: r8188eu: remove free_hal_data from hal_ops
Date:   Mon,  6 Sep 2021 21:02:20 +0200
Message-Id: <20210906190223.11396-38-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove free_hal_data from hal_ops and remove its wrapper
rtw_hal_free_data(). Call rtl8188e_free_hal_data() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 6 +-----
 drivers/staging/r8188eu/include/hal_intf.h      | 5 +----
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4394c6825f1a..17ac271e2417 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,12 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-void rtw_hal_free_data(struct adapter *adapt)
-{
-	if (adapt->HalFunc.free_hal_data)
-		adapt->HalFunc.free_hal_data(adapt);
-}
-
 uint	 rtw_hal_init(struct adapter *adapt)
 {
 	uint	status = _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 9a76e9aaa2d0..22750cd40d45 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -669,12 +669,10 @@ void rtl8188e_InitializeFirmwareVars(struct adapter *padapter)
 	pHalData->LastHMEBoxNum = 0;
 }
 
-static void rtl8188e_free_hal_data(struct adapter *padapter)
+void rtl8188e_free_hal_data(struct adapter *padapter)
 {
-
 	kfree(padapter->HalData);
 	padapter->HalData = NULL;
-
 }
 
 /*  */
@@ -1760,8 +1758,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
-
 	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 35201286704f..9b0a44659f57 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -127,8 +127,6 @@ struct hal_ops {
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
-	void	(*free_hal_data)(struct adapter *padapter);
-
 	u32	(*inirp_init)(struct adapter *padapter);
 	u32	(*inirp_deinit)(struct adapter *padapter);
 
@@ -194,7 +192,7 @@ void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
-
+void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			u16 _offset, u16 _size_byte, u8 *pbuf,
@@ -207,7 +205,6 @@ int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
-void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 3b277774b39a..97889d17a0e4 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -946,7 +946,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_free_pwrctrl_priv(padapter);
 
-	rtw_hal_free_data(padapter);
+	rtl8188e_free_hal_data(padapter);
 
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
-- 
2.33.0

