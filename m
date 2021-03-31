Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99934FD23
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhCaJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhCaJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so21534792edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6r3wJkTfgXOb09KzV4WZdWmyuiaF5CHkBHLFr4r259Y=;
        b=kxLm/x5RnQwGDcoFaDHNV5puG9fm7YUDM/MTfIhYtvfSaeRnvkIKskFSE1TXifFFZs
         gUbhZtDJsenbUAfUMvPDOuqv8sbCGffXM4FHPKiqxvIXW4GPP7WtMeAsQ0Rs0T91JjOy
         CWpTrHHCg+WxMnfXO+o8fcPVFik2JIcbWg4yuJlb02fbIIit1rTrZMq1JhJyv5XDN+D3
         e57cMpJaOFK6PsOQ1+rUoPRAdiztTIaQoaaV/VbB0fI0iIbVK+3LXt5F7RKTl96pC70R
         vBEtVWLf31BCJJrKGCXmnqUr0CbjP6zLhU5GxaGrV8NryY8+dvg/MY8vSRphiPH7dekS
         +LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6r3wJkTfgXOb09KzV4WZdWmyuiaF5CHkBHLFr4r259Y=;
        b=Kxc2ppfPPxz6gXp1K0/TaISYOlGozMtDOD8TyjgK29gYwDdb80Qdea1I1tSIcP+DMF
         bxSg7VVnwT5+5YJtpdAKd/Ri48ATEhiTGdtzhACXk2TQNPVzUy/QxqLDRoE62/5PRW6+
         63jj3aSWY/XiPXw/JYUiLzeg7uZzNBDr428rsTnewobOR9g92UzSI35pgKdNXNAaspMD
         8IsW9ZO6kW2EgtrlgnaWKm3F20/FAkFcI9R3ly8I5D3IzoBLcjOKCmLfXKAVN930A1SO
         YZrxljSawBnauHVWx6b66zOaLzO7zqNd/UCvp7ArzVqbAegtwIjVq95A3J6JQ06U4BVL
         3AJQ==
X-Gm-Message-State: AOAM532I83hX63HkitzP8/IRc3j3kG/vo5Z3VR5ffmqFKEoGijvYRdcx
        yckyuOKtF6Ent2P9NlpVKKs=
X-Google-Smtp-Source: ABdhPJysMkymAWBe4J7W/ABLX6GzYXFMPVZFutnRVMW+vnfPqU2qlmfCb2OiXvEFyEAfRMwrzON+xg==
X-Received: by 2002:a05:6402:158d:: with SMTP id c13mr2527746edv.297.1617183617806;
        Wed, 31 Mar 2021 02:40:17 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id h17sm1098489eds.26.2021.03.31.02.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_eeprom.c
Date:   Wed, 31 Mar 2021 11:39:31 +0200
Message-Id: <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_eeprom.c | 26 ++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
index 3cbd65dee741..6176d741d60e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
+++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
@@ -36,7 +36,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
 _func_enter_;
 
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	mask = 0x01 << (count - 1);
@@ -49,8 +49,8 @@ _func_enter_;
 		if (data & mask)
 			x |= _EEDI;
 		if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
-		goto out;
+			pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
+			goto out;
 		}
 		rtw_write8(padapter, EE_9346CR, (u8)x);
 		udelay(CLOCK_RATE);
@@ -59,7 +59,7 @@ _func_enter_;
 		mask = mask >> 1;
 	} while (mask);
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	x &= ~_EEDI;
@@ -73,7 +73,7 @@ u16 shift_in_bits(_adapter *padapter)
 	u16 x, d = 0, i;
 _func_enter_;
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	x = rtw_read8(padapter, EE_9346CR);
@@ -85,7 +85,7 @@ _func_enter_;
 		d = d << 1;
 		up_clk(padapter, &x);
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 		x = rtw_read8(padapter, EE_9346CR);
@@ -123,23 +123,23 @@ void eeprom_clean(_adapter *padapter)
 	u16 x;
 _func_enter_;
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	x = rtw_read8(padapter, EE_9346CR);
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	x &= ~(_EECS | _EEDI);
 	rtw_write8(padapter, EE_9346CR, (u8)x);
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	up_clk(padapter, &x);
-		if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true) {
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	down_clk(padapter, &x);
@@ -156,14 +156,14 @@ u16 eeprom_read16(_adapter *padapter, u16 reg) /*ReadEEprom*/
 _func_enter_;
 
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 	/* select EEPROM, reset bits, set _EECS*/
 	x = rtw_read8(padapter, EE_9346CR);
 
 	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
 		goto out;
 	}
 
-- 
2.20.1

