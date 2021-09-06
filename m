Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1976402032
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbhIFTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245215AbhIFTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1FDC0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eb14so10614823edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JLjw1LG1EqFWNQ8nBF3vVHD63NcJfn88butHEvinAA=;
        b=T1griKZtt9nUYthUy8YwEod8iMiugibDhE31UGT8TQYAqSOW8VZCJVdvyt24xuUeH5
         fV5oI7G/L8c+ltvw3Oyc0SGuj3DFH1daLv3Vgl+kYO9jyhq9ty56YfI54iyNzEX3+fqM
         me+Z9T4nFHF+Q7ljzSxQcn9nFNhQ73SqMaVD7OHknTFGvAv9/jie26L/cjAJzgP9N7hc
         +bFlqh18hu8IGRTuj64lhnO+PYnqSHPN1IlhK0JWomtmoy5n7hZQnnH985G1UvD6G9nX
         ZrbXDXJ6MuN7uQGRno20gE9JORFdggnKVI3Ev+T8ChyTQcTd100sXd5p/zuEn/Ei2wGT
         THIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JLjw1LG1EqFWNQ8nBF3vVHD63NcJfn88butHEvinAA=;
        b=E7dIeXfP8CAXSnkOVklUxCcGRCTI0CizoBZnksc43JlCzT9iB7cIi5yZsXGdlaCGHL
         VHt6bpreEvBKdJcYhEl0h3RCh3SVwJW7NCSjSUZ1IFCz3UBukucZcmhc3AlopQS3848P
         xKAYCWSvun37xkZnzQ0Kx1vjhxUT5wttDRhoQ3g7I3Sug4jyioQYjroHd1iWS7y17kJN
         ofVmk3PMyxZS7bAiuRFiRi9lo2FrcCrIn/lpqFS34uh3krt8+N15bfus3qzO5rJYwM0Z
         I3cDG7CajeKjZc8s93S514K8c9bAQLBQe7A3nEzGC3lbKtUnfiIc0U37LwUaP0q39d9s
         Y2xw==
X-Gm-Message-State: AOAM532cGb2uAxc7UwNzEZJihuAWnw+PokjUknmQxBkfjSdu3q7TOvvT
        uDBR3Pxh2b8DuLS/NHBECes=
X-Google-Smtp-Source: ABdhPJzbGrH5V3a9AIvgqkeCHmbUpJvTRyr94GzfBWzK1IuxAv329DVgVJHjHPhLxRqQ+yNn76U1fA==
X-Received: by 2002:a05:6402:3090:: with SMTP id de16mr14920253edb.7.1630954981052;
        Mon, 06 Sep 2021 12:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 21/40] staging: r8188eu: remove EfusePowerSwitch from hal_ops
Date:   Mon,  6 Sep 2021 21:02:04 +0200
Message-Id: <20210906190223.11396-22-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove EfusePowerSwitch from hal_ops and call
rtl8188e_EfusePowerSwitch() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 7 +------
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index e1a9c031435b..8388ec60d21d 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -82,7 +82,7 @@ Efuse_PowerSwitch(
 		u8 write,
 		u8 PwrState)
 {
-	pAdapter->HalFunc.EfusePowerSwitch(pAdapter, write, PwrState);
+	rtl8188e_EfusePowerSwitch(pAdapter, write, PwrState);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 04c382e698f9..c7edb9ba4085 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -757,11 +757,7 @@ hal_EfusePowerSwitch_RTL8188E(
 	}
 }
 
-static void
-rtl8188e_EfusePowerSwitch(
-		struct adapter *pAdapter,
-		u8 bWrite,
-		u8 PwrState)
+void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
 }
@@ -1795,7 +1791,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->EfusePowerSwitch = &rtl8188e_EfusePowerSwitch;
 	pHalFunc->ReadEFuse = &rtl8188e_ReadEFuse;
 	pHalFunc->EFUSEGetEfuseDefinition = &rtl8188e_EFUSE_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &rtl8188e_EfuseGetCurrentSize;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f85385cc9288..86456bac3a5a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	void (*EfusePowerSwitch)(struct adapter *padapter, u8 bWrite,
-				 u8 PwrState);
 	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset,
 			  u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType,
@@ -221,6 +219,8 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 
+void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState);
+
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
-- 
2.33.0

