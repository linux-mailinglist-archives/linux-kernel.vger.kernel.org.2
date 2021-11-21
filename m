Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4F458321
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 12:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhKULaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbhKULaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 06:30:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 03:27:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l25so47175860eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 03:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8qwozoI4ZgvY8N3QOUrFpTNybxtK5/UyM93WgmSUcs=;
        b=FYbFHF2QM+ZPPXDFsPv/so2dy8U9Ff855nzNxC/vY6iUEN0Ys1bjUUs9G29y0uHjF8
         aVw1jQMB/0c5Pw7Pzle31twT8hQy7X8ONbqK47uU3Sp3JvXO2fqsHn3v1y6bT4e6xWuj
         0hemHxZU466JbWRht3jNPlJIhwNXScho6CsrhfeVhnkdbrAINqpmvV380Xl6IpmmzL9A
         ZIrHlaZ1CIi3q5t6V8DBN/96VbzCaqo8x9lkeXviCwuAKyA9MWW0cmjDXyja4U3f9s8i
         rQgh1RidJeIHztdKFo5lKtk1ypXUGEeCVFkbuVmESasOFykXQPShzoV+tRoZUH3V3zhV
         oznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8qwozoI4ZgvY8N3QOUrFpTNybxtK5/UyM93WgmSUcs=;
        b=yZ5dnpE87q4rYMZvnXcl1WeiWgyZgc42jzQbJ8rCZO4baSVhJk0zWaDtisvieGX4YY
         RBxJl8CsPazErgVfcEHawJNiBpWHAzBZj2Vai+o65OC6Kv6EAdz/zLn77kLGGLSfh2fU
         tr0j+DFXDi214F+tI3/JFfup6S4gv1S4V+3MkUc3dGcaeEfVrUWCeXcE/1NpbDjQV/Px
         ROUDoDv3Kzh/1As/XBNrAjpEKnofFk36Aq0fXkvvw/bND9CaI4iLk+v6UP1UFGgncxt4
         NrxnaZvd+IBGpNvi5Eni/x4rh79hj+9yQ7x00oAKpRlEswo/QT1VHd7Bnik0kszVxoS/
         IqQg==
X-Gm-Message-State: AOAM533+6PF+y6aUOW9QpA6qWAEWZ/W6lxDua8/4BJzQRTEX+bBNkzeT
        +b+EFHwn3oBe7icg5oEDkNKZUoM0j6U=
X-Google-Smtp-Source: ABdhPJyaVEhpifhFF0K+5F/45yMmT3PeLDFfsQeShkF7DuGSZYcOfrnfOWustG0rVCYxJuvAtQ/vrQ==
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr28790469ejc.543.1637494034513;
        Sun, 21 Nov 2021 03:27:14 -0800 (PST)
Received: from bulldog.fritz.box (host-95-252-102-163.retail.telecomitalia.it. [95.252.102.163])
        by smtp.gmail.com with ESMTPSA id nb4sm2309065ejc.21.2021.11.21.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 03:27:14 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: rename variable bHWRadioOff
Date:   Sun, 21 Nov 2021 12:19:59 +0100
Message-Id: <20211121112000.632456-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "bHWRadioOff"
into linux kernel coding style equivalent variable "hw_radio_off".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index ff171acc11f4..e9d1b56d8809 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -229,7 +229,7 @@ struct vnt_private {
 	/* GPIO Radio Control */
 	unsigned char byRadioCtl;
 	unsigned char byGPIO;
-	bool bHWRadioOff;
+	bool hw_radio_off;
 	bool bPrvActive4RadioOFF;
 	bool bGPIOBlockRead;
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 1f98f2b069c4..897d70cf32b8 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -373,7 +373,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_RADIOCTL);
-	priv->bHWRadioOff = false;
+	priv->hw_radio_off = false;
 
 	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
@@ -383,10 +383,10 @@ static void device_init_registers(struct vnt_private *priv)
 		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
 		     (!(priv->byGPIO & GPIO0_DATA) &&
 		     (priv->byRadioCtl & EEP_RADIOCTL_INV)))
-			priv->bHWRadioOff = true;
+			priv->hw_radio_off = true;
 	}
 
-	if (priv->bHWRadioOff || priv->bRadioControlOff)
+	if (priv->hw_radio_off || priv->bRadioControlOff)
 		CARDbRadioPowerOff(priv);
 
 	/* get Permanent network address */
-- 
2.25.1

