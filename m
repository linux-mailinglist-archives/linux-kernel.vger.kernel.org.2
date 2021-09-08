Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759AD40411B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbhIHWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbhIHWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:40:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E7C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:39:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so5522570wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZUam9qH4spLtSbIqVT5PxWyLMuNl2EkYKHpGMO7e0s=;
        b=WnvUVaMveKJK//CyNXg31Qt9OcYWJDlH3oxZ+HlezEXM5KROarTlwhQYq9Feg6YHTr
         nLar9EN97RjKbSCaMYaYnxqbhM5AO6S/+7c/OvGotmEO9Y1EU14/rKLlEm8POS+Hs3sy
         GQjAOBEIIOJOJJ7AIx++Wn2IZGX3WLyGGqVmE+6wMNZ2bWjhaziFuVNha4d7W2xszebS
         Gy2dWNjEPd3Y9qY8YMYXR2K8WhhSHl3qUDx+/uecVkbP9qbzZGZaRLfZIER5puhaYMAv
         9ytzvgDfVLRrBMMKEtWeQ9fIEZkpCI8RnKHNQ97j/d8h4nD3l5yaTDEhpj2R8vEKuzBe
         1hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZUam9qH4spLtSbIqVT5PxWyLMuNl2EkYKHpGMO7e0s=;
        b=1+P4pcqW8xqiDqKPHByrCZOzEaVFYMYWM5vlsotD0zQgzGLfqP7F7UrF46mkc9JJVk
         Z2tvYj7De9gU/8i3ze92keArRnpD/AJutpTfPZqVSmDBGoOBNWopJTZOewU8ryc0zs2C
         BZpQsDHo+E0NtWqPk1ZrV38U7CtFwZgoDIHiSEVrpi8vcXl5Cd0udY+MIYuh/xPZq4cN
         K50wsQw3gJN6HgbWz46wSD3Lb5jG3uzFvNc8pPKiKxzfF8i358uvOPwn2kiOSKb+6P/3
         bVxW4wPWod2mceUM28NwBMy5mFfqEaGzUj0jQpsBeHf6Wiyvdae49vSLAMxoEipZ6QZ8
         /FJQ==
X-Gm-Message-State: AOAM531lEYUGQFULi3UcS0idsG99cPcun4LKtvKIpNi6JU+Nn2mFDJiL
        j3XKlhnRDF7ClqAWquVKB9o=
X-Google-Smtp-Source: ABdhPJxCCY8yWWUTC/6H9ZR4BG6aEyZCG+OuaZDZoRmMLHu8ljltTpxWz08NcTzLRq0Oh14OtE3Oqg==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr572152wrf.125.1631140766228;
        Wed, 08 Sep 2021 15:39:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id d29sm428643wrc.6.2021.09.08.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:39:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove unused PHY_GetTxPowerLevel8188E()
Date:   Thu,  9 Sep 2021 00:39:00 +0200
Message-Id: <20210908223903.10516-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908223903.10516-1-straube.linux@gmail.com>
References: <20210908223903.10516-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function PHY_GetTxPowerLevel8188E() is unused and it is the only user
of function phy_TxPwrIdxToDbm(), remove both.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 79 -------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  1 -
 2 files changed, 80 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 1c1906161da2..7542a8398886 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -670,85 +670,6 @@ static	u8 phy_DbmToTxPwrIdx(struct adapter *Adapter, enum wireless_mode Wireless
 	return TxPwrIdx;
 }
 
-/*  */
-/*	Description: */
-/*		Map Tx power index into dBm according to */
-/*		current HW model, for example, RF and PA, and */
-/*		current wireless mode. */
-/*	By Bruce, 2008-01-29. */
-/*  */
-static int phy_TxPwrIdxToDbm(struct adapter *Adapter, enum wireless_mode WirelessMode, u8 TxPwrIdx)
-{
-	int				Offset = 0;
-	int				PwrOutDbm = 0;
-
-	/*  */
-	/*  Tested by MP, we found that CCK Index 0 equals to -7dbm, OFDM legacy equals to -8dbm. */
-	/*  Note: */
-	/*	The mapping may be different by different NICs. Do not use this formula for what needs accurate result. */
-	/*  By Bruce, 2008-01-29. */
-	/*  */
-	switch (WirelessMode) {
-	case WIRELESS_MODE_B:
-		Offset = -7;
-		break;
-	case WIRELESS_MODE_G:
-	case WIRELESS_MODE_N_24G:
-	default:
-		Offset = -8;
-		break;
-	}
-
-	PwrOutDbm = TxPwrIdx / 2 + Offset; /*  Discard the decimal part. */
-
-	return PwrOutDbm;
-}
-
-/*-----------------------------------------------------------------------------
- * Function:    GetTxPowerLevel8190()
- *
- * Overview:    This function is export to "common" moudule
- *
- * Input:       struct adapter *Adapter
- *			psByte			Power Level
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- *---------------------------------------------------------------------------*/
-void PHY_GetTxPowerLevel8188E(struct adapter *Adapter, u32 *powerlevel)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
-	u8 TxPwrLevel = 0;
-	int			TxPwrDbm;
-
-	/*  */
-	/*  Because the Tx power indexes are different, we report the maximum of them to */
-	/*  meet the CCX TPC request. By Bruce, 2008-01-31. */
-	/*  */
-
-	/*  CCK */
-	TxPwrLevel = pHalData->CurrentCckTxPwrIdx;
-	TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_B, TxPwrLevel);
-
-	/*  Legacy OFDM */
-	TxPwrLevel = pHalData->CurrentOfdm24GTxPwrIdx + pHalData->LegacyHTTxPowerDiff;
-
-	/*  Compare with Legacy OFDM Tx power. */
-	if (phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_G, TxPwrLevel) > TxPwrDbm)
-		TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_G, TxPwrLevel);
-
-	/*  HT OFDM */
-	TxPwrLevel = pHalData->CurrentOfdm24GTxPwrIdx;
-
-	/*  Compare with HT OFDM Tx power. */
-	if (phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_N_24G, TxPwrLevel) > TxPwrDbm)
-		TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_N_24G, TxPwrLevel);
-
-	*powerlevel = TxPwrDbm;
-}
-
 static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
 			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
 			       u8 *BW40PowerLevel)
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index ea83c2e17913..df3d3f516996 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -189,7 +189,6 @@ int PHY_RFConfig8188E(struct adapter *adapter);
 void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
 
 /*  BB TX Power R/W */
-void PHY_GetTxPowerLevel8188E(struct adapter *adapter, u32 *powerlevel);
 void PHY_SetTxPowerLevel8188E(struct adapter *adapter, u8 channel);
 bool PHY_UpdateTxPowerDbm8188E(struct adapter *adapter, int power);
 
-- 
2.33.0

