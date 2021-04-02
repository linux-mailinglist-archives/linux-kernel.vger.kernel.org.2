Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147E352E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhDBRas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhDBRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC8C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so5300073wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jhCL9EUC2P98XH0gvEVV2X6JKScPT/AA7vi/6Ti45Y=;
        b=hETOx9v+Lap7/4S3krPf5aESJdz+GkcCb6Mi40O4DwT977ltXu0QaCY7eiFBEfqVfd
         X61L178qRogZ6C2zO8YORvhRYvsrhN5deF9M9BJfaWLay8G6n2KQ0P/VPKwtKwF94QaE
         XwKPDKqsy3mBombAmMlmX8boTOdM7Rbm8Hd4K9dRF2n9AsOv9wkVXCvsCriVe91EmLXe
         YwDsixCZ0wyK5UoSzEX/xyK5ki/NZDkC7Ym36FutYzxhe65uX07V9zqN8NEDzPod4e4l
         D7kOJGodv3HnQYvfvRD6djJha//zVg03Rk48o+gMX9viTTC29GiD4qQmWoREB3uSspMn
         jEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jhCL9EUC2P98XH0gvEVV2X6JKScPT/AA7vi/6Ti45Y=;
        b=DaNEmgB9nDB3VXFPLONt6l28nAzP1l+QfLaFKm6Lf3/tx0yhuZr9k6Pobvlq5l9w31
         JVtgEV4C6dGf+lPKhMZEvi/bKBe11B2SJsYXagbHR8jqSRFEbgdYb+0J4DT3xRNr08A2
         1OgCvwJpJpvRRK+B4ov5Vr0wxS3YnKG5jQYIcqxLlU4Iggu1ZrO9YH/S+ualzhwKkayX
         MkgzmlKq/yAdRnbgcnmgwr/nnl6AjnfIvcP8W2HiWTeJVQcUmbo5A5AAX7afAXaqd43h
         nD3jOtt3ox+1EWCF9gEaRh7qLuo28xfdPTBPpeRfzK1svVH9mfKa+XyVqOgXF9Nz7MkW
         OqIg==
X-Gm-Message-State: AOAM531XxWGgM4Pf64BDnIbHxRjPmJzSFm1/G9WFuUKpxMbmSdShRRTM
        gqH3h3ytEziOsMapsnYYIWfibPbZYsjWVA==
X-Google-Smtp-Source: ABdhPJwcwXgcX+Irhh55OBT/CU+5pRN9J1SRlccmddgeL+/JWDLuZ6oArxZfOK3MEiC99MCTgHVaIQ==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr15599669wrr.319.1617384626835;
        Fri, 02 Apr 2021 10:30:26 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id s21sm12968838wmc.10.2021.04.02.10.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 06/30] staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
Date:   Fri,  2 Apr 2021 19:29:48 +0200
Message-Id: <f0f1777b9f88807eaf98f7ebc21fdd1757147822.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_eeprom.c | 56 ++++++++-------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
index 3cbd65dee741..32d5e5b23337 100644
--- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
+++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
@@ -35,10 +35,9 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
 	u16 x, mask;
 _func_enter_;
 
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	mask = 0x01 << (count - 1);
 	x = rtw_read8(padapter, EE_9346CR);
 
@@ -48,20 +47,18 @@ _func_enter_;
 		x &= ~_EEDI;
 		if (data & mask)
 			x |= _EEDI;
-		if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
-		goto out;
-		}
+		if (padapter->bSurpriseRemoved == true)
+			goto out;
+
 		rtw_write8(padapter, EE_9346CR, (u8)x);
 		udelay(CLOCK_RATE);
 		up_clk(padapter, &x);
 		down_clk(padapter, &x);
 		mask = mask >> 1;
 	} while (mask);
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	x &= ~_EEDI;
 	rtw_write8(padapter, EE_9346CR, (u8)x);
 out:
@@ -72,10 +69,9 @@ u16 shift_in_bits(_adapter *padapter)
 {
 	u16 x, d = 0, i;
 _func_enter_;
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	x = rtw_read8(padapter, EE_9346CR);
 
 	x &= ~(_EEDO | _EEDI);
@@ -84,10 +80,9 @@ _func_enter_;
 	for (i = 0; i < 16; i++) {
 		d = d << 1;
 		up_clk(padapter, &x);
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 		x = rtw_read8(padapter, EE_9346CR);
 
 		x &= ~(_EEDI);
@@ -122,26 +117,22 @@ void eeprom_clean(_adapter *padapter)
 {
 	u16 x;
 _func_enter_;
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	x = rtw_read8(padapter, EE_9346CR);
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	x &= ~(_EECS | _EEDI);
 	rtw_write8(padapter, EE_9346CR, (u8)x);
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	up_clk(padapter, &x);
-		if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	down_clk(padapter, &x);
 out:
 _func_exit_;
@@ -155,17 +146,14 @@ u16 eeprom_read16(_adapter *padapter, u16 reg) /*ReadEEprom*/
 
 _func_enter_;
 
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
+
 	/* select EEPROM, reset bits, set _EECS*/
 	x = rtw_read8(padapter, EE_9346CR);
 
-	if (padapter->bSurpriseRemoved == true) {
-		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
+	if (padapter->bSurpriseRemoved == true)
 		goto out;
-	}
 
 	x &= ~(_EEDI | _EEDO | _EESK | _EEM0);
 	x |= _EEM1 | _EECS;
-- 
2.20.1

