Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07F3E4A45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhHIQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhHIQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05409C06179B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so22345955wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuoqEI2gvnSOIG70BCNU9Xui1ARcgvxhDmIF/Yn1GoY=;
        b=LDskWhslqABEGhbnyG9QKJWnzC1duePcYgpRwyLpfuvPx6YQojdTj/XXGQG+KvXLVe
         Yeg/Fa9xcHJz460YEIeIn2fROgLp09zUMgm5eirry6fa5iiOX2uwtfC7nG6CHwbIv8jC
         s+VJzBH0vIGoXDy+5SqUtUnkRqFWWnyG2bqEtr+r1i8N25itDJqMfUBlOI2Rm0659KIt
         RgF2eY4SD058xrHINmoIQ7/qVDLxCQJM2IJlD7ZtgM+SHctGJqNwaTRXxSl7b26BmIk8
         oGVYiqZYbmdbTG2GePKK3lLazi7xgEjep0/4SyfZEFWrajMx2PshcPrI1ZwEklzEh/bu
         e+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuoqEI2gvnSOIG70BCNU9Xui1ARcgvxhDmIF/Yn1GoY=;
        b=afvfcBIFVB5gW0luvF7wRIH1ee9Qtrev6UzEmMe7MISAOpo+1l/p8HllsW2RWCEUGt
         FbDS6JYwoZ+GpMAYyIxYsxCnqX4HM4pybNYNLDTEBhwKiOjh4eSOdc6HLNaYRC24mpkz
         9wCCxcKWAgmaDddJ6fAHVGgwiEw7/krllUAWqBLIzAY8K+amj3tIv1OT2xJL+vFuwsS1
         kAtFxI4Qb0oPcE9lHQFrMgNdqo30608KifHD+S8S9KPl5M/lkpRp+1MmGRl+vGauBfhC
         2yix4NPC5xBC5XHfHrVGLB9Vx2rqsDwMUi7k/na1y999M0Ybq5nxNorFnZVBv+SzAsYy
         LD3w==
X-Gm-Message-State: AOAM531sDtJGBgWgOWQQHlmiFOy3j9GKKKgY6AeUv+ANgkf+lXCvULhq
        yIIwnBWzlGNcDyISkgH10Zw=
X-Google-Smtp-Source: ABdhPJxdP1P6Q81TkrTYLVmG1xQ4toyST61I+f/9MuTAmuFUyT0aTdNuOP3klwSQ3iND067P7g0oXA==
X-Received: by 2002:adf:e10c:: with SMTP id t12mr25982770wrz.36.1628527851408;
        Mon, 09 Aug 2021 09:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 06/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_led.c
Date:   Mon,  9 Aug 2021 18:49:56 +0200
Message-Id: <20210809165007.23204-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_led.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 354 ++++++++++++-------------
 1 file changed, 177 insertions(+), 177 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 22d4df9c92a5..671c7cbc7cc3 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -17,7 +17,7 @@ void BlinkTimerCallback(struct timer_list *t)
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
 		return;
 
-	_set_workitem(&(pLed->BlinkWorkItem));
+	_set_workitem(&pLed->BlinkWorkItem);
 }
 
 /*  */
@@ -62,7 +62,7 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_8
 	ResetLedStatus(pLed);
 
 	timer_setup(&pLed->BlinkTimer, BlinkTimerCallback, 0);
-	_init_workitem(&(pLed->BlinkWorkItem), BlinkWorkItemCallback, pLed);
+	_init_workitem(&pLed->BlinkWorkItem, BlinkWorkItemCallback, pLed);
 }
 
 /*  */
@@ -71,8 +71,8 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_8
 /*  */
 void DeInitLed871x(struct LED_871x *pLed)
 {
-	_cancel_workitem_sync(&(pLed->BlinkWorkItem));
-	_cancel_timer_ex(&(pLed->BlinkTimer));
+	_cancel_workitem_sync(&pLed->BlinkWorkItem);
+	_cancel_timer_ex(&pLed->BlinkTimer);
 	ResetLedStatus(pLed);
 }
 
@@ -85,7 +85,7 @@ void DeInitLed871x(struct LED_871x *pLed)
 static void SwLedBlink(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
@@ -141,20 +141,20 @@ static void SwLedBlink(struct LED_871x *pLed)
 		/*  Schedule a timer to toggle LED state. */
 		switch (pLed->CurrLedState) {
 		case LED_BLINK_NORMAL:
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 			break;
 		case LED_BLINK_SLOWLY:
 		case LED_BLINK_StartToBlink:
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 			break;
 		case LED_BLINK_WPS:
 			if (pLed->BlinkingLedState == RTW_LED_ON)
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_LONG_INTERVAL);
 			else
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_LONG_INTERVAL);
 			break;
 		default:
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 			break;
 		}
 	}
@@ -163,7 +163,7 @@ static void SwLedBlink(struct LED_871x *pLed)
 static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
@@ -184,14 +184,14 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 		break;
 	case LED_BLINK_NORMAL:
 		if (pLed->bLedOn)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 		break;
 	case LED_BLINK_SCAN:
 		pLed->BlinkTimes--;
@@ -205,7 +205,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -213,7 +213,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -221,7 +221,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_BLINK_TXRX:
@@ -236,7 +236,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -244,7 +244,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 			}
 			pLed->BlinkTimes = 0;
 			pLed->bLedBlinkInProgress = false;
@@ -253,7 +253,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_BLINK_WPS:
@@ -261,7 +261,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
 		if (pLed->BlinkingLedState == RTW_LED_ON)
@@ -276,12 +276,12 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 
 			pLed->bLedWPSBlinkInProgress = false;
 		} else {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
 		}
 		break;
 	default:
@@ -292,7 +292,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 static void SwLedBlink2(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
@@ -327,7 +327,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -356,7 +356,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -368,7 +368,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 static void SwLedBlink3(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
@@ -407,7 +407,7 @@ static void SwLedBlink3(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -439,7 +439,7 @@ static void SwLedBlink3(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -448,12 +448,12 @@ static void SwLedBlink3(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
 		if (pLed->BlinkingLedState == RTW_LED_ON) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
 			bStopBlinking = false;
 		} else {
 			bStopBlinking = true;
@@ -477,8 +477,8 @@ static void SwLedBlink3(struct LED_871x *pLed)
 static void SwLedBlink4(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct led_priv *ledpriv = &(padapter->ledpriv);
-	struct LED_871x *pLed1 = &(ledpriv->SwLed1);
+	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
@@ -499,15 +499,15 @@ static void SwLedBlink4(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 		break;
 	case LED_BLINK_StartToBlink:
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 		} else {
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		}
 		break;
 	case LED_BLINK_SCAN:
@@ -524,7 +524,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -535,7 +535,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -553,7 +553,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 			}
 			pLed->bLedBlinkInProgress = false;
 		} else {
@@ -564,17 +564,17 @@ static void SwLedBlink4(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 		}
 		break;
 	case LED_BLINK_WPS:
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 		} else {
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		}
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS authentication fail */
@@ -583,7 +583,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
 
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		break;
 	case LED_BLINK_WPS_STOP_OVERLAP:	/* WPS session overlap */
 		pLed->BlinkTimes--;
@@ -597,14 +597,14 @@ static void SwLedBlink4(struct LED_871x *pLed)
 		if (bStopBlinking) {
 			pLed->BlinkTimes = 10;
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
 
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		}
 		break;
 	default:
@@ -639,7 +639,7 @@ static void SwLedBlink5(struct LED_871x *pLed)
 					pLed->CurrLedState = RTW_LED_ON;
 					pLed->BlinkingLedState = RTW_LED_ON;
 					if (!pLed->bLedOn)
-						_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+						_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 
 			pLed->bLedScanBlinkInProgress = false;
@@ -651,7 +651,7 @@ static void SwLedBlink5(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -670,7 +670,7 @@ static void SwLedBlink5(struct LED_871x *pLed)
 				pLed->CurrLedState = RTW_LED_ON;
 				pLed->BlinkingLedState = RTW_LED_ON;
 				if (!pLed->bLedOn)
-					_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+					_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 
 			pLed->bLedBlinkInProgress = false;
@@ -682,7 +682,7 @@ static void SwLedBlink5(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 			}
 		}
 		break;
@@ -706,9 +706,9 @@ static void SwLedBlink6(struct LED_871x *pLed)
  /* ALPHA, added by chiyoko, 20090106 */
 static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &ledpriv->SwLed0;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
@@ -718,11 +718,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 
@@ -732,7 +732,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_LINK:
@@ -740,11 +740,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedLinkBlinkInProgress = true;
@@ -753,7 +753,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -763,15 +763,15 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				 pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -781,7 +781,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		 }
 		break;
 	case LED_CTL_TX:
@@ -790,11 +790,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			pLed->bLedBlinkInProgress = true;
@@ -804,26 +804,26 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
 		 if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				 pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedScanBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedScanBlinkInProgress = false;
 			}
 			pLed->bLedWPSBlinkInProgress = true;
@@ -832,42 +832,42 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		 }
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedNoLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedNoLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			 pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress)
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 		else
 			pLed->bLedWPSBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
 		} else {
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		pLed->bLedNoLinkBlinkInProgress = true;
@@ -876,29 +876,29 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
 		if (pLed->bLedNoLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedNoLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		SwLedOff(padapter, pLed);
@@ -911,9 +911,9 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
  /* Arcadyan/Sitecom , added by chiyoko, 20090216 */
 static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_SITE_SURVEY:
@@ -923,7 +923,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				return;
 
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -933,7 +933,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		 }
 		break;
 	case LED_CTL_TX:
@@ -948,37 +948,37 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_LINK:
 		pLed->CurrLedState = RTW_LED_ON;
 		pLed->BlinkingLedState = RTW_LED_ON;
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
 		if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedScanBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedScanBlinkInProgress = false;
 			}
 			pLed->bLedWPSBlinkInProgress = true;
 			pLed->CurrLedState = RTW_LED_ON;
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		 }
 		break;
 	case LED_CTL_STOP_WPS:
@@ -988,7 +988,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		} else {
 			pLed->CurrLedState = RTW_LED_ON;
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
@@ -998,7 +998,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		} else {
 			pLed->CurrLedState = RTW_LED_OFF;
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_START_TO_LINK:
@@ -1006,26 +1006,26 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		if (!IS_LED_BLINKING(pLed)) {
 			pLed->CurrLedState = RTW_LED_OFF;
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	default:
 		break;
@@ -1035,9 +1035,9 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
   /* COREGA, added by chiyoko, 20090316 */
  static void SwLedControlMode3(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_SITE_SURVEY:
@@ -1047,7 +1047,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				return;
 
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -1057,7 +1057,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_TX:
@@ -1072,7 +1072,7 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_LINK:
@@ -1081,25 +1081,25 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		pLed->CurrLedState = RTW_LED_ON;
 		pLed->BlinkingLedState = RTW_LED_ON;
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
 		if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedScanBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedScanBlinkInProgress = false;
 			}
 			pLed->bLedWPSBlinkInProgress = true;
@@ -1108,12 +1108,12 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		} else {
 			pLed->bLedWPSBlinkInProgress = true;
@@ -1122,46 +1122,46 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
 		} else {
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
 		if (!IS_LED_BLINKING(pLed)) {
 			pLed->CurrLedState = RTW_LED_OFF;
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&(pLed->BlinkTimer), 0);
+			_set_timer(&pLed->BlinkTimer, 0);
 		}
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	default:
 		break;
@@ -1171,33 +1171,33 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
  /* Edimax-Belkin, added by chiyoko, 20090413 */
 static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
-	struct LED_871x *pLed1 = &(ledpriv->SwLed1);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
+	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
 		if (pLed1->bLedWPSBlinkInProgress) {
 			pLed1->bLedWPSBlinkInProgress = false;
-			_cancel_timer_ex(&(pLed1->BlinkTimer));
+			_cancel_timer_ex(&pLed1->BlinkTimer);
 
 			pLed1->BlinkingLedState = RTW_LED_OFF;
 			pLed1->CurrLedState = RTW_LED_OFF;
 
 			if (pLed1->bLedOn)
-				_set_timer(&(pLed->BlinkTimer), 0);
+				_set_timer(&pLed->BlinkTimer, 0);
 		}
 
 		if (!pLed->bLedStartToLinkBlinkInProgress) {
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 
@@ -1205,10 +1205,10 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->CurrLedState = LED_BLINK_StartToBlink;
 			if (pLed->bLedOn) {
 				pLed->BlinkingLedState = RTW_LED_OFF;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 			} else {
 				pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 			}
 		}
 		break;
@@ -1218,13 +1218,13 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		if (LedAction == LED_CTL_LINK) {
 			if (pLed1->bLedWPSBlinkInProgress) {
 				pLed1->bLedWPSBlinkInProgress = false;
-				_cancel_timer_ex(&(pLed1->BlinkTimer));
+				_cancel_timer_ex(&pLed1->BlinkTimer);
 
 				pLed1->BlinkingLedState = RTW_LED_OFF;
 				pLed1->CurrLedState = RTW_LED_OFF;
 
 				if (pLed1->bLedOn)
-					_set_timer(&(pLed->BlinkTimer), 0);
+					_set_timer(&pLed->BlinkTimer, 0);
 			}
 		}
 
@@ -1232,7 +1232,7 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 
@@ -1242,7 +1242,7 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -1252,11 +1252,11 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				return;
 
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -1266,7 +1266,7 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_TX:
@@ -1275,7 +1275,7 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			pLed->bLedBlinkInProgress = true;
@@ -1285,49 +1285,49 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
 		if (pLed1->bLedWPSBlinkInProgress) {
 			pLed1->bLedWPSBlinkInProgress = false;
-			_cancel_timer_ex(&(pLed1->BlinkTimer));
+			_cancel_timer_ex(&pLed1->BlinkTimer);
 
 			pLed1->BlinkingLedState = RTW_LED_OFF;
 			pLed1->CurrLedState = RTW_LED_OFF;
 
 			if (pLed1->bLedOn)
-				_set_timer(&(pLed->BlinkTimer), 0);
+				_set_timer(&pLed->BlinkTimer, 0);
 		}
 
 		if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedScanBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedScanBlinkInProgress = false;
 			}
 			pLed->bLedWPSBlinkInProgress = true;
 			pLed->CurrLedState = LED_BLINK_WPS;
 			if (pLed->bLedOn) {
 				pLed->BlinkingLedState = RTW_LED_OFF;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
 			} else {
 				pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+				_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 			}
 		}
 		break;
 	case LED_CTL_STOP_WPS:	/* WPS connect success */
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 
@@ -1337,12 +1337,12 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 
 		break;
 	case LED_CTL_STOP_WPS_FAIL:		/* WPS authentication fail */
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		pLed->bLedNoLinkBlinkInProgress = true;
@@ -1351,11 +1351,11 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 
 		/* LED1 settings */
 		if (pLed1->bLedWPSBlinkInProgress)
-			_cancel_timer_ex(&(pLed1->BlinkTimer));
+			_cancel_timer_ex(&pLed1->BlinkTimer);
 		else
 			pLed1->bLedWPSBlinkInProgress = true;
 		pLed1->CurrLedState = LED_BLINK_WPS_STOP;
@@ -1363,11 +1363,11 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed1->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed1->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		break;
 	case LED_CTL_STOP_WPS_FAIL_OVERLAP:	/* WPS session overlap */
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		pLed->bLedNoLinkBlinkInProgress = true;
@@ -1376,11 +1376,11 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 
 		/* LED1 settings */
 		if (pLed1->bLedWPSBlinkInProgress)
-			_cancel_timer_ex(&(pLed1->BlinkTimer));
+			_cancel_timer_ex(&pLed1->BlinkTimer);
 		else
 			pLed1->bLedWPSBlinkInProgress = true;
 		pLed1->CurrLedState = LED_BLINK_WPS_STOP_OVERLAP;
@@ -1389,38 +1389,38 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed1->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed1->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed->BlinkTimer), LED_BLINK_NORMAL_INTERVAL);
+		_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
 
 		if (pLed->bLedNoLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedNoLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		if (pLed->bLedStartToLinkBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedStartToLinkBlinkInProgress = false;
 		}
 		if (pLed1->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&(pLed1->BlinkTimer));
+			_cancel_timer_ex(&pLed1->BlinkTimer);
 			pLed1->bLedWPSBlinkInProgress = false;
 		}
 		pLed1->BlinkingLedState = LED_UNKNOWN;
@@ -1439,9 +1439,9 @@ SwLedControlMode5(
 	enum LED_CTL_MODE LedAction
 )
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
@@ -1450,13 +1450,13 @@ SwLedControlMode5(
 		pLed->CurrLedState = RTW_LED_ON;
 		pLed->BlinkingLedState = RTW_LED_ON;
 
-		_set_timer(&(pLed->BlinkTimer), 0);
+		_set_timer(&pLed->BlinkTimer, 0);
 		break;
 	case LED_CTL_SITE_SURVEY:
 		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
 		} else if (!pLed->bLedScanBlinkInProgress) {
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&(pLed->BlinkTimer));
+				_cancel_timer_ex(&pLed->BlinkTimer);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -1466,7 +1466,7 @@ SwLedControlMode5(
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SCAN_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_TX:
@@ -1481,7 +1481,7 @@ SwLedControlMode5(
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&(pLed->BlinkTimer), LED_BLINK_FASTER_INTERVAL_ALPHA);
+			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
 		}
 		break;
 	case LED_CTL_POWER_OFF:
@@ -1489,7 +1489,7 @@ SwLedControlMode5(
 		pLed->BlinkingLedState = RTW_LED_OFF;
 
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&(pLed->BlinkTimer));
+			_cancel_timer_ex(&pLed->BlinkTimer);
 			pLed->bLedBlinkInProgress = false;
 		}
 		SwLedOff(padapter, pLed);
@@ -1506,17 +1506,17 @@ SwLedControlMode6(
 	enum LED_CTL_MODE LedAction
 )
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
-	struct LED_871x *pLed0 = &(ledpriv->SwLed0);
+	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed0 = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		_cancel_timer_ex(&(pLed0->BlinkTimer));
+		_cancel_timer_ex(&pLed0->BlinkTimer);
 		pLed0->CurrLedState = RTW_LED_ON;
 		pLed0->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&(pLed0->BlinkTimer), 0);
+		_set_timer(&pLed0->BlinkTimer, 0);
 		break;
 	case LED_CTL_POWER_OFF:
 		SwLedOff(padapter, pLed0);
@@ -1534,7 +1534,7 @@ SwLedControlMode6(
 void BlinkHandler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
 		return;
@@ -1568,7 +1568,7 @@ void BlinkHandler(struct LED_871x *pLed)
 
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct registry_priv *registry_par;
 
        if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
-- 
2.32.0

