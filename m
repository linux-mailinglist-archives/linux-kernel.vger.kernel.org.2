Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC085353859
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhDDOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhDDOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F9C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4472477wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmNzf36fyYg+0AMkEesws+QYsMSDK6OKbz+EDQka0qY=;
        b=uTdww3EUd2OCcuyKCtmN+7rJjNqmmf1ZGgvk77+Bh2dvIbtPYswMunZw9LOrzVyql7
         iFIc1YAkaE363bvyMLsnLdWYAUGkm7EqQIVdUhxmexXz3FiIka/8sRpyF8Gx4PdES4z7
         3SR1VRo3B4XZQSUBwBgfyO6tgYRdbLCF0Q1o8JCdq5K7JsKsU1v6bwLKBqESs3GDMilc
         3vvNUdNg7cw5TRUhaD5tiXtGWU+3fln2GOMrHf3+Zqdv3uZ7lwT6gZO8/ZMk9VUS25YE
         K6HHcrS9FJLQU9fQbty8JnwDFfw8cuDn1e5rddOK308kpr94Xvqy1vqMNhxCq6ouEDO2
         Rn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmNzf36fyYg+0AMkEesws+QYsMSDK6OKbz+EDQka0qY=;
        b=h8OnIklwXk8SZqCDmqrdG76vpZQq0fiIoABscYO90hEjcqvNNWxYJy//Qp17/vY99a
         Orw6tdMv2N0ui/ytO2QFoe6sCzObmKAg519Dglmf104AfHZdBvLTp4HoA8keeSWnW5Jj
         Si15NNM6hcWye2a44XG+izKhLUrGPVfadtKuu3OVNGjAWvin9rtwc/wpWgyeb4mBqqQe
         qKj57g44g6KlY2ii3SeMY4V6EecLZ/rdL2+c+HjDh+N2meC8RtwwxrkLg1IfIFez/Fzw
         riJ+GWOhS8fwjbyBB6jYwxBOW35YUsmwwubFEABnH4tU3kxhIKLLxskn78CFJqekl73j
         Uyfw==
X-Gm-Message-State: AOAM530ioUVhN8xm0LZEDnSdNfKYNnwrQdOiToBUxLRY7GSvQ+UOYSqX
        D3bUP4SEYywHND3zbq/PkNU=
X-Google-Smtp-Source: ABdhPJxM+4CsNJGl7zL0hga/O259V1+AteNPFUvqUd7XI4Ye6Z3BDbSnkZULgZpFf8usA8/8VGhs1w==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr20609473wmi.183.1617545400493;
        Sun, 04 Apr 2021 07:10:00 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id e10sm7276721wrw.14.2021.04.04.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 06/30] staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
Date:   Sun,  4 Apr 2021 16:09:22 +0200
Message-Id: <e302fadf18a36d8521456858caff641c0f598731.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_eeprom.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

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

