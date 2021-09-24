Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C49417C88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbhIXUvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348472AbhIXUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:51:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B7C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i24so15110963wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+lWEv9N1xdLypdg8g+1lrIeO0sXMqbU8ThFt4NhNtU=;
        b=PB5ZG6h1E0ZRCedYOzYThDTPbg9wQp7zOcokG+8iCpqyWlGXPzJdWgxUukd0leL/Yw
         +dbWrRHsqd8SIMenirAtlgRUvd0Xwr6Q0MftgQ69i1GAIZXBU1YVD6s/0oGYXTs1XiBM
         qc5XNacnjMi8uTd5SoxYLWOmfzV/Vv2hWf2xeCWqLkD5x1W+a5Gq7cz83rQdCeBDlZrN
         QWnQjNzm8EOqvo1BzP4yzX+WVBTQ5KqwCRpN54WJmRJDaireEUMoiPjv950mh0clpJmt
         6rVoO2PRu6PWGm8S22PANBXJVOXMFkjQCPc10c/M3tz/to9ICEwiHqSJrKtSaYjlbq2X
         C+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+lWEv9N1xdLypdg8g+1lrIeO0sXMqbU8ThFt4NhNtU=;
        b=iM2vLx4rVNnZyQcygKVvGHN0kjDfqpUChF+NU79YUFk3CZWtq61RwuQ7zdPusl/OkH
         ZR2xlFq2nKrr1BrCh7vcqkScS/7IdHlRbFdcoQI2pNP0rZULvOOUiMOAI66RQFuPmsyz
         dPLtEY7XTjH8qcjUGrl1fPms4SJnFSmF1FkDMFsQTg0Pj5Gb/yeYuOp9Qzp1bSocjQLP
         iWYBKi7Wqb77e3etMN8/tIfdtYjPMyU6DQtXHCrF269t9Ul7WKcLVx+WjZr0zgiGBymr
         4AIf5NBVKywsEJ5tX8gpZ6WwknSDOts44wFs2EkW2i/61PW5RnAfPCRU9wjmjzE9Y++t
         /5xg==
X-Gm-Message-State: AOAM532jhPhdulrkmf8anx2KBMZJj5ubMzkc0b1B4NPSBzTr4LYxQhq2
        VnzrVPwt0K0XAgjHGx7H97g=
X-Google-Smtp-Source: ABdhPJyCJhCKmVF60PYU+JtDCSN2EbNP4dKLnkPP1MxO2jqkAw7FOA5UIQsgfbudlKM/WTfzq5B9ww==
X-Received: by 2002:a5d:6343:: with SMTP id b3mr13026929wrw.124.1632516570234;
        Fri, 24 Sep 2021 13:49:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51da])
        by smtp.gmail.com with ESMTPSA id j19sm9040292wra.92.2021.09.24.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:49:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove dead led blink functions
Date:   Fri, 24 Sep 2021 22:49:13 +0200
Message-Id: <20210924204917.6313-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924204917.6313-1-straube.linux@gmail.com>
References: <20210924204917.6313-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LedStrategy is SW_LED_MODE1 in this driver. Remove led blink
functions that are not used for SW_LED_MODE1.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 524 +------------------------
 1 file changed, 1 insertion(+), 523 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index b33e34cce12e..49324e9789b9 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -76,84 +76,6 @@ void DeInitLed871x(struct LED_871x *pLed)
 	ResetLedStatus(pLed);
 }
 
-/*  */
-/*	Description: */
-/*		Implementation of LED blinking behavior. */
-/*		It toggle off LED and schedule corresponding timer if necessary. */
-/*  */
-
-static void SwLedBlink(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bStopBlinking = false;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-
-	/*  Determine if we shall change LED state again. */
-	pLed->BlinkTimes--;
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_NORMAL:
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		break;
-	case LED_BLINK_StartToBlink:
-		if (check_fwstate(pmlmepriv, _FW_LINKED) && check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-			bStopBlinking = true;
-		if (check_fwstate(pmlmepriv, _FW_LINKED) &&
-		    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
-		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)))
-			bStopBlinking = true;
-		else if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		break;
-	case LED_BLINK_WPS:
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		break;
-	default:
-		bStopBlinking = true;
-		break;
-	}
-
-	if (bStopBlinking) {
-		if (check_fwstate(pmlmepriv, _FW_LINKED) && !pLed->bLedOn) {
-			SwLedOn(padapter, pLed);
-		} else if (check_fwstate(pmlmepriv, _FW_LINKED) && pLed->bLedOn) {
-			SwLedOff(padapter, pLed);
-		}
-		pLed->BlinkTimes = 0;
-		pLed->bLedBlinkInProgress = false;
-	} else {
-		/*  Assign LED state to toggle. */
-		if (pLed->BlinkingLedState == RTW_LED_ON)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-
-		/*  Schedule a timer to toggle LED state. */
-		switch (pLed->CurrLedState) {
-		case LED_BLINK_NORMAL:
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
-			break;
-		case LED_BLINK_SLOWLY:
-		case LED_BLINK_StartToBlink:
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
-			break;
-		case LED_BLINK_WPS:
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_LONG_INTERVAL);
-			break;
-		default:
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
-			break;
-		}
-	}
-}
-
 static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
@@ -283,420 +205,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 	}
 }
 
-static void SwLedBlink2(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bStopBlinking = false;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_SCAN:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				SwLedOn(padapter, pLed);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-				SwLedOff(padapter, pLed);
-			}
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_TXRX:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				SwLedOn(padapter, pLed);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-				SwLedOff(padapter, pLed);
-			}
-			pLed->bLedBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	default:
-		break;
-	}
-}
-
-static void SwLedBlink3(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bStopBlinking = false;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON) {
-		SwLedOn(padapter, pLed);
-	} else {
-		if (pLed->CurrLedState != LED_BLINK_WPS_STOP)
-			SwLedOff(padapter, pLed);
-	}
-
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_SCAN:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				if (!pLed->bLedOn)
-					SwLedOn(padapter, pLed);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-				if (pLed->bLedOn)
-					SwLedOff(padapter, pLed);
-			}
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_TXRX:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				if (!pLed->bLedOn)
-					SwLedOn(padapter, pLed);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-
-				if (pLed->bLedOn)
-					SwLedOff(padapter, pLed);
-			}
-			pLed->bLedBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_WPS:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
-		break;
-	case LED_BLINK_WPS_STOP:	/* WPS success */
-		if (pLed->BlinkingLedState == RTW_LED_ON) {
-			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA);
-			bStopBlinking = false;
-		} else {
-			bStopBlinking = true;
-		}
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-				SwLedOff(padapter, pLed);
-			} else {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				SwLedOn(padapter, pLed);
-			}
-			pLed->bLedWPSBlinkInProgress = false;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
-static void SwLedBlink4(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-	struct led_priv *ledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed1 = &ledpriv->SwLed1;
-	u8 bStopBlinking = false;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-
-	if (!pLed1->bLedWPSBlinkInProgress && pLed1->BlinkingLedState == LED_UNKNOWN) {
-		pLed1->BlinkingLedState = RTW_LED_OFF;
-		pLed1->CurrLedState = RTW_LED_OFF;
-		SwLedOff(padapter, pLed1);
-	}
-
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_SLOWLY:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
-		break;
-	case LED_BLINK_StartToBlink:
-		if (pLed->bLedOn) {
-			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
-		} else {
-			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
-		}
-		break;
-	case LED_BLINK_SCAN:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = false;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				pLed->bLedNoLinkBlinkInProgress = false;
-				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
-			}
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_TXRX:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				pLed->bLedNoLinkBlinkInProgress = true;
-				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
-			}
-			pLed->bLedBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_WPS:
-		if (pLed->bLedOn) {
-			pLed->BlinkingLedState = RTW_LED_OFF;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_SLOWLY_INTERVAL);
-		} else {
-			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
-		}
-		break;
-	case LED_BLINK_WPS_STOP:	/* WPS authentication fail */
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-
-		_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
-		break;
-	case LED_BLINK_WPS_STOP_OVERLAP:	/* WPS session overlap */
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0) {
-			if (pLed->bLedOn)
-				pLed->BlinkTimes = 1;
-			else
-				bStopBlinking = true;
-		}
-
-		if (bStopBlinking) {
-			pLed->BlinkTimes = 10;
-			pLed->BlinkingLedState = RTW_LED_ON;
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_LINK_INTERVAL_ALPHA);
-		} else {
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-
-			_set_timer(&pLed->BlinkTimer, LED_BLINK_NORMAL_INTERVAL);
-		}
-		break;
-	default:
-		break;
-	}
-}
-
-static void SwLedBlink5(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-	u8 bStopBlinking = false;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_SCAN:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-				if (pLed->bLedOn)
-					SwLedOff(padapter, pLed);
-			} else {
-					pLed->CurrLedState = RTW_LED_ON;
-					pLed->BlinkingLedState = RTW_LED_ON;
-					if (!pLed->bLedOn)
-						_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_SCAN_INTERVAL_ALPHA);
-			}
-		}
-		break;
-	case LED_BLINK_TXRX:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-
-		if (bStopBlinking) {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				pLed->CurrLedState = RTW_LED_OFF;
-				pLed->BlinkingLedState = RTW_LED_OFF;
-				if (pLed->bLedOn)
-					SwLedOff(padapter, pLed);
-			} else {
-				pLed->CurrLedState = RTW_LED_ON;
-				pLed->BlinkingLedState = RTW_LED_ON;
-				if (!pLed->bLedOn)
-					_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-
-			pLed->bLedBlinkInProgress = false;
-		} else {
-			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
-				SwLedOff(padapter, pLed);
-			} else {
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
-				_set_timer(&pLed->BlinkTimer, LED_BLINK_FASTER_INTERVAL_ALPHA);
-			}
-		}
-		break;
-
-	default:
-		break;
-	}
-}
-
-static void SwLedBlink6(struct LED_871x *pLed)
-{
-	struct adapter *padapter = pLed->padapter;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-}
-
  /* ALPHA, added by chiyoko, 20090106 */
 static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
@@ -1520,44 +1028,14 @@ SwLedControlMode6(
 	}
 }
 
-/*  */
-/*	Description: */
-/*		Handler function of LED Blinking. */
-/*		We dispatch acture LED blink action according to LedStrategy. */
-/*  */
 void BlinkHandler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-	struct led_priv *ledpriv = &padapter->ledpriv;
 
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
 		return;
 
-	switch (ledpriv->LedStrategy) {
-	case SW_LED_MODE0:
-		SwLedBlink(pLed);
-		break;
-	case SW_LED_MODE1:
-		SwLedBlink1(pLed);
-		break;
-	case SW_LED_MODE2:
-		SwLedBlink2(pLed);
-		break;
-	case SW_LED_MODE3:
-		SwLedBlink3(pLed);
-		break;
-	case SW_LED_MODE4:
-		SwLedBlink4(pLed);
-		break;
-	case SW_LED_MODE5:
-		SwLedBlink5(pLed);
-		break;
-	case SW_LED_MODE6:
-		SwLedBlink6(pLed);
-		break;
-	default:
-		break;
-	}
+	SwLedBlink1(pLed);
 }
 
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
-- 
2.33.0

