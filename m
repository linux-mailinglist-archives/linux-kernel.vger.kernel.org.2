Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C919402003
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhIFS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbhIFSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D772C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j13so10567055edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIzcA7kDeR7Tp8yYzZpF0njPv2fcxCf50SRHZkuULqs=;
        b=AuCk+1Hm/S/HD6cXlT41eMk6mX4A/kiVpdzg7cEDgw/Zwxi1u53DgBdG+zpedYm6NY
         QNiMUdJ+FTWwWfA1Dj/6IBe5pWKpyvQZC8IusBLoi1fGLLL+WDgY3jBB6wPlNkMYhqRZ
         qPYgEWUWg0bs6nV2uNdB7ny6h7UGche5awO4B7e6FfNUfitnWAr6ugcrXPtdTBrHkzZV
         rlTxhczb2KTHBfooTZvKebxNlX7oFyMXeDn/t/FFrEDrFHiunMr/DNSKbvgS2xEAnIOI
         AE5HiX2x3Ta/hLKZuH5lyswrqzna/NjdWu9isVyPvGE/hZJAIKcu+4e4WCMx166Ltgei
         xqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIzcA7kDeR7Tp8yYzZpF0njPv2fcxCf50SRHZkuULqs=;
        b=nplU4dsatwTWtHDYGJtJnFZ1fJm+qdt/WzTZIBQpXh/V5E3J5qVX4oJdMdnwA+M8TH
         V2QJTxbYwbjjO2tfROt2wBYLwvxOHcoFeR+2bNjeN+LYjZoIuvx9GXAgMZl9tXxb0DbG
         cZ+EheRnEmDS1vjtjO5YbZjrTE7x37gB45BEKBfkeV2QvgqRqAoymhEl6okHq2yHM4jy
         wO7xGuwLSIwteW6GX71loTxHB13siwH/ECciOCEhGyI8S7ZubRABt5CxLEZFixgDcfH1
         nxDt12a6oLvGV+lO12BTr3scJV8LhC8fwcQ6nJxPj/LfG5Rq3SV9hjFzsf8iEvqrh5jE
         b9zA==
X-Gm-Message-State: AOAM533OgtBPh03A0reoXcNm6T098PxK56spfyt4mrhzXZJLqCgfLU/g
        ClFRVHMQvsdTOFtNmEwcpuU=
X-Google-Smtp-Source: ABdhPJwJt8rsgOh2QQ9c4p7tu8VzBqx0D7GlkGIm3kk8rtRxIXqWt9M/2T8cNEAW6xsiT439rlWfhA==
X-Received: by 2002:a05:6402:1e8e:: with SMTP id f14mr14732572edf.15.1630954460292;
        Mon, 06 Sep 2021 11:54:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 24/40] staging: r8188eu: remove ReadEFuse from hal_ops
Date:   Mon,  6 Sep 2021 20:53:11 +0200
Message-Id: <20210906185327.10326-25-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ReadEFuse from hal_ops and remove its wrapper
efuse_ReadEFuse(). Call rtl8188e_ReadEFuse() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 11 +++--------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  7 +++----
 drivers/staging/r8188eu/include/hal_intf.h      |  5 +++--
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 1aeddfa2f14d..faf6cefaa4f0 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -175,11 +175,6 @@ ReadEFuseByte(
 /* 					write addr must be after sec5. */
 /*  */
 
-static void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool pseudo)
-{
-	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, pseudo);
-}
-
 void EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool pseudo
 	)
 {
@@ -450,7 +445,7 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	rtl8188e_EfusePowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
+	rtl8188e_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
 
 	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
@@ -468,7 +463,7 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	rtl8188e_EfusePowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
+	rtl8188e_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
 
 	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
@@ -745,7 +740,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
 
 	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
-	efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	rtl8188e_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
 
 	rtl8188e_EfusePowerSwitch(pAdapter, false, false);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b5d0cd332165..eed32dd6ee28 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -912,9 +912,9 @@ static void ReadEFuse_Pseudo(struct adapter *Adapter, u8 efuseType, u16 _offset,
 	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
-static void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
-			       u16 _offset, u16 _size_byte, u8 *pbuf,
-			       bool bPseudoTest)
+void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
+			u16 _offset, u16 _size_byte, u8 *pbuf,
+			bool bPseudoTest)
 {
 	if (bPseudoTest)
 		ReadEFuse_Pseudo(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
@@ -1782,7 +1782,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->ReadEFuse = &rtl8188e_ReadEFuse;
 	pHalFunc->EFUSEGetEfuseDefinition = &rtl8188e_EFUSE_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &rtl8188e_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &rtl8188e_Efuse_PgPacketRead;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 86456bac3a5a..e1bb1f30c7e9 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset,
-			  u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType,
 					u8 type, void *pOut, bool bPseudoTest);
 	u16	(*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType,
@@ -220,6 +218,9 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState);
+void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
+			u16 _offset, u16 _size_byte, u8 *pbuf,
+			bool bPseudoTest);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
-- 
2.33.0

