Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0F3DCD2F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhHATF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhHATFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:05:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7EC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b11so13451241wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+t9gqlVKrDTraoXV7VGWYthjJFTyNl4L9x3mtB9gmos=;
        b=lELHLRtzKQXHMFIAhglORI1T8m8jXyQAxTbEr1nSvpqJ76y9pVMR22oHYYORUksL+0
         Xk7AqIvTuuI6BY7j1EOhshYEDFnBOLhCF1m3Fx0hHqURrjzjBeGTDNbyJpdEvhxhes0D
         uhGaK3CaVz4rSlzxcZuHatU6h/OGDo00AqntNmzi5FXPPfEJ6frSi2I6dFcNSJpaJG9+
         wSgzFB63RzT/6oiq4jjHLe/dAPterzCwqJXB4jiKLmXMVdt4Xxx2CQVawY9RH+UQZRwr
         cASoUtTgCEWxedaOKJneHeVJ4pQvOYD3LmOB9Xc0PHIYGkXAWnjPNkyWetRSGMz+WUgd
         jC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+t9gqlVKrDTraoXV7VGWYthjJFTyNl4L9x3mtB9gmos=;
        b=k/K+T++jBzDXkoatEMSMPY4yYu8zguxpuBBVkv4uUP1TJ57fWWF2sXvxLsqCOL+jKv
         JBnVL5Sd/lS+R+DG+IXzHVRlEBKqbdX4xqmx0zrdPys+Eqn3s/8yc/YqEjj4cYkQwOlr
         lp8EcAW0rt132ZCGOE3J7lwOrRgvPCCeLcNOzUxgMZYVdSXzGuEtg249f8mlhIeJ47RN
         yx4nhUR9Quxd0a5U9exraV7XOB+++1Cd3yawFDU83rSyZzzNr6DUF76BBIwmTV/4//0n
         e775uflSzOiTYbn9MWe8X/ZIDCOlM24/RgqEmtJSs1aBFSgWClUnbX6jNUkQy/Nc+/LG
         tXxg==
X-Gm-Message-State: AOAM5303vMujKNnbsO0YdiDdjSMzaPANJVw0DOWQyxj4+NpvPiSHHtyX
        k6YvNAsVjhhwEgfzFv44mPGMdg==
X-Google-Smtp-Source: ABdhPJwewk/K0SZ4LWyAi3mpf9OY+cZNJ7x2SpIrTn9ez8G7INftn+QpJ3+X/J004EXpxn6fMwCcdA==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr13911030wrv.20.1627844689789;
        Sun, 01 Aug 2021 12:04:49 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:49 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 13/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
Date:   Sun,  1 Aug 2021 20:04:35 +0100
Message-Id: <20210801190437.82017-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_led.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_led.c | 82 ++++----------------------
 1 file changed, 12 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 70e989d11e44..22d4df9c92a5 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -89,13 +89,10 @@ static void SwLedBlink(struct LED_871x *pLed)
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
 
 	/*  Determine if we shall change LED state again. */
 	pLed->BlinkTimes--;
@@ -170,13 +167,10 @@ static void SwLedBlink1(struct LED_871x *pLed)
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
 
 	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
 		SwLedOff(padapter, pLed);
@@ -212,7 +206,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
 				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -221,7 +214,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
 				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -245,7 +237,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
 				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -254,7 +245,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
 				_set_timer(&(pLed->BlinkTimer), LED_BLINK_NO_LINK_INTERVAL_ALPHA);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->BlinkTimes = 0;
 			pLed->bLedBlinkInProgress = false;
@@ -287,7 +277,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
 			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LINK_INTERVAL_ALPHA);
-			RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 
 			pLed->bLedWPSBlinkInProgress = false;
 		} else {
@@ -307,13 +296,10 @@ static void SwLedBlink2(struct LED_871x *pLed)
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
 
 	switch (pLed->CurrLedState) {
 	case LED_BLINK_SCAN:
@@ -327,13 +313,10 @@ static void SwLedBlink2(struct LED_871x *pLed)
 				pLed->CurrLedState = RTW_LED_ON;
 				pLed->BlinkingLedState = RTW_LED_ON;
 				SwLedOn(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("stop scan blink CurrLedState %d\n", pLed->CurrLedState));
-
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->CurrLedState = RTW_LED_OFF;
 				pLed->BlinkingLedState = RTW_LED_OFF;
 				SwLedOff(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("stop scan blink CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -359,12 +342,10 @@ static void SwLedBlink2(struct LED_871x *pLed)
 				pLed->CurrLedState = RTW_LED_ON;
 				pLed->BlinkingLedState = RTW_LED_ON;
 				SwLedOn(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("stop CurrLedState %d\n", pLed->CurrLedState));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->CurrLedState = RTW_LED_OFF;
 				pLed->BlinkingLedState = RTW_LED_OFF;
 				SwLedOff(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("stop CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedBlinkInProgress = false;
 		} else {
@@ -393,11 +374,9 @@ static void SwLedBlink3(struct LED_871x *pLed)
 	/*  Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == RTW_LED_ON) {
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
 	} else {
 		if (pLed->CurrLedState != LED_BLINK_WPS_STOP)
 			SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
 	}
 
 	switch (pLed->CurrLedState) {
@@ -413,13 +392,11 @@ static void SwLedBlink3(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_ON;
 				if (!pLed->bLedOn)
 					SwLedOn(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->CurrLedState = RTW_LED_OFF;
 				pLed->BlinkingLedState = RTW_LED_OFF;
 				if (pLed->bLedOn)
 					SwLedOff(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -446,14 +423,12 @@ static void SwLedBlink3(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_ON;
 				if (!pLed->bLedOn)
 					SwLedOn(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->CurrLedState = RTW_LED_OFF;
 				pLed->BlinkingLedState = RTW_LED_OFF;
 
 				if (pLed->bLedOn)
 					SwLedOff(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedBlinkInProgress = false;
 		} else {
@@ -490,7 +465,6 @@ static void SwLedBlink3(struct LED_871x *pLed)
 				pLed->CurrLedState = RTW_LED_ON;
 				pLed->BlinkingLedState = RTW_LED_ON;
 				SwLedOn(padapter, pLed);
-				RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 			}
 			pLed->bLedWPSBlinkInProgress = false;
 		}
@@ -508,13 +482,10 @@ static void SwLedBlink4(struct LED_871x *pLed)
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
 
 	if (!pLed1->bLedWPSBlinkInProgress && pLed1->BlinkingLedState == LED_UNKNOWN) {
 		pLed1->BlinkingLedState = RTW_LED_OFF;
@@ -639,7 +610,6 @@ static void SwLedBlink4(struct LED_871x *pLed)
 	default:
 		break;
 	}
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("SwLedBlink4 CurrLedState %d\n", pLed->CurrLedState));
 }
 
 static void SwLedBlink5(struct LED_871x *pLed)
@@ -648,13 +618,10 @@ static void SwLedBlink5(struct LED_871x *pLed)
 	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
 
 	switch (pLed->CurrLedState) {
 	case LED_BLINK_SCAN:
@@ -723,8 +690,6 @@ static void SwLedBlink5(struct LED_871x *pLed)
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("SwLedBlink5 CurrLedState %d\n", pLed->CurrLedState));
 }
 
 static void SwLedBlink6(struct LED_871x *pLed)
@@ -732,15 +697,10 @@ static void SwLedBlink6(struct LED_871x *pLed)
 	struct adapter *padapter = pLed->padapter;
 
 	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
+	if (pLed->BlinkingLedState == RTW_LED_ON)
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
-	} else {
+	else
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
-	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("<==== blink6\n"));
 }
 
  /* ALPHA, added by chiyoko, 20090106 */
@@ -946,8 +906,6 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Led %d\n", pLed->CurrLedState));
 }
 
  /* Arcadyan/Sitecom , added by chiyoko, 20090216 */
@@ -1031,7 +989,6 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->CurrLedState = RTW_LED_ON;
 			pLed->BlinkingLedState = RTW_LED_ON;
 			_set_timer(&(pLed->BlinkTimer), 0);
-			RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
@@ -1042,7 +999,6 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->CurrLedState = RTW_LED_OFF;
 			pLed->BlinkingLedState = RTW_LED_OFF;
 			_set_timer(&(pLed->BlinkTimer), 0);
-			RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 		}
 		break;
 	case LED_CTL_START_TO_LINK:
@@ -1074,8 +1030,6 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("CurrLedState %d\n", pLed->CurrLedState));
 }
 
   /* COREGA, added by chiyoko, 20090316 */
@@ -1212,8 +1166,6 @@ static void SwLedControlMode2(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	default:
 		break;
 	}
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
-		 ("CurrLedState %d\n", pLed->CurrLedState));
 }
 
  /* Edimax-Belkin, added by chiyoko, 20090413 */
@@ -1478,8 +1430,6 @@ static void SwLedControlMode4(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Led %d\n", pLed->CurrLedState));
 }
 
  /* Sercomm-Belkin, added by chiyoko, 20090415 */
@@ -1547,8 +1497,6 @@ SwLedControlMode5(
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Led %d\n", pLed->CurrLedState));
 }
 
  /* WNC-Corega, added by chiyoko, 20090902 */
@@ -1576,8 +1524,6 @@ SwLedControlMode6(
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("ledcontrol 6 Led %d\n", pLed0->CurrLedState));
 }
 
 /*  */
@@ -1669,8 +1615,4 @@ void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	default:
 		break;
 	}
-
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
-		 ("LedStrategy:%d, LedAction %d\n",
-		 ledpriv->LedStrategy, LedAction));
 }
-- 
2.31.1

