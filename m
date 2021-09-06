Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94640202B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbhIFTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245541AbhIFTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816AC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so9391750edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmbLARluVxMQ+ZokkZJzSgEYmy1Qusxy/6FmmYzAGJc=;
        b=OjyEBq85EXnSmdQni4t4o/a0F2VyQrcxd7NlvdEAffSRudypur4PcvR/0H4/k4TC8F
         suxON3ntO2PXwvPRT16Ootac7WIq+zhoFd2lNuaf0kfCHO32aINr8EzNv7zyfxG3MOZD
         urWhf+hqhvGKSQsXiQjL9HIvCr/PHQmpVOOIvTZpN4gSA5yfI0Qu/gZGdkPHWTsr7p2N
         11q+SY8TtOhH2ooTNai/6m2MYzA0j6brMoZA1P47WSIYJueUcNVmhwdU5TxsyZ5xzcqZ
         jjWvdHThjFNFaiEubRzIE30rZPaHlmv2CzjCCxI6RJp3xOkdP9UP12ypiq+oVcIK3MBt
         rrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmbLARluVxMQ+ZokkZJzSgEYmy1Qusxy/6FmmYzAGJc=;
        b=Ku6faas6zvug/krG54SINMU3fJbMLnBZnZnFFd+a6vRkIU5w/ZGL8k+jLUiOH4lRt/
         1xCPN9hby87EuVenDrmayxX33Aj0AU3Sf8/AwxU4JIVEZvtqlRL9yTkeZEKvoH6/xoaN
         n9yVLv02XyF2/m7OAUz8gSP+6I82TKBuCqgSbsMFIBzgYvdKLlDtv5H6rjvpi9EaJyJg
         MsyOB3OxzV/NexBUtVVvQ3K+A2OBcoiwXa7+2JDUYAfHk4Lp9j+/CJs1v5zn3RGwgRM6
         zjdOh5ZN7DvFOcEPrAY2sC/y/qlPKkqQsx0PXFL7GBeiRma+nnj5SgKL1anptAJ0iLoK
         DuQA==
X-Gm-Message-State: AOAM53096Dglo2WxZTmQlevAbvp/h+Qv9cpZqkzd8OF03rLyCk00bMDR
        nWqHTeohzbp1o9SG5lXzu7U=
X-Google-Smtp-Source: ABdhPJxmA1nCb4FriIsPzsBDcZdNByhrlK7bX+M0yR3Xe7cdR9uslsj/orTVwX+9HBiofuR82ZqC8g==
X-Received: by 2002:a05:6402:1703:: with SMTP id y3mr14724939edu.355.1630954975715;
        Mon, 06 Sep 2021 12:02:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 14/40] staging: r8188eu: remove hal_power_on from hal_ops
Date:   Mon,  6 Sep 2021 21:01:57 +0200
Message-Id: <20210906190223.11396-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_power_on from hal_ops and remove its wrapper
rtw_hal_power_on(). Call rtl8188eu_InitPowerOn() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c       | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h      | 4 +---
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 39b1a8711754..58ece9a1232c 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -12,13 +12,6 @@ void rtw_hal_free_data(struct adapter *adapt)
 		adapt->HalFunc.free_hal_data(adapt);
 }
 
-u32 rtw_hal_power_on(struct adapter *adapt)
-{
-	if (adapt->HalFunc.hal_power_on)
-		return adapt->HalFunc.hal_power_on(adapt);
-	return _FAIL;
-}
-
 uint	 rtw_hal_init(struct adapter *adapt)
 {
 	uint	status = _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0b14748e1346..207fb182ee6c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -904,7 +904,7 @@ static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u1
 	if (!bPseudoTest) {
 		int ret = _FAIL;
 		if (rtw_IOL_applied(Adapter)) {
-			rtw_hal_power_on(Adapter);
+			rtl8188eu_InitPowerOn(Adapter);
 
 			iol_mode_enable(Adapter, 1);
 			ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 7b9cca4e3cb4..2c010f12118a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -85,7 +85,7 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 				pdvobjpriv->RtNumInPipes, pdvobjpriv->RtNumOutPipes);
 }
 
-static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
+u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 {
 	u16 value16;
 	/*  HW Power on sequence */
@@ -2214,7 +2214,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
 
-	halfunc->hal_power_on = rtl8188eu_InitPowerOn;
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9f804f9f5363..63842cd469c5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -124,7 +124,6 @@ enum hal_odm_variable {
 typedef s32 (*c2h_id_filter)(u8 id);
 
 struct hal_ops {
-	u32	(*hal_power_on)(struct adapter *padapter);
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
@@ -227,10 +226,9 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
+u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 
 void	rtw_hal_free_data(struct adapter *padapter);
-
-u32 rtw_hal_power_on(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
-- 
2.33.0

