Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7E45DEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356582AbhKYQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356492AbhKYQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:48:10 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A360C061394
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:25:36 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHYx-0006jj-Ry; Thu, 25 Nov 2021 17:25:32 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: use a delayed worker for led updates
Date:   Thu, 25 Nov 2021 17:25:13 +0100
Message-Id: <20211125162513.25039-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125162513.25039-1-martin@kaiser.cx>
References: <20211125162513.25039-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The led layer uses a combination of timer and worker for periodic led
updates, e.g. for blinking. The reason seems to be that blocking
operations like a usb read are not allowed in a timer handler.

Replace the combination of timer and worker with a delayed worker.

Convert the timeout defines from milliseconds to jiffies to make them
usable as delays for the delayed worker. Shorten the names of the defines
and rename the work item to make checkpatch happy.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 106 ++++++++++------------
 drivers/staging/r8188eu/include/rtw_led.h |  16 ++--
 2 files changed, 53 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index ae46fd48f940..31994d6ba26f 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -4,20 +4,10 @@
 #include "../include/drv_types.h"
 #include "../include/rtw_led.h"
 
-void BlinkTimerCallback(struct timer_list *t)
-{
-	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
-	struct adapter *padapter = pLed->padapter;
-
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
-		return;
-
-	schedule_work(&pLed->BlinkWorkItem);
-}
-
 void BlinkWorkItemCallback(struct work_struct *work)
 {
-	struct LED_871x *pLed = container_of(work, struct LED_871x, BlinkWorkItem);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
 	BlinkHandler(pLed);
 }
 
@@ -45,14 +35,12 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_8
 
 	ResetLedStatus(pLed);
 
-	timer_setup(&pLed->BlinkTimer, BlinkTimerCallback, 0);
-	INIT_WORK(&pLed->BlinkWorkItem, BlinkWorkItemCallback);
+	INIT_DELAYED_WORK(&pLed->blink_work, BlinkWorkItemCallback);
 }
 
 void DeInitLed871x(struct LED_871x *pLed)
 {
-	cancel_work_sync(&pLed->BlinkWorkItem);
-	_cancel_timer_ex(&pLed->BlinkTimer);
+	cancel_delayed_work_sync(&pLed->blink_work);
 	ResetLedStatus(pLed);
 }
 
@@ -80,14 +68,14 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_BLINK_NORMAL:
 		if (pLed->bLedOn)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_BLINK_SCAN:
 		pLed->BlinkTimes--;
@@ -101,7 +89,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -109,7 +97,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -117,7 +105,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		}
 		break;
 	case LED_BLINK_TXRX:
@@ -132,7 +120,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -140,7 +128,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
 			pLed->bLedBlinkInProgress = false;
 		} else {
@@ -148,7 +136,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
 		}
 		break;
 	case LED_BLINK_WPS:
@@ -156,7 +144,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
 		if (pLed->BlinkingLedState == RTW_LED_ON)
@@ -171,12 +159,12 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 
 			pLed->bLedWPSBlinkInProgress = false;
 		} else {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
 		}
 		break;
 	default:
@@ -198,11 +186,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedBlinkInProgress = false;
 			}
 
@@ -212,7 +200,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		}
 		break;
 	case LED_CTL_LINK:
@@ -220,11 +208,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedLinkBlinkInProgress = true;
@@ -233,7 +221,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -243,15 +231,15 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedBlinkInProgress = false;
 			}
 			pLed->bLedScanBlinkInProgress = true;
@@ -261,7 +249,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		 }
 		break;
 	case LED_CTL_TX:
@@ -270,11 +258,11 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			pLed->bLedBlinkInProgress = true;
@@ -284,26 +272,26 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
 		}
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
 		 if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedNoLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedNoLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedBlinkInProgress = false;
 			}
 			if (pLed->bLedScanBlinkInProgress) {
-				_cancel_timer_ex(&pLed->BlinkTimer);
+				cancel_delayed_work_sync(&pLed->blink_work);
 				pLed->bLedScanBlinkInProgress = false;
 			}
 			pLed->bLedWPSBlinkInProgress = true;
@@ -312,42 +300,42 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 				pLed->BlinkingLedState = RTW_LED_OFF;
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		 }
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedNoLinkBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedNoLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress)
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 		else
 			pLed->bLedWPSBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
 		} else {
 			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, 0);
+			schedule_delayed_work(&pLed->blink_work, 0);
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		pLed->bLedNoLinkBlinkInProgress = true;
@@ -356,29 +344,29 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			pLed->BlinkingLedState = RTW_LED_OFF;
 		else
 			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
 		if (pLed->bLedNoLinkBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedNoLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedBlinkInProgress = false;
 		}
 		if (pLed->bLedWPSBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
 		if (pLed->bLedScanBlinkInProgress) {
-			_cancel_timer_ex(&pLed->BlinkTimer);
+			cancel_delayed_work_sync(&pLed->blink_work);
 			pLed->bLedScanBlinkInProgress = false;
 		}
 		SwLedOff(padapter, pLed);
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index c035fe267635..7e901aae92fb 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -13,11 +13,11 @@
 #define LED_BLINK_SLOWLY_INTERVAL		200
 #define LED_BLINK_LONG_INTERVAL			400
 
-#define LED_BLINK_NO_LINK_INTERVAL_ALPHA	1000
-#define LED_BLINK_LINK_INTERVAL_ALPHA		500	/* 500 */
-#define LED_BLINK_SCAN_INTERVAL_ALPHA		180	/* 150 */
-#define LED_BLINK_FASTER_INTERVAL_ALPHA		50
-#define LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA	5000
+#define LED_BLINK_NO_LINK_INTVL			msecs_to_jiffies(1000)
+#define LED_BLINK_LINK_INTVL			msecs_to_jiffies(500)
+#define LED_BLINK_SCAN_INTVL			msecs_to_jiffies(180)
+#define LED_BLINK_FASTER_INTVL			msecs_to_jiffies(50)
+#define LED_BLINK_WPS_SUCESS_INTVL		msecs_to_jiffies(5000)
 
 #define LED_BLINK_NORMAL_INTERVAL_NETTRONIX	100
 #define LED_BLINK_SLOWLY_INTERVAL_NETTRONIX	2000
@@ -105,15 +105,12 @@ struct LED_871x {
 
 	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
 
-	struct timer_list BlinkTimer; /*  Timer object for led blinking. */
-
 	/*  ALPHA, added by chiyoko, 20090106 */
 	u8 bLedNoLinkBlinkInProgress;
 	u8 bLedLinkBlinkInProgress;
 	u8 bLedStartToLinkBlinkInProgress;
 	u8 bLedScanBlinkInProgress;
-	struct work_struct BlinkWorkItem; /* Workitem used by BlinkTimer to
-					   * manipulate H/W to blink LED. */
+	struct delayed_work blink_work;
 };
 
 #define IS_LED_WPS_BLINKING(_LED_871x)					\
@@ -143,7 +140,6 @@ struct led_priv{
 			(adapt)->ledpriv.LedControlHandler((adapt), (action)); \
 	} while (0)
 
-void BlinkTimerCallback(struct timer_list *t);
 void BlinkWorkItemCallback(struct work_struct *work);
 
 void ResetLedStatus(struct LED_871x * pLed);
-- 
2.20.1

