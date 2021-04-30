Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1332636F694
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhD3HqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhD3Hpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E3C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so103792308ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhDV+dGvUpd2CbZWpHEvmRVpoamIVv7GpJ51OZmyAlA=;
        b=KWhF+4N5Fj+vK67jG6J+BA+pGmkJlGtg9Dnsef2RUzFXKCHVyq+sMvQqL7pVNd7aq4
         4NejVE6Q2QQEOJYn5lgDUkYgXdV868/HAe0lpdK1LfEb7BORszku3+xc7Hh8n+Xyopbi
         E7gopscjeeQuLlLSoIsin627RAxrWBf1YgXWYmjqFUH+9pyMiYXdIuAgG/tVunjgwjVU
         NicBh3PyU5ZKHEZEzjsAyWh4lrNW2XVzU3dZAHb+AjzZDDZH6OY31GUSplgGonqM4y3H
         UY/kG0bLMd8Qs5H4OZRslLh/5dZZhMQCOxc9qD7p+c32LE0Rz5/1Giy8eG/3xs9URTkS
         Kp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhDV+dGvUpd2CbZWpHEvmRVpoamIVv7GpJ51OZmyAlA=;
        b=pMKltndv4i1MVysjFDvLHPHcRcjfZjqoXjvw6pMbd/CZ/VkyC4qjhs4nR8CrrYJV1J
         QUtUHneZyNP0XaML091OUlfXn8XW2ns7t19TvqfEUEAhlDfpFrOMtElSdVaKfR3Dvhhs
         OOLkidOTbRJG4GzjDwbVzVkk0ZSEAwDrLet2WBaXw3Ob7yegEJmjmi1gEDNe+O0NFir6
         oLh1Ct9YWEgLDTOMQPVfrpbh7ilDoHEXTMEB2cpGs/m3Efa1yACJPRTIEqhHsVIfoF5A
         ioGHGZ3SOdFt8EtQ249LTugczN1atYM7a9IbP1i13gMGjCe4APyg+URvbBv3eJVp2kqk
         xIog==
X-Gm-Message-State: AOAM533lZhzsyrW66e5g9urR35dc/w3U0MBxJ9Qhi3J19ebNuIrE6uQK
        60HednWqQcg2+VdGOnQ6JfCNY0WVF1VZLg==
X-Google-Smtp-Source: ABdhPJzvoWBX32CliVyKza3TXd9Lf52ABt7NKArS6DYImzdzEHWxqpcjimAB3Ba2YtXVXZpgnf4zeg==
X-Received: by 2002:a17:906:608a:: with SMTP id t10mr2859071ejj.374.1619768677928;
        Fri, 30 Apr 2021 00:44:37 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id bm26sm1442116ejb.82.2021.04.30.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 20/43] staging: rtl8723bs: remove BTC_PRINT logs
Date:   Fri, 30 Apr 2021 09:43:38 +0200
Message-Id: <b929a577177a47c8d018ffa95ad042c55069678a.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BTC_PRINT logs.

BTC_PRINT macro's default behavoiur is _do nothing_.
It's enabled by uncommenting some code in hal/hal_btcoex.c
file.

So just remove it.

Applied following semantic patch:

@@
@@

-	BTC_PRINT(...);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 580 +-----------------
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   | 489 ---------------
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   7 -
 3 files changed, 2 insertions(+), 1074 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 503790924532..28f41a637c96 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -41,43 +41,18 @@ static u8 halbtc8723b1ant_BtRssiState(
 			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 
 				btRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to High\n")
-				);
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state stay at Low\n")
-				);
 			}
 		} else {
 			if (btRssi < rssiThresh) {
 				btRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to Low\n")
-				);
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state stay at High\n")
-				);
 			}
 		}
 	} else if (levelNum == 3) {
 		if (rssiThresh > rssiThresh1) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_BT_RSSI_STATE,
-				("[BTCoex], BT Rssi thresh error!!\n")
-			);
 			return pCoexSta->preBtRssiState;
 		}
 
@@ -87,18 +62,8 @@ static u8 halbtc8723b1ant_BtRssiState(
 		) {
 			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to Medium\n")
-				);
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state stay at Low\n")
-				);
 			}
 		} else if (
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
@@ -106,41 +71,16 @@ static u8 halbtc8723b1ant_BtRssiState(
 		) {
 			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 				btRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to High\n")
-				);
 			} else if (btRssi < rssiThresh) {
 				btRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to Low\n")
-				);
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_MEDIUM;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state stay at Medium\n")
-				);
 			}
 		} else {
 			if (btRssi < rssiThresh1) {
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state switch to Medium\n")
-				);
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_BT_RSSI_STATE,
-					("[BTCoex], BT Rssi state stay at High\n")
-				);
 			}
 		}
 	}
@@ -322,12 +262,6 @@ static void halbtc8723b1ant_QueryBtInfo(struct btc_coexist *pBtCoexist)
 
 	H2C_Parameter[0] |= BIT0;	/*  trigger */
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		("[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n", H2C_Parameter[0])
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x61, 1, H2C_Parameter);
 }
 
@@ -367,18 +301,6 @@ static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
 	if ((pCoexSta->lowPriorityTx >= 1050) && (!pCoexSta->bC2hBtInquiryPage))
 		pCoexSta->popEventCnt++;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE,
-		(
-			"[BTCoex], Hi-Pri Rx/Tx: %d/%d, Lo-Pri Rx/Tx: %d/%d\n",
-			regHPRx,
-			regHPTx,
-			regLPRx,
-			regLPTx
-		)
-	);
-
 	/*  reset counter */
 	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0xc);
 
@@ -587,11 +509,6 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 
 	if (!pBtLinkInfo->bBtLinkExist) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], No BT link exists!!!\n")
-		);
 		return algorithm;
 	}
 
@@ -606,41 +523,16 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 
 	if (numOfDiffProfile == 1) {
 		if (pBtLinkInfo->bScoExist) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE,
-				("[BTCoex], BT Profile = SCO only\n")
-			);
 			algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
 		} else {
 			if (pBtLinkInfo->bHidExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = HID only\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_HID;
 			} else if (pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = A2DP only\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_A2DP;
 			} else if (pBtLinkInfo->bPanExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = PAN(HS) only\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANHS;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = PAN(EDR) only\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR;
 				}
 			}
@@ -648,74 +540,29 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 	} else if (numOfDiffProfile == 2) {
 		if (pBtLinkInfo->bScoExist) {
 			if (pBtLinkInfo->bHidExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = SCO + HID\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_HID;
 			} else if (pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = SCO + A2DP ==> SCO\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
 			} else if (pBtLinkInfo->bPanExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = SCO + PAN(HS)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = SCO + PAN(EDR)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
 		} else {
 			if (pBtLinkInfo->bHidExist && pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = HID + A2DP\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
 			} else if (pBtLinkInfo->bHidExist && pBtLinkInfo->bPanExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = HID + PAN(HS)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = HID + PAN(EDR)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			} else if (pBtLinkInfo->bPanExist && pBtLinkInfo->bA2dpExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = A2DP + PAN(HS)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = A2DP + PAN(EDR)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_A2DP;
 				}
 			}
@@ -723,32 +570,19 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 	} else if (numOfDiffProfile == 3) {
 		if (pBtLinkInfo->bScoExist) {
 			if (pBtLinkInfo->bHidExist && pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT Profile = SCO + HID + A2DP ==> HID\n")
-				);
 				algorithm = BT_8723B_1ANT_COEX_ALGO_HID;
 			} else if (
 				pBtLinkInfo->bHidExist && pBtLinkInfo->bPanExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT Profile = SCO + HID + PAN(HS)\n"));
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT Profile = SCO + HID + PAN(EDR)\n"));
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			} else if (pBtLinkInfo->bPanExist && pBtLinkInfo->bA2dpExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT Profile = SCO + A2DP + PAN(HS)\n"));
 					algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = SCO + A2DP + PAN(EDR) ==> HID\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -759,18 +593,8 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = HID + A2DP + PAN(HS)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = HID + A2DP + PAN(EDR)\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP_PANEDR;
 				}
 			}
@@ -783,18 +607,7 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], Error!!! BT Profile = SCO + HID + A2DP + PAN(HS)\n")
-					);
-
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], BT Profile = SCO + HID + A2DP + PAN(EDR) ==>PAN(EDR)+HID\n")
-					);
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -820,15 +633,6 @@ static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
 		H2C_Parameter[5] = 0xf9;	/* MCS5 or OFDM36 */
 	}
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], set WiFi Low-Penalty Retry: %s",
-			(bLowPenaltyRa ? "ON!!" : "OFF!!")
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x69, 6, H2C_Parameter);
 }
 
@@ -857,32 +661,12 @@ static void halbtc8723b1ant_SetCoexTable(
 	u8 val0x6cc
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c0, val0x6c0);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c4, val0x6c4);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c8, val0x6c8);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc)
-	);
 	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cc, val0x6cc);
 }
 
@@ -895,15 +679,6 @@ static void halbtc8723b1ant_CoexTable(
 	u8 val0x6cc
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6cc = 0x%x\n",
-			(bForceExec ? "force to" : ""),
-			val0x6c0, val0x6c4, val0x6cc
-		)
-	);
 	pCoexDm->curVal0x6c0 = val0x6c0;
 	pCoexDm->curVal0x6c4 = val0x6c4;
 	pCoexDm->curVal0x6c8 = val0x6c8;
@@ -933,12 +708,6 @@ static void halbtc8723b1ant_CoexTableWithType(
 	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE,
-		("[BTCoex], ********** CoexTable(%d) **********\n", type)
-	);
-
 	pCoexSta->nCoexTableType = type;
 
 	switch (type) {
@@ -996,15 +765,6 @@ static void halbtc8723b1ant_SetFwIgnoreWlanAct(
 	if (bEnable)
 		H2C_Parameter[0] |= BIT0; /* function enable */
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
-			H2C_Parameter[0]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x63, 1, H2C_Parameter);
 }
 
@@ -1012,28 +772,9 @@ static void halbtc8723b1ant_IgnoreWlanAct(
 	struct btc_coexist *pBtCoexist, bool bForceExec, bool bEnable
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s turn Ignore WlanAct %s\n",
-			(bForceExec ? "force to" : ""),
-			(bEnable ? "ON" : "OFF")
-		)
-	);
 	pCoexDm->bCurIgnoreWlanAct = bEnable;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], bPreIgnoreWlanAct = %d, bCurIgnoreWlanAct = %d!!\n",
-				pCoexDm->bPreIgnoreWlanAct,
-				pCoexDm->bCurIgnoreWlanAct
-			)
-		);
-
 		if (pCoexDm->bPreIgnoreWlanAct == pCoexDm->bCurIgnoreWlanAct)
 			return;
 	}
@@ -1057,44 +798,14 @@ static void halbtc8723b1ant_LpsRpwm(
 	struct btc_coexist *pBtCoexist, bool bForceExec, u8 lpsVal, u8 rpwmVal
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s set lps/rpwm = 0x%x/0x%x\n",
-			(bForceExec ? "force to" : ""),
-			lpsVal,
-			rpwmVal
-		)
-	);
 	pCoexDm->curLps = lpsVal;
 	pCoexDm->curRpwm = rpwmVal;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], LPS-RxBeaconMode = 0x%x , LPS-RPWM = 0x%x!!\n",
-				pCoexDm->curLps,
-				pCoexDm->curRpwm
-			)
-		);
-
 		if (
 			(pCoexDm->preLps == pCoexDm->curLps) &&
 			(pCoexDm->preRpwm == pCoexDm->curRpwm)
 		) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE_FW_DETAIL,
-				(
-					"[BTCoex], LPS-RPWM_Last = 0x%x , LPS-RPWM_Now = 0x%x!!\n",
-					pCoexDm->preRpwm,
-					pCoexDm->curRpwm
-				)
-			);
-
 			return;
 		}
 	}
@@ -1108,12 +819,6 @@ static void halbtc8723b1ant_SwMechanism(
 	struct btc_coexist *pBtCoexist, bool bLowPenaltyRA
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_BT_MONITOR,
-		("[BTCoex], SM[LpRA] = %d\n", bLowPenaltyRA)
-	);
-
 	halbtc8723b1ant_LowPenaltyRa(pBtCoexist, NORMAL_EXEC, bLowPenaltyRA);
 }
 
@@ -1190,10 +895,8 @@ static void halbtc8723b1ant_SetAntPath(
 				cntBtCalChk++;
 
 				if (u1Tmp & BIT0) {
-					BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ########### BT is calibrating (wait cnt =%d) ###########\n", cntBtCalChk));
 					mdelay(50);
 				} else {
-					BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ********** BT is NOT calibrating (wait cnt =%d)**********\n", cntBtCalChk));
 					break;
 				}
 			}
@@ -1318,11 +1021,6 @@ static void halbtc8723b1ant_SetFwPstdma(
 
 	if (bApEnable) {
 		if (byte1 & BIT4 && !(byte1 & BIT5)) {
-			BTC_PRINT(
-				BTC_MSG_INTERFACE,
-				INTF_NOTIFY,
-				("[BTCoex], FW for 1Ant AP mode\n")
-			);
 			realByte1 &= ~BIT4;
 			realByte1 |= BIT5;
 
@@ -1343,19 +1041,6 @@ static void halbtc8723b1ant_SetFwPstdma(
 	pCoexDm->psTdmaPara[3] = byte4;
 	pCoexDm->psTdmaPara[4] = realByte5;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], PS-TDMA H2C cmd = 0x%x%08x\n",
-			H2C_Parameter[0],
-			H2C_Parameter[1] << 24 |
-			H2C_Parameter[2] << 16 |
-			H2C_Parameter[3] << 8 |
-			H2C_Parameter[4]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x60, 5, H2C_Parameter);
 }
 
@@ -1379,23 +1064,7 @@ static void halbtc8723b1ant_PsTdma(
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 
 	if (pCoexDm->bCurPsTdmaOn) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			(
-				"[BTCoex], ********** TDMA(on, %d) **********\n",
-				pCoexDm->curPsTdma
-			)
-		);
 	} else {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			(
-				"[BTCoex], ********** TDMA(off, %d) **********\n",
-				pCoexDm->curPsTdma
-			)
-		);
 	}
 
 	if (!bForceExec) {
@@ -1672,12 +1341,6 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		!bWifiConnected &&
 		BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus
 	) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], Wifi non connected-idle + BT non connected-idle!!\n")
-		);
-
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
@@ -1685,12 +1348,6 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		bWifiConnected &&
 		(BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus)
 	) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], Wifi connected + BT non connected-idle!!\n")
-		);
-
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
@@ -1698,12 +1355,6 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		!bWifiConnected &&
 		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
 	) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], Wifi non connected-idle + BT connected-idle!!\n")
-		);
-
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
@@ -1711,8 +1362,6 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		bWifiConnected &&
 		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
 	) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi connected + BT connected-idle!!\n"));
-
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
@@ -1720,28 +1369,12 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		!bWifiConnected &&
 		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE != pCoexDm->btStatus)
 	) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], Wifi non connected-idle + BT Busy!!\n")
-		);
-
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
 	} else {
 		if (bWifiBusy) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE,
-				("[BTCoex], Wifi Connected-Busy + BT Busy!!\n")
-			);
 		} else {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE,
-				("[BTCoex], Wifi Connected-Idle + BT Busy!!\n")
-			);
 		}
 
 		bCommon = false;
@@ -1759,12 +1392,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 	s32 result;   /* 0: no change, +1: increase WiFi duration, -1: decrease WiFi duration */
 	u8 retryCount = 0, btInfoExt;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		("[BTCoex], TdmaDurationAdjustForAcl()\n")
-	);
-
 	if (
 		(BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN == wifiStatus) ||
 		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN == wifiStatus) ||
@@ -1791,11 +1418,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 
 	if (!pCoexDm->bAutoTdmaAdjust) {
 		pCoexDm->bAutoTdmaAdjust = true;
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			("[BTCoex], first run TdmaDurationAdjust()!!\n")
-		);
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
 		pCoexDm->psTdmaDuAdjType = 2;
@@ -1833,11 +1455,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				up = 0;
 				dn = 0;
 				result = 1;
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE_FW_DETAIL,
-					("[BTCoex], Increase wifi duration!!\n")
-				);
 			}
 		} else if (retryCount <= 3) { /*  <=3 retry in the last 2-second duration */
 			up--;
@@ -1860,7 +1477,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				dn = 0;
 				WaitCount = 0;
 				result = -1;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], Decrease wifi duration for retryCounter<3!!\n"));
 			}
 		} else { /* retry count > 3, 只要1次 retry count > 3, 則調窄WiFi duration */
 			if (WaitCount == 1)
@@ -1876,11 +1492,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 			dn = 0;
 			WaitCount = 0;
 			result = -1;
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE_FW_DETAIL,
-				("[BTCoex], Decrease wifi duration for retryCounter>3!!\n")
-			);
 		}
 
 		if (result == -1) {
@@ -1918,14 +1529,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				pCoexDm->psTdmaDuAdjType = 1;
 			}
 		} else {	  /* no change */
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE_FW_DETAIL,
-				(
-					"[BTCoex], ********** TDMA(on, %d) **********\n",
-					pCoexDm->curPsTdma
-				)
-			);
 		}
 
 		if (
@@ -2271,20 +1874,9 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 	bool bScan = false, bLink = false, bRoam = false;
 	bool bUnder4way = false, bApEnable = false;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE,
-		("[BTCoex], CoexForWifiConnect() ===>\n")
-	);
-
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way);
 	if (bUnder4way) {
 		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], CoexForWifiConnect(), return for wifi is under 4way<===\n")
-		);
 		return;
 	}
 
@@ -2296,11 +1888,6 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 			halbtc8723b1ant_ActionWifiConnectedScan(pBtCoexist);
 		else
 			halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE,
-			("[BTCoex], CoexForWifiConnect(), return for wifi is under scan<===\n")
-		);
 		return;
 	}
 
@@ -2397,47 +1984,36 @@ static void halbtc8723b1ant_RunSwCoexistMechanism(struct btc_coexist *pBtCoexist
 	} else {
 		switch (pCoexDm->curAlgorithm) {
 		case BT_8723B_1ANT_COEX_ALGO_SCO:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = SCO.\n"));
 			/* halbtc8723b1ant_ActionSco(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID.\n"));
 			/* halbtc8723b1ant_ActionHid(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = A2DP.\n"));
 			/* halbtc8723b1ant_ActionA2dp(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_A2DP_PANHS:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = A2DP+PAN(HS).\n"));
 			/* halbtc8723b1ant_ActionA2dpPanHs(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN(EDR).\n"));
 			/* halbtc8723b1ant_ActionPanEdr(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANHS:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HS mode.\n"));
 			/* halbtc8723b1ant_ActionPanHs(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN+A2DP.\n"));
 			/* halbtc8723b1ant_ActionPanEdrA2dp(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR_HID:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN(EDR)+HID.\n"));
 			/* halbtc8723b1ant_ActionPanEdrHid(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID+A2DP+PAN.\n"));
 			/* halbtc8723b1ant_ActionHidA2dpPanEdr(pBtCoexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID+A2DP.\n"));
 			/* halbtc8723b1ant_ActionHidA2dp(pBtCoexist); */
 			break;
 		default:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = coexist All Off!!\n"));
 			break;
 		}
 		pCoexDm->preAlgorithm = pCoexDm->curAlgorithm;
@@ -2454,20 +2030,15 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 	u32 wifiLinkStatus = 0;
 	u32 numOfWifiLink = 0;
 
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism() ===>\n"));
-
 	if (pBtCoexist->bManualControl) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n"));
 		return;
 	}
 
 	if (pBtCoexist->bStopCoexDm) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism(), return for Stop Coex DM <===\n"));
 		return;
 	}
 
 	if (pCoexSta->bUnderIps) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], wifi is under IPS !!!\n"));
 		return;
 	}
 
@@ -2498,24 +2069,10 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 	numOfWifiLink = wifiLinkStatus >> 16;
 
 	if ((numOfWifiLink >= 2) || (wifiLinkStatus & WIFI_P2P_GO_CONNECTED)) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE,
-			INTF_NOTIFY,
-			(
-				"############# [BTCoex],  Multi-Port numOfWifiLink = %d, wifiLinkStatus = 0x%x\n",
-				numOfWifiLink,
-				wifiLinkStatus
-			)
-		);
 		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
 		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
 
 		if ((pBtLinkInfo->bA2dpExist) && (pCoexSta->bC2hBtInquiryPage)) {
-			BTC_PRINT(
-				BTC_MSG_INTERFACE,
-				INTF_NOTIFY,
-				("############# [BTCoex],  BT Is Inquirying\n")
-			);
 			halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
 		} else
 			halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
@@ -2544,11 +2101,6 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 	if (pCoexSta->bC2hBtInquiryPage) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE,
-			INTF_NOTIFY,
-			("############# [BTCoex],  BT Is Inquirying\n")
-		);
 		halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
 		return;
 	} else if (bBtHsOn) {
@@ -2560,8 +2112,6 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 	if (!bWifiConnected) {
 		bool bScan = false, bLink = false, bRoam = false;
 
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], wifi is non connected-idle !!!\n"));
-
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
@@ -2599,12 +2149,6 @@ static void halbtc8723b1ant_InitHwConfig(
 	u32 u4Tmp = 0;/*  fwVer; */
 	u8 u1Tmpa = 0, u1Tmpb = 0;
 
-	BTC_PRINT(
-		BTC_MSG_INTERFACE,
-		INTF_INIT,
-		("[BTCoex], 1Ant Init HW Config!!\n")
-	);
-
 	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x550, 0x8, 0x1);  /* enable TBTT nterrupt */
 
 	/*  0x790[5:0]= 0x5 */
@@ -2627,17 +2171,6 @@ static void halbtc8723b1ant_InitHwConfig(
 	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
 	u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
 	u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
-
-	BTC_PRINT(
-		BTC_MSG_INTERFACE,
-		INTF_NOTIFY,
-		(
-			"############# [BTCoex], 0x948 = 0x%x, 0x765 = 0x%x, 0x67 = 0x%x\n",
-			u4Tmp,
-			u1Tmpa,
-			u1Tmpb
-		)
-	);
 }
 
 /*  */
@@ -2705,12 +2238,6 @@ void EXhalbtc8723b1ant_InitHwConfig(struct btc_coexist *pBtCoexist, bool bWifiOn
 
 void EXhalbtc8723b1ant_InitCoexDm(struct btc_coexist *pBtCoexist)
 {
-	BTC_PRINT(
-		BTC_MSG_INTERFACE,
-		INTF_INIT,
-		("[BTCoex], Coex Mechanism Init!!\n")
-	);
-
 	pBtCoexist->bStopCoexDm = false;
 
 	halbtc8723b1ant_InitCoexDm(pBtCoexist);
@@ -3187,18 +2714,12 @@ void EXhalbtc8723b1ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 		return;
 
 	if (BTC_IPS_ENTER == type) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS ENTER notify\n")
-		);
 		pCoexSta->bUnderIps = true;
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
 		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
 		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
 	} else if (BTC_IPS_LEAVE == type) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS LEAVE notify\n")
-		);
 		pCoexSta->bUnderIps = false;
 
 		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
@@ -3213,14 +2734,8 @@ void EXhalbtc8723b1ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 		return;
 
 	if (BTC_LPS_ENABLE == type) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS ENABLE notify\n")
-		);
 		pCoexSta->bUnderLps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS DISABLE notify\n")
-		);
 		pCoexSta->bUnderLps = false;
 	}
 }
@@ -3241,31 +2756,13 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 
 	if (BTC_SCAN_START == type) {
 		pCoexSta->bWiFiIsHighPriTask = true;
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN START notify\n")
-		);
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
 		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
 		u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
 		u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
-
-
-		BTC_PRINT(
-			BTC_MSG_INTERFACE,
-			INTF_NOTIFY,
-			(
-				"[BTCoex], 0x948 = 0x%x, 0x765 = 0x%x, 0x67 = 0x%x\n",
-				u4Tmp,
-				u1Tmpa,
-				u1Tmpb
-			)
-		);
 	} else {
 		pCoexSta->bWiFiIsHighPriTask = false;
-		BTC_PRINT(
-			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN FINISH notify\n")
-		);
 
 		pBtCoexist->fBtcGet(
 			pBtCoexist, BTC_GET_U1_AP_NUM, &pCoexSta->nScanAPNum
@@ -3332,11 +2829,9 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 
 	if (BTC_ASSOCIATE_START == type) {
 		pCoexSta->bWiFiIsHighPriTask = true;
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT START notify\n"));
 		 pCoexDm->nArpCnt = 0;
 	} else {
 		pCoexSta->bWiFiIsHighPriTask = false;
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT FINISH notify\n"));
 		/* pCoexDm->nArpCnt = 0; */
 	}
 
@@ -3387,8 +2882,6 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 		return;
 
 	if (BTC_MEDIA_CONNECT == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA connect notify\n"));
-
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode);
 
 		/* Set CCK Tx/Rx high Pri except 11b mode */
@@ -3405,7 +2898,6 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 		pCoexDm->backupRetryLimit = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x42a);
 		pCoexDm->backupAmpduMaxTime = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x456);
 	} else {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA disconnect notify\n"));
 		pCoexDm->nArpCnt = 0;
 
 		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cd, 0x0); /* CCK Tx */
@@ -3430,15 +2922,6 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 	pCoexDm->wifiChnlInfo[1] = H2C_Parameter[1];
 	pCoexDm->wifiChnlInfo[2] = H2C_Parameter[2];
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], FW write 0x66 = 0x%x\n",
-			H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | H2C_Parameter[2]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x66, 3, H2C_Parameter);
 }
 
@@ -3463,18 +2946,7 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 		BTC_PACKET_ARP == type
 	) {
 		if (BTC_PACKET_ARP == type) {
-			BTC_PRINT(
-				BTC_MSG_INTERFACE,
-				INTF_NOTIFY,
-				("[BTCoex], special Packet ARP notify\n")
-			);
-
 			pCoexDm->nArpCnt++;
-			BTC_PRINT(
-				BTC_MSG_INTERFACE,
-				INTF_NOTIFY,
-				("[BTCoex], ARP Packet Count = %d\n", pCoexDm->nArpCnt)
-			);
 
 			if (pCoexDm->nArpCnt >= 10) /*  if APR PKT > 10 after connect, do not go to ActionWifiConnectedSpecialPacket(pBtCoexist) */
 				pCoexSta->bWiFiIsHighPriTask = false;
@@ -3482,19 +2954,9 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 				pCoexSta->bWiFiIsHighPriTask = true;
 		} else {
 			pCoexSta->bWiFiIsHighPriTask = true;
-			BTC_PRINT(
-				BTC_MSG_INTERFACE,
-				INTF_NOTIFY,
-				("[BTCoex], special Packet DHCP or EAPOL notify\n")
-			);
 		}
 	} else {
 		pCoexSta->bWiFiIsHighPriTask = false;
-		BTC_PRINT(
-			BTC_MSG_INTERFACE,
-			INTF_NOTIFY,
-			("[BTCoex], special Packet [Type = %d] notify\n", type)
-		);
 	}
 
 	pCoexSta->specialPktPeriodCnt = 0;
@@ -3546,23 +3008,14 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		rspSource = BT_INFO_SRC_8723B_1ANT_WIFI_FW;
 	pCoexSta->btInfoC2hCnt[rspSource]++;
 
-	BTC_PRINT(
-		BTC_MSG_INTERFACE,
-		INTF_NOTIFY,
-		("[BTCoex], Bt info[%d], length =%d, hex data =[",
-		rspSource,
-		length)
-	);
 	for (i = 0; i < length; i++) {
 		pCoexSta->btInfoC2h[rspSource][i] = tmpBuf[i];
 		if (i == 1)
 			btInfo = tmpBuf[i];
 		if (i == length - 1)
-			BTC_PRINT(
-				BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x]\n", tmpBuf[i])
-			);
+			{}
 		else
-			BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x, ", tmpBuf[i]));
+			{}
 	}
 
 	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {
@@ -3586,18 +3039,12 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 		if (!pCoexSta->bBtTxRxMask) {
 			/* BT into is responded by BT FW and BT RF REG 0x3C != 0x15 => Need to switch BT TRx Mask */
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x15\n"));
 			pBtCoexist->fBtcSetBtReg(pBtCoexist, BTC_BT_REG_RF, 0x3c, 0x15);
 		}
 
 		/*  Here we need to resend some wifi info to BT */
 		/*  because bt is reset and loss of the info. */
 		if (pCoexSta->btInfoExt & BIT1) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE,
-				("[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n")
-			);
 			pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 			if (bWifiConnected)
 				EXhalbtc8723b1ant_MediaStatusNotify(pBtCoexist, BTC_MEDIA_CONNECT);
@@ -3607,11 +3054,6 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 		if (pCoexSta->btInfoExt & BIT3) {
 			if (!pBtCoexist->bManualControl && !pBtCoexist->bStopCoexDm) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n")
-				);
 				halbtc8723b1ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, false);
 			}
 		} else {
@@ -3661,26 +3103,21 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 	if (!(btInfo & BT_INFO_8723B_1ANT_B_CONNECTION)) {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n"));
 	} else if (btInfo == BT_INFO_8723B_1ANT_B_CONNECTION)	{
 		/*  connection exists but no busy */
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n"));
 	} else if (
 		(btInfo & BT_INFO_8723B_1ANT_B_SCO_ESCO) ||
 		(btInfo & BT_INFO_8723B_1ANT_B_SCO_BUSY)
 	) {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT SCO busy!!!\n"));
 	} else if (btInfo & BT_INFO_8723B_1ANT_B_ACL_BUSY) {
 		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != pCoexDm->btStatus)
 			pCoexDm->bAutoTdmaAdjust = false;
 
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_ACL_BUSY;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT ACL busy!!!\n"));
 	} else {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_MAX;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n"));
 	}
 
 	if (
@@ -3698,8 +3135,6 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *pBtCoexist)
 {
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Halt notify\n"));
-
 	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 	halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 0);
 	halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
@@ -3713,11 +3148,7 @@ void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *pBtCoexist)
 
 void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState)
 {
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify\n"));
-
 	if (BTC_WIFI_PNP_SLEEP == pnpState) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to SLEEP\n"));
-
 		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
 		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
@@ -3725,7 +3156,6 @@ void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState)
 
 		pBtCoexist->bStopCoexDm = true;
 	} else if (BTC_WIFI_PNP_WAKE_UP == pnpState) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to WAKE UP\n"));
 		pBtCoexist->bStopCoexDm = false;
 		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
 		halbtc8723b1ant_InitCoexDm(pBtCoexist);
@@ -3738,16 +3168,10 @@ void EXhalbtc8723b1ant_Periodical(struct btc_coexist *pBtCoexist)
 	static u8 disVerInfoCnt;
 	u32 fwVer = 0, btPatchVer = 0;
 
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], ==========================Periodical ===========================\n"));
-
 	if (disVerInfoCnt <= 5) {
 		disVerInfoCnt += 1;
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], CoexVer/ FwVer/ PatchVer = %d_%x/ 0x%x/ 0x%x(%d)\n", \
-			GLCoexVerDate8723b1Ant, GLCoexVer8723b1Ant, fwVer, btPatchVer, btPatchVer));
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
 	}
 
 	halbtc8723b1ant_MonitorBtCtr(pBtCoexist);
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 4b570ec75e67..73f1cc6bc27c 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -46,23 +46,18 @@ static u8 halbtc8723b2ant_BtRssiState(
 		) {
 			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				btRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state stay at Low\n"));
 			}
 		} else {
 			if (btRssi < rssiThresh) {
 				btRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to Low\n"));
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state stay at High\n"));
 			}
 		}
 	} else if (levelNum == 3) {
 		if (rssiThresh > rssiThresh1) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi thresh error!!\n"));
 			return pCoexSta->preBtRssiState;
 		}
 
@@ -72,10 +67,8 @@ static u8 halbtc8723b2ant_BtRssiState(
 		) {
 			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to Medium\n"));
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state stay at Low\n"));
 			}
 		} else if (
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
@@ -83,21 +76,16 @@ static u8 halbtc8723b2ant_BtRssiState(
 		) {
 			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				btRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
 			} else if (btRssi < rssiThresh) {
 				btRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to Low\n"));
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state stay at Medium\n"));
 			}
 		} else {
 			if (btRssi < rssiThresh1) {
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state switch to Medium\n"));
 			} else {
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI_STATE, ("[BTCoex], BT Rssi state stay at High\n"));
 			}
 		}
 	}
@@ -127,23 +115,18 @@ static u8 halbtc8723b2ant_WifiRssiState(
 		) {
 			if (wifiRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				wifiRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
 			} else {
 				wifiRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state stay at Low\n"));
 			}
 		} else {
 			if (wifiRssi < rssiThresh) {
 				wifiRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to Low\n"));
 			} else {
 				wifiRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state stay at High\n"));
 			}
 		}
 	} else if (levelNum == 3) {
 		if (rssiThresh > rssiThresh1) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI thresh error!!\n"));
 			return pCoexSta->preWifiRssiState[index];
 		}
 
@@ -153,10 +136,8 @@ static u8 halbtc8723b2ant_WifiRssiState(
 		) {
 			if (wifiRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				wifiRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to Medium\n"));
 			} else {
 				wifiRssiState = BTC_RSSI_STATE_STAY_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state stay at Low\n"));
 			}
 		} else if (
 			(pCoexSta->preWifiRssiState[index] == BTC_RSSI_STATE_MEDIUM) ||
@@ -164,21 +145,16 @@ static u8 halbtc8723b2ant_WifiRssiState(
 		) {
 			if (wifiRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT)) {
 				wifiRssiState = BTC_RSSI_STATE_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
 			} else if (wifiRssi < rssiThresh) {
 				wifiRssiState = BTC_RSSI_STATE_LOW;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to Low\n"));
 			} else {
 				wifiRssiState = BTC_RSSI_STATE_STAY_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state stay at Medium\n"));
 			}
 		} else {
 			if (wifiRssi < rssiThresh1) {
 				wifiRssiState = BTC_RSSI_STATE_MEDIUM;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state switch to Medium\n"));
 			} else {
 				wifiRssiState = BTC_RSSI_STATE_STAY_HIGH;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RSSI_STATE, ("[BTCoex], wifi RSSI state stay at High\n"));
 			}
 		}
 	}
@@ -233,31 +209,6 @@ static void halbtc8723b2ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
 	pCoexSta->lowPriorityTx = regLPTx;
 	pCoexSta->lowPriorityRx = regLPRx;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_BT_MONITOR,
-		(
-			"[BTCoex], High Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
-			regHPTxRx,
-			regHPTx,
-			regHPTx,
-			regHPRx,
-			regHPRx
-		)
-	);
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_BT_MONITOR,
-		(
-			"[BTCoex], Low Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
-			regLPTxRx,
-			regLPTx,
-			regLPTx,
-			regLPRx,
-			regLPRx
-		)
-	);
-
 	/*  reset counter */
 	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0xc);
 }
@@ -270,12 +221,6 @@ static void halbtc8723b2ant_QueryBtInfo(struct btc_coexist *pBtCoexist)
 
 	H2C_Parameter[0] |= BIT0;	/*  trigger */
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		("[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n", H2C_Parameter[0])
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x61, 1, H2C_Parameter);
 }
 
@@ -384,7 +329,6 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 
 	if (!pBtLinkInfo->bBtLinkExist) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], No BT link exists!!!\n"));
 		return algorithm;
 	}
 
@@ -402,21 +346,16 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 
 	if (numOfDiffProfile == 1) {
 		if (pBtLinkInfo->bScoExist) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO only\n"));
 			algorithm = BT_8723B_2ANT_COEX_ALGO_SCO;
 		} else {
 			if (pBtLinkInfo->bHidExist) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID only\n"));
 				algorithm = BT_8723B_2ANT_COEX_ALGO_HID;
 			} else if (pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], A2DP only\n"));
 				algorithm = BT_8723B_2ANT_COEX_ALGO_A2DP;
 			} else if (pBtLinkInfo->bPanExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], PAN(HS) only\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANHS;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], PAN(EDR) only\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR;
 				}
 			}
@@ -424,17 +363,13 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 	} else if (numOfDiffProfile == 2) {
 		if (pBtLinkInfo->bScoExist) {
 			if (pBtLinkInfo->bHidExist) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + HID\n"));
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (pBtLinkInfo->bA2dpExist) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + A2DP ==> SCO\n"));
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (pBtLinkInfo->bPanExist) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + PAN(HS)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_SCO;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + PAN(EDR)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -443,17 +378,14 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bHidExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID + A2DP\n"));
 				algorithm = BT_8723B_2ANT_COEX_ALGO_HID_A2DP;
 			} else if (
 				pBtLinkInfo->bHidExist &&
 				pBtLinkInfo->bPanExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID + PAN(HS)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_HID;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID + PAN(EDR)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				}
 			} else if (
@@ -461,10 +393,8 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], A2DP + PAN(HS)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], A2DP + PAN(EDR)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_A2DP;
 				}
 			}
@@ -475,29 +405,14 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bHidExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				BTC_PRINT(
-					BTC_MSG_ALGORITHM,
-					ALGO_TRACE,
-					("[BTCoex], SCO + HID + A2DP ==> HID\n")
-				);
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (
 				pBtLinkInfo->bHidExist &&
 				pBtLinkInfo->bPanExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], SCO + HID + PAN(HS)\n")
-					);
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				} else {
-					BTC_PRINT(
-						BTC_MSG_ALGORITHM,
-						ALGO_TRACE,
-						("[BTCoex], SCO + HID + PAN(EDR)\n")
-					);
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				}
 			} else if (
@@ -505,10 +420,8 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + A2DP + PAN(HS)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + A2DP + PAN(EDR) ==> HID\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -519,10 +432,8 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID + A2DP + PAN(HS)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], HID + A2DP + PAN(EDR)\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_HID_A2DP_PANEDR;
 				}
 			}
@@ -535,10 +446,7 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bA2dpExist
 			) {
 				if (bBtHsOn) {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Error!!! SCO + HID + A2DP + PAN(HS)\n"));
-
 				} else {
-					BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], SCO + HID + A2DP + PAN(EDR) ==>PAN(EDR)+HID\n"));
 					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -558,17 +466,6 @@ static void halbtc8723b2ant_SetFwDacSwingLevel(
 	/*  0x18/ 0x10/ 0xc/ 0x8/ 0x4/ 0x6 */
 	H2C_Parameter[0] = dacSwingLvl;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		("[BTCoex], Set Dac Swing Level = 0x%x\n", dacSwingLvl)
-	);
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		("[BTCoex], FW write 0x64 = 0x%x\n", H2C_Parameter[0])
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x64, 1, H2C_Parameter);
 }
 
@@ -580,16 +477,6 @@ static void halbtc8723b2ant_SetFwDecBtPwr(
 
 	H2C_Parameter[0] = decBtPwrLvl;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], decrease Bt Power level = %d, FW write 0x62 = 0x%x\n",
-			decBtPwrLvl,
-			H2C_Parameter[0]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x62, 1, H2C_Parameter);
 }
 
@@ -597,28 +484,9 @@ static void halbtc8723b2ant_DecBtPwr(
 	struct btc_coexist *pBtCoexist, bool bForceExec, u8 decBtPwrLvl
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s Dec BT power level = %d\n",
-			(bForceExec ? "force to" : ""),
-			decBtPwrLvl
-		)
-	);
 	pCoexDm->curBtDecPwrLvl = decBtPwrLvl;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], preBtDecPwrLvl =%d, curBtDecPwrLvl =%d\n",
-				pCoexDm->preBtDecPwrLvl,
-				pCoexDm->curBtDecPwrLvl
-			)
-		);
-
 		if (pCoexDm->preBtDecPwrLvl == pCoexDm->curBtDecPwrLvl)
 			return;
 	}
@@ -631,28 +499,9 @@ static void halbtc8723b2ant_FwDacSwingLvl(
 	struct btc_coexist *pBtCoexist, bool bForceExec, u8 fwDacSwingLvl
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s set FW Dac Swing level = %d\n",
-			(bForceExec ? "force to" : ""),
-			fwDacSwingLvl
-		)
-	);
 	pCoexDm->curFwDacSwingLvl = fwDacSwingLvl;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], preFwDacSwingLvl =%d, curFwDacSwingLvl =%d\n",
-				pCoexDm->preFwDacSwingLvl,
-				pCoexDm->curFwDacSwingLvl
-			)
-		);
-
 		if (pCoexDm->preFwDacSwingLvl == pCoexDm->curFwDacSwingLvl)
 			return;
 	}
@@ -669,17 +518,11 @@ static void halbtc8723b2ant_SetSwRfRxLpfCorner(
 {
 	if (bRxRfShrinkOn) {
 		/* Shrink RF Rx LPF corner */
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_EXEC,
-			("[BTCoex], Shrink RF Rx LPF corner!!\n")
-		);
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1e, 0xfffff, 0xffffc);
 	} else {
 		/* Resume RF Rx LPF corner */
 		/*  After initialized, we can use pCoexDm->btRf0x1eBackup */
 		if (pBtCoexist->bInitilized) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], Resume RF Rx LPF corner!!\n"));
 			pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1e, 0xfffff, pCoexDm->btRf0x1eBackup);
 		}
 	}
@@ -689,28 +532,9 @@ static void halbtc8723b2ant_RfShrink(
 	struct btc_coexist *pBtCoexist, bool bForceExec, bool bRxRfShrinkOn
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s turn Rx RF Shrink = %s\n",
-			(bForceExec ? "force to" : ""),
-			(bRxRfShrinkOn ? "ON" : "OFF")
-		)
-	);
 	pCoexDm->bCurRfRxLpfShrink = bRxRfShrinkOn;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], bPreRfRxLpfShrink =%d, bCurRfRxLpfShrink =%d\n",
-				pCoexDm->bPreRfRxLpfShrink,
-				pCoexDm->bCurRfRxLpfShrink
-			)
-		);
-
 		if (pCoexDm->bPreRfRxLpfShrink == pCoexDm->bCurRfRxLpfShrink)
 			return;
 	}
@@ -735,15 +559,6 @@ static void halbtc8723b2ant_SetSwPenaltyTxRateAdaptive(
 		H2C_Parameter[5] = 0xf9;	/* MCS5 or OFDM36 */
 	}
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], set WiFi Low-Penalty Retry: %s",
-			(bLowPenaltyRa ? "ON!!" : "OFF!!")
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x69, 6, H2C_Parameter);
 }
 
@@ -752,28 +567,9 @@ static void halbtc8723b2ant_LowPenaltyRa(
 )
 {
 	/* return; */
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s turn LowPenaltyRA = %s\n",
-			(bForceExec ? "force to" : ""),
-			(bLowPenaltyRa ? "ON" : "OFF")
-		)
-	);
 	pCoexDm->bCurLowPenaltyRa = bLowPenaltyRa;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], bPreLowPenaltyRa =%d, bCurLowPenaltyRa =%d\n",
-				pCoexDm->bPreLowPenaltyRa,
-				pCoexDm->bCurLowPenaltyRa
-			)
-		);
-
 		if (pCoexDm->bPreLowPenaltyRa == pCoexDm->bCurLowPenaltyRa)
 			return;
 	}
@@ -786,11 +582,6 @@ static void halbtc8723b2ant_SetDacSwingReg(struct btc_coexist *pBtCoexist, u32 l
 {
 	u8 val = (u8)level;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], Write SwDacSwing = 0x%x\n", level)
-	);
 	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x883, 0x3e, val);
 }
 
@@ -812,32 +603,10 @@ static void halbtc8723b2ant_DacSwing(
 	u32 dacSwingLvl
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s turn DacSwing =%s, dacSwingLvl = 0x%x\n",
-			(bForceExec ? "force to" : ""),
-			(bDacSwingOn ? "ON" : "OFF"),
-			dacSwingLvl
-		)
-	);
 	pCoexDm->bCurDacSwingOn = bDacSwingOn;
 	pCoexDm->curDacSwingLvl = dacSwingLvl;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], bPreDacSwingOn =%d, preDacSwingLvl = 0x%x, bCurDacSwingOn =%d, curDacSwingLvl = 0x%x\n",
-				pCoexDm->bPreDacSwingOn,
-				pCoexDm->preDacSwingLvl,
-				pCoexDm->bCurDacSwingOn,
-				pCoexDm->curDacSwingLvl
-			)
-		);
-
 		if ((pCoexDm->bPreDacSwingOn == pCoexDm->bCurDacSwingOn) &&
 			(pCoexDm->preDacSwingLvl == pCoexDm->curDacSwingLvl))
 			return;
@@ -857,7 +626,6 @@ static void halbtc8723b2ant_SetAgcTable(
 
 	/* BB AGC Gain Table */
 	if (bAgcTableEn) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], BB Agc Table On!\n"));
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0x6e1A0001);
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0x6d1B0001);
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0x6c1C0001);
@@ -866,7 +634,6 @@ static void halbtc8723b2ant_SetAgcTable(
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0x691F0001);
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0x68200001);
 	} else {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], BB Agc Table Off!\n"));
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0xaa1A0001);
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0xa91B0001);
 		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0xc78, 0xa81C0001);
@@ -880,11 +647,9 @@ static void halbtc8723b2ant_SetAgcTable(
 	/* RF Gain */
 	pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0xef, 0xfffff, 0x02000);
 	if (bAgcTableEn) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], Agc Table On!\n"));
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x3b, 0xfffff, 0x38fff);
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x3b, 0xfffff, 0x38ffe);
 	} else {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], Agc Table Off!\n"));
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x3b, 0xfffff, 0x380c3);
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x3b, 0xfffff, 0x28ce6);
 	}
@@ -892,11 +657,9 @@ static void halbtc8723b2ant_SetAgcTable(
 
 	pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0xed, 0xfffff, 0x1);
 	if (bAgcTableEn) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], Agc Table On!\n"));
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x40, 0xfffff, 0x38fff);
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x40, 0xfffff, 0x38ffe);
 	} else {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_SW_EXEC, ("[BTCoex], Agc Table Off!\n"));
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x40, 0xfffff, 0x380c3);
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x40, 0xfffff, 0x28ce6);
 	}
@@ -913,28 +676,9 @@ static void halbtc8723b2ant_AgcTable(
 	struct btc_coexist *pBtCoexist, bool bForceExec, bool bAgcTableEn
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s %s Agc Table\n",
-			(bForceExec ? "force to" : ""),
-			(bAgcTableEn ? "Enable" : "Disable")
-		)
-	);
 	pCoexDm->bCurAgcTableEn = bAgcTableEn;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], bPreAgcTableEn =%d, bCurAgcTableEn =%d\n",
-				pCoexDm->bPreAgcTableEn,
-				pCoexDm->bCurAgcTableEn
-			)
-		);
-
 		if (pCoexDm->bPreAgcTableEn == pCoexDm->bCurAgcTableEn)
 			return;
 	}
@@ -951,32 +695,12 @@ static void halbtc8723b2ant_SetCoexTable(
 	u8 val0x6cc
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c0, val0x6c0);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c4, val0x6c4);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8)
-	);
 	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c8, val0x6c8);
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW_EXEC,
-		("[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc)
-	);
 	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cc, val0x6cc);
 }
 
@@ -989,47 +713,12 @@ static void halbtc8723b2ant_CoexTable(
 	u8 val0x6cc
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_SW,
-		(
-			"[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6c8 = 0x%x, 0x6cc = 0x%x\n",
-			(bForceExec ? "force to" : ""),
-			val0x6c0,
-			val0x6c4,
-			val0x6c8,
-			val0x6cc
-		)
-	);
 	pCoexDm->curVal0x6c0 = val0x6c0;
 	pCoexDm->curVal0x6c4 = val0x6c4;
 	pCoexDm->curVal0x6c8 = val0x6c8;
 	pCoexDm->curVal0x6cc = val0x6cc;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], preVal0x6c0 = 0x%x, preVal0x6c4 = 0x%x, preVal0x6c8 = 0x%x, preVal0x6cc = 0x%x !!\n",
-				pCoexDm->preVal0x6c0,
-				pCoexDm->preVal0x6c4,
-				pCoexDm->preVal0x6c8,
-				pCoexDm->preVal0x6cc
-			)
-		);
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_SW_DETAIL,
-			(
-				"[BTCoex], curVal0x6c0 = 0x%x, curVal0x6c4 = 0x%x, curVal0x6c8 = 0x%x, curVal0x6cc = 0x%x !!\n",
-				pCoexDm->curVal0x6c0,
-				pCoexDm->curVal0x6c4,
-				pCoexDm->curVal0x6c8,
-				pCoexDm->curVal0x6cc
-			)
-		);
-
 		if (
 			(pCoexDm->preVal0x6c0 == pCoexDm->curVal0x6c0) &&
 			(pCoexDm->preVal0x6c4 == pCoexDm->curVal0x6c4) &&
@@ -1104,15 +793,6 @@ static void halbtc8723b2ant_SetFwIgnoreWlanAct(
 	if (bEnable)
 		H2C_Parameter[0] |= BIT0;		/*  function enable */
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
-			H2C_Parameter[0]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x63, 1, H2C_Parameter);
 }
 
@@ -1120,22 +800,9 @@ static void halbtc8723b2ant_IgnoreWlanAct(
 	struct btc_coexist *pBtCoexist, bool bForceExec, bool bEnable
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s turn Ignore WlanAct %s\n",
-			(bForceExec ? "force to" : ""),
-			(bEnable ? "ON" : "OFF")
-		)
-	);
-
 	pCoexDm->bCurIgnoreWlanAct = bEnable;
 
 	if (!bForceExec) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], bPreIgnoreWlanAct = %d, bCurIgnoreWlanAct = %d!!\n",
-			pCoexDm->bPreIgnoreWlanAct, pCoexDm->bCurIgnoreWlanAct));
-
 		if (pCoexDm->bPreIgnoreWlanAct == pCoexDm->bCurIgnoreWlanAct)
 			return;
 	}
@@ -1167,19 +834,6 @@ static void halbtc8723b2ant_SetFwPstdma(
 	pCoexDm->psTdmaPara[3] = byte4;
 	pCoexDm->psTdmaPara[4] = byte5;
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], FW write 0x60(5bytes) = 0x%x%08x\n",
-			H2C_Parameter[0],
-			H2C_Parameter[1] << 24 |
-			H2C_Parameter[2] << 16 |
-			H2C_Parameter[3] << 8 |
-			H2C_Parameter[4]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x60, 5, H2C_Parameter);
 }
 
@@ -1305,38 +959,10 @@ static void halbtc8723b2ant_PsTdma(
 	struct btc_coexist *pBtCoexist, bool bForceExec, bool bTurnOn, u8 type
 )
 {
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW,
-		(
-			"[BTCoex], %s turn %s PS TDMA, type =%d\n",
-			(bForceExec ? "force to" : ""),
-			(bTurnOn ? "ON" : "OFF"),
-			type
-		)
-	);
 	pCoexDm->bCurPsTdmaOn = bTurnOn;
 	pCoexDm->curPsTdma = type;
 
 	if (!bForceExec) {
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], bPrePsTdmaOn = %d, bCurPsTdmaOn = %d!!\n",
-				pCoexDm->bPrePsTdmaOn,
-				pCoexDm->bCurPsTdmaOn
-			)
-		);
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], prePsTdma = %d, curPsTdma = %d!!\n",
-				pCoexDm->prePsTdma, pCoexDm->curPsTdma
-			)
-		);
-
 		if (
 			(pCoexDm->bPrePsTdmaOn == pCoexDm->bCurPsTdmaOn) &&
 			(pCoexDm->prePsTdma == pCoexDm->curPsTdma)
@@ -1505,8 +1131,6 @@ static bool halbtc8723b2ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable);
 		halbtc8723b2ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x8);
 
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi non-connected idle!!\n"));
-
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1, 0xfffff, 0x0);
 		halbtc8723b2ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
 		halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 1);
@@ -1523,8 +1147,6 @@ static bool halbtc8723b2ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable);
 			halbtc8723b2ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x8);
 
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi connected + BT non connected-idle!!\n"));
-
 			pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1, 0xfffff, 0x0);
 			halbtc8723b2ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
 			halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 1);
@@ -1542,7 +1164,6 @@ static bool halbtc8723b2ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			if (bBtHsOn)
 				return false;
 
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi connected + BT connected-idle!!\n"));
 			halbtc8723b2ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x8);
 
 			pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1, 0xfffff, 0x0);
@@ -1560,13 +1181,11 @@ static bool halbtc8723b2ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable);
 
 			if (bWifiBusy) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi Connected-Busy + BT Busy!!\n"));
 				bCommon = false;
 			} else {
 				if (bBtHsOn)
 					return false;
 
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi Connected-Idle + BT Busy!!\n"));
 				btRssiState = halbtc8723b2ant_BtRssiState(2, 29, 0);
 				halbtc8723b2ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x8);
 
@@ -1598,11 +1217,8 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 	s32 result;   /* 0: no change, +1: increase WiFi duration, -1: decrease WiFi duration */
 	u8 retryCount = 0;
 
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW, ("[BTCoex], TdmaDurationAdjust()\n"));
-
 	if (!pCoexDm->bAutoTdmaAdjust) {
 		pCoexDm->bAutoTdmaAdjust = true;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], first run TdmaDurationAdjust()!!\n"));
 		{
 			if (bScoHid) {
 				if (bTxPause) {
@@ -1648,15 +1264,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 	} else {
 		/* acquire the BT TRx retry count from BT_Info byte2 */
 		retryCount = pCoexSta->btRetryCnt;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], retryCount = %d\n", retryCount));
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], up =%d, dn =%d, m =%d, n =%d, WaitCount =%d\n",
-				up, dn, m, n, WaitCount
-			)
-		);
 		result = 0;
 		WaitCount++;
 
@@ -1673,7 +1280,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 				up = 0;
 				dn = 0;
 				result = 1;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], Increase wifi duration!!\n"));
 			}
 		} else if (retryCount <= 3) { /*  <=3 retry in the last 2-second duration */
 			up--;
@@ -1696,7 +1302,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 				dn = 0;
 				WaitCount = 0;
 				result = -1;
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], Decrease wifi duration for retryCounter<3!!\n"));
 			}
 		} else { /* retry count > 3, 只要1次 retry count > 3, 則調窄WiFi duration */
 			if (WaitCount == 1)
@@ -1712,14 +1317,10 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 			dn = 0;
 			WaitCount = 0;
 			result = -1;
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], Decrease wifi duration for retryCounter>3!!\n"));
 		}
 
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], max Interval = %d\n", maxInterval));
 		if (maxInterval == 1) {
 			if (bTxPause) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
-
 				if (pCoexDm->curPsTdma == 71)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
 				else if (pCoexDm->curPsTdma == 1)
@@ -1768,7 +1369,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(13);
 				}
 			} else {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
 				if (pCoexDm->curPsTdma == 5)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(71);
 				else if (pCoexDm->curPsTdma == 6)
@@ -1821,7 +1421,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 			}
 		} else if (maxInterval == 2) {
 			if (bTxPause) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
 				if (pCoexDm->curPsTdma == 1)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
 				else if (pCoexDm->curPsTdma == 2)
@@ -1868,7 +1467,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
 				}
 			} else {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
 				if (pCoexDm->curPsTdma == 5)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
 				else if (pCoexDm->curPsTdma == 6)
@@ -1917,7 +1515,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 			}
 		} else if (maxInterval == 3) {
 			if (bTxPause) {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
 				if (pCoexDm->curPsTdma == 1)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
 				else if (pCoexDm->curPsTdma == 2)
@@ -1964,7 +1561,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
 				}
 			} else {
-				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
 				if (pCoexDm->curPsTdma == 5)
 					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
 				else if (pCoexDm->curPsTdma == 6)
@@ -2018,15 +1614,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 	/*  then we have to adjust it back to the previous record one. */
 	if (pCoexDm->curPsTdma != pCoexDm->psTdmaDuAdjType) {
 		bool bScan = false, bLink = false, bRoam = false;
-		BTC_PRINT(
-			BTC_MSG_ALGORITHM,
-			ALGO_TRACE_FW_DETAIL,
-			(
-				"[BTCoex], PsTdma type mismatch!!!, curPsTdma =%d, recordPsTdma =%d\n",
-				pCoexDm->curPsTdma,
-				pCoexDm->psTdmaDuAdjType
-			)
-		);
 
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
@@ -2035,7 +1622,6 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 		if (!bScan && !bLink && !bRoam)
 			halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, pCoexDm->psTdmaDuAdjType);
 		else {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], roaming/link/scan is under progress, will adjust next time!!!\n"));
 		}
 	}
 }
@@ -2660,21 +2246,16 @@ static void halbtc8723b2ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 {
 	u8 algorithm = 0;
 
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism() ===>\n"));
-
 	if (pBtCoexist->bManualControl) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n"));
 		return;
 	}
 
 	if (pCoexSta->bUnderIps) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], wifi is under IPS !!!\n"));
 		return;
 	}
 
 	algorithm = halbtc8723b2ant_ActionAlgorithm(pBtCoexist);
 	if (pCoexSta->bC2hBtInquiryPage && (BT_8723B_2ANT_COEX_ALGO_PANHS != algorithm)) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT is under inquiry/page scan !!\n"));
 		halbtc8723b2ant_ActionBtInquiry(pBtCoexist);
 		return;
 	} else {
@@ -2685,69 +2266,47 @@ static void halbtc8723b2ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 	}
 
 	pCoexDm->curAlgorithm = algorithm;
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Algorithm = %d\n", pCoexDm->curAlgorithm));
 
 	if (halbtc8723b2ant_IsCommonAction(pBtCoexist)) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant common.\n"));
 		pCoexDm->bAutoTdmaAdjust = false;
 	} else {
 		if (pCoexDm->curAlgorithm != pCoexDm->preAlgorithm) {
-			BTC_PRINT(
-				BTC_MSG_ALGORITHM,
-				ALGO_TRACE,
-				(
-					"[BTCoex], preAlgorithm =%d, curAlgorithm =%d\n",
-					pCoexDm->preAlgorithm,
-					pCoexDm->curAlgorithm
-				)
-			);
 			pCoexDm->bAutoTdmaAdjust = false;
 		}
 
 
 		switch (pCoexDm->curAlgorithm) {
 		case BT_8723B_2ANT_COEX_ALGO_SCO:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = SCO.\n"));
 			halbtc8723b2ant_ActionSco(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = HID.\n"));
 			halbtc8723b2ant_ActionHid(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = A2DP.\n"));
 			halbtc8723b2ant_ActionA2dp(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_A2DP_PANHS:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = A2DP+PAN(HS).\n"));
 			halbtc8723b2ant_ActionA2dpPanHs(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = PAN(EDR).\n"));
 			halbtc8723b2ant_ActionPanEdr(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANHS:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = HS mode.\n"));
 			halbtc8723b2ant_ActionPanHs(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = PAN+A2DP.\n"));
 			halbtc8723b2ant_ActionPanEdrA2dp(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR_HID:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = PAN(EDR)+HID.\n"));
 			halbtc8723b2ant_ActionPanEdrHid(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = HID+A2DP+PAN.\n"));
 			halbtc8723b2ant_ActionHidA2dpPanEdr(pBtCoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID_A2DP:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = HID+A2DP.\n"));
 			halbtc8723b2ant_ActionHidA2dp(pBtCoexist);
 			break;
 		default:
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action 2-Ant, algorithm = coexist All Off!!\n"));
 			halbtc8723b2ant_CoexAllOff(pBtCoexist);
 			break;
 		}
@@ -2784,8 +2343,6 @@ static void halbtc8723b2ant_InitHwConfig(struct btc_coexist *pBtCoexist, bool bB
 {
 	u8 u1Tmp = 0;
 
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], 2Ant Init HW Config!!\n"));
-
 	/*  backup rf 0x1e value */
 	pCoexDm->btRf0x1eBackup =
 		pBtCoexist->fBtcGetRfReg(pBtCoexist, BTC_RF_A, 0x1e, 0xfffff);
@@ -2873,8 +2430,6 @@ void EXhalbtc8723b2ant_InitHwConfig(struct btc_coexist *pBtCoexist, bool bWifiOn
 
 void EXhalbtc8723b2ant_InitCoexDm(struct btc_coexist *pBtCoexist)
 {
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], Coex Mechanism Init!!\n"));
-
 	halbtc8723b2ant_InitCoexDm(pBtCoexist);
 }
 
@@ -3262,13 +2817,11 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 void EXhalbtc8723b2ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (BTC_IPS_ENTER == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS ENTER notify\n"));
 		pCoexSta->bUnderIps = true;
 		halbtc8723b2ant_WifiOffHwCfg(pBtCoexist);
 		halbtc8723b2ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, true);
 		halbtc8723b2ant_CoexAllOff(pBtCoexist);
 	} else if (BTC_IPS_LEAVE == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS LEAVE notify\n"));
 		pCoexSta->bUnderIps = false;
 		halbtc8723b2ant_InitHwConfig(pBtCoexist, false);
 		halbtc8723b2ant_InitCoexDm(pBtCoexist);
@@ -3279,10 +2832,8 @@ void EXhalbtc8723b2ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 void EXhalbtc8723b2ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (BTC_LPS_ENABLE == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS ENABLE notify\n"));
 		pCoexSta->bUnderLps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS DISABLE notify\n"));
 		pCoexSta->bUnderLps = false;
 	}
 }
@@ -3290,18 +2841,14 @@ void EXhalbtc8723b2ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 void EXhalbtc8723b2ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (BTC_SCAN_START == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN START notify\n"));
 	} else if (BTC_SCAN_FINISH == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN FINISH notify\n"));
 	}
 }
 
 void EXhalbtc8723b2ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (BTC_ASSOCIATE_START == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT START notify\n"));
 	} else if (BTC_ASSOCIATE_FINISH == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT FINISH notify\n"));
 	}
 }
 
@@ -3313,9 +2860,7 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 	u8 apNum = 0;
 
 	if (BTC_MEDIA_CONNECT == type) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA connect notify\n"));
 	} else {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA disconnect notify\n"));
 	}
 
 	/*  only 2.4G we need to inform bt the chnl mask */
@@ -3339,22 +2884,12 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 	pCoexDm->wifiChnlInfo[1] = H2C_Parameter[1];
 	pCoexDm->wifiChnlInfo[2] = H2C_Parameter[2];
 
-	BTC_PRINT(
-		BTC_MSG_ALGORITHM,
-		ALGO_TRACE_FW_EXEC,
-		(
-			"[BTCoex], FW write 0x66 = 0x%x\n",
-			H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | H2C_Parameter[2]
-		)
-	);
-
 	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x66, 3, H2C_Parameter);
 }
 
 void EXhalbtc8723b2ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (type == BTC_PACKET_DHCP) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], DHCP Packet notify\n"));
 	}
 }
 
@@ -3375,21 +2910,17 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 
 	pCoexSta->btInfoC2hCnt[rspSource]++;
 
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Bt info[%d], length =%d, hex data =[", rspSource, length));
 	for (i = 0; i < length; i++) {
 		pCoexSta->btInfoC2h[rspSource][i] = tmpBuf[i];
 		if (i == 1)
 			btInfo = tmpBuf[i];
 
 		if (i == length - 1) {
-			BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x]\n", tmpBuf[i]));
 		} else {
-			BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x, ", tmpBuf[i]));
 		}
 	}
 
 	if (pBtCoexist->bManualControl) {
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), return for Manual CTRL<===\n"));
 		return;
 	}
 
@@ -3404,14 +2935,12 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TX_RX_MASK, &pCoexSta->bBtTxRxMask);
 		if (pCoexSta->bBtTxRxMask) {
 			/* BT into is responded by BT FW and BT RF REG 0x3C != 0x01 => Need to switch BT TRx Mask */
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x01\n"));
 			pBtCoexist->fBtcSetBtReg(pBtCoexist, BTC_BT_REG_RF, 0x3c, 0x01);
 		}
 
 		/*  Here we need to resend some wifi info to BT */
 		/*  because bt is reset and loss of the info. */
 		if ((pCoexSta->btInfoExt & BIT1)) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n"));
 			pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 
 			if (bWifiConnected)
@@ -3421,7 +2950,6 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 		}
 
 		if ((pCoexSta->btInfoExt & BIT3)) {
-			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n"));
 			halbtc8723b2ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, false);
 		} else {
 			/*  BT already NOT ignore Wlan active, do nothing here. */
@@ -3465,22 +2993,17 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 
 	if (!(btInfo & BT_INFO_8723B_2ANT_B_CONNECTION)) {
 		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n"));
 	} else if (btInfo == BT_INFO_8723B_2ANT_B_CONNECTION)	{ /*  connection exists but no busy */
 		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_CONNECTED_IDLE;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n"));
 	} else if (
 		(btInfo & BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
 		(btInfo & BT_INFO_8723B_2ANT_B_SCO_BUSY)
 	) {
 		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_SCO_BUSY;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT SCO busy!!!\n"));
 	} else if (btInfo & BT_INFO_8723B_2ANT_B_ACL_BUSY) {
 		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_ACL_BUSY;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT ACL busy!!!\n"));
 	} else {
 		pCoexDm->btStatus = BT_8723B_2ANT_BT_STATUS_MAX;
-		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n"));
 	}
 
 	if (
@@ -3505,8 +3028,6 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 
 void EXhalbtc8723b2ant_HaltNotify(struct btc_coexist *pBtCoexist)
 {
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Halt notify\n"));
-
 	halbtc8723b2ant_WifiOffHwCfg(pBtCoexist);
 	pBtCoexist->fBtcSetBtReg(pBtCoexist, BTC_BT_REG_RF, 0x3c, 0x15); /* BT goto standby while GNT_BT 1-->0 */
 	halbtc8723b2ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, true);
@@ -3516,12 +3037,8 @@ void EXhalbtc8723b2ant_HaltNotify(struct btc_coexist *pBtCoexist)
 
 void EXhalbtc8723b2ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState)
 {
-	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify\n"));
-
 	if (BTC_WIFI_PNP_SLEEP == pnpState) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to SLEEP\n"));
 	} else if (BTC_WIFI_PNP_WAKE_UP == pnpState) {
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to WAKE UP\n"));
 		halbtc8723b2ant_InitHwConfig(pBtCoexist, false);
 		halbtc8723b2ant_InitCoexDm(pBtCoexist);
 		halbtc8723b2ant_QueryBtInfo(pBtCoexist);
@@ -3533,16 +3050,10 @@ void EXhalbtc8723b2ant_Periodical(struct btc_coexist *pBtCoexist)
 	static u8 disVerInfoCnt;
 	u32 fwVer = 0, btPatchVer = 0;
 
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], ==========================Periodical ===========================\n"));
-
 	if (disVerInfoCnt <= 5) {
 		disVerInfoCnt += 1;
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], CoexVer/ FwVer/ PatchVer = %d_%x/ 0x%x/ 0x%x(%d)\n", \
-			GLCoexVerDate8723b2Ant, GLCoexVer8723b2Ant, fwVer, btPatchVer, btPatchVer));
-		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
 	}
 
 	if (
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 5802ed4c6f82..30d763b48349 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -131,9 +131,6 @@ static void halbtcoutsrc_NormalLps(struct btc_coexist *pBtCoexist)
 {
 	struct adapter *padapter;
 
-
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Normal LPS behavior!!!\n"));
-
 	padapter = pBtCoexist->Adapter;
 
 	if (pBtCoexist->btInfo.bBtCtrlLps) {
@@ -1481,10 +1478,6 @@ u32 hal_btcoex_GetRaMask(struct adapter *padapter)
 
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen)
 {
-	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_EXEC, ("[BTCoex], FW write pwrModeCmd = 0x%04x%08x\n",
-		pCmdBuf[0] << 8 | pCmdBuf[1],
-		pCmdBuf[2] << 24 | pCmdBuf[3] << 16 | pCmdBuf[4] << 8 | pCmdBuf[5]));
-
 	memcpy(GLBtCoexist.pwrModeVal, pCmdBuf, cmdLen);
 }
 
-- 
2.20.1

