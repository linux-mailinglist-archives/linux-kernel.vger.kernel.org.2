Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B0417C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348514AbhIXUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbhIXUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:51:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C0C0614ED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so31078000wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggSSluSfCP353WDDv81czvciokxy86FRslxnjZPG5F0=;
        b=nmHiMwRvRivsWqFb6thAnlq3nhtw2q2lj8MvalzhAdgJevAwnN8Anl3D5nrBw+xwtP
         wzh9YMPTFEsfj3kVEaj84IUl+33zQDEAhz7tI0e/WyKKZwOVBS2nhT6k9njUNFQQeMgl
         uspiy9Cu3TC9PGOqRtiLuigHAPlNHk0kHea0dOxEgKBjyNCcMtEC5jilmF1sHLP2zkVt
         fd9dnWlDIYSFc40W5m7yhztQdTKiLonggrtqY4RlQs2N/9iiyUl1Gu8FPalXGSTEsc5+
         g7ZDWzXdCGFShKQg+herjKqLRLC3MqDnJQ+MzhM6EwT0YuJY/YHrbSUXJZtFV/yZyrrt
         RDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggSSluSfCP353WDDv81czvciokxy86FRslxnjZPG5F0=;
        b=0xY5z6WSdH5j1F1Q7JYLaEWInBtHIuQhKeCz3ITKF0nBoD0VaPP9D3wlM8uA2IpWGS
         p7uIn8a1+0C5zSuYFxRsU+FwLV42Jq1yWO6tEEOHsvQv/G7at/4M3bkM7Zjh/LUxMbMH
         S2JLEybScTydEoK3PmrDKjNwKygaVdKyMSoIRwHuVySUxiAPp/stpHcCGE4frDMcSvA5
         4rP5x1WOPQvghYMWohiALKmcWlwKXWJwrg594Hg2wFSvGg2C9HKilvXj7x9EEu3lFqqT
         QxrEEYUS+YP/rCjVCCwWaNItHTsb5evRcFFGz2iB08UoVoB/8oN6o54s+4lIqyBH4IN0
         vmsg==
X-Gm-Message-State: AOAM532OT8Z48AE/87aAcyZJnRuMn/HFVuhlwWGqkk1sZ5q3gcD12umi
        XnutcGjUI5n5NfyiLVtDHMo=
X-Google-Smtp-Source: ABdhPJxuNcaMGHAn6UOkJbB1ueoKNRMsFdj9QoOV6MEyndGV+miwWu8o9dfkCti1V5VV5702MiToPg==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr4022134wmg.176.1632516571798;
        Fri, 24 Sep 2021 13:49:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51da])
        by smtp.gmail.com with ESMTPSA id j19sm9040292wra.92.2021.09.24.13.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:49:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove unnecessary comments
Date:   Fri, 24 Sep 2021 22:49:15 +0200
Message-Id: <20210924204917.6313-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924204917.6313-1-straube.linux@gmail.com>
References: <20210924204917.6313-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names in rtw_led.c are self-explanatory. Remove
unnecessary comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index da02cd4fdc52..09d8c4e85863 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -4,11 +4,6 @@
 #include "../include/drv_types.h"
 #include "../include/rtw_led.h"
 
-/*  */
-/*	Description: */
-/*		Callback function of LED BlinkTimer, */
-/*		it just schedules to corresponding BlinkWorkItem/led_blink_hdl */
-/*  */
 void BlinkTimerCallback(struct timer_list *t)
 {
 	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
@@ -20,21 +15,12 @@ void BlinkTimerCallback(struct timer_list *t)
 	_set_workitem(&pLed->BlinkWorkItem);
 }
 
-/*  */
-/*	Description: */
-/*		Callback function of LED BlinkWorkItem. */
-/*		We dispatch acture LED blink action according to LedStrategy. */
-/*  */
 void BlinkWorkItemCallback(struct work_struct *work)
 {
 	struct LED_871x *pLed = container_of(work, struct LED_871x, BlinkWorkItem);
 	BlinkHandler(pLed);
 }
 
-/*  */
-/*	Description: */
-/*		Reset status of LED_871x object. */
-/*  */
 void ResetLedStatus(struct LED_871x *pLed)
 {
 	pLed->CurrLedState = RTW_LED_OFF; /*  Current LED state. */
@@ -52,8 +38,6 @@ void ResetLedStatus(struct LED_871x *pLed)
 	pLed->bLedScanBlinkInProgress = false;
 }
 
-/*Description: */
-/*		Initialize an LED_871x object. */
 void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_871x LedPin)
 {
 	pLed->padapter = padapter;
@@ -65,10 +49,6 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_8
 	_init_workitem(&pLed->BlinkWorkItem, BlinkWorkItemCallback, pLed);
 }
 
-/*  */
-/*	Description: */
-/*		DeInitialize an LED_871x object. */
-/*  */
 void DeInitLed871x(struct LED_871x *pLed)
 {
 	_cancel_workitem_sync(&pLed->BlinkWorkItem);
@@ -205,7 +185,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 	}
 }
 
- /* ALPHA, added by chiyoko, 20090106 */
 static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
-- 
2.33.0

