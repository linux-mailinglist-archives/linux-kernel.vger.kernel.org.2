Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7AF3870F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbhEREoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhEREoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:44:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m190so6153457pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6/Rho8TmYFKlfRGaJ1gUUbZ0GhH8HY750ITGcGEJbQ=;
        b=a6+sVuw8JuFwtb+6lRAmy0yEpj4S+4lUcBxnLwiD79eFjLEGb4xq2hkXurslWnZ54Y
         Kb6W1Y01ApZ808S/3/Nco+HeCmJ12oI+eQIvHs9x9NfjxfnSij33KixPyvhLHVZG7cei
         orIfji+1vF56JiXl0dreX4SIe+n7/r2RrZl2ysAjR3jPm+xY80qc/T/Sh7NknNtnlwe2
         osEH5otKYGybQYb1y4WQWG4nJLvOyq7gpXj9c95ujRB3fzAiKM9JrCUYMB3tpi9kXQgK
         85c4j2rwuUPPncqhJXeV6ELSkrPipqkRkt1L9x4nJpzwS8P6L6NkxuI8p6+ZGlqx+zsG
         gUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6/Rho8TmYFKlfRGaJ1gUUbZ0GhH8HY750ITGcGEJbQ=;
        b=sjRJ7nVcOqvTH+C8h7EtA57BBN1YvZqu4dFAg6CpxsZdvpPoeKptMzEArwhv4+ft5/
         vYWx0iLhdNm/vef4oC2mRB4E/7i7r9QTiRvBCYf3rsIUPowh+xvuuMGH+xkCZhzLukOI
         K8S+4Dcf12z6JUP9XhJUA1gok9YWBYKghztwxrRzPWYrIR1qvIxWMUsgATFpcIMKnp0K
         rKc5BRHGufNe/FxOgE/LpcM93n5HcB8q9mwfl+RYv7vKunRPmZ5k87I+MsChQW4EFXy8
         EoASQ0PJLBnJFZPPS1pigaMyjBsYTlHL3HHbjmj5SYm20hG1DAhgLYeWhJvAifqcA5Yn
         iFKw==
X-Gm-Message-State: AOAM5301RXSmW6wLlHIBZrWqPrYMkPiVHKw7cOiewWSCPZfO5E5yeIVz
        eSathjoYk9p/wJHfhg8VOU8=
X-Google-Smtp-Source: ABdhPJyn7rCSGrq13tBL3k6WKDgjEl+T4YKdWXb73gjv67ZdefGNAZmwkGR2csScm7T2FmUgI+rY0g==
X-Received: by 2002:a63:1224:: with SMTP id h36mr3135495pgl.296.1621312987055;
        Mon, 17 May 2021 21:43:07 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:43:06 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 1/7] Staging: rtl8723bs: remove unnecessary braces in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:13 -0400
Message-Id: <20210518044119.2960494-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warnings:

WARNING: braces {} are not necessary for any arm of this statement
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
[...]
+			} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+			if (btRssi < rssiThresh) {
[...]
+			} else {
[...]

WARNING: braces {} are not necessary for single statement blocks
+		if (rssiThresh > rssiThresh1) {
+			return pCoexSta->preBtRssiState;
+		}

WARNING: braces {} are not necessary for any arm of this statement
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
[...]
+			} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
[...]
+			} else if (btRssi < rssiThresh) {
[...]
+			} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+			if (btRssi < rssiThresh1) {
[...]
+			} else {
[...]

WARNING: braces {} are not necessary for single statement blocks
+	if (!pBtLinkInfo->bBtLinkExist) {
+		return algorithm;
+	}

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (bBtHsOn) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for any arm of this statement
+				if (u1Tmp & BIT0) {
[...]
+				} else {
[...]

WARNING: braces {} are not necessary for single statement blocks
+	if (pBtCoexist->bManualControl) {
+		return;
+	}

WARNING: braces {} are not necessary for single statement blocks
+	if (pBtCoexist->bStopCoexDm) {
+		return;
+	}

WARNING: braces {} are not necessary for single statement blocks
+	if (pCoexSta->bUnderIps) {
+		return;
+	}

WARNING: braces {} are not necessary for any arm of this statement
+		if ((pBtLinkInfo->bA2dpExist) && (pCoexSta->bC2hBtInquiryPage)) {
[...]
+		} else
[...]

WARNING: braces {} are not necessary for any arm of this statement
+	if (BTC_LPS_ENABLE == type) {
[...]
+	} else if (BTC_LPS_DISABLE == type) {
[...]

WARNING: braces {} are not necessary for single statement blocks
+			if (!pBtCoexist->bManualControl && !pBtCoexist->bStopCoexDm) {
+				halbtc8723b1ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, false);
+			}

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 94 ++++++++-----------
 1 file changed, 37 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 300327f8706c..85bf45cabecd 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -38,50 +38,44 @@ static u8 halbtc8723b1ant_BtRssiState(
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
 
 				btRssiState = BTC_RSSI_STATE_HIGH;
-			} else {
+			else
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-			}
 		} else {
-			if (btRssi < rssiThresh) {
+			if (btRssi < rssiThresh)
 				btRssiState = BTC_RSSI_STATE_LOW;
-			} else {
+			else
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-			}
 		}
 	} else if (levelNum == 3) {
-		if (rssiThresh > rssiThresh1) {
+		if (rssiThresh > rssiThresh1)
 			return pCoexSta->preBtRssiState;
-		}
 
 		if (
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-			} else {
+			else
 				btRssiState = BTC_RSSI_STATE_STAY_LOW;
-			}
 		} else if (
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
 		) {
-			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
 				btRssiState = BTC_RSSI_STATE_HIGH;
-			} else if (btRssi < rssiThresh) {
+			else if (btRssi < rssiThresh)
 				btRssiState = BTC_RSSI_STATE_LOW;
-			} else {
+			else
 				btRssiState = BTC_RSSI_STATE_STAY_MEDIUM;
-			}
 		} else {
-			if (btRssi < rssiThresh1) {
+			if (btRssi < rssiThresh1)
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
-			} else {
+			else
 				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
-			}
 		}
 	}
 
@@ -508,9 +502,8 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 
-	if (!pBtLinkInfo->bBtLinkExist) {
+	if (!pBtLinkInfo->bBtLinkExist)
 		return algorithm;
-	}
 
 	if (pBtLinkInfo->bScoExist)
 		numOfDiffProfile++;
@@ -530,11 +523,10 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 			} else if (pBtLinkInfo->bA2dpExist) {
 				algorithm = BT_8723B_1ANT_COEX_ALGO_A2DP;
 			} else if (pBtLinkInfo->bPanExist) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANHS;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR;
-				}
 			}
 		}
 	} else if (numOfDiffProfile == 2) {
@@ -544,27 +536,24 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 			} else if (pBtLinkInfo->bA2dpExist) {
 				algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
 			} else if (pBtLinkInfo->bPanExist) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
 			}
 		} else {
 			if (pBtLinkInfo->bHidExist && pBtLinkInfo->bA2dpExist) {
 				algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
 			} else if (pBtLinkInfo->bHidExist && pBtLinkInfo->bPanExist) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
 			} else if (pBtLinkInfo->bPanExist && pBtLinkInfo->bA2dpExist) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_A2DP_PANHS;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_A2DP;
-				}
 			}
 		}
 	} else if (numOfDiffProfile == 3) {
@@ -574,17 +563,15 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 			} else if (
 				pBtLinkInfo->bHidExist && pBtLinkInfo->bPanExist
 			) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
 			} else if (pBtLinkInfo->bPanExist && pBtLinkInfo->bA2dpExist) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_SCO;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
 			}
 		} else {
 			if (
@@ -592,11 +579,10 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bPanExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				if (bBtHsOn) {
+				if (bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
-				} else {
+				else
 					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP_PANEDR;
-				}
 			}
 		}
 	} else if (numOfDiffProfile >= 3) {
@@ -893,11 +879,10 @@ static void halbtc8723b1ant_SetAntPath(
 				u1Tmp = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x49d);
 				cntBtCalChk++;
 
-				if (u1Tmp & BIT0) {
+				if (u1Tmp & BIT0)
 					mdelay(50);
-				} else {
+				else
 					break;
-				}
 			}
 
 			/*  set grant_bt to PTA */
@@ -2015,17 +2000,14 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 	u32 wifiLinkStatus = 0;
 	u32 numOfWifiLink = 0;
 
-	if (pBtCoexist->bManualControl) {
+	if (pBtCoexist->bManualControl)
 		return;
-	}
 
-	if (pBtCoexist->bStopCoexDm) {
+	if (pBtCoexist->bStopCoexDm)
 		return;
-	}
 
-	if (pCoexSta->bUnderIps) {
+	if (pCoexSta->bUnderIps)
 		return;
-	}
 
 	if (
 		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||
@@ -2057,9 +2039,9 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
 		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
 
-		if ((pBtLinkInfo->bA2dpExist) && (pCoexSta->bC2hBtInquiryPage)) {
+		if ((pBtLinkInfo->bA2dpExist) && (pCoexSta->bC2hBtInquiryPage))
 			halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
-		} else
+		else
 			halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
 
 		return;
@@ -2718,11 +2700,10 @@ void EXhalbtc8723b1ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
 		return;
 
-	if (BTC_LPS_ENABLE == type) {
+	if (BTC_LPS_ENABLE == type)
 		pCoexSta->bUnderLps = true;
-	} else if (BTC_LPS_DISABLE == type) {
+	else if (BTC_LPS_DISABLE == type)
 		pCoexSta->bUnderLps = false;
-	}
 }
 
 void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
@@ -3029,9 +3010,8 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		}
 
 		if (pCoexSta->btInfoExt & BIT3) {
-			if (!pBtCoexist->bManualControl && !pBtCoexist->bStopCoexDm) {
+			if (!pBtCoexist->bManualControl && !pBtCoexist->bStopCoexDm)
 				halbtc8723b1ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, false);
-			}
 		} else {
 			/*  BT already NOT ignore Wlan active, do nothing here. */
 		}
-- 
2.25.1

