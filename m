Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53740203B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbhIFTGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t19so15107764ejr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNRpiblACd1XahKWtsfFQ7za/HUNceoFV4adLbdklTA=;
        b=MJRhqWqEYBhgAMPV9u3P5lrrVfA564dtG5IWKs8xHYW+ECxumC0oYu2zXnlccKn5NM
         BC8jSMzxfeZQ3u9FpEKPVVMrlY2O3AmGd4W4yNwPB/P7WnRzBKDZDUM0bXdp1IzdHiDg
         Z44kaUnqSrDHciOQT8yUpR/qmrWZx8mxNdp+Tk894NIp2aD2AEjhfbMVfU6iy1npcigj
         L0fD2jUZH9WFUIJizeY9AQP7Gq9v8Pfcih6auEQCyGs3KxUTUuuWrnhof05DawBJPvjG
         suFdhcXG7eOWaZ3ZcafVSMjJi86uEfbdjvsy2oZJnWcw57Ds2IrcJAL5lLr9ATQKpHQW
         Xsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNRpiblACd1XahKWtsfFQ7za/HUNceoFV4adLbdklTA=;
        b=QFEDnNVSvSFMj6jx6k0wQH9ZYmAIc0tACDtIcTYiJ2rqXVnIOhq/fqlRRcoOioBiyk
         j5Lk4su5/IUFu8qzVGxoLaX44wziFao6Ik5qX0Il0lTV1X2BmrirWHHckpVuNrflmg4r
         QmjgNnzR8o5L7HzLD/iTIBLtc9TIsG5M/z1E6bFnsxAFET+fwaOGrPfw6e0/QIpmDCR5
         C2pSSDcn7kpCK9hyCxPoiAAfIhcZFkX/7t5BEjebRN5BpDcS8GTaWJ6McmptYN1ugfz8
         4XqOAQAPvSqJsvj5qvyYaTccrMldPLsNlmtH7HZ1TqZmX4qtAPMZSGDghhogcE4QJ9RI
         +d2g==
X-Gm-Message-State: AOAM530mGJr96cLU3EUd3vMJrw28p6lbfiQFDH/FdBJR0GfwleLCVrzC
        CBVOozm8LsunvDDELfIlIbA=
X-Google-Smtp-Source: ABdhPJxsM+XrUVemdKGeTt0UqHSitFcmHQ2EZQoQEED1JKGwP31KWZTfosxcEXErFucs114+OMVe3A==
X-Received: by 2002:a17:906:3054:: with SMTP id d20mr14793614ejd.294.1630954986135;
        Mon, 06 Sep 2021 12:03:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 28/40] staging: r8188eu: remove Efuse_PgPacketRead from hal_ops
Date:   Mon,  6 Sep 2021 21:02:11 +0200
Message-Id: <20210906190223.11396-29-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Efuse_PgPacketRead from hal_ops and remove its wrapper
Efuse_PgPacketRead(). Call rtl8188e_Efuse_PgPacketRead() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 9 ---------
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 ++---
 drivers/staging/r8188eu/include/hal_intf.h      | 3 +--
 drivers/staging/r8188eu/include/rtw_efuse.h     | 1 -
 5 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 9196a7925940..518ed5b2e8d2 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -247,15 +247,6 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 	return result;
 }
 
-int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool pseudo)
-{
-	int	ret = 0;
-
-	ret =  pAdapter->HalFunc.Efuse_PgPacketRead(pAdapter, offset, data, pseudo);
-
-	return ret;
-}
-
 int Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool pseudo)
 {
 	int ret;
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 48f0f3b8dbb8..4c56c0da7625 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -974,7 +974,7 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid == QUERY_OID) {
 		rtl8188e_EfusePowerSwitch(Adapter, false, true);
-		if (Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false))
+		if (rtl8188e_Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 8b7fde0a49f1..9cbb13a07f83 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1294,7 +1294,7 @@ static int Hal_EfusePgPacketRead_Pseudo(struct adapter *pAdapter, u8 offset, u8
 	return ret;
 }
 
-static int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
+int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
 {
 	int	ret;
 
@@ -1313,7 +1313,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 
 	memset((void *)originaldata, 0xff, 8);
 
-	if (Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
+	if (rtl8188e_Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
 		/* check if data exist */
 		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
 
@@ -1782,7 +1782,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->Efuse_PgPacketRead = &rtl8188e_Efuse_PgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 640195a4c830..115d2598b3b0 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	int	(*Efuse_PgPacketRead)(struct adapter *adapter, u8 offset,
-				      u8 *data, bool bPseudoTest);
 	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset,
 				       u8 word_en, u8 *data, bool bPseudoTest);
 	u8	(*Efuse_WordEnableDataWrite)(struct adapter *padapter,
@@ -220,6 +218,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
 				       u8 type, void *pOut, bool bPseudoTest);
 u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
+int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 5cd1313dbe36..d19ef73be39e 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -116,7 +116,6 @@ void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
-int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data, bool test);
 int Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data,
 			bool test);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-- 
2.33.0

