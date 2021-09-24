Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E22417C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbhIXUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348460AbhIXUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:51:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C0C061762
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so30940585wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8tei2z4GrmoyrcZEip935wZKfOS4cdN7dMi2avI0l8=;
        b=VEijUiro5FMz2eQM6QdaP3Oy9NZvKxZYB5ax/puTVShgfwf0ATt6MMULPPlt/biRDc
         P6u4YFn0e4lsvp55rrDjty0JrCbVvWpsYMG/yx/VPfU8bvb4Z82hwU57d6kbIO/yZ2Ez
         lOv9PKNiHwyCSyRoLaFFlovXaL+Z/rRgaK2KoCJ/Ecqplkksc6Vr7ueW46Uwh/9c4DNS
         yfXbL2GGQwE6YsrbfJNUzSTiaJCd653p+yeghtHGnFL6I0MIsQ+rs9GVOBdaiWoItjNq
         4qRPBb/TmJ7kTNC3aqHpcxscBVP70ArJnKl3LJlHWMIgDCYVvnEHE/IwbqbpISISMPBA
         TaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8tei2z4GrmoyrcZEip935wZKfOS4cdN7dMi2avI0l8=;
        b=e6cMgnYY6O0VfEwwKE9L/Cc/XGQ3XGyX+LfwLJGvlJgkz17frnXTZDwE0uGv/tpYzW
         KlYA3utV5YO97EyKZhTBKlNsiE7lG7x28h+eraZT0sXfC1W2NCILvStdvKhZc8/ronB1
         odoUD6o0bnTXP0hogybKN7Ath3fOd27tLkrEkZq2CeaM/u5xJ3IyXprDHNhPxZxqWWhN
         WmLXKG1WpTbcU201NWWB+Shaduv/ScOF1tOAh00p4W1eE5LQjSWuWaPTBOw1NjzEWhlL
         3KKZdvXRSLfl1n3mA6jW7lJdDNyEIX2ifdj1K6uecM5wngZl0WiXbXiiLuiiIID2BfBS
         KTcA==
X-Gm-Message-State: AOAM532eMDy5UUSMEulaE8jsqvmblzxlnQ+xuzFM3zl+M2rfQZuslhHZ
        HIDdddLnPrxL+2oYe6q3BTw=
X-Google-Smtp-Source: ABdhPJw9xkkZJYbO2u0eexPnMm1qG7EIXZY6vdJLoiNT857yBsV9TgsuE2okssm2k5mvHCzpsleeeA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr13761309wro.264.1632516573298;
        Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51da])
        by smtp.gmail.com with ESMTPSA id j19sm9040292wra.92.2021.09.24.13.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove LedStrategy from struct led_priv
Date:   Fri, 24 Sep 2021 22:49:17 +0200
Message-Id: <20210924204917.6313-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924204917.6313-1-straube.linux@gmail.com>
References: <20210924204917.6313-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LedStrategy is set but never used. Remove it from struct led_priv and
remove the now unused enum LED_STRATEGY_871x as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c |  1 -
 drivers/staging/r8188eu/include/rtw_led.h | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 483a3b0ea94f..467809340a82 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1042,7 +1042,6 @@ static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool Autol
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 
 	pledpriv->bRegUseLed = true;
-	pledpriv->LedStrategy = SW_LED_MODE1;
 	haldata->bLedOpenDrain = true;/*  Support Open-drain arrangement for controlling the LED. */
 }
 
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index f0965aa5b470..ebe6395642ae 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -127,30 +127,12 @@ struct LED_871x {
 	(((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress	||	\
 	((struct LED_871x *)_LED_871x)->bLedScanBlinkInProgress)
 
-/*  LED customization. */
-
-enum LED_STRATEGY_871x {
-	SW_LED_MODE0 = 0, /* SW control 1 LED via GPIO0. It is default option.*/
-	SW_LED_MODE1= 1, /*  2 LEDs, through LED0 and LED1. For ALPHA. */
-	SW_LED_MODE2 = 2, /*  SW control 1 LED via GPIO0, customized for AzWave
-			   * 8187 minicard. */
-	SW_LED_MODE3 = 3, /*  SW control 1 LED via GPIO0, customized for Sercomm
-			   * Printer Server case. */
-	SW_LED_MODE4 = 4, /* for Edimax / Belkin */
-	SW_LED_MODE5 = 5, /* for Sercomm / Belkin */
-	SW_LED_MODE6 = 6, /* for 88CU minicard, porting from ce SW_LED_MODE7 */
-	HW_LED = 50, /*  HW control 2 LEDs, LED0 and LED1 (there are 4
-		      * different control modes, see MAC.CONFIG1 for details.)*/
-	LED_ST_NONE = 99,
-};
-
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE	LedAction);
 
 struct led_priv{
 	/* add for led control */
 	struct LED_871x			SwLed0;
 	struct LED_871x			SwLed1;
-	enum LED_STRATEGY_871x	LedStrategy;
 	u8	bRegUseLed;
 	void (*LedControlHandler)(struct adapter *padapter,
 				  enum LED_CTL_MODE LedAction);
-- 
2.33.0

