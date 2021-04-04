Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4466E35385A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhDDOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhDDOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31EC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b9so896009wrs.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wM65qpTGPdNiE6psQoUXh4NGVD1kefhM3YwIRcpdY1c=;
        b=lIBrj6AgrPBn0ZRbyCYCmXFADDWbWXJn5FXQacv8O8gmVSE5F4LHcvHjZ37YnXRW3P
         UY/42ktc2sqVVfFxwM90Rs0JBqyx3+EyWgYveJiJPsGFbsMI68Az1zY68bAoOsAATWPF
         v40D3qvqKmhHnDAE9XYrOFHeOSCZsLyJ6IHqs6+BWuY2h1Kj/hSlCV0N07rfMLqvB6pc
         V+bDy5mRXwB+8knxLTMsRZLGcEaLkAQ0v26fkOpNvAJecaNvTGt40dcjWYzUZRJEol6+
         L9IMcpwAy8fcFojpcq2WwAA1NxuOEtXcrbPZ4bxChn+zbdKxz3dNkOdjI72us8QB5L3W
         NZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wM65qpTGPdNiE6psQoUXh4NGVD1kefhM3YwIRcpdY1c=;
        b=g6OiRD5FWZca9siA7shuq6JGWCWI6nFnVAju1nqX/T/cytVPPDDIU3JraQ2sWHly+6
         vNXcHKWWONhVnwo6HOYL20JAwCmMaVskSeIbC2rzt6xNlrtZaTgfViStQTAc1fNxd6Tz
         U4xau/So5h2HbV6bU/XrYsHDzcbtsycJrrJuX2YeehWtxWvpojSKRsVbZrpqXdJLKged
         kBEdIt5N/msq36cB98wmKPDxfSSnh05rhBPKFWwP7YwVYqpC5tqsAvHDLpCxkaGOrkgK
         W2ZFxfdD5ExsDVZ2iWCoOn0v+IYTIUHb258fYeR9me/w+/OIcmUnrMo/PoEQ7B9eZJU5
         dx9A==
X-Gm-Message-State: AOAM530UYaEZuB1eF1nqeKJnmzGWGYSsEc7ab2ShOJ+/ouXtvsSL2O75
        30uGPkmszPXijcY7kKbXiSg=
X-Google-Smtp-Source: ABdhPJzXqu5WcnjmwoXzE4/dcq+rpVirqsxuJmY7oMzLgeUVe8BRX0DfhNiITvqcMhNpTZQTI5kIKw==
X-Received: by 2002:a5d:420f:: with SMTP id n15mr1211762wrq.186.1617545402066;
        Sun, 04 Apr 2021 07:10:02 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id r1sm29375522wrj.63.2021.04.04.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 07/30] staging: rtl8723bs: fix error prone if conditions in core/rtw_eeprom.c
Date:   Sun,  4 Apr 2021 16:09:23 +0200
Message-Id: <2ffcefe0b2c44cb5d392c4cd095da0f9b754cdc7.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch issues:

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

