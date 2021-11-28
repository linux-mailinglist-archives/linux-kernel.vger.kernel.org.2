Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B44607E5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358881AbhK1RPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhK1RNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2123C06175A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j3so31418186wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBHJ/aKw5Cr+IB+VkwG1v8Q23E2p2sxCrJ2g9gsZZxY=;
        b=LycxiqIEtrFYBf9r8eajOVn2eokpukusQSQ0dxioFaJ7TBiwYIw9z++hT7J8Gq8OGV
         4aoiQhX6Jg47bCyrv8VlYpxn+oshHRCzIugghSidb1vj/GYDYYISq/rCUgcWnOynbSHa
         SABD2OPsHbHuv/R6/ISkIK81eoUjtpJ3xP1kNQtYdxWMlrBAW4VggC4yuNRYkzf+5POy
         BrhGNFEeq72kVpwhI+C1ezVfve8CW1izRkcNJ6tpQEGTmSadxCepgunlWlC44xlDqwIc
         GZTX8IiiVxqWVlHalVg3bo/Ww4eWZXauCUllcCzMWUc8ct4YLFiXsWgf3C/8ladBXQc4
         d5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBHJ/aKw5Cr+IB+VkwG1v8Q23E2p2sxCrJ2g9gsZZxY=;
        b=yBAc7cZi29pOrYkcbbNiUN2t0xfBoXRVAjD8H87wA2dJQRM4aFd/AEHgYZjPfUd9C3
         mKFj+7dl4R+tfliA2D0O5zrORxKDZiVh/mgbwYP1zdZ3Zh75e9ZXZNe3kha2loaCmFdj
         vPb2yO+5h37rrFkVZSomQepZtkI8eEXKQOBBxGIlBo2PT9hXrq+tYVLDoVWuAfeHQw3u
         h9vEMcEYnX2DUAS+p7zPgv0f26D5J+en8Qg+vMtxzB1srgsTRpjuBysgGoLUrM+9GvnI
         h5pEJvVCiEUyjaSMoe89sGldJ5ZFQc8zN6vlFBFo5/X93Ys49nDnVcDwEjMNeQY/V0wr
         9CVQ==
X-Gm-Message-State: AOAM531h6FfO1maYhk/Y6Fn8JdhSM00xZobnW7D0fO94GW6QBL5ANbEc
        sE/GLxfLyLkIzyCroqdXxZc=
X-Google-Smtp-Source: ABdhPJw6XC/dQRGdXjaNFlFHUrIG2cmgYdUP6XcJnW8LWE0d+1kT3p4sInyXerCFoRGcp3VUSC7FiQ==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr28084600wrw.504.1638119392501;
        Sun, 28 Nov 2021 09:09:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:52 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 06/10] staging: r8188eu: remove rf_type from writeOFDMPowerReg88E()
Date:   Sun, 28 Nov 2021 18:09:20 +0100
Message-Id: <20211128170924.5874-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
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

