Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440F401FB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbhIFS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbhIFS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF4C0617AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g21so10537027edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIF2Esx7hxbd1+D8H3QRhY4CXlFqFtTlZU89yMkPcII=;
        b=RZ5GCmDjY0qsl/HoSBxcRBi1N+vcUN0qghJmhSorzRZWZKLrShvxj9TESzDWavjY12
         CsDiVyDnFd9vz07uhoae20vgDC1TcVUTurtU+hF7S5+h8Hf3iE+ns1MtmftDs7UZAKpB
         MKQjrZHyXsKlLA3Zs8g7vSgsN0odYCZU/fCh+v2/GQdEO3VkHvLdhKKkItGkOmyY1QX9
         CFVhbga4vdmRPT3thNhF0DhF/HhkE+QBemVZZIRJvRwPq4EPqooEeAJ9UjEOzbNrp0Yp
         ds5gVni+BJrc9Iwfl7JK60STYK8mTfAr8nhcLdY+0y9eMQnnBw5gzHflPsVSKzpd0tx3
         ceZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIF2Esx7hxbd1+D8H3QRhY4CXlFqFtTlZU89yMkPcII=;
        b=pdp2/X96h4eLmzQYIGJywEC5ndVzm1m0V7ZhmtoWy98XGOHP6ZJX067JsqVKg5EMfI
         0GrWS/J/05E8cLGJy7FKOnfo8eyInjLQy1JVjZV1z5+oXzDm04WBxgE4OoW/KABaC1Vk
         uKqCfj4eNkdrd9RqcKBCzJz33+Or/A6XQ76EqVHE8WxBrOUDUXGy5c+/kNiSAs7fgNqU
         lTPWgKcVNSUCsDHknve7wwBUlaVEAcJHYEQnvdFtFvUCe3tDnY4K/0qSNxVLZpYHwU5F
         tLI4qP3lpyHa1kwFxkIszPimPt/Mg6dMlPDfKCp3sutc1v0rNhsnQi8ZrAW9asBRlM1o
         xxPg==
X-Gm-Message-State: AOAM530TUZ6XuV5+8ss7vei9MqiujFI3EheoyQqETeWw1nXerMYDHf+r
        VJJJK2NOBtrLTY/jUVGDcPU=
X-Google-Smtp-Source: ABdhPJzr1VKQv+rvQMGklOzM5IqLwiS5FdggrGrM/8SCuE0gteyavDMzRBM1ZDfZhAgaqP/XzTI2jQ==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr14524700edd.63.1630952728633;
        Mon, 06 Sep 2021 11:25:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 37/40] staging: r8188eu: remove free_hal_data from hal_ops
Date:   Mon,  6 Sep 2021 20:24:35 +0200
Message-Id: <20210906182438.5417-38-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove free_hal_data hal_ops and remove its wrapper
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

