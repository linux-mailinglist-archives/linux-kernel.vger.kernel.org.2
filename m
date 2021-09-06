Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18559402010
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbhIFS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbhIFSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24163C061292
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so15055137ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7Q5ZHy3T5GJZxSylTWg0OrJkmDBjXdj8q48DoC9j8Y=;
        b=cat9gC5NyDMjI0hIBaasdUUxI+L/1EODgDdf4u2HmmdA5UOlY50PnE4xggAzbf2WzP
         lDoX78YcfRExdM0s1HaNv+NC+OMLzpOSo1AuaT7g9mxO3VhPvAVHgenOnGg5eYxHbcKo
         oKvWnV7rOSRg6+6yQeh0zJqVlWW9ZeBsQK7rsYA4+lemFv4tv/OPX7WVf4wpRv4Vc+Qq
         HNU0yvR8Pe6Oi7S2RggAJxj40ivt94swHyISF0UmNu/mXMZbgfADkaXRfAAG37T7nBCB
         1VwHE4Tm4FotqCBKxdrt3lrho6MxYI+lEngLyrDC44kHuIlm9mHl9tA71DcgbcSCDG1E
         mZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7Q5ZHy3T5GJZxSylTWg0OrJkmDBjXdj8q48DoC9j8Y=;
        b=S3dHGmSwFIl26ZVmDTkHfhymYdaFvPVbVvIh260Z+o1pi3GsJXZLj923XWpCvdRbGf
         E2vKB4Jai5L8NEEJxAzL1HHgGpN1spzYW1IOUrc5H5HoaCN6PRqQlZ15m0os3oRfmEOC
         PK1Jv50uob+LBjj/91OYM0jWW7QjTgWlEyPy//V3zJWQDk9UaiFvg3zIKXwPlgEv3vS1
         hbmJ8Dp+ZlQPe5fmHUTwre0hTyG6iXZMOD826AqS737nPx+cF4jLQYnw1CiS85Mur2uk
         +3jhskrZ3CVFlB5x6n3ZGH6135+xic1wF1RTQvLOu/0IUBtYs+D5N9ogzszWtMsRjvis
         BKRg==
X-Gm-Message-State: AOAM530gcSnatt0m1QnhubcLz/zSEtOpBr+JESFkBsVdt8Q6ZFGl7ePv
        3nVhwfiHa1rrPWfeJUbXkh4=
X-Google-Smtp-Source: ABdhPJyFWn+BYvOETxEQNkdopvTyqQHIESmkh8Ck/wCzeYtqzRp6IpVw5xda7OSq5apUj3r5S9Dm6g==
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr14619153ejc.511.1630954469775;
        Mon, 06 Sep 2021 11:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 37/40] staging: r8188eu: remove free_hal_data from hal_ops
Date:   Mon,  6 Sep 2021 20:53:24 +0200
Message-Id: <20210906185327.10326-38-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

