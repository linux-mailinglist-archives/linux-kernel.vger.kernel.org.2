Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714336FCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhD3OrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhD3OqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1CC061362
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i3so57235198edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtDNhuesiV092x3OUvFA66jxC2b1Nb/wzZi8zlya7+c=;
        b=DvS3jrnscMyDhfzctSjpve9s7yJBnfw47oU6Mg4pGhExjtiqCR3WMKiFhPH+yj5RFJ
         6L5xGXrAI1igVfa1ZLf8wupaRS/faB6QJVkSteZjaA2clV9BPmcjKtektVST4NIt+64+
         r/93YWRoFAXlIQBM8TsPqfUDl9TbpS9H1o/K/Pld4DCZZcIHMdSG+XhtuMmKSHixX946
         7dV7W+USgtB18Zf/SuHViKcasKq+q4zMXtJ4eadGT3qm+H+E2MIwQv/5D6X6xB2FwIei
         omo+IjNrnWg4fNDNTTF+Gg6CE7vnOmOUe1VDTQ9Oweuwq0/ovg7+I6FdmdF5yTQibpXY
         mjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtDNhuesiV092x3OUvFA66jxC2b1Nb/wzZi8zlya7+c=;
        b=XIEmtjPwqAtnoHOMCBxWo1ngDPTo3pPMt0j5mBRWlX1IL/qu5HBGq2aWhwvSYqJFPh
         ZPGuZa15I+Tqlnt/tkX9V1kqmbkhbpQuoMsBGxiTwvhAYjSsAI+nyPN98bwwa413vDEs
         Rqs6jWemwR5DeZmuIkSqqOi+5enWg8p4YaRG5zNkTiQ77xUc2o09X1r0vzCjbHEj5Mc3
         pioke6wzO3aEvzmXyEgRSBYiJeoEPoiZWSqGgng3tUCGCqiXLp5HHSvvcmt7CBYdOcbj
         dFN+ZOd7+/szdFqhrQtcBJHbK3EJahQSZx7A0hWLatV17CM4HQUtQf+GZB1fsixvsoki
         nlvA==
X-Gm-Message-State: AOAM530q+GSzokssdM76Fi0PDqWldVwAn1A2SdNr/ymn8LGnwOFuJGax
        k570dZGPKyvH7WzLT7f0fK04tFx5dXA=
X-Google-Smtp-Source: ABdhPJzt73pIjfIQU8RCsE9iPDDBSmFbzzx0iyewrU9WnU+2AovGslV012pz6xRPa4/EJVM3SBG0MA==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr6341971edy.224.1619793909736;
        Fri, 30 Apr 2021 07:45:09 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id c19sm1467824edu.20.2021.04.30.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:09 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/43] staging: rtl8723bs: remove commented out *RT_DISP logs
Date:   Fri, 30 Apr 2021 16:44:07 +0200
Message-Id: <85d7ec0fc3065fec11b79f0977571c9649be3dc2.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out ODM_RT_DISP and RT_DISP logs.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c      | 7 -------
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 179199993fa7..32f7eb952ca8 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -59,8 +59,6 @@ static u8 odm_EVMdbToPercentage(s8 Value)
 	ret_val = Value;
 	ret_val /= 2;
 
-	/* ODM_RT_DISP(FRX, RX_PHY_SQ, ("EVMdbToPercentage92C Value =%d / %x\n", ret_val, ret_val)); */
-
 	if (ret_val >= 0)
 		ret_val = 0;
 	if (ret_val <= -33)
@@ -166,7 +164,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			/* Translate DBM to percentage. */
 			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
 			total_rssi += RSSI;
-			/* RT_DISP(FRX, RX_PHY_SS, ("RF-%d RXPWR =%x RSSI =%d\n", i, rx_pwr[i], RSSI)); */
 
 			pPhyInfo->rx_mimo_signal_strength[i] = (u8) RSSI;
 
@@ -181,7 +178,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1)&0x7f)-110;
 
 		PWDB_ALL_BT = PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
-		/* RT_DISP(FRX, RX_PHY_SS, ("PWDB_ALL =%d\n", PWDB_ALL)); */
 
 		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
 		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL_BT;
@@ -203,9 +199,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 				/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
 				EVM = odm_EVMdbToPercentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
 
-				/* RT_DISP(FRX, RX_PHY_SQ, ("RXRATE =%x RXEVM =%x EVM =%s%d\n", */
-				/* GET_RX_STATUS_DESC_RX_MCS(pDesc), pDrvInfo->rxevm[i], "%", EVM)); */
-
 				/* if (pPktinfo->bPacketMatchBSSID) */
 				{
 					if (i == ODM_RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 4e21d98f7414..db06c778993b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1148,10 +1148,8 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	retU2 = ((bank-1)*EFUSE_BT_REAL_BANK_CONTENT_LEN)+efuse_addr;
 	if (bPseudoTest) {
 		pEfuseHal->fakeBTEfuseUsedBytes = retU2;
-		/* RT_DISP(FEEPROM, EFUSE_PG, ("Hal_EfuseGetCurrentSize_BT92C(), already use %u bytes\n", pEfuseHal->fakeBTEfuseUsedBytes)); */
 	} else {
 		pEfuseHal->BTEfuseUsedBytes = retU2;
-		/* RT_DISP(FEEPROM, EFUSE_PG, ("Hal_EfuseGetCurrentSize_BT92C(), already use %u bytes\n", pEfuseHal->BTEfuseUsedBytes)); */
 	}
 
 	return retU2;
-- 
2.20.1

