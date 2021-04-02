Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187E0352E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhDBRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhDBRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9169C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso4610578wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mejZVqpRJ8oVKa+6YzrLPAS4xjEjGZsSp2jhdnFadfE=;
        b=jeP/TSj+Y4AYtnBoSS8z5vzezLfDMty/5TdSJ4BK5CSeLnAHGngQdvjWKXrG5mISSc
         8Er+MIuw/CLsdHOFL5FrrXM7UtRnRld7nIE8wudk94IkJpbCzVNzojnuMqj6ZfFB7qaj
         WSUMlUqE5cedJEaK9glbEGFdOoL5a129M6yH0XfaxEW7neXlMPGUpXDQoBmVxeZ2s+KN
         V8WlsZ+IMCj6Q8RNLaYpaQRxA+22+Cc3sX6WZsLRWxPPnvG4ePh0pNtGT0fp7lEHVr+F
         BS0BgktiRo+Ah1m9L7WslgXo2SyIoG8fHzEScDldTbua0cQY2IJnbdrDc+pZvim/HxFn
         rSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mejZVqpRJ8oVKa+6YzrLPAS4xjEjGZsSp2jhdnFadfE=;
        b=PgTIukE6RYU1VAKOwY9+YMLIZEQTWeVbkQhSjiyAN7HTnulbOhlwA7GkQkQdoOK1/0
         1Ha+S53vqWPLezGliQS2XMsr6JgmUavID0ipAyQZ4g9TvQwy/t7/k8g3Kg/vLXpEObR4
         sWcy1dP6mCHVi4ZQcWNTYMH/EOMdt/hBcYQAGF3rQi9NRKGktKZQvVCXYxL2dHaI63Gd
         LQG1QTRGL1EHmONi1ZAqK0ZzKOkAF/tIQhFPMF7E8QV+xOUqb7diB79VN0FElHvRcSbV
         0A7MOZA087bR6B0hmThMIWqx8F5oXyQeCXi0i/VYhjwYZCW1tS35k2c9ouvhCXJHOwNE
         d3Bg==
X-Gm-Message-State: AOAM532BB9hsIOLLqqKXdp9ge0Ab3AM9CFX4NY3cYL3e4h+5xMnzO+Kq
        WE6YEsbk6fas0N0y7ERM+qw=
X-Google-Smtp-Source: ABdhPJw/uS1HPNjFjLfn2axRnsoF//Vw++8n9+JWMu7H/Nvp5fiISnsSfjoOTX2RygBaAk30h5PiDg==
X-Received: by 2002:a1c:b006:: with SMTP id z6mr13160878wme.19.1617384628595;
        Fri, 02 Apr 2021 10:30:28 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id o14sm3840226wrc.3.2021.04.02.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 07/30] staging: rtl8723bs: fix error prone if conditions
Date:   Fri,  2 Apr 2021 19:29:49 +0200
Message-Id: <979809a68e00f4841f90ca699c75a038762200a4.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit check:

CHECK: Using comparison to true is error prone
21: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:38:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
36: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:50:
+		if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
47: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:59:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
60: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:72:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
73: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:83:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
86: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:120:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
93: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:124:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
101: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:129:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
108: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:133:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
121: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:149:
+	if (padapter->bSurpriseRemoved == true)

CHECK: Using comparison to true is error prone
130: FILE: drivers/staging/rtl8723bs/core/rtw_eeprom.c:155:
+	if (padapter->bSurpriseRemoved == true)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_eeprom.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
index 32d5e5b23337..be0eda1604d0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
+++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
@@ -35,7 +35,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
 	u16 x, mask;
 _func_enter_;
 
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	mask = 0x01 << (count - 1);
@@ -47,7 +47,7 @@ _func_enter_;
 		x &= ~_EEDI;
 		if (data & mask)
 			x |= _EEDI;
-		if (padapter->bSurpriseRemoved == true)
+		if (padapter->bSurpriseRemoved)
 			goto out;
 
 		rtw_write8(padapter, EE_9346CR, (u8)x);
@@ -56,7 +56,7 @@ _func_enter_;
 		down_clk(padapter, &x);
 		mask = mask >> 1;
 	} while (mask);
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	x &= ~_EEDI;
@@ -69,7 +69,7 @@ u16 shift_in_bits(_adapter *padapter)
 {
 	u16 x, d = 0, i;
 _func_enter_;
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	x = rtw_read8(padapter, EE_9346CR);
@@ -80,7 +80,7 @@ _func_enter_;
 	for (i = 0; i < 16; i++) {
 		d = d << 1;
 		up_clk(padapter, &x);
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 		x = rtw_read8(padapter, EE_9346CR);
@@ -117,20 +117,20 @@ void eeprom_clean(_adapter *padapter)
 {
 	u16 x;
 _func_enter_;
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	x = rtw_read8(padapter, EE_9346CR);
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	x &= ~(_EECS | _EEDI);
 	rtw_write8(padapter, EE_9346CR, (u8)x);
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	up_clk(padapter, &x);
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	down_clk(padapter, &x);
@@ -146,13 +146,13 @@ u16 eeprom_read16(_adapter *padapter, u16 reg) /*ReadEEprom*/
 
 _func_enter_;
 
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	/* select EEPROM, reset bits, set _EECS*/
 	x = rtw_read8(padapter, EE_9346CR);
 
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto out;
 
 	x &= ~(_EEDI | _EEDO | _EESK | _EEM0);
-- 
2.20.1

