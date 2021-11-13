Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE744F26F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 11:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhKMKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhKMKYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 05:24:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D44C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 02:21:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m20so2196430edc.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 02:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecovIr3cgAtR+3fYnJ5+gVzcYeZtoVQWk0eRWV5BA60=;
        b=dF9S9AHlGYB4O2sQGUKorbkrzvOWrHQ864io9IZdPvNyyFCmx0ngbxjFMrChpU2nQF
         Euh+Q9zczwVLex0vzFLldVyQkfF/IQvXtqUN8nJSxD7TZ0zp+/lQJeh62jRwHED/M9Bz
         hwnMMdGEjbGcMYwPPn7lgu4r7hqlDWXPK92i8FIXYnjBebeu1w388o7Pvi+RWgdZ/SZS
         6Ntc/vKkhTII0SEulIIIbPhehb1bCtdeiWnCBc73uHYfjMBdsFG6wgV7yXNr8VfOnldf
         iAwCcDDrG0b3SQul1PxebtwDWdO4PXW55BK4jmVuZeE7wRKEmBcjKMhT8RyYuY+MRL6/
         R9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecovIr3cgAtR+3fYnJ5+gVzcYeZtoVQWk0eRWV5BA60=;
        b=c3HQVQ5L8RcPfWkdXoOLm3+D0sOdxNZcPeP3jnLPGVNyOB1J+3zXtf6hCWhXVwV1i4
         CK/v1GLIcAPmdBkTGJgKonsstWRvZajP9TkLzxlUiimgDE53F9ActGJTo0IFkDk4f6tV
         V/1vkyjrDUwyTzyfFCPJAfvNR92QsxVBCuWeef3dbFTJpxgGOJ+ppeSHz94jE1Q/udhU
         7teBrK2/gSzJdb1sLtRw4C0BhRnVVpz72xJiVAMaX3qiO+B/F+3mxmB0j0VvYk5j1R3Y
         9CFW1QsdGHAyJeNasgWjIELadYyAjxQJKR9tFztP1bpSIlOP1LsY3jvKtz5Wi7A5X5I6
         KjfA==
X-Gm-Message-State: AOAM533uR6oPZWRqTkLOmXQKT8F4J7bTyoBavq6nw8pKQxqwh1UCri7X
        Nrsi9Hj+N23luD88Nn7vu5QWRi73pHQ=
X-Google-Smtp-Source: ABdhPJxdk/MUFzyatk1yugomiILDuKYPh2gffhsNDkiSVq+0zSdCeo00SkxCGyahxRx2o9siG2mrqg==
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr28654805ejc.424.1636798891363;
        Sat, 13 Nov 2021 02:21:31 -0800 (PST)
Received: from tom-desktop.station (net-93-150-197-192.cust.dsl.teletu.it. [93.150.197.192])
        by smtp.gmail.com with ESMTPSA id e19sm4212840edu.47.2021.11.13.02.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 02:21:30 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: fix camelcase in bRadioOff
Date:   Sat, 13 Nov 2021 11:21:20 +0100
Message-Id: <20211113102126.82904-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable bRadioOff with snake case
variable radio_off.
Drop Hungarian notation prefix in `bRadioOff` variable.
Change it to use snake case.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/card.c        | 4 ++--
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 26e08fec6e6a..eac7c234f9db 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -404,7 +404,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
  */
 void CARDbRadioPowerOff(struct vnt_private *priv)
 {
-	if (priv->bRadioOff)
+	if (priv->radio_off)
 		return;
 
 	switch (priv->byRFType) {
@@ -429,7 +429,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	bb_set_deep_sleep(priv, priv->local_id);
 
-	priv->bRadioOff = true;
+	priv->radio_off = true;
 	pr_debug("chester power off\n");
 	MACvRegBitsOn(priv->port_offset, MAC_REG_GPIOCTL0,
 		      LED_ACTSET);  /* LED issue */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 4706bde1ec1d..3768791d9744 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -221,7 +221,7 @@ struct vnt_private {
 	bool bBarkerPreambleMd;
 
 	bool bRadioControlOff;
-	bool bRadioOff;
+	bool radio_off;
 	bool bEnablePSMode;
 	unsigned short wListenInterval;
 	bool bPWBitOn;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 212d2a287b2c..e74caf22d75a 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -369,7 +369,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* Set Short Slot Time, xIFS, and RSPINF. */
 	priv->wCurrentRate = RATE_54M;
 
-	priv->bRadioOff = false;
+	priv->radio_off = false;
 
 	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_RADIOCTL);
-- 
2.25.1

