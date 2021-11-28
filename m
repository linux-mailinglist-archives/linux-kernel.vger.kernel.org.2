Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5374E460696
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357666AbhK1N7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F025C06175A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j3so30619542wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBHJ/aKw5Cr+IB+VkwG1v8Q23E2p2sxCrJ2g9gsZZxY=;
        b=o5f+F6qCNQU6FEYpLffXeR2zq8TaG+F4lj2rvXNwtsc+FCwvdbIyCNg5gnU+0UVWXG
         D/bIXQqDtyd2PTez5WcAK6FQR84UvDiinycQdgHoBjZBW+uIuZ3CA5cNO3+AyQIcyS75
         40fQrff58B165D/baVA3jt3mIMZIcA5U14v2xfxnZ/g877FOrx9x21TU7h5AYGNP8JpI
         Uwi0A21klpHDB6XLyJMyWQ5xYlGO/Ej4jaQk6dgk4I3MEK7wRXFPIKu49QNx6GzKuAg7
         2kP+BWydLWrFbAtEJDfLsDYsWxgq4lyxeEP1fLcofWSqnh14bptczgZV+aV3/885+/Mv
         Tq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBHJ/aKw5Cr+IB+VkwG1v8Q23E2p2sxCrJ2g9gsZZxY=;
        b=hzvoQKwUpo5vs82YmNtf3W1LRHGmKfcmav+1RLFSNLHbHTDp+ZtTKwSJTU9fXSoRQt
         7wz0got6OCtMHazEWGfhQ4ONvcg6bclSOpNJYlo/B9nDp5Mfw4RGl29uO2vzafLS4aNB
         QDmskWrCo1lSAqj/9aIV6bXbbfNpsmq3cTd4l9qTbSz44NxMYpYyZFfd58P9KEZaK7ff
         JKM0Lv0jLo/juSKPtUcBx6Dg/xPcagFJcM9/0PlMnmLQ8ABc8L69S2DBYnFoUEm67Q0Q
         dBJL499q593+/rFa25rUBus29grmuy9qAQQ0EX30kYYyGZu8z8t1h74bk0Ak+U9yMYWB
         f3dg==
X-Gm-Message-State: AOAM533wvrJQ1RFOTXvMORFkSvvFh/RgkTevPmRZIONlOmjmtjFZYkgO
        B2BulX2XBW2JYhk7ThLlcriaLS21OcE=
X-Google-Smtp-Source: ABdhPJyZhD6oA1VKcnvLRyIOCP+HlvTd45EQcOH58TbWg5c39y5u4SREeqtK2kB/cyxFr4OrHBRNyg==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr27783423wrz.76.1638107617064;
        Sun, 28 Nov 2021 05:53:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove rf_type from writeOFDMPowerReg88E()
Date:   Sun, 28 Nov 2021 14:53:22 +0100
Message-Id: <20211128135326.9838-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128135326.9838-1-straube.linux@gmail.com>
References: <20211128135326.9838-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pHalData->rf_type is always RF_1T1R. Remove unnecessary checks from
writeOFDMPowerReg88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 946a1b97d96f..813dd938c817 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -272,7 +272,6 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 }
 static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u16 regoffset_a[6] = {
 		rTxAGC_A_Rate18_06, rTxAGC_A_Rate54_24,
 		rTxAGC_A_Mcs03_Mcs00, rTxAGC_A_Mcs07_Mcs04,
@@ -302,10 +301,7 @@ static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
 		PHY_SetBBReg(Adapter, regoffset, bMaskDWord, writeVal);
 
 		/*  201005115 Joseph: Set Tx Power diff for Tx power training mechanism. */
-		if (((pHalData->rf_type == RF_2T2R) &&
-		     (regoffset == rTxAGC_A_Mcs15_Mcs12 || regoffset == rTxAGC_B_Mcs15_Mcs12)) ||
-		    ((pHalData->rf_type != RF_2T2R) &&
-		     (regoffset == rTxAGC_A_Mcs07_Mcs04 || regoffset == rTxAGC_B_Mcs07_Mcs04))) {
+		if (regoffset == rTxAGC_A_Mcs07_Mcs04 || regoffset == rTxAGC_B_Mcs07_Mcs04) {
 			writeVal = pwr_val[3];
 			if (regoffset == rTxAGC_A_Mcs15_Mcs12 || regoffset == rTxAGC_A_Mcs07_Mcs04)
 				regoffset = 0xc90;
-- 
2.34.0

