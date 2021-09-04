Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24606400B62
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhIDMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhIDMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98130C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i3so1126686wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjGQcdj4Knl301hFJWFCQe4nS0zuwuso/gUPSHuU+kk=;
        b=mUTX1s8FzIPXMm06vlMVqQEZE+Kt4QHu/KrHTawfFQFZoeNZ8dvxkdagqoh4dofeXw
         QIF7y96Pzs/BW1b9724EagAZISq0eTNMbXnm+sAzKDGwLsxDAsRwmFLrv4EIkECsWeYU
         jHsYWTq8qcvi0P45NJWr+tu1pwn3URo1mm+VZWHJJvgelvBFl5mGvzz8xSlaXu2vtsrf
         mBIcx+bo1ykQAKOlkD0mr0AMgXoi4ib1Tf8vtOUBCzKX6U05zSGnvyckgbjK1vZpLrak
         gUbuJMfk+6p9kw9Rq9tR+B/Um4R5uZmwr3iWGQrKSwSGG9CxXoDNL6VoUf5OYG/eDBO2
         YiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjGQcdj4Knl301hFJWFCQe4nS0zuwuso/gUPSHuU+kk=;
        b=TavWWUoEUeCkKUDsoo2A08P8oElUobqmIOU7OpnOpT4FASpI7Ze2tQOkIXU/sCwjSQ
         8QAAEcoSa6qqxdO26/xqf/7E+RTDlbGvZBfmyacAZeXlMrmLunXci4FzC7UA4DbS+5GI
         cR9g0qg8ywPEttomRuckDaNWIRvpfsXIFtNzBBc+DOYXDIFoiz0OuOtQHxBtDye7H974
         E2djRuMEPb5WWGQg/v5qHIQOMOixcxwHhYYd1Ds9McN6DbAQOhVa5Bbb9ZSXarkpRq4U
         unnvV1bXmjbjwAow/QYrysfcEQDOh0S/HY+/SWVDpfzm80kvzVp7Ih3GIz95p5YhyNoC
         aF2g==
X-Gm-Message-State: AOAM5317zzfQeK000tvS0UlEqK0McD5O9UhWA2mUyh2XvQEy2zmDtUZt
        bMLiBEPlO4u9qqSHWX1Gdto=
X-Google-Smtp-Source: ABdhPJx+GXPj0ixBefkedjRjO6Tfzn47DxFFROLLwf2caNscMZeVpJ0+LiLNJai68So4xOXVkvploA==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr3172882wmc.102.1630759255320;
        Sat, 04 Sep 2021 05:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: remove GetHalODMVarHandler from hal_ops
Date:   Sat,  4 Sep 2021 14:40:32 +0200
Message-Id: <20210904124033.14244-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove GetHalODMVarHandler from hal_ops ant remove its wrapper
rtw_hal_get_odm_var(), both are unused.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 -----
 drivers/staging/r8188eu/include/hal_intf.h      | 6 ------
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1a59644679f1..9069b52f83ff 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -124,15 +124,6 @@ void rtw_hal_set_odm_var(struct adapter *adapt,
 						      val1, set);
 }
 
-void rtw_hal_get_odm_var(struct adapter *adapt,
-			 enum hal_odm_variable var, void *val1,
-			 bool set)
-{
-	if (adapt->HalFunc.GetHalODMVarHandler)
-		adapt->HalFunc.GetHalODMVarHandler(adapt, var,
-						      val1, set);
-}
-
 void rtw_hal_enable_interrupt(struct adapter *adapt)
 {
 	if (adapt->HalFunc.enable_interrupt)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 64a0223f0ee0..09f7bc010ba7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1728,10 +1728,6 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
 }
 
-static void rtl8188e_GetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
-{
-}
-
 static void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
@@ -1823,7 +1819,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
 	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
 
-	pHalFunc->GetHalODMVarHandler = &rtl8188e_GetHalODMVar;
 	pHalFunc->SetHalODMVarHandler = &rtl8188e_SetHalODMVar;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 7046f4b222b6..d5cf9b0d9a77 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -174,9 +174,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	void	(*GetHalODMVarHandler)(struct adapter *padapter,
-				       enum hal_odm_variable eVariable,
-				       void *pValue1, bool bSet);
 	void	(*SetHalODMVarHandler)(struct adapter *padapter,
 				       enum hal_odm_variable eVariable,
 				       void *pValue1, bool bSet);
@@ -290,9 +287,6 @@ u8 rtw_hal_get_def_var(struct adapter *padapter,
 void rtw_hal_set_odm_var(struct adapter *padapter,
 			 enum hal_odm_variable eVariable, void *pValue1,
 			 bool bSet);
-void rtw_hal_get_odm_var(struct adapter *padapter,
-			 enum hal_odm_variable eVariable,
-			 void *pValue1, bool bSet);
 
 void rtw_hal_enable_interrupt(struct adapter *padapter);
 void rtw_hal_disable_interrupt(struct adapter *padapter);
-- 
2.33.0

