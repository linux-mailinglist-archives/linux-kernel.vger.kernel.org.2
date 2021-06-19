Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72E3AD99D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhFSKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y7so13654280wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl3sew4+3k/AhpCGc4Lc2dArjD5pv2kQsjJB8SHpweA=;
        b=E7tcwF2T0SALQUcjRT+4f+wz0Jt1IaSUTNchOCOKi91WX9C3DALcUPsSbbVDgBsaa/
         bDwRinSvRRb6MdvKaWp8R9+NdwbrkH99Nnw5/22vfliNDppDdCbZmTRQrx9CpHAWgyNx
         GMOtB+fRz9kBms6vtbcO0sywhrZbqT1i9Tiad/4kS4r0rG6eOtpmK+tqztEu8eXg41CK
         9nBj+iX5ubgc48d1J+N0UQMnAVRKz//1bXjHHT6cAwML1NJ8QX57bQ2H29OzQ2VMG3Xm
         lavzUfrYxgYoJQYfOf450a3UQQJ+RAHNw+YY2FP0ZRNhZ+fRyc0HUpMrSxtVMyICUzGV
         3etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zl3sew4+3k/AhpCGc4Lc2dArjD5pv2kQsjJB8SHpweA=;
        b=tW4ILTeICKAuE/0btx0I6VBZfFaBKWHuMNxzTRvy0FZSXdzhktsoDSSWBARYPecQl6
         dfsp1M7r1mhs9IEkZUeUc6S+jBL00XNG6+BQsC+/fU2j32jZicNqJpOCSoAbwmlZlc8D
         p5RxP/L2qDZde1jfdYIZa9b6BUiljouj1biaPP196Xz+C9UINU8evAthP2o46BrZBZhi
         m+PYzRqCQQRsBvE2olYsCFiywLhliS2Jy+aRnyiN5qNzou2HciVEmJioC9Pp9GvAOKjm
         AZpm3OIT8pGz4MUGvJmv2yWUNBD31LE6BLjbUpioSXRRB150aJwGtw/sS0RIyMYRT/K6
         mwJA==
X-Gm-Message-State: AOAM5325QUJH/IJcD+0Ms2RCpzsfjjxKKIdf4XCoCOb/ySreKHOcji+L
        qHwphkVZBYZDwVfDWT+rF4YaovabHDx1lg==
X-Google-Smtp-Source: ABdhPJwg3V8nxD68IJ3OECW8YbW3DDcZ5vCsRRpp3yEzSS/9JkaVfnLnFoHvgfEXMjrGkl0NaIjXpA==
X-Received: by 2002:a5d:4c8f:: with SMTP id z15mr17284156wrs.131.1624099659766;
        Sat, 19 Jun 2021 03:47:39 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id k11sm13381935wmj.1.2021.06.19.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] staging: rtl8723bs: remove VHT dead code
Date:   Sat, 19 Jun 2021 12:47:15 +0200
Message-Id: <d3f79570088ad339bd80fe9d6b24604ac91ea8d3.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove VHT dead code, as the device doesn't support
VHT (which is a 802.11ac capability).

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       | 241 -----------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 383 +-----------------
 drivers/staging/rtl8723bs/include/hal_com.h   |  62 +--
 .../rtl8723bs/include/hal_com_phycfg.h        |   4 -
 drivers/staging/rtl8723bs/include/ieee80211.h |  45 --
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |  21 -
 drivers/staging/rtl8723bs/include/rtw_ht.h    |   4 -
 8 files changed, 9 insertions(+), 752 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 285acd3d843b..c128d462c6c7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -46,7 +46,6 @@ static struct action_handler OnAction_tbl[] = {
 	{RTW_WLAN_CATEGORY_UNPROTECTED_WNM, "ACTION_UNPROTECTED_WNM", &DoReserved},
 	{RTW_WLAN_CATEGORY_SELF_PROTECTED, "ACTION_SELF_PROTECTED", &DoReserved},
 	{RTW_WLAN_CATEGORY_WMM, "ACTION_WMM", &DoReserved},
-	{RTW_WLAN_CATEGORY_VHT, "ACTION_VHT", &DoReserved},
 	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &DoReserved},
 };
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 7a88447f8294..eebd48438733 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -295,126 +295,6 @@ u8 MRateToHwRate(u8 rate)
 	case MGN_MCS31:
 		ret = DESC_RATEMCS31;
 		break;
-	case MGN_VHT1SS_MCS0:
-		ret = DESC_RATEVHTSS1MCS0;
-		break;
-	case MGN_VHT1SS_MCS1:
-		ret = DESC_RATEVHTSS1MCS1;
-		break;
-	case MGN_VHT1SS_MCS2:
-		ret = DESC_RATEVHTSS1MCS2;
-		break;
-	case MGN_VHT1SS_MCS3:
-		ret = DESC_RATEVHTSS1MCS3;
-		break;
-	case MGN_VHT1SS_MCS4:
-		ret = DESC_RATEVHTSS1MCS4;
-		break;
-	case MGN_VHT1SS_MCS5:
-		ret = DESC_RATEVHTSS1MCS5;
-		break;
-	case MGN_VHT1SS_MCS6:
-		ret = DESC_RATEVHTSS1MCS6;
-		break;
-	case MGN_VHT1SS_MCS7:
-		ret = DESC_RATEVHTSS1MCS7;
-		break;
-	case MGN_VHT1SS_MCS8:
-		ret = DESC_RATEVHTSS1MCS8;
-		break;
-	case MGN_VHT1SS_MCS9:
-		ret = DESC_RATEVHTSS1MCS9;
-		break;
-	case MGN_VHT2SS_MCS0:
-		ret = DESC_RATEVHTSS2MCS0;
-		break;
-	case MGN_VHT2SS_MCS1:
-		ret = DESC_RATEVHTSS2MCS1;
-		break;
-	case MGN_VHT2SS_MCS2:
-		ret = DESC_RATEVHTSS2MCS2;
-		break;
-	case MGN_VHT2SS_MCS3:
-		ret = DESC_RATEVHTSS2MCS3;
-		break;
-	case MGN_VHT2SS_MCS4:
-		ret = DESC_RATEVHTSS2MCS4;
-		break;
-	case MGN_VHT2SS_MCS5:
-		ret = DESC_RATEVHTSS2MCS5;
-		break;
-	case MGN_VHT2SS_MCS6:
-		ret = DESC_RATEVHTSS2MCS6;
-		break;
-	case MGN_VHT2SS_MCS7:
-		ret = DESC_RATEVHTSS2MCS7;
-		break;
-	case MGN_VHT2SS_MCS8:
-		ret = DESC_RATEVHTSS2MCS8;
-		break;
-	case MGN_VHT2SS_MCS9:
-		ret = DESC_RATEVHTSS2MCS9;
-		break;
-	case MGN_VHT3SS_MCS0:
-		ret = DESC_RATEVHTSS3MCS0;
-		break;
-	case MGN_VHT3SS_MCS1:
-		ret = DESC_RATEVHTSS3MCS1;
-		break;
-	case MGN_VHT3SS_MCS2:
-		ret = DESC_RATEVHTSS3MCS2;
-		break;
-	case MGN_VHT3SS_MCS3:
-		ret = DESC_RATEVHTSS3MCS3;
-		break;
-	case MGN_VHT3SS_MCS4:
-		ret = DESC_RATEVHTSS3MCS4;
-		break;
-	case MGN_VHT3SS_MCS5:
-		ret = DESC_RATEVHTSS3MCS5;
-		break;
-	case MGN_VHT3SS_MCS6:
-		ret = DESC_RATEVHTSS3MCS6;
-		break;
-	case MGN_VHT3SS_MCS7:
-		ret = DESC_RATEVHTSS3MCS7;
-		break;
-	case MGN_VHT3SS_MCS8:
-		ret = DESC_RATEVHTSS3MCS8;
-		break;
-	case MGN_VHT3SS_MCS9:
-		ret = DESC_RATEVHTSS3MCS9;
-		break;
-	case MGN_VHT4SS_MCS0:
-		ret = DESC_RATEVHTSS4MCS0;
-		break;
-	case MGN_VHT4SS_MCS1:
-		ret = DESC_RATEVHTSS4MCS1;
-		break;
-	case MGN_VHT4SS_MCS2:
-		ret = DESC_RATEVHTSS4MCS2;
-		break;
-	case MGN_VHT4SS_MCS3:
-		ret = DESC_RATEVHTSS4MCS3;
-		break;
-	case MGN_VHT4SS_MCS4:
-		ret = DESC_RATEVHTSS4MCS4;
-		break;
-	case MGN_VHT4SS_MCS5:
-		ret = DESC_RATEVHTSS4MCS5;
-		break;
-	case MGN_VHT4SS_MCS6:
-		ret = DESC_RATEVHTSS4MCS6;
-		break;
-	case MGN_VHT4SS_MCS7:
-		ret = DESC_RATEVHTSS4MCS7;
-		break;
-	case MGN_VHT4SS_MCS8:
-		ret = DESC_RATEVHTSS4MCS8;
-		break;
-	case MGN_VHT4SS_MCS9:
-		ret = DESC_RATEVHTSS4MCS9;
-		break;
 	default:
 		break;
 	}
@@ -559,127 +439,6 @@ u8 HwRateToMRate(u8 rate)
 	case DESC_RATEMCS31:
 		ret_rate = MGN_MCS31;
 		break;
-	case DESC_RATEVHTSS1MCS0:
-		ret_rate = MGN_VHT1SS_MCS0;
-		break;
-	case DESC_RATEVHTSS1MCS1:
-		ret_rate = MGN_VHT1SS_MCS1;
-		break;
-	case DESC_RATEVHTSS1MCS2:
-		ret_rate = MGN_VHT1SS_MCS2;
-		break;
-	case DESC_RATEVHTSS1MCS3:
-		ret_rate = MGN_VHT1SS_MCS3;
-		break;
-	case DESC_RATEVHTSS1MCS4:
-		ret_rate = MGN_VHT1SS_MCS4;
-		break;
-	case DESC_RATEVHTSS1MCS5:
-		ret_rate = MGN_VHT1SS_MCS5;
-		break;
-	case DESC_RATEVHTSS1MCS6:
-		ret_rate = MGN_VHT1SS_MCS6;
-		break;
-	case DESC_RATEVHTSS1MCS7:
-		ret_rate = MGN_VHT1SS_MCS7;
-		break;
-	case DESC_RATEVHTSS1MCS8:
-		ret_rate = MGN_VHT1SS_MCS8;
-		break;
-	case DESC_RATEVHTSS1MCS9:
-		ret_rate = MGN_VHT1SS_MCS9;
-		break;
-	case DESC_RATEVHTSS2MCS0:
-		ret_rate = MGN_VHT2SS_MCS0;
-		break;
-	case DESC_RATEVHTSS2MCS1:
-		ret_rate = MGN_VHT2SS_MCS1;
-		break;
-	case DESC_RATEVHTSS2MCS2:
-		ret_rate = MGN_VHT2SS_MCS2;
-		break;
-	case DESC_RATEVHTSS2MCS3:
-		ret_rate = MGN_VHT2SS_MCS3;
-		break;
-	case DESC_RATEVHTSS2MCS4:
-		ret_rate = MGN_VHT2SS_MCS4;
-		break;
-	case DESC_RATEVHTSS2MCS5:
-		ret_rate = MGN_VHT2SS_MCS5;
-		break;
-	case DESC_RATEVHTSS2MCS6:
-		ret_rate = MGN_VHT2SS_MCS6;
-		break;
-	case DESC_RATEVHTSS2MCS7:
-		ret_rate = MGN_VHT2SS_MCS7;
-		break;
-	case DESC_RATEVHTSS2MCS8:
-		ret_rate = MGN_VHT2SS_MCS8;
-		break;
-	case DESC_RATEVHTSS2MCS9:
-		ret_rate = MGN_VHT2SS_MCS9;
-		break;
-	case DESC_RATEVHTSS3MCS0:
-		ret_rate = MGN_VHT3SS_MCS0;
-		break;
-	case DESC_RATEVHTSS3MCS1:
-		ret_rate = MGN_VHT3SS_MCS1;
-		break;
-	case DESC_RATEVHTSS3MCS2:
-		ret_rate = MGN_VHT3SS_MCS2;
-		break;
-	case DESC_RATEVHTSS3MCS3:
-		ret_rate = MGN_VHT3SS_MCS3;
-		break;
-	case DESC_RATEVHTSS3MCS4:
-		ret_rate = MGN_VHT3SS_MCS4;
-		break;
-	case DESC_RATEVHTSS3MCS5:
-		ret_rate = MGN_VHT3SS_MCS5;
-		break;
-	case DESC_RATEVHTSS3MCS6:
-		ret_rate = MGN_VHT3SS_MCS6;
-		break;
-	case DESC_RATEVHTSS3MCS7:
-		ret_rate = MGN_VHT3SS_MCS7;
-		break;
-	case DESC_RATEVHTSS3MCS8:
-		ret_rate = MGN_VHT3SS_MCS8;
-		break;
-	case DESC_RATEVHTSS3MCS9:
-		ret_rate = MGN_VHT3SS_MCS9;
-		break;
-	case DESC_RATEVHTSS4MCS0:
-		ret_rate = MGN_VHT4SS_MCS0;
-		break;
-	case DESC_RATEVHTSS4MCS1:
-		ret_rate = MGN_VHT4SS_MCS1;
-		break;
-	case DESC_RATEVHTSS4MCS2:
-		ret_rate = MGN_VHT4SS_MCS2;
-		break;
-	case DESC_RATEVHTSS4MCS3:
-		ret_rate = MGN_VHT4SS_MCS3;
-		break;
-	case DESC_RATEVHTSS4MCS4:
-		ret_rate = MGN_VHT4SS_MCS4;
-		break;
-	case DESC_RATEVHTSS4MCS5:
-		ret_rate = MGN_VHT4SS_MCS5;
-		break;
-	case DESC_RATEVHTSS4MCS6:
-		ret_rate = MGN_VHT4SS_MCS6;
-		break;
-	case DESC_RATEVHTSS4MCS7:
-		ret_rate = MGN_VHT4SS_MCS7;
-		break;
-	case DESC_RATEVHTSS4MCS8:
-		ret_rate = MGN_VHT4SS_MCS8;
-		break;
-	case DESC_RATEVHTSS4MCS9:
-		ret_rate = MGN_VHT4SS_MCS9;
-		break;
-
 	default:
 		break;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 395eb3b5af71..bb7941aee0c4 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -39,18 +39,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 	case HT_MCS24_MCS31:
 		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
 		break;
-	case VHT_1SSMCS0_1SSMCS9:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6];
-		break;
-	case VHT_2SSMCS0_2SSMCS9:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7];
-		break;
-	case VHT_3SSMCS0_3SSMCS9:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8];
-		break;
-	case VHT_4SSMCS0_4SSMCS9:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
-		break;
 	default:
 		break;
 	}
@@ -91,18 +79,6 @@ phy_SetTxPowerByRateBase(
 	case HT_MCS24_MCS31:
 		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
 		break;
-	case VHT_1SSMCS0_1SSMCS9:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][6] = Value;
-		break;
-	case VHT_2SSMCS0_2SSMCS9:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][7] = Value;
-		break;
-	case VHT_3SSMCS0_3SSMCS9:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][8] = Value;
-		break;
-	case VHT_4SSMCS0_4SSMCS9:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
-		break;
 	default:
 		break;
 	}
@@ -131,14 +107,6 @@ struct adapter *padapter
 		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_MCS23);
 		phy_SetTxPowerByRateBase(padapter, path, HT_MCS16_MCS23, RF_3TX, base);
 
-		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_VHT1SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_VHT2SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_VHT3SS_MCS7);
-		phy_SetTxPowerByRateBase(padapter, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
 	}
 }
 
@@ -442,81 +410,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 		*RateNum = 4;
 		break;
 
-	case 0xC3C:
-	case 0xE3C:
-	case 0x183C:
-	case 0x1a3C:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS0);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS1);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS2);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS3);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xC40:
-	case 0xE40:
-	case 0x1840:
-	case 0x1a40:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS4);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS5);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS6);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS7);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xC44:
-	case 0xE44:
-	case 0x1844:
-	case 0x1a44:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS8);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT1SS_MCS9);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS0);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS1);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xC48:
-	case 0xE48:
-	case 0x1848:
-	case 0x1a48:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS2);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS3);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS4);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS5);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xC4C:
-	case 0xE4C:
-	case 0x184C:
-	case 0x1a4C:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS6);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS7);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS8);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS9);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
 	case 0xCD8:
 	case 0xED8:
 	case 0x18D8:
@@ -547,49 +440,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 		*RateNum = 4;
 		break;
 
-	case 0xCE0:
-	case 0xEE0:
-	case 0x18E0:
-	case 0x1aE0:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS0);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS1);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS2);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS3);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xCE4:
-	case 0xEE4:
-	case 0x18E4:
-	case 0x1aE4:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS4);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS5);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS6);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS7);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xCE8:
-	case 0xEE8:
-	case 0x18E8:
-	case 0x1aE8:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS8);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_VHT3SS_MCS9);
-		for (i = 0; i < 2; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
 	default:
 		break;
 	}
@@ -617,10 +467,6 @@ static void PHY_StoreTxPowerByRateNew(
 		return;
 
 	for (i = 0; i < rateNum; ++i) {
-		if (rateIndex[i] == PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS0) ||
-			 rateIndex[i] == PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS1))
-			TxNum = RF_2TX;
-
 		pHalData->TxPwrByRateOffset[RfPath][TxNum][rateIndex[i]] = PwrByRateVal[i];
 	}
 }
@@ -691,18 +537,6 @@ struct adapter *padapter
 	u8 mcs16_23Rates[8] = {
 		MGN_MCS16, MGN_MCS17, MGN_MCS18, MGN_MCS19, MGN_MCS20, MGN_MCS21, MGN_MCS22, MGN_MCS23
 	};
-	u8 vht1ssRates[10] = {
-		MGN_VHT1SS_MCS0, MGN_VHT1SS_MCS1, MGN_VHT1SS_MCS2, MGN_VHT1SS_MCS3, MGN_VHT1SS_MCS4,
-		MGN_VHT1SS_MCS5, MGN_VHT1SS_MCS6, MGN_VHT1SS_MCS7, MGN_VHT1SS_MCS8, MGN_VHT1SS_MCS9
-	};
-	u8 vht2ssRates[10] = {
-		MGN_VHT2SS_MCS0, MGN_VHT2SS_MCS1, MGN_VHT2SS_MCS2, MGN_VHT2SS_MCS3, MGN_VHT2SS_MCS4,
-		MGN_VHT2SS_MCS5, MGN_VHT2SS_MCS6, MGN_VHT2SS_MCS7, MGN_VHT2SS_MCS8, MGN_VHT2SS_MCS9
-	};
-	u8 vht3ssRates[10] = {
-		MGN_VHT3SS_MCS0, MGN_VHT3SS_MCS1, MGN_VHT3SS_MCS2, MGN_VHT3SS_MCS3, MGN_VHT3SS_MCS4,
-		MGN_VHT3SS_MCS5, MGN_VHT3SS_MCS6, MGN_VHT3SS_MCS7, MGN_VHT3SS_MCS8, MGN_VHT3SS_MCS9
-	};
 
 	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
 		for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
@@ -740,27 +574,6 @@ struct adapter *padapter
 				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i]);
 				PHY_SetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i], value - base);
 			}
-
-			/*  VHT 1SS */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT1SS_MCS7);
-			for (i = 0; i < sizeof(vht1ssRates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht1ssRates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, vht1ssRates[i], value - base);
-			}
-
-			/*  VHT 2SS */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT2SS_MCS7);
-			for (i = 0; i < sizeof(vht2ssRates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht2ssRates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, vht2ssRates[i], value - base);
-			}
-
-			/*  VHT 3SS */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_VHT3SS_MCS7);
-			for (i = 0; i < sizeof(vht3ssRates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, vht3ssRates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, vht3ssRates[i], value - base);
-			}
 		}
 	}
 }
@@ -823,38 +636,6 @@ void PHY_SetTxPowerIndexByRateSection(
 					       Channel, htRates4T,
 					       ARRAY_SIZE(htRates4T));
 
-	} else if (RateSection == VHT_1SSMCS0_1SSMCS9) {
-		u8 vhtRates1T[] = {MGN_VHT1SS_MCS0, MGN_VHT1SS_MCS1, MGN_VHT1SS_MCS2, MGN_VHT1SS_MCS3, MGN_VHT1SS_MCS4,
-				MGN_VHT1SS_MCS5, MGN_VHT1SS_MCS6, MGN_VHT1SS_MCS7, MGN_VHT1SS_MCS8, MGN_VHT1SS_MCS9};
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, vhtRates1T,
-					       ARRAY_SIZE(vhtRates1T));
-
-	} else if (RateSection == VHT_2SSMCS0_2SSMCS9) {
-		u8 vhtRates2T[] = {MGN_VHT2SS_MCS0, MGN_VHT2SS_MCS1, MGN_VHT2SS_MCS2, MGN_VHT2SS_MCS3, MGN_VHT2SS_MCS4,
-				MGN_VHT2SS_MCS5, MGN_VHT2SS_MCS6, MGN_VHT2SS_MCS7, MGN_VHT2SS_MCS8, MGN_VHT2SS_MCS9};
-
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, vhtRates2T,
-					       ARRAY_SIZE(vhtRates2T));
-	} else if (RateSection == VHT_3SSMCS0_3SSMCS9) {
-		u8 vhtRates3T[] = {MGN_VHT3SS_MCS0, MGN_VHT3SS_MCS1, MGN_VHT3SS_MCS2, MGN_VHT3SS_MCS3, MGN_VHT3SS_MCS4,
-				MGN_VHT3SS_MCS5, MGN_VHT3SS_MCS6, MGN_VHT3SS_MCS7, MGN_VHT3SS_MCS8, MGN_VHT3SS_MCS9};
-
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, vhtRates3T,
-					       ARRAY_SIZE(vhtRates3T));
-	} else if (RateSection == VHT_4SSMCS0_4SSMCS9) {
-		u8 vhtRates4T[] = {MGN_VHT4SS_MCS0, MGN_VHT4SS_MCS1, MGN_VHT4SS_MCS2, MGN_VHT4SS_MCS3, MGN_VHT4SS_MCS4,
-				MGN_VHT4SS_MCS5, MGN_VHT4SS_MCS6, MGN_VHT4SS_MCS7, MGN_VHT4SS_MCS8, MGN_VHT4SS_MCS9};
-
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, vhtRates4T,
-					       ARRAY_SIZE(vhtRates4T));
 	}
 }
 
@@ -883,23 +664,23 @@ u8 PHY_GetTxPowerIndexBase(
 		txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
 
 	if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
-		if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
-		if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS8 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW20_24G_Diff[RFPath][TX_2S];
-		if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS16 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW20_24G_Diff[RFPath][TX_3S];
-		if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS24 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW20_24G_Diff[RFPath][TX_4S];
 
 	} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
-		if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
-		if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS8 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
-		if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS16 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
-		if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
+		if (MGN_MCS24 <= Rate && Rate <= MGN_MCS31)
 			txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
 	}
@@ -1060,126 +841,6 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate)
 	case MGN_MCS31:
 		index = 43;
 		break;
-	case MGN_VHT1SS_MCS0:
-		index = 44;
-		break;
-	case MGN_VHT1SS_MCS1:
-		index = 45;
-		break;
-	case MGN_VHT1SS_MCS2:
-		index = 46;
-		break;
-	case MGN_VHT1SS_MCS3:
-		index = 47;
-		break;
-	case MGN_VHT1SS_MCS4:
-		index = 48;
-		break;
-	case MGN_VHT1SS_MCS5:
-		index = 49;
-		break;
-	case MGN_VHT1SS_MCS6:
-		index = 50;
-		break;
-	case MGN_VHT1SS_MCS7:
-		index = 51;
-		break;
-	case MGN_VHT1SS_MCS8:
-		index = 52;
-		break;
-	case MGN_VHT1SS_MCS9:
-		index = 53;
-		break;
-	case MGN_VHT2SS_MCS0:
-		index = 54;
-		break;
-	case MGN_VHT2SS_MCS1:
-		index = 55;
-		break;
-	case MGN_VHT2SS_MCS2:
-		index = 56;
-		break;
-	case MGN_VHT2SS_MCS3:
-		index = 57;
-		break;
-	case MGN_VHT2SS_MCS4:
-		index = 58;
-		break;
-	case MGN_VHT2SS_MCS5:
-		index = 59;
-		break;
-	case MGN_VHT2SS_MCS6:
-		index = 60;
-		break;
-	case MGN_VHT2SS_MCS7:
-		index = 61;
-		break;
-	case MGN_VHT2SS_MCS8:
-		index = 62;
-		break;
-	case MGN_VHT2SS_MCS9:
-		index = 63;
-		break;
-	case MGN_VHT3SS_MCS0:
-		index = 64;
-		break;
-	case MGN_VHT3SS_MCS1:
-		index = 65;
-		break;
-	case MGN_VHT3SS_MCS2:
-		index = 66;
-		break;
-	case MGN_VHT3SS_MCS3:
-		index = 67;
-		break;
-	case MGN_VHT3SS_MCS4:
-		index = 68;
-		break;
-	case MGN_VHT3SS_MCS5:
-		index = 69;
-		break;
-	case MGN_VHT3SS_MCS6:
-		index = 70;
-		break;
-	case MGN_VHT3SS_MCS7:
-		index = 71;
-		break;
-	case MGN_VHT3SS_MCS8:
-		index = 72;
-		break;
-	case MGN_VHT3SS_MCS9:
-		index = 73;
-		break;
-	case MGN_VHT4SS_MCS0:
-		index = 74;
-		break;
-	case MGN_VHT4SS_MCS1:
-		index = 75;
-		break;
-	case MGN_VHT4SS_MCS2:
-		index = 76;
-		break;
-	case MGN_VHT4SS_MCS3:
-		index = 77;
-		break;
-	case MGN_VHT4SS_MCS4:
-		index = 78;
-		break;
-	case MGN_VHT4SS_MCS5:
-		index = 79;
-		break;
-	case MGN_VHT4SS_MCS6:
-		index = 80;
-		break;
-	case MGN_VHT4SS_MCS7:
-		index = 81;
-		break;
-	case MGN_VHT4SS_MCS8:
-		index = 82;
-		break;
-	case MGN_VHT4SS_MCS9:
-		index = 83;
-		break;
 	default:
 		break;
 	}
@@ -1319,26 +980,6 @@ static s16 get_rate_sctn_idx(const u8 rate)
 	case MGN_MCS24: case MGN_MCS25: case MGN_MCS26: case MGN_MCS27:
 	case MGN_MCS28: case MGN_MCS29: case MGN_MCS30: case MGN_MCS31:
 		return 5;
-	case MGN_VHT1SS_MCS0: case MGN_VHT1SS_MCS1: case MGN_VHT1SS_MCS2:
-	case MGN_VHT1SS_MCS3: case MGN_VHT1SS_MCS4: case MGN_VHT1SS_MCS5:
-	case MGN_VHT1SS_MCS6: case MGN_VHT1SS_MCS7: case MGN_VHT1SS_MCS8:
-	case MGN_VHT1SS_MCS9:
-		return 6;
-	case MGN_VHT2SS_MCS0: case MGN_VHT2SS_MCS1: case MGN_VHT2SS_MCS2:
-	case MGN_VHT2SS_MCS3: case MGN_VHT2SS_MCS4: case MGN_VHT2SS_MCS5:
-	case MGN_VHT2SS_MCS6: case MGN_VHT2SS_MCS7: case MGN_VHT2SS_MCS8:
-	case MGN_VHT2SS_MCS9:
-		return 7;
-	case MGN_VHT3SS_MCS0: case MGN_VHT3SS_MCS1: case MGN_VHT3SS_MCS2:
-	case MGN_VHT3SS_MCS3: case MGN_VHT3SS_MCS4: case MGN_VHT3SS_MCS5:
-	case MGN_VHT3SS_MCS6: case MGN_VHT3SS_MCS7: case MGN_VHT3SS_MCS8:
-	case MGN_VHT3SS_MCS9:
-		return 8;
-	case MGN_VHT4SS_MCS0: case MGN_VHT4SS_MCS1: case MGN_VHT4SS_MCS2:
-	case MGN_VHT4SS_MCS3: case MGN_VHT4SS_MCS4: case MGN_VHT4SS_MCS5:
-	case MGN_VHT4SS_MCS6: case MGN_VHT4SS_MCS7: case MGN_VHT4SS_MCS8:
-	case MGN_VHT4SS_MCS9:
-		return 9;
 	default:
 		return -1;
 	}
@@ -1510,14 +1151,6 @@ void PHY_SetTxPowerLimit(
 		rateSection = 4;
 	else if (eqNByte(RateSection, (u8 *)("HT"), 2) && eqNByte(RfPath, (u8 *)("4T"), 2))
 		rateSection = 5;
-	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("1T"), 2))
-		rateSection = 6;
-	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("2T"), 2))
-		rateSection = 7;
-	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("3T"), 2))
-		rateSection = 8;
-	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("4T"), 2))
-		rateSection = 9;
 	else
 		return;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 6bcc443d59fb..1bc332261b2a 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -69,46 +69,6 @@
 #define DESC_RATEMCS29				0x29
 #define DESC_RATEMCS30				0x2A
 #define DESC_RATEMCS31				0x2B
-#define DESC_RATEVHTSS1MCS0		0x2C
-#define DESC_RATEVHTSS1MCS1		0x2D
-#define DESC_RATEVHTSS1MCS2		0x2E
-#define DESC_RATEVHTSS1MCS3		0x2F
-#define DESC_RATEVHTSS1MCS4		0x30
-#define DESC_RATEVHTSS1MCS5		0x31
-#define DESC_RATEVHTSS1MCS6		0x32
-#define DESC_RATEVHTSS1MCS7		0x33
-#define DESC_RATEVHTSS1MCS8		0x34
-#define DESC_RATEVHTSS1MCS9		0x35
-#define DESC_RATEVHTSS2MCS0		0x36
-#define DESC_RATEVHTSS2MCS1		0x37
-#define DESC_RATEVHTSS2MCS2		0x38
-#define DESC_RATEVHTSS2MCS3		0x39
-#define DESC_RATEVHTSS2MCS4		0x3A
-#define DESC_RATEVHTSS2MCS5		0x3B
-#define DESC_RATEVHTSS2MCS6		0x3C
-#define DESC_RATEVHTSS2MCS7		0x3D
-#define DESC_RATEVHTSS2MCS8		0x3E
-#define DESC_RATEVHTSS2MCS9		0x3F
-#define DESC_RATEVHTSS3MCS0		0x40
-#define DESC_RATEVHTSS3MCS1		0x41
-#define DESC_RATEVHTSS3MCS2		0x42
-#define DESC_RATEVHTSS3MCS3		0x43
-#define DESC_RATEVHTSS3MCS4		0x44
-#define DESC_RATEVHTSS3MCS5		0x45
-#define DESC_RATEVHTSS3MCS6		0x46
-#define DESC_RATEVHTSS3MCS7		0x47
-#define DESC_RATEVHTSS3MCS8		0x48
-#define DESC_RATEVHTSS3MCS9		0x49
-#define DESC_RATEVHTSS4MCS0		0x4A
-#define DESC_RATEVHTSS4MCS1		0x4B
-#define DESC_RATEVHTSS4MCS2		0x4C
-#define DESC_RATEVHTSS4MCS3		0x4D
-#define DESC_RATEVHTSS4MCS4		0x4E
-#define DESC_RATEVHTSS4MCS5		0x4F
-#define DESC_RATEVHTSS4MCS6		0x50
-#define DESC_RATEVHTSS4MCS7		0x51
-#define DESC_RATEVHTSS4MCS8		0x52
-#define DESC_RATEVHTSS4MCS9		0x53
 
 #define HDATA_RATE(rate)\
 (rate == DESC_RATE1M) ? "CCK_1M" : \
@@ -138,27 +98,7 @@
 (rate == DESC_RATEMCS12) ? "MCS12" : \
 (rate == DESC_RATEMCS13) ? "MCS13" : \
 (rate == DESC_RATEMCS14) ? "MCS14" : \
-(rate == DESC_RATEMCS15) ? "MCS15" : \
-(rate == DESC_RATEVHTSS1MCS0) ? "VHTSS1MCS0" : \
-(rate == DESC_RATEVHTSS1MCS1) ? "VHTSS1MCS1" : \
-(rate == DESC_RATEVHTSS1MCS2) ? "VHTSS1MCS2" : \
-(rate == DESC_RATEVHTSS1MCS3) ? "VHTSS1MCS3" : \
-(rate == DESC_RATEVHTSS1MCS4) ? "VHTSS1MCS4" : \
-(rate == DESC_RATEVHTSS1MCS5) ? "VHTSS1MCS5" : \
-(rate == DESC_RATEVHTSS1MCS6) ? "VHTSS1MCS6" : \
-(rate == DESC_RATEVHTSS1MCS7) ? "VHTSS1MCS7" : \
-(rate == DESC_RATEVHTSS1MCS8) ? "VHTSS1MCS8" : \
-(rate == DESC_RATEVHTSS1MCS9) ? "VHTSS1MCS9" : \
-(rate == DESC_RATEVHTSS2MCS0) ? "VHTSS2MCS0" : \
-(rate == DESC_RATEVHTSS2MCS1) ? "VHTSS2MCS1" : \
-(rate == DESC_RATEVHTSS2MCS2) ? "VHTSS2MCS2" : \
-(rate == DESC_RATEVHTSS2MCS3) ? "VHTSS2MCS3" : \
-(rate == DESC_RATEVHTSS2MCS4) ? "VHTSS2MCS4" : \
-(rate == DESC_RATEVHTSS2MCS5) ? "VHTSS2MCS5" : \
-(rate == DESC_RATEVHTSS2MCS6) ? "VHTSS2MCS6" : \
-(rate == DESC_RATEVHTSS2MCS7) ? "VHTSS2MCS7" : \
-(rate == DESC_RATEVHTSS2MCS8) ? "VHTSS2MCS8" : \
-(rate == DESC_RATEVHTSS2MCS9) ? "VHTSS2MCS9" : "UNKNOWN"
+(rate == DESC_RATEMCS15) ? "MCS15" : "UNKNOWN"
 
 
 enum{
diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index 3d95ab1986b1..c966d0e3e5ae 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -19,10 +19,6 @@ enum rate_section {
 	HT_MCS8_MCS15,
 	HT_MCS16_MCS23,
 	HT_MCS24_MCS31,
-	VHT_1SSMCS0_1SSMCS9,
-	VHT_2SSMCS0_2SSMCS9,
-	VHT_3SSMCS0_3SSMCS9,
-	VHT_4SSMCS0_4SSMCS9,
 };
 
 enum {
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index ac88bd30b097..378c21595e05 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -60,7 +60,6 @@ enum {
 #define WLAN_STA_HT BIT(11)
 #define WLAN_STA_WPS BIT(12)
 #define WLAN_STA_MAYBE_WPS BIT(13)
-#define WLAN_STA_VHT BIT(14)
 #define WLAN_STA_NONERP BIT(31)
 
 #define IEEE_CMD_SET_WPA_PARAM			1
@@ -135,8 +134,6 @@ enum {
 	RATEID_IDX_BG = 6,
 	RATEID_IDX_G = 7,
 	RATEID_IDX_B = 8,
-	RATEID_IDX_VHT_2SS = 9,
-	RATEID_IDX_VHT_1SS = 10,
 };
 
 enum network_type {
@@ -424,51 +421,10 @@ enum {
 	MGN_MCS29,
 	MGN_MCS30,
 	MGN_MCS31,
-	MGN_VHT1SS_MCS0,
-	MGN_VHT1SS_MCS1,
-	MGN_VHT1SS_MCS2,
-	MGN_VHT1SS_MCS3,
-	MGN_VHT1SS_MCS4,
-	MGN_VHT1SS_MCS5,
-	MGN_VHT1SS_MCS6,
-	MGN_VHT1SS_MCS7,
-	MGN_VHT1SS_MCS8,
-	MGN_VHT1SS_MCS9,
-	MGN_VHT2SS_MCS0,
-	MGN_VHT2SS_MCS1,
-	MGN_VHT2SS_MCS2,
-	MGN_VHT2SS_MCS3,
-	MGN_VHT2SS_MCS4,
-	MGN_VHT2SS_MCS5,
-	MGN_VHT2SS_MCS6,
-	MGN_VHT2SS_MCS7,
-	MGN_VHT2SS_MCS8,
-	MGN_VHT2SS_MCS9,
-	MGN_VHT3SS_MCS0,
-	MGN_VHT3SS_MCS1,
-	MGN_VHT3SS_MCS2,
-	MGN_VHT3SS_MCS3,
-	MGN_VHT3SS_MCS4,
-	MGN_VHT3SS_MCS5,
-	MGN_VHT3SS_MCS6,
-	MGN_VHT3SS_MCS7,
-	MGN_VHT3SS_MCS8,
-	MGN_VHT3SS_MCS9,
-	MGN_VHT4SS_MCS0,
-	MGN_VHT4SS_MCS1,
-	MGN_VHT4SS_MCS2,
-	MGN_VHT4SS_MCS3,
-	MGN_VHT4SS_MCS4,
-	MGN_VHT4SS_MCS5,
-	MGN_VHT4SS_MCS6,
-	MGN_VHT4SS_MCS7,
-	MGN_VHT4SS_MCS8,
-	MGN_VHT4SS_MCS9,
 	MGN_UNKNOWN
 };
 
 #define IS_HT_RATE(_rate)				(_rate >= MGN_MCS0 && _rate <= MGN_MCS31)
-#define IS_VHT_RATE(_rate)				(_rate >= MGN_VHT1SS_MCS0 && _rate <= MGN_VHT4SS_MCS9)
 #define IS_CCK_RATE(_rate)				(MGN_1M == _rate || _rate == MGN_2M || _rate == MGN_5_5M || _rate == MGN_11M)
 #define IS_OFDM_RATE(_rate)				(MGN_6M <= _rate && _rate <= MGN_54M  && _rate != MGN_11M)
 
@@ -625,7 +581,6 @@ enum {
 	RTW_WLAN_CATEGORY_TDLS = 12,
 	RTW_WLAN_CATEGORY_SELF_PROTECTED = 15, /*  add for CONFIG_IEEE80211W, none 11w also can use */
 	RTW_WLAN_CATEGORY_WMM = 17,
-	RTW_WLAN_CATEGORY_VHT = 21,
 	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
 };
 
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
index 56bdc14af47d..9dd329a5208a 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
@@ -402,27 +402,6 @@ struct txdesc_8723b {
 #define DESC8723B_RATEMCS13		0x19
 #define DESC8723B_RATEMCS14		0x1a
 #define DESC8723B_RATEMCS15		0x1b
-#define DESC8723B_RATEVHTSS1MCS0		0x2c
-#define DESC8723B_RATEVHTSS1MCS1		0x2d
-#define DESC8723B_RATEVHTSS1MCS2		0x2e
-#define DESC8723B_RATEVHTSS1MCS3		0x2f
-#define DESC8723B_RATEVHTSS1MCS4		0x30
-#define DESC8723B_RATEVHTSS1MCS5		0x31
-#define DESC8723B_RATEVHTSS1MCS6		0x32
-#define DESC8723B_RATEVHTSS1MCS7		0x33
-#define DESC8723B_RATEVHTSS1MCS8		0x34
-#define DESC8723B_RATEVHTSS1MCS9		0x35
-#define DESC8723B_RATEVHTSS2MCS0		0x36
-#define DESC8723B_RATEVHTSS2MCS1		0x37
-#define DESC8723B_RATEVHTSS2MCS2		0x38
-#define DESC8723B_RATEVHTSS2MCS3		0x39
-#define DESC8723B_RATEVHTSS2MCS4		0x3a
-#define DESC8723B_RATEVHTSS2MCS5		0x3b
-#define DESC8723B_RATEVHTSS2MCS6		0x3c
-#define DESC8723B_RATEVHTSS2MCS7		0x3d
-#define DESC8723B_RATEVHTSS2MCS8		0x3e
-#define DESC8723B_RATEVHTSS2MCS9		0x3f
-
 
 #define		RX_HAL_IS_CCK_RATE_8723B(pDesc)\
 			(GET_RX_STATUS_DESC_RX_RATE_8723B(pDesc) == DESC8723B_RATE1M ||\
diff --git a/drivers/staging/rtl8723bs/include/rtw_ht.h b/drivers/staging/rtl8723bs/include/rtw_ht.h
index e3f353fe1e47..1527d8be2d7a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ht.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ht.h
@@ -42,10 +42,6 @@ enum {
 	HT_AGG_SIZE_16K = 1,
 	HT_AGG_SIZE_32K = 2,
 	HT_AGG_SIZE_64K = 3,
-	VHT_AGG_SIZE_128K = 4,
-	VHT_AGG_SIZE_256K = 5,
-	VHT_AGG_SIZE_512K = 6,
-	VHT_AGG_SIZE_1024K = 7,
 };
 
 enum {
-- 
2.20.1

